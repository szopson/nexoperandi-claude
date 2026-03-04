---
name: scraping
description: Kompletny skill web scrapingu przez Crawl4AI (self-hosted, 0 zł) — 7 trybów MCP. Decision tree, gotowe skrypty JS, hooki, obsługa błędów.
---

# Web Scraping (Crawl4AI Mega-Skill)

Self-hosted Crawl4AI (0 zł, bez limitów) jako jedyny scraper.

## Decision Tree — który tryb?

```
Chcę pobrać treść strony
├── Czysty tekst (artykuł, docs) → md fit [Tryb 1]
├── Tekst + obrazki/linki → md raw [Tryb 2]
├── Szukam konkretnej info na stronie → md bm25 + query [Tryb 3]
├── Strona wymaga interakcji (klik, scroll, form) → execute_js [Tryb 4]
├── Wiele URLi naraz → crawl [Tryb 5]
├── Potrzebuję screenshot → screenshot [Tryb 6]
└── Potrzebuję struktury HTML/DOM → html [Tryb 7]

Nie mam URL / szukam w internecie
├── Wyszukiwanie stron → WebSearch (wbudowany Claude)
├── Lista URLi na domenie → crawl4ai crawl (zwraca linki)
└── Structured data → crawl4ai md + parsowanie w Claude (LLM extraction)
```

---

## Tryb 1: `md fit` — Czysty tekst strony

**MCP:** `mcp__crawl4ai__md`

**Kiedy:** Artykuł, dokumentacja, blog, landing page — gdy potrzebujesz samego tekstu bez szumu.

**Parametry:**
| Param | Wartość | Opis |
|-------|---------|------|
| `url` | URL strony | Wymagany |
| `f` | `"fit"` | Filtr — tylko główny content (bez nawigacji, footera) |

**Przykład:**
```
mcp__crawl4ai__md
url: "https://example.com/article"
f: "fit"
```

**Co zwraca:** Czysty Markdown — sam tekst artykułu, bez obrazków, menu, footera. Najmniej tokenów.

**Kiedy NIE używać:** Gdy potrzebujesz obrazków (użyj raw) lub strona wymaga interakcji (użyj execute_js).

**Gotchas:**
- `fit` może pominąć sidebar/FAQ jeśli algorytm uzna je za "nie-main content"
- Dla stron SPA bez SSR — content może być pusty (→ execute_js)

---

## Tryb 2: `md raw` — Pełny Markdown z obrazkami

**MCP:** `mcp__crawl4ai__md`

**Kiedy:** Potrzebujesz tekstu + linków do obrazków (`![alt](url)`), pełny layout strony.

**Parametry:**
| Param | Wartość | Opis |
|-------|---------|------|
| `url` | URL strony | Wymagany |
| `f` | `"raw"` | Pełny markdown bez filtrowania |

**Przykład:**
```
mcp__crawl4ai__md
url: "https://example.com"
f: "raw"
```

**Co zwraca:** Kompletny Markdown ze wszystkimi elementami — tekst, obrazki, linki, nawigacja.

**Kiedy NIE używać:** Gdy analizujesz LLM (za dużo tokenów). Użyj `fit`.

**Gotchas:**
- Znacznie więcej tokenów niż fit (2-5x)
- Obrazki jako `![alt](url)` — nie pobiera samych plików

---

## Tryb 3: `md bm25` — Szukanie konkretnej info na stronie

**MCP:** `mcp__crawl4ai__md`

**Kiedy:** Znasz URL i szukasz konkretnej informacji (np. "cena", "wymagania techniczne", "FAQ o zwrotach").

**Parametry:**
| Param | Wartość | Opis |
|-------|---------|------|
| `url` | URL strony | Wymagany |
| `f` | `"bm25"` | Filtr BM25 — ranking akapitów po relevance |
| `q` | query string | Czego szukasz (np. "pricing", "wymagania") |

**Przykład:**
```
mcp__crawl4ai__md
url: "https://docs.example.com/code-node/"
f: "bm25"
q: "environment variables"
```

**Co zwraca:** Tylko akapity najbardziej pasujące do query, posortowane po relevance score.

**Kiedy NIE używać:** Gdy chcesz całą stronę (użyj fit/raw) lub nie wiesz czego szukasz.

