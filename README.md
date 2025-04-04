//
//  README.md
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 4/4/25.
//


# 🚀 SwiftUIRepository

A modular SwiftUI-based iOS app leveraging **MVVM**, **Repository Pattern**, and **Test-Driven Development**.
This project is built to show clean architecture, reusable components, Combine-powered reactivity, and fully mocked test coverage.

---

## 🧠 Architecture Breakdown

| Layer          | Responsibility                                          |
|----------------|---------------------------------------------------------|
| **View**       | SwiftUI UI components, subscribes to ViewModel state    |
| **ViewModel**  | Business logic, publishes state, interacts with repo    |
| **Repository** | Abstracts data layer (e.g., network, local storage)     |
| **Service**    | Handles actual network calls (via URLSession, etc)      |
| **Model**      | Codable data models for API/JSON                        |

---

## ✨ Features

- 🧱 **MVVM + Repository Pattern**
- 📡 **Network Layer** with `URLSession` abstraction
- 💉 **Dependency Injection** for testability
- 🧪 **Unit Tests** for ViewModels, Repos, Network Layer
- 📄 **Mock JSON Files** for test scenarios (valid, invalid, empty)
- ✅ **SwiftUI UI Tests** included

---

## 🧬 Project Structure

```
SwiftUIRepository/
├── SwiftUIRepository.xcodeproj/              # Xcode project
├── SwiftUIRepository/                        # Main app code
│   ├── Models/                               # Codable models (e.g., Pokemon.swift)
│   ├── Views/                                # SwiftUI Views
│   ├── ViewModels/                           # ObservableObject classes
│   ├── Repository/                           # PokemonRepository, protocols, etc.
│   └── Services/                             # NetworkManager
├── SwiftUIRepositoryTests/                   # Unit Tests
│   ├── RepositoryTests/                      # FakeNetworkManager, Repo test cases
│   ├── ViewModelTests/                       # ViewModel logic tests
│   ├── NetworkManagerTests/                  # URLSession mocking
│   └── TestJsonFile/                         # Valid, Invalid, NoData test mocks
└── SwiftUIRepositoryUITests/                 # UI Tests
```

---

## 🚀 Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/your-username/SwiftUIRepository.git
cd SwiftUIRepository
```

### 2. Open in Xcode

```bash
open SwiftUIRepository.xcodeproj
```

### 3. Run the App

Choose a simulator or real device, build (`Cmd + B`) and run (`Cmd + R`)!

---

## ✅ Testing

This project is built with **100% testability** in mind. To run tests:

```bash
Cmd + U
```

### Includes:

- ✅ ViewModel logic unit tests
- 🧪 Repository tests with fake service injection
- 📄 Tests using `ValidPokemon.json`, `NoData.json`, and `InValidPokemon.json`
- 🧼 URLSession mocks (`MockSession.swift`)
- 🔁 Edge case handling (empty, corrupted, or malformed data)

---

## 📁 JSON Test Mocks

Located in:

```
SwiftUIRepositoryTests/RepositoryTests/TestJsonFile/
├── ValidPokemon.json
├── InValidPokemon.json
└── NoData.json
```

Use these to test loading success/fail states in your ViewModel or Repository logic.

---
