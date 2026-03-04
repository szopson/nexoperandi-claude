---
name: post
description: Wygeneruj i zascheduluj post LinkedIn + X/Twitter dla NexOperandi
allowed-tools: Read, Write, Edit, WebFetch, WebSearch
---

# Command: /post

Wygeneruj i zascheduluj post LinkedIn + X/Twitter dla NexOperandi.

## Użycie
```
/post                    # Interaktywne — pyta o szczegóły
/post linkedin pl        # Post LinkedIn po polsku
/post x en               # Tweet po angielsku
/post [temat]            # Wygeneruj o konkretnym temacie
```

## Proces

### 1. Wybierz temat
Sprawdź Notion → baza "Content Queue" → pobierz pierwszy temat ze statusem "ready".
Jeśli baza pusta → użyj tematu z fallback listy:

1. Ile telefonów traci klinika estetyczna po godzinach pracy
2. Jak AI receptionist różni się od chatbota na stronie
3. Automatyzacja umawiania wizyt — co działa, co nie
4. Czy małe biznesy mogą sobie pozwolić na AI
5. 3 procesy które każda klinika może zautomatyzować w tydzień
6. ROI z AI automation — jak liczyć zanim kupisz
7. VAPI po polsku — jak działa głosowy AI po polsku
8. n8n vs Zapier — co wybrać dla małego biznesu

### 2. Wygeneruj content
Użyj skill `marketing` → sekcja odpowiednia dla platformy.

**LinkedIn (PL):**
- Hook (1 zdanie, zatrzymuje scrollowanie)
- Problem (1-2 zdania, ból klienta)
- Insight (2-3 akapity, konkretny przykład)
- Rozwiązanie (1 akapit, bez sprzedaży)
- CTA (pytanie lub zaproszenie do DM)
- Hashtagi: #AIAutomation #NexOperandi + 3 branżowe
- Max 1300 znaków

**X/Twitter (EN):**
- Przetłumacz kluczowy insight z LinkedIn
- Max 280 znaków
- Mocny hook
- Hashtagi: max 2

### 3. Review checklist
- [ ] Hook zatrzymuje scrollowanie
- [ ] Jasna propozycja wartości
- [ ] Konkretne liczby/przykłady
- [ ] Jedno CTA
- [ ] Poprawna długość
- [ ] Brak błędów

### 4. Schedulowanie
- LinkedIn: następny dzień roboczy o 9:00 CET
- X: następny dzień roboczy o 8:00 CET
- Status: "scheduled" (nie "published" — można przejrzeć)

## Przykład output

```
POST LINKEDIN (PL)

Hook:
Większość klinik traci 30% telefonów po 18:00.

Content:
Sprawdziłem dane z 20 klinik medycyny estetycznej w Polsce.

Wynik: średnio 3 na 10 połączeń zostaje nieodebranych.

To nie tylko stracone wizyty.
To stracone zaufanie.

Klient dzwoni, nikt nie odbiera — idzie do konkurencji.

AI receptionist odbiera 100% połączeń.
24/7. W 2 sekundy.

CTA:
Chcesz zobaczyć jak to działa?
Link do demo w komentarzu.

Hashtagi:
#AIAutomation #NexOperandi #MedycynaEstetyczna #Automatyzacja #SmallBusiness

---
Platform: LinkedIn
Language: PL
Length: 412 znaków
Suggested time: wtorek 9:00 CET
```

## Powiadomienie po wygenerowaniu

```
Content wygenerowany!

LinkedIn (PL):
[pierwsze 200 znaków]...

X (EN):
[pełny tweet]

Publikacja: [data i godzina]
Status: zaschedulowany w Postiz
```