**Gotchas:**
- Wymaga dobrego query — zbyt ogólne = zbyt dużo wyników
- Działa na akapitach — krótkie sekcje mogą mieć niski score

---

## Tryb 4: `execute_js` — Browser automation

**MCP:** `mcp__crawl4ai__execute_js`

**Kiedy:** Strona wymaga interakcji: kliknięcie przycisku, scroll, zamknięcie cookie banner, rozwinięcie akordeonów, wypełnienie formularza, załadowanie lazy content.

**Parametry:**
| Param | Wartość | Opis |
|-------|---------|------|
| `url` | URL strony | Wymagany |
| `scripts` | lista stringów JS | Każdy skrypt = osobne wyrażenie JS do wykonania |

**Przykład — rozwinięcie FAQ akordeonów:**
```
mcp__crawl4ai__execute_js
url: "https://example.com"
scripts: [
  "document.querySelectorAll('[data-state=\"closed\"]').forEach(el => el.click())",
  "await new Promise(r => setTimeout(r, 1000))"
]
```

**Co zwraca:** Pełny `CrawlResult` — markdown, html, links, js_execution_result. Wyciągaj dane z markdown (pole `_markdown.fit_markdown` lub `_markdown.raw_markdown`).

**Kiedy NIE używać:** Dla statycznych stron — overhead niepotrzebny, użyj `md fit`.

**KRYTYCZNE GOTCHAS:**
- **CrawlResult = 500K+ znaków** — ZAWSZE leci do pliku tymczasowego (nie wraca inline). Musisz potem `Grep` lub `Bash python3` na zapisanym pliku żeby wyciągnąć dane
- **`js_execution_result` nie przechwytuje return value** z twojego skryptu — zamiast tego szukaj danych w sekcjach `raw_markdown` / `fit_markdown` CrawlResult
- Skrypty wykonują się sekwencyjnie — dodaj `await` / `setTimeout` między akcjami
- Każdy skrypt to wyrażenie (IIFE lub async function) — nie zwykły statement
- **React/Next.js:** klikanie akordeonów Radix UI (`data-state="closed"`) często NIE działa — markdown generuje się przed re-renderem Reacta. Patrz sekcja "React/Next.js FAQ" poniżej

### Gotowe skrypty JS

**Cookie banner dismiss:**
```javascript
"(function() { const btns = document.querySelectorAll('button, [role=\"button\"]'); for (const b of btns) { const t = b.textContent.toLowerCase(); if (t.includes('accept') || t.includes('akceptuj') || t.includes('agree') || t.includes('zgadzam')) { b.click(); return 'clicked: ' + t; } } return 'no cookie banner found'; })()"
```

**Infinite scroll (5 rund):**
```javascript
"(async function() { for (let i = 0; i < 5; i++) { window.scrollTo(0, document.body.scrollHeight); await new Promise(r => setTimeout(r, 2000)); } return 'scrolled ' + document.body.scrollHeight + 'px'; })()"
```

**Accordion/FAQ expand all:**
```javascript
"(function() { const items = document.querySelectorAll('[data-state=\"closed\"], details:not([open]), .accordion-item:not(.active)'); items.forEach(el => { if (el.tagName === 'DETAILS') el.setAttribute('open', ''); else el.click(); }); return 'expanded ' + items.length + ' items'; })()"
```

**Wait for lazy content:**
```javascript
"(async function() { await new Promise(r => setTimeout(r, 3000)); return 'waited 3s for lazy load'; })()"
```

**Click specific button by text:**
```javascript
"(function() { const btns = [...document.querySelectorAll('button, a, [role=\"button\"]')]; const target = btns.find(b => b.textContent.trim().includes('Load More')); if (target) { target.click(); return 'clicked'; } return 'not found'; })()"
```

---

## Tryb 5: `crawl` — Wiele URLi naraz

**MCP:** `mcp__crawl4ai__crawl`

**Kiedy:** Pobieranie wielu stron naraz — dokumentacja, archiwum bloga, seria artykułów.

