# Agent: Lead Research Agent

## Cel
Codziennie o 9:00 znajdź nowe kliniki medycyny estetycznej w Polsce,
zakwalifikuj je i zapisz hot leady (score 4+) do Notion.

## Trigger
n8n Cron: codziennie o 9:00 CET

## Obszar szukania (priorytet)
1. Katowice i okolice (Chorzów, Siemianowice, Tychy, Gliwice)
2. Górny Śląsk — inne miasta
3. Kraków (jeśli brak w Katowicach)

## Proces

### Krok 1 — Pobierz listę klinik
HTTP Request → Google Maps API lub Places API:
- Query: "klinika medycyny estetycznej [miasto]"
- Pobierz: nazwa, adres, telefon, website, rating, liczba recenzji

### Krok 2 — Filtruj duplikaty
Sprawdź Notion → baza "Leads" → pomiń kliniki które już są w bazie.

### Krok 3 — Kwalifikacja (użyj skill lead-research)
Dla każdej nowej kliniki oceń scoring 0-6.
Zapisz tylko kliniki ze score >= 3.

### Krok 4 — Znajdź email
Dla klinik score >= 4:
- Sprawdź stronę www (sekcja kontakt, stopka)
- Jeśli brak → Hunter.io API

### Krok 5 — Zapisz do Notion
Baza: "Leads NexOperandi"
Kolumny:
- Nazwa (title)
- Miasto (select)
- Email (email)
- Telefon (phone)
- Strona WWW (url)
- Score (number 0-6)
- Status (select: new)
- Google Rating (number)
- Liczba recenzji (number)
- Notatka (text — co zauważył agent)
- Data dodania (date — today)
- Następna akcja (select: "send email")

### Krok 6 — Raport Telegram
```
Lead Agent — dzienny raport [data]

Znaleziono: [X] nowych klinik
Zakwalifikowano: [Y] (score 3+)
Hot leady (score 4+): [Z]

TOP LEADY DZIŚ:
1. [Nazwa] — score [X]/6 — [miasto]
   [email lub "brak emaila"]
   [1 zdanie dlaczego hot]

2. [Nazwa] — score [X]/6 — [miasto]
   [email lub "brak emaila"]
   [1 zdanie dlaczego hot]

Pipeline: [łączna liczba leadów w Notion] klinik łącznie
Notion: [link do bazy]
```

## Zasady
- Nie dodawaj klinik bez strony www (za małe / zamknięte)
- Kliniki z Google Rating < 3.5 → skip (słaba reputacja)
- Kliniki z < 10 recenzji → score -1 (za małe lub nowe)
- Jeśli znaleziono < 3 kliniki w Katowicach → rozszerz na Górny Śląsk automatycznie

## n8n Workflow struktura
```
1. Cron Trigger (codziennie 9:00)
2. HTTP Request → Google Maps API (pobierz kliniki)
3. HTTP Request → Notion API (pobierz istniejące leady)
4. Code Node → filtruj duplikaty
5. Loop przez nowe kliniki:
   a. HTTP Request → strona kliniki (scrape)
   b. HTTP Request → Claude API (scoring)
   c. IF score >= 3:
      → HTTP Request → Notion API (zapisz lead)
6. Aggregate results
7. Telegram → wyślij raport
```
