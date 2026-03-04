---
name: lead
description: Zakwalifikuj lead, oceń fit do NexOperandi, przygotuj do outreach
allowed-tools: Read, Write, Edit, WebFetch, WebSearch
---

# Command: /lead

Zakwalifikuj lead, oceń fit do NexOperandi, przygotuj do outreach.

## Użycie
```
/lead [nazwa kliniki]         # Research i kwalifikacja
/lead [url strony]            # Research po URL
/lead score [nazwa]           # Tylko score, bez pełnego raportu
/lead batch [plik]            # Przetwórz wiele leadów
```

## Proces

### 1. Zbierz dane podstawowe
- Nazwa kliniki, strona www, lokalizacja
- Telefon, email (jeśli dostępne)
- Google Maps link

### 2. Research digital presence
Użyj skill `lead-research` → sekcja "Research krok po kroku":
- Google rating + liczba recenzji
- Sprawdź recenzje pod kątem fraz: "trudno się dodzwonić", "nie odbierają"
- Social media activity (Instagram followers)
- Strona www: czy jest booking online, chatbot, live chat?
- Godziny pracy

### 3. Scoring (0-6)
```
[ ] Brak online booking na stronie         +1
[ ] Brak obsługi po 18:00 lub w weekendy   +1
[ ] Negatywne recenzje o dostępności       +1
[ ] Aktywny Instagram (1K+ followers)       +1
[ ] 50+ recenzji Google                     +1
[ ] Brak live chatu                         +1
```

**Ocena:**
- 4-6: HOT → priorytet outreach
- 2-3: WARM → kolejka
- 0-1: COLD → skip

### 4. Znajdź email
- Sprawdź stronę: kontakt, stopka
- Jeśli brak → Hunter.io z domeną kliniki

## Format output

```
LEAD REPORT: [Nazwa Kliniki]

DANE PODSTAWOWE
• Strona: [url]
• Lokalizacja: [miasto, dzielnica]
• Telefon: [numer]
• Email: [email lub "nie znaleziono"]

DIGITAL PRESENCE
• Google: [X.X] gwiazdek ([N] recenzji)
• Instagram: [followers] followers
• Booking online: TAK/NIE
• Live chat: TAK/NIE
• Godziny: [godziny pracy]

SCORING
[x] Brak online booking
[x] Brak obsługi po 18:00
[ ] Negatywne recenzje o dostępności
[x] Aktywny Instagram 1K+
[x] 50+ recenzji Google
[x] Brak live chatu

SCORE: 5/6 — HOT LEAD

NOTATKA
[Co rzuca się w oczy — np. "W recenzjach 3 osoby piszą o trudności
z dodzwonieniem się. Instagram bardzo aktywny, 5K followers.
Robią głównie medycynę estetyczną twarzy."]

SUGEROWANY SUBJECT EMAILA
"Pytanie o wizyty po 18:00"

NASTĘPNA AKCJA
Wysłać cold email z skill marketing → szablon dla klinik estetycznych.
```

## Zasady
- Nie dodawaj klinik bez strony www
- Google Rating < 3.5 → skip
- < 10 recenzji → score -1
- Jeśli < 3 kliniki w Katowicach → rozszerz na Górny Śląsk