**Parametry:**
| Param | Wartość | Opis |
|-------|---------|------|
| `urls` | lista URLi | Wymagany, max 100 |
| `crawler_config` | obiekt | Opcjonalny — konfiguracja crawlera |
| `browser_config` | obiekt | Opcjonalny — konfiguracja przeglądarki |
| `hooks` | obiekt HookConfig | Opcjonalny — Python hooks (wymaga CRAWL4AI_HOOKS_ENABLED) |

**Przykład — crawl 3 stron dokumentacji:**
```
mcp__crawl4ai__crawl
urls: [
  "https://docs.example.com/node-code/",
  "https://docs.example.com/node-set/",
  "https://docs.example.com/node-if/"
]
```

**Przykład z konfiguracją:**
```
mcp__crawl4ai__crawl
urls: ["https://blog.example.com"]
crawler_config: {
  "max_depth": 2,
  "max_pages": 20
}
browser_config: {
  "headless": true,
  "user_agent_mode": "random"
}
```

**Co zwraca:** Lista CrawlResult dla każdego URLa — markdown, html, links, media.

**Kiedy NIE używać:** Dla jednej strony — użyj `md`. Crawl ma overhead na setup.

**Gotchas:**
- Limit 100 URLi na wywołanie
- Duże crawle mogą trwać długo — zacznij od małego limitu
- Wyniki mogą być duże — rozważ `fit` filter post-hoc

---

## Tryb 6: `screenshot` — Zrzut ekranu strony

**UWAGA:** NIE używaj `mcp__crawl4ai__screenshot` bezpośrednio — base64 (10-15 MB) może crashować konwersację!

**Kiedy:** Podgląd strony, analiza layoutu, porównanie wizualne, dokumentacja UI.

**Dwa podejścia:**

| Tryb | Co robi | Output | Rozmiar |
|------|---------|--------|---------|
| Pełna jakość | PNG do podglądu | `~/Downloads/` | 10-15 MB |
| Skompresowany | JPEG (max 1200px) do analizy w Claude | folder projektu | 100-400 KB |

**Wrapper script (Python):**
```python
import asyncio
from crawl4ai import AsyncWebCrawler

async def screenshot(url: str, output_path: str, compress: bool = False):
    async with AsyncWebCrawler() as crawler:
        result = await crawler.arun(url=url, screenshot=True)
        import base64
        img_data = base64.b64decode(result.screenshot)

        if compress:
            from PIL import Image
            import io
            img = Image.open(io.BytesIO(img_data))
            img.thumbnail((1200, 9999))
            img.save(output_path, "JPEG", quality=70)
        else:
            with open(output_path, "wb") as f:
                f.write(img_data)

asyncio.run(screenshot("https://example.com", "output.png"))
```

**Zasady:**
- PNG (pełna jakość) → tylko do podglądu, nie Read w Claude
- JPEG (skompresowany) → bezpieczny do Read + analizy przez Claude
- Użytkownik mówi "zapisz" → pełna jakość. Mówi "przeanalizuj/pokaż mi" → skompresowany.

---

## Tryb 7: `html` — Struktura HTML/DOM

**MCP:** `mcp__crawl4ai__html`

**Kiedy:** Analiza struktury strony, reverse-engineering komponentów, szukanie selektorów do execute_js.

**Parametry:**
| Param | Wartość | Opis |
|-------|---------|------|
| `url` | URL strony | Wymagany |

**Przykład:**
```
mcp__crawl4ai__html
url: "https://example.com"
```

**Co zwraca:** Preprocessed HTML — sanitized, z zachowaną strukturą DOM i CSS classes.

**Kiedy NIE używać:** Gdy potrzebujesz treści czytelnej dla człowieka — użyj `md fit`.

**Gotchas:**
- Zwraca dużo tokenów (surowy HTML)
- Przydatny głównie do pisania selektorów CSS/XPath dla execute_js
- Dla stron z frameworkami (React, Vue) — zobaczysz komponenty z ich klasami (np. Radix UI `data-state`)

---

## Hooki (crawl endpoint)

Crawl4AI `crawl` endpoint wspiera Python hooks — fragmenty kodu wykonywane w kluczowych momentach crawla.

**Dostępne hook points:**
| Hook | Kiedy się odpala |
|------|------------------|
| `on_browser_created` | Po stworzeniu instancji przeglądarki |
| `before_goto` | Przed nawigacją na URL |
| `after_goto` | Po załadowaniu strony |
| `before_return_html` | Przed zwróceniem HTML |

