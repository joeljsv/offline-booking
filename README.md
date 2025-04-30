# 🎫 Offline-First Flutter Ticket Booking App
A clean architecture-based Flutter application for booking and managing transport tickets offline using `Hive`, `BLoC`, `AutoRoute`, and `GetIt`. The app is designed to simulate local notifications, maintain balance, and handle cancellation logic with refund rules.

---

## 📦 Features

- ✅ Offline-first storage with Hive
- ✅ Clean architecture (data, domain, presentation layers)
- ✅ State management using BLoC
- ✅ Route navigation powered by AutoRoute
- ✅ Balance tracking and refund handling
- ✅ Local push notifications for updates
- ✅ Advanced filtering and search functionality
- ✅ Reusable and modular UI components
- ✅ Testable and maintainable folder structure

---

## 🗂 Folder Structure

```
lib/
├── core/
│   ├── constants/
│   ├── enums/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   ├── repositories_impl/
│   └── services/
├── domain/
│   ├── entities/
│   ├── usecases/
│   └── repositories/
├── presentation/
│   ├── bloc/ticket/
│   ├── pages/
│   ├── routes/
│   └── widgets/
├── injection.dart
└── main.dart

screen/ (contains screenshots)
apks/   (contains build APKs)
```

---

## 🧱 Tech Stack & Dependencies

### Core Dependencies
| Package                    | Purpose                      |
|---------------------------|------------------------------|
| `flutter_bloc`            | State management             |
| `auto_route`              | Declarative routing          |
| `get_it`                  | Dependency injection         |
| `hive` / `hive_flutter`   | Local database               |
| `json_annotation`         | Model serialization          |
| `flutter_local_notifications` | Local push notifications |
| `intl`                    | Date formatting              |
| `equatable`               | Value-based equality         |

### Dev Dependencies
| Package                    | Purpose                      |
|---------------------------|------------------------------|
| `build_runner`            | Code generation              |
| `hive_generator`          | Hive model adapters          |
| `json_serializable`       | JSON parsing boilerplate     |
| `auto_route_generator`    | AutoRoute navigation builder |
| `flutter_lints`           | Code linting & best practices|

---
