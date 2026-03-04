---
name: brief
description: Przygotuj podsumowanie dnia - emaile, kalendarz, leady, status agentów
allowed-tools: Read, Write, Edit, WebFetch, WebSearch
---

# Command: /brief

Przygotuj podsumowanie dnia dla NexOperandi.

## Użycie
```
/brief              # Pełny brief
/brief quick        # Tylko najważniejsze
/brief week         # Podsumowanie tygodnia
```

## Dane do zebrania (przez MCP)
1. **Gmail** — ostatnie 10 nieprzeczytanych emaili
2. **Kalendarz** — spotkania na dziś
3. **Leady** — top 3 kliniki do kontaktu dziś (Notion → baza leadów, status = "to contact today")
4. **n8n** — czy wszystkie agenty działają (ostatnie execution każdego workflow)

## Format outputu

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
[Jedna najważniejsza rzecz do zrobienia — wybierz na podstawie danych]
```

## Zasady
- Jeśli email od potencjalnego klienta → wyróżnij na górze sekcji EMAIL
- Jeśli agent ma błąd → napisz krótko co i sugeruj restart
- Jeśli brak leadów w Notion → napisz "Brak leadów na dziś — sprawdź pipeline"
- Ton: energiczny, szanujący czas

## Weekly Summary (/brief week)

Dodatkowe sekcje:
- Week-over-week comparison
- Decision Day analysis
- Revenue tracking
- Co zadziałało / co zmieniamy