**Przykład — custom headers + auth cookie:**
```
mcp__crawl4ai__crawl
urls: ["https://protected-site.com/dashboard"]
hooks: {
  "code": {
    "before_goto": "page.set_extra_http_headers({'Authorization': 'Bearer TOKEN123'})",
    "after_goto": "await page.wait_for_selector('.dashboard-loaded', timeout=5000)"
  },
  "timeout": 30
}
```

**Przykład — scroll before scrape:**
```
hooks: {
  "code": {
    "after_goto": "for i in range(3):\n    await page.evaluate('window.scrollTo(0, document.body.scrollHeight)')\n    await asyncio.sleep(2)"
  }
}
```

**UWAGA:** Hooki wymagają `CRAWL4AI_HOOKS_ENABLED=true` na serwerze. Dla prostych interakcji użyj `execute_js` zamiast hooków.

---

## Alternatywy gdy Crawl4AI nie wystarczy

Crawl4AI pokrywa 95% przypadków. Dla reszty:

### Szukanie w internecie (brak URL)

**Narzędzie:** `WebSearch` (wbudowany Claude)

```
WebSearch(query="Claude Code best practices 2026")
```

Zwraca linki + snippety. Znalezione URLe → scrapuj przez Crawl4AI `md fit` (0 zł).

### Lista URLi na domenie

**Narzędzie:** `mcp__crawl4ai__crawl`

```
mcp__crawl4ai__crawl
urls: ["https://docs.example.com"]
```

Crawl zwraca linki ze strony w `links` polu CrawlResult.

### Structured data extraction

**Narzędzie:** `mcp__crawl4ai__md` + parsowanie w Claude

```
1. mcp__crawl4ai__md(url="https://shop.com/product/123", f="fit")
2. Claude parsuje markdown i wyciąga structured data z tekstu
```

Bez potrzeby external API — Claude jest świetny w ekstrakcji danych z tekstu.

---

## React/Next.js — FAQ ukryte w akordeonach (RSC payload)

**Problem:** Strony Next.js z Radix UI accordion (`data-state="closed"`) NIE renderują treści zamkniętych sekcji w DOM. Klikanie w `execute_js` nie pomaga — markdown generuje się przed re-renderem Reacta, a single-accordion zamyka poprzedni element.

**Kluczowy insight:** Treść WSZYSTKICH akordeonów jest ZAWSZE w RSC payload — skrypty `self.__next_f.push()` w HTML. `md raw` pobiera pełną stronę z tym payloadem. Nawet zamknięte sekcje mają pełną treść — wystarczy ją wyciągnąć.

### Przetestowany workflow

```
KROK 1: md raw → pełna strona (widoczne FAQ + RSC payload w tle)
  ↓
KROK 2: Sprawdź czy md raw ma odpowiedzi na pytania FAQ
  ├── TAK → gotowe, wyciągnij z markdowna
  └── NIE (tylko pytania, brak odpowiedzi) → KROK 3
  ↓
KROK 3: execute_js → CrawlResult (500K+) → zapisany do pliku tymczasowego
  ↓
KROK 4: Python (Bash heredoc) → parsuj plik z CrawlResult:
  a) Znajdź pozycje pytań FAQ po keyword (np. "techniczn", "społecznoś")
  b) Wytnij chunk tekstu między pytaniem N a pytaniem N+1
  c) Wyciągnij odpowiedzi: re.findall(r'children\\\\\\":\\\\\\"(.*?)\\\\\\"', chunk)
  d) Decode unicode: .encode('utf-8').decode('unicode_escape')
```

### Gotowy skrypt Python (Bash heredoc)

