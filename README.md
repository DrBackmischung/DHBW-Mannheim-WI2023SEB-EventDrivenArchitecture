# DHBW-Mannheim-WI2023SEB-EventDrivenArchitecture

Dieses Projekt zeigt eine einfache, aber vollständige Implementierung einer **Event-Driven Architecture (EDA)** in Erlang. Es besteht aus einer zentralen Event-Bus-Komponente und zwei Services, die über Ereignisse lose gekoppelt sind.

---

## 📦 Komponentenübersicht

| Modul             | Rolle                            |
|-------------------|----------------------------------|
| `event_bus`       | Zentrale Eventverteilung (Publisher/Subscriber) |
| `order_service`   | Sendet Events (z. B. Bestellung aufgegeben)     |
| `billing_service` | Reagiert auf Events (z. B. Rechnung ausstellen) |
| `eda_app`         | Initialisiert & demonstriert alles              |

---

## ▶️ Ausführen

### Voraussetzungen
- Erlang installiert (z. B. über `brew install erlang` oder `apt install erlang`)

### Schritte

```bash
cd erlang-eda
erl
```

In der Erlang-Shell:

```erlang
c(event_bus).
c(order_service).
c(billing_service).
c(eda_app).
eda_app:run_demo().
```

---

## ✅ Beispielausgabe

```
[OrderService] Order placed: {order_placed,"alice@example.com","Buch"}
[BillingService] Charging "alice@example.com" for item "Buch"
[OrderService] Order placed: {order_placed,"bob@example.com","Headset"}
[BillingService] Charging "bob@example.com" for item "Headset"
```

---

## 💡 Warum ist das Event-Driven Architecture?

**Event-Driven Architecture (EDA)** basiert auf drei zentralen Prinzipien:

### 1. 🔌 **Lose Kopplung**
- Der `order_service` **kennt nicht den** `billing_service`.
- Es wird nur ein Event an den `event_bus` gesendet.

### 2. 📣 **Event-Publishing**
- Ereignisse wie `{order_placed, User, Item}` werden durch `publish/1` gesendet.
- Der `event_bus` schickt sie an alle abonnierten Prozesse.

### 3. 🎯 **Reaktive Services**
- Der `billing_service` **reagiert** auf relevante Events via `handle_info/2`.
- Weitere Subscriber könnten **parallel** hinzugefügt werden, ohne dass der Publisher davon weiß.


