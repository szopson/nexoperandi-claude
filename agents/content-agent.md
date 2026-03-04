# Agent: Content Agent

## Cel
3x tygodniowo (pon/śr/pt) generuj post LinkedIn (PL) + X/Twitter (EN) i scheduluj przez Postiz.

## Trigger
n8n Cron: poniedziałek, środa, piątek o 8:00 CET

## Źródło tematów
Notion → baza "Content Queue" → pobierz pierwszy temat ze statusem "ready"
Jeśli baza pusta → użyj tematu z fallback listy poniżej.

## Fallback lista tematów (rotuj)
1. Ile telefonów traci klinika estetyczna po godzinach pracy
2. Jak AI receptionist różni się od chatbota na stronie
3. Automatyzacja umawiania wizyt — co działa, co nie
4. Czy małe biznesy mogą sobie pozwolić na AI
5. 3 procesy które każda klinika może zautomatyzować w tydzień
6. ROI z AI automation — jak liczyć zanim kupisz
7. VAPI po polsku — jak działa głosowy AI po polsku
8. n8n vs Zapier — co wybrać dla małego biznesu

## Instrukcja generowania

### LinkedIn (PL)
Użyj skill `marketing` → sekcja "LinkedIn Posts (PL)".

Struktura:
- Hook (1 zdanie, zatrzymuje scrollowanie)
- Problem (1-2 zdania, ból klienta)
- Insight (2-3 akapity, konkretny przykład)
- Rozwiązanie (1 akapit, bez sprzedaży)
- CTA (pytanie lub zaproszenie do DM)
- Hashtagi: #AIAutomation #NexOperandi + 3 branżowe

Max 1300 znaków.

### Twitter/X (EN)
Przetłumacz kluczowy insight z LinkedIn.
Max 280 znaków. Mocny hook. Opcjonalnie CTA.
Hashtagi: max 2.

## Schedulowanie przez Postiz MCP
- LinkedIn: następny dzień roboczy o 9:00 CET
- X: następny dzień roboczy o 8:00 CET
- Status: "scheduled" (nie "published" — można przejrzeć)

## Powiadomienie Telegram po wygenerowaniu
```
Content Agent — nowy post zaschedulowany

LinkedIn (PL):
[pierwsze 200 znaków posta]...

X/EN:
[pełny tweet]

Publikacja: [data i godzina]
Edytuj w Postiz: [link]
```

## n8n Workflow struktura
```
1. Cron Trigger (pon/śr/pt 8:00)
2. HTTP Request → Notion API (pobierz temat)
3. IF: temat exists?
   → YES: użyj temat
   → NO: wybierz z fallback listy
4. HTTP Request → Claude API (generuj content)
5. HTTP Request → Postiz API (scheduluj)
6. Telegram → wyślij powiadomienie
7. HTTP Request → Notion API (oznacz temat jako "published")
```