```bash
python3 << 'PYEOF'
import json, re

# Ścieżka do pliku z CrawlResult (z execute_js)
RESULT_FILE = "ŚCIEŻKA_DO_PLIKU_WYNIKOWEGO"

with open(RESULT_FILE) as f:
    data = json.load(f)

text = data[0].get('text', '')

# 1. Znajdź pytania FAQ po pattern "header"
#    Escaping w RSC: header\\\\":\\\\"PYTANIE\\\\"
header_pattern = r'header\\\\\\":\\\\\\"(.*?)\\\\\\"'
headers = re.findall(header_pattern, text)

if not headers:
    print("Brak FAQ w RSC payload — spróbuj innego podejścia")
    exit()

print(f"Znaleziono {len(headers)} pytań FAQ\n")

# 2. Dla każdego pytania — znajdź chunk do następnego pytania
for i, header in enumerate(headers):
    # Decode unicode w nagłówku
    h_decoded = header.encode('utf-8').decode('unicode_escape')

    # Znajdź pozycję pytania w tekście
    q_pos = text.find(header)

    # Znajdź koniec: pozycja następnego pytania lub +3000 znaków
    if i + 1 < len(headers):
        next_pos = text.find(headers[i + 1], q_pos + len(header))
    else:
        next_pos = q_pos + 3000

    chunk = text[q_pos:next_pos]

    # 3. Wyciągnij odpowiedzi z children
    answer_parts = re.findall(r'children\\\\\\":\\\\\\"(.*?)\\\\\\"', chunk)
    clean_parts = []
    for p in answer_parts:
        if len(p) > 5:
            decoded = p.encode('utf-8').decode('unicode_escape')
            clean_parts.append(decoded)

    print(f"### {i+1}. {h_decoded}")
    print(' '.join(clean_parts) if clean_parts else '(brak odpowiedzi w RSC)')
    print()
PYEOF
```

### Kiedy stosować
- Strona Next.js/React z akordeonami (Radix UI, Headless UI) lub tabami
- `md raw` zwraca pytania FAQ bez odpowiedzi
- `execute_js` z kliknięciem nie rozwiązuje problemu

### Kiedy NIE stosować
- **Statyczne akordeony** (HTML `<details>`) — wystarczy `execute_js` z `setAttribute('open', '')`
- **WordPress/Elementor** — content jest w DOM, tylko ukryty CSS, kliknięcie w JS działa
- **Strona z SSR** która renderuje wszystko — `md raw` wystarczy

---

## Obsługa błędów

| Problem | Przyczyna | Rozwiązanie |
|---------|-----------|-------------|
| "Could not find session" | SSE connection died (Traefik buforuje) | Restart MCP serwera Crawl4AI |
| Timeout / długie ładowanie | Wolna strona, dużo JS | Zwiększ `screenshot_wait_for` lub dodaj wait w execute_js |
| Pusty content z `md` | SPA bez SSR, content ładowany po JS | Użyj `execute_js` z wait, potem czytaj markdown z CrawlResult |
| Bot detection / 403 | Strona blokuje crawlery | W `crawl`: `browser_config: { "user_agent_mode": "random" }` |
| Crawl4AI niedostępny | Kontener padł | SSH na VPS → `docker compose restart crawl4ai`, potem restart MCP |
| execute_js nie działa | Zły selektor CSS | Najpierw użyj `html` żeby sprawdzić strukturę DOM, potem pisz selektory |

**Fallback chain — ogólny:**
1. `md fit` → jeśli pusty content →
2. `md raw` → jeśli nadal pusty →
3. `execute_js` (wait + scroll) → jeśli nadal pusty →
4. `html` (surowy DOM, parsuj ręcznie)

**Fallback chain — FAQ/akordeony:**
1. `md raw` → sprawdź czy odpowiedzi są w markdown →
2. Jeśli NIE → `execute_js` → CrawlResult do pliku → Python parser na RSC payload (patrz sekcja React/Next.js)
3. Jeśli statyczne `<details>` → `execute_js` z `setAttribute('open', '')` wystarczy

---

## Zapis wyników

**Format nazwy:** `YYYY-MM-DD_domena_tryb.md`

**Przykłady:**
- `2026-02-08_docs-example-com_fit.md`
- `2026-02-08_blog-example-com_crawl.md`
- `2026-02-08_competitor-com_execute-js.md`

**Zapisuj gdy:**
- Wyniki będą potrzebne później (research, porównanie)
- Użytkownik prosi o zapis

**Nie zapisuj gdy:**
- Jednorazowe sprawdzenie (np. "co jest na tej stronie?")
- Screenshot (base64 nie nadaje się do .md)

---

## Workflow

### Krok 1: Ustal parametry

