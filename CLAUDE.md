# NexOperandi — Claude Context

## Kim jesteśmy
NexOperandi to agencja AI automation dla poważnych biznesów (B2B).
Budujemy i wdrażamy rozwiązania AI, które automatyzują powtarzalne zadania —
obsługę telefoniczną, umawianie wizyt, kwalifikację leadów, generowanie contentu.

## Nasza oferta

### Model cenowy
- **Core offer:** Lead-to-appointment automation dla B2B service businesses
- **Setup:** €750 (jednorazowo)
- **Abonament:** €250/miesiąc

### Tiery usług (dla większych projektów)
- **Tier 1 (~€500):** Gotowe automatyzacje, quick wins, szybkie wdrożenie
- **Tier 2 (~€2-5K):** Custom AI workflows dopasowane do klienta
- **Tier 3 (~€10-50K):** Kompleksowe systemy AI, pełna integracja, SLA

### Flagship product: AI Voice Receptionist
- VAPI (voice AI, polski język) + n8n (workflow automation)
- Odbiera telefony 24/7, umawia wizyty, odpowiada na FAQ
- ROI: 3-5 uratowanych wizyt/tydzień = zwrot w 2-4 tygodnie

## Target Market

### ICP (Ideal Customer Profile)
**Małe i średnie firmy (<100 pracowników) szukające automatyzacji:**
- Kliniki medycyny estetycznej
- Gabinety dentystyczne
- Firmy usługowe (elektrycy, hydraulicy, serwisy)
- Kancelarie prawne i biura rachunkowe
- Agencje nieruchomości
- Salony beauty i SPA
- Warsztaty samochodowe
- Inne biznesy B2B z dużą ilością telefonów/leadów

**Wspólne cechy:**
- Dużo telefonów/zapytań od klientów
- Brak zasobów na pełnoetatową recepcję 24/7
- Tracą leady przez nieodebrane telefony
- Gotowi zainwestować w automatyzację (budżet €500-5000)

**Aktualny fokus walidacyjny Q1/Q2 2026:** Kliniki medycyny estetycznej (Katowice/Śląsk)

## Stack techniczny
- **Workflow automation:** n8n (self-hosted) → https://n8n.srv1108737.hstgr.cloud
- **Voice AI:** VAPI (polski język)
- **Social media scheduling:** Postiz (self-hosted)
- **Infrastruktura:** Hostinger VPS, Docker, PostgreSQL, Traefik
- **Frontend:** React, Next.js, Tailwind, TypeScript
- **Backend:** FastAPI (Python), Node.js
- **Analytics:** PostHog, GA4, Amplitude, Hotjar
- **CRM/docs:** Notion

## Kluczowe linki
- Website: https://nexoperandi.cloud
- Booking: https://calendly.com/nexoperandi/nexoperandi-demo-automation
- Scoreboard: https://www.notion.so/b09e457caa0043639c3c30a07dbbe7e9
- Repo: GitHub (private)

## Narzędzia MCP dostępne
- Google Maps MCP — research klinik, scraping
- Notion MCP — dokumenty, CRM, baza leadów
- Telegram MCP — powiadomienia, briefy
- PostgreSQL MCP — dane operacyjne
- GitHub MCP — zarządzanie repo

## Execution Squad Framework
Track daily: Execution → Positive Signal → Booked → Show → Close → Cash

Zasady:
- One channel at a time
- One CTA per campaign
- 7-day lock before changing
- Change ONE thing on Decision Day

## Priorytety (Marzec 2026)
1. Domknięcie discovery calls z klinikami medycyny estetycznej
2. Cold outreach — wysyłka emaili do klinik Katowice
3. Content marketing — LinkedIn PL + X EN o AI dla biznesu

## Styl pracy
- Komunikacja po polsku, konkretnie i praktycznie
- Dawaj actionable next steps, nie filozofuj
- Przy strategii: opcje z pros/cons, nie jedna odpowiedź
- Każda rekomendacja to hipoteza do walidacji — mów to wprost
- English w kodzie i komentarzach technicznych

## Skille dostępne

| Skill | Kiedy używać |
|-------|-------------|
| `marketing` | Posty LinkedIn, cold email, copywriting PL/EN |
| `content` | Blog, newsletter, social media kalendarze |
| `lead-research` | Kwalifikacja klinik, research B2B, scoring leadów |
| `nexoperandi-ops` | Oferty klientów, propozycje, pricing, discovery prep |
| `n8n-ops` | Tworzenie i debugowanie n8n workflows |

## Komendy dostępne

- `/post` — wygeneruj i zascheduluj post LinkedIn + X
- `/lead [nazwa]` — zakwalifikuj lead, oceń fit
- `/brief` — podsumowanie dnia (emaile + kalendarz + leady)
- `/proposal [klient]` — draft propozycji dla klienta
- `/ops` — dashboard operacji NexOperandi

## Zasady pracy
- Najpierw najprostsza działająca wersja, potem iteruj
- Commituj po każdej zakończonej funkcji
- Zawsze pytaj jeśli nie jesteś pewien zakresu — nie zakładaj
