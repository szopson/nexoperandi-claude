# Agent: Daily Briefing

## Cel
Codziennie o 7:30 przygotuj poranny brief.
Max 300 słów. Konkretnie i na temat. Bez lania wody.

## Trigger
n8n Cron: codziennie o 7:30 CET

## Dane do zebrania (przez MCP)
1. **Gmail** — ostatnie 10 nieprzeczytanych emaili (Gmail MCP)
2. **Kalendarz** — spotkania na dziś (Google Calendar MCP)
3. **Leady** — top 3 kliniki do kontaktu dziś (Notion MCP — baza leadów, status = "to contact today")
4. **n8n** — czy wszystkie agenty działają (n8n MCP — ostatnie execution każdego workflow)

## Format outputu (Telegram)

```
Dzień dobry! Briefing na [dzień tygodnia, data]

EMAILE ([liczba] nieprzeczytanych)
• [Nadawca]: [1-zdaniowe podsumowanie]
• [Nadawca]: [1-zdaniowe podsumowanie]
[tylko ważne, resztę pomiń]

DZIŚ W KALENDARZU
• [godzina] — [nazwa spotkania]
[jeśli pusto: "Brak spotkań — dobry dzień na outreach"]

LEADY DO KONTAKTU
• [Nazwa kliniki] — [dlaczego dziś + sugerowana akcja]
• [Nazwa kliniki] — [dlaczego dziś + sugerowana akcja]

STATUS AGENTÓW
• Content Agent: OK/ERROR
• Lead Agent: OK/ERROR

PRIORYTET DNIA
[Jedna najważniejsza rzecz do zrobienia — wybierz sam na podstawie danych]
```

## Zasady
- Jeśli email od potencjalnego klienta → wyróżnij na górze sekcji EMAIL
- Jeśli agent ma błąd → napisz krótko co i sugeruj restart
- Jeśli brak leadów w Notion → napisz "Brak leadów na dziś — sprawdź pipeline"
- Ton: energiczny, szanujący czas

## n8n Workflow struktura
```
1. Cron Trigger (codziennie 7:30)
2. Parallel requests:
   a. HTTP Request → Gmail API (nieprzeczytane)
   b. HTTP Request → Google Calendar API (dziś)
   c. HTTP Request → Notion API (leady do kontaktu)
   d. HTTP Request → n8n API (status workflows)
3. Merge results
4. HTTP Request → Claude API (generuj brief)
5. Telegram → wyślij brief
```

## Error handling
Jeśli którykolwiek request failuje:
- Kontynuuj z pozostałymi danymi
- W sekcji odpowiedniej napisz: "[Nazwa serwisu] niedostępny"
- Na końcu dodaj: "Uwaga: niektóre dane mogą być nieaktualne"