Zapytaj użytkownika (jeśli nie podał):
- **URL** — adres strony (lub query dla search)
- **Tryb** — automatycznie dobierz z decision tree, lub użytkownik wskazuje
- **Cel** — co chce uzyskać (pomaga wybrać fit vs raw vs bm25)

### Krok 2: Wykonaj scraping

Użyj odpowiedniego trybu z decision tree.

### Krok 3: Przetwórz wyniki

1. Sprawdź czy scraping się powiódł
2. Wyświetl podsumowanie (rozmiar, główne sekcje)
3. Zapytaj czy zapisać do pliku

---

## Przykłady użycia

**Artykuł blogowy:**
```
User: /scraping https://blog.example.com/article
→ md fit — czysty tekst, 0 zł
```

**FAQ ukryte w akordeonach:**
```
User: /scraping https://example.com — wyciągnij FAQ
→ execute_js — klik na akordeony, potem markdown z CrawlResult
```

**Szukanie info na stronie:**
```
User: /scraping https://docs.example.com/code-node — szukam "environment variables"
→ md bm25 z q="environment variables"
```

**Dokumentacja (wiele stron):**
```
User: /scraping https://docs.example.com crawl
→ crawl z listą URLi
```

**Szukanie w internecie:**
```
User: /scraping "AI agents pricing 2026"
→ WebSearch → znalezione URLe → Crawl4AI md fit (0 zł)
```

**Screenshot strony:**
```
User: /scraping https://competitor.com screenshot
→ screenshot — base64 PNG (zapisz przez wrapper script)
```

**Struktura HTML:**
```
User: /scraping https://competitor.com html
→ html — DOM structure + CSS classes
```

---

## Pipelines — przykłady komend opartych na scrape

### `/blog-scan [topic]` — Content ideas z blogów

**Tryby:** `md fit` + `md bm25`

Skanuje wybrane blogi AI/tech/marketing, filtruje BM25 pod temat, generuje content ideas z hookami i kątami na LinkedIn.

**Flow:**
```
N blogów → md bm25 (równolegle) → ekstrakcja tematów → ranking pomysłów → Top 5 z hookami
```

**Użycie:** `/blog-scan "AI agents"` lub `/blog-scan` (skanuje wszystko)

---

### `/competitor-scan [url]` — Analiza konkurencji

**Tryby:** `md fit` → `md bm25` → `execute_js` (jeśli akordeony) → `html` (opcjonalnie)

Wyciąga z jednego URL: FAQ, pricing, features, testimoniale, copy. Automatycznie sprawdza substrony (/faq, /pricing, /cennik).

**Flow:**
```
URL → md fit (rozpoznanie) → bm25 celowane (FAQ, pricing, features, testimoniale)
  ├── substrony (/faq, /pricing) → md fit (równolegle)
  └── akordeony? → execute_js (klik) → markdown z CrawlResult
→ strukturalny raport
```

**Użycie:** `/competitor-scan https://competitor.com` lub `/competitor-scan https://competitor.com "pricing i FAQ"`

---

### `/trend-scan [topic]` — Multi-source research

**Tryby:** `md bm25` (primary) + WebSearch (fallback dla niszowych tematów)

Skanuje 5-8 źródeł pod konkretny temat, syntetyzuje findings, szuka sprzeczności (= materiał na hot take).

**Flow:**
```
Temat → dobór źródeł → md bm25 na każdym (równolegle)
  └── niszowy temat? → WebSearch → nowe URLe → md bm25
→ synteza + sprzeczności + content ideas
```

**Combo pipeline:**
```
/trend-scan "AI agents"     → research tematu
/blog-scan "AI agents"      → content ideas z blogów
/content "Post o AI agents" → gotowy post
```

**Użycie:** `/trend-scan "Claude Code vs Cursor"`

---

### Kiedy który pipeline?

```
Chcę pomysły na content
├── Z moich notatek → /content-ideas
├── Z blogów AI/tech → /blog-scan [topic]
└── Z newsów dnia → /daily-brief

Chcę zbadać temat
├── Szybki multi-source scan → /trend-scan [topic]
├── Głęboki research → /research-manual [topic]
└── Analiza jednej firmy/strony → /competitor-scan [url]

Chcę scrapować stronę (raw)
└── /scraping [url] [tryb]
```
