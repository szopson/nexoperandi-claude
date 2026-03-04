---
name: nexoperandi-ops
description: Pisanie propozycji dla klientów, wycena projektów, przygotowanie do discovery call, tworzenie ofert, scope'owanie projektów AI automation.
---

# Skill: NexOperandi Ops

## Kiedy używać
Pisanie propozycji dla klientów, wycena projektów, przygotowanie do discovery call,
tworzenie ofert, scope'owanie projektów AI automation.

## Model biznesowy NexOperandi

### Target Market
**Małe firmy <100 pracowników szukające automatyzacji:**
- Kliniki medycyny estetycznej, gabinety dentystyczne
- Firmy usługowe (elektrycy, hydraulicy, serwisy)
- Kancelarie prawne, biura rachunkowe
- Agencje nieruchomości, salony beauty
- Inne biznesy z dużą ilością telefonów/leadów

### Core Offer
- **Setup:** €750 (jednorazowo)
- **Abonament:** €250/miesiąc
- **Produkt:** AI Voice Receptionist (VAPI + n8n)

### Tiery usług (dla większych projektów)

**Tier 1 — Quick Win (~€500)**
- Gotowe automatyzacje z playbooka
- Wdrożenie: 1-2 tygodnie
- Przykłady: automatyczne przypomnienia SMS o wizytach, prosty chatbot FAQ,
  automatyczny follow-up po konsultacji, powiadomienia dla zespołu
- Dla kogo: klient chce zobaczyć czy AI działa zanim wyda więcej

**Tier 2 — Custom Workflow (~€2-5K)**
- Custom AI workflow dopasowany do procesów klienta
- Wdrożenie: 3-6 tygodni
- Przykłady: AI Voice Receptionist, pełna automatyzacja umawiania wizyt,
  integracja z CRM klienta, lead qualification pipeline
- Dla kogo: klient ma konkretny problem, widzi ROI, ma budżet

**Tier 3 — Full AI System (~€10-50K)**
- Kompleksowy system AI, multiple workflows, pełna integracja
- Wdrożenie: 2-6 miesięcy, SLA, ongoing support
- Dla kogo: większy biznes, dużo procesów do automatyzacji

### Flagship product: AI Voice Receptionist
**Stack:** VAPI (voice AI, polski język) + n8n (workflow) + PostgreSQL (dane)

**Co robi:**
- Odbiera telefony 24/7 w imieniu kliniki
- Umawia wizyty, odpowiada na FAQ, przekierowuje pilne sprawy
- Wysyła potwierdzenia SMS i przypomnienia
- Loguje wszystkie rozmowy, raportuje właścicielowi

**ROI dla kliniki:**
- 3-5 wizyt tygodniowo uratowanych z nieodebranych telefonów
- Przy średniej wizycie 500 zł → 1500-2500 zł/tydzień więcej
- Payback w ciągu 2-4 tygodni

## Discovery Call — przygotowanie

### Pytania do zadania klientowi
1. "Ile telefonów dziennie odbiera Wasza recepcja?"
2. "Co się dzieje z telefonami po godzinach / w weekendy?"
3. "Ile trwa umówienie nowej wizyty przez telefon?"
4. "Czy mierzycie ile telefonów zostaje nieodebranych?"
5. "Co byście zrobili z czasem, który teraz idzie na odbieranie telefonów?"
6. "Jaki system CRM / kalendarz używacie?"
7. "Jaki macie budżet na to rozwiązanie?"

### Sygnały że klient jest gotowy
- Mówi konkretne liczby (wie ile traci)
- Ma już kogoś kto "próbował coś zautomatyzować"
- Pyta o integrację z ich systemem
- Pyta o czas wdrożenia, nie o cenę

### Red flags
- "Chcę zobaczyć demo bez żadnych rozmów" (nie rozumie wartości)
- "Mamy już chatbota na stronie" (może nie potrzebować)
- "Budżet to kilkadziesiąt złotych miesięcznie" (tier 1 minimum)

## Propozycja dla klienta — szablon

```
Propozycja: [Nazwa projektu]
Klient: [Nazwa kliniki]
Data: [data]
Przygotował: NexOperandi

---

PROBLEM KTÓRY ROZWIĄZUJEMY
[2-3 zdania. Konkretny ból klienta z discovery call. Ich słowami.]

NASZE ROZWIĄZANIE
[Opisz co budujemy. Bez żargonu. Co klient ZOBACZY i POCZUJE.]

CO DOSTARCZAMY
- [Deliverable 1]
- [Deliverable 2]
- [Deliverable 3]

HARMONOGRAM
Tydzień 1-2: [co robimy]
Tydzień 3-4: [co robimy]
Tydzień 5-6: [testy + wdrożenie]

INWESTYCJA
[Cena] jednorazowo + [cena] miesięczne utrzymanie (opcjonalnie)

ROI
Przy [konkretne założenie], zwrot inwestycji po [X] tygodniach.

NASTĘPNY KROK
Podpisanie umowy + wpłata 50% zaliczki → zaczynamy w ciągu 5 dni roboczych.
```

## Wycena projektów

### Jak liczyć
- Tier 1: flat fee, szybkie wdrożenie, minimal customization
- Tier 2: czas implementacji × stawka + licencje narzędzi + margines 30%
- Tier 3: discovery → szczegółowy scope → estymacja godzinowa × 1.5 (buffer)

### Narzędzia i koszty miesięczne (do budżetu klienta)
- VAPI: ~$50-200/mies. zależnie od minut rozmów
- n8n cloud: $20-50/mies. (lub self-hosted na VPS klienta)
- Hosting VPS (jeśli nowy): ~$20-40/mies.
- SMS gateway (Twilio/MessageBird): ~$0.05-0.10 per SMS

### Zasady wyceny
- Nigdy nie dawaj ceny bez discovery call (nie wiesz zakresu)
- Zawsze podawaj widełki, nie jedną liczbę
- Pierwsze 2 tygodnie to discovery + design, nie coding
- Maintenance contract oddzielnie od projektu

## Execution Squad Framework

### Daily tracking
```
Date: [YYYY-MM-DD]

Execution: [liczba akcji outreach]
Positive Signal: [odpowiedzi]
Booked: [zaplanowane rozmowy]
Show: [odbyte rozmowy]
Close: [zamknięte deale]
Cash: [zebrana kasa]
```

### Weekly review (Decision Day)
```
Week: [W##]

Total execution: [N]
Conversion rate: [X]%
Revenue: €[X]

Co zadziałało:
- [Insight 1]
- [Insight 2]

Co zmieniamy (JEDNA rzecz):
- [Zmiana]

Focus na przyszły tydzień:
- [Priorytet]
```

### Zasady
1. One channel at a time
2. One CTA per campaign
3. 7-day lock before changing
4. Change ONE thing on Decision Day
5. Track daily, review weekly

## Umowa — minimalne elementy
- Zakres (scope) — co robimy, czego NIE robimy
- Harmonogram + milestones
- Płatność: 50% z góry, 50% przy delivery
- Własność kodu: klient
- SLA na maintenance (jeśli jest)
- Klauzula zmian zakresu: każda zmiana = nowa wycena
