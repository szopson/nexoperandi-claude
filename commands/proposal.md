---
name: proposal
description: Przygotuj draft propozycji dla klienta NexOperandi
allowed-tools: Read, Write, Edit, WebFetch, WebSearch
---

# Command: /proposal

Przygotuj draft propozycji dla klienta NexOperandi.

## Użycie
```
/proposal [nazwa klienta lub opis sytuacji]
```

## Przykład
```
/proposal "Klinika Estetyczna Piękna, Katowice — chcą AI receptionist,
3 gabinety, problem: nieodebrane telefony po 18:00, budżet ~3000 EUR"
```

## Proces

### 1. Zbierz informacje
- Nazwa kliniki
- Lokalizacja
- Problem który zgłosili (z discovery call)
- Budżet (jeśli znany)
- Dodatkowe wymagania

### 2. Dopasuj tier
Użyj skill `nexoperandi-ops` → sekcja "Tiery usług":
- Tier 1 (~€500): quick win, gotowe automatyzacje
- Tier 2 (~€2-5K): custom workflow
- Tier 3 (~€10-50K): full AI system

### 3. Wypełnij szablon propozycji
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
€[X] jednorazowo + €[Y]/miesiąc utrzymanie

ROI
Przy [konkretne założenie], zwrot inwestycji po [X] tygodniach.

NASTĘPNY KROK
Podpisanie umowy + wpłata 50% zaliczki → zaczynamy w ciągu 5 dni roboczych.
```

### 4. Policz ROI
Przykład dla kliniki estetycznej:
- Założenie: 5 nieodebranych telefonów/tydzień
- Wartość wizyty: 500 zł średnio
- Utracone: 5 × 500 = 2500 zł/tydzień = 10 000 zł/miesiąc
- Koszt rozwiązania: €750 setup + €250/mies. ≈ 4000 zł/mies.
- ROI: 2.5x w pierwszym miesiącu

### 5. Poproś o review
Przed wysłaniem — zawsze poproś o sprawdzenie:
- Czy cena jest adekwatna?
- Czy harmonogram realny?
- Czy coś pominęliśmy z discovery?

## Format output

```
PROPOZYCJA: AI Voice Receptionist dla [Klinika]

[Pełna propozycja według szablonu]

---

CHECKLIST PRZED WYSŁANIEM:
[ ] Cena zweryfikowana
[ ] Harmonogram realny
[ ] ROI policzony z konkretnymi liczbami
[ ] Wszystkie wymagania z discovery uwzględnione

Chcesz coś zmienić przed wysłaniem?
```

## Zasady
- Nigdy nie wysyłaj propozycji bez discovery call
- Zawsze używaj języka klienta (ich słowa z rozmowy)
- Unikaj żargonu technicznego
- Podawaj konkretne liczby, nie "znacząca poprawa"
