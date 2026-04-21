## CineVault 🎬

A production-grade, Netflix-style Flutter application for discovering, exploring, and tracking movies and TV shows.

Beyond being a functional movie tracker, CineVault serves as a **technical showcase of advanced software architecture**, demonstrating the practical application of SOLID principles, and robust Riverpod state management.

## ✨ Key Features

- **Curated Home Feed:** Netflix-style horizontal carousels that dynamically fetch and cache discovery categories (e.g., Marvel, Pixar, Sci-Fi) using Riverpod caching.

- **Deep Search Engine:** Search the OMDb database for any movie, series, or episode.

- **Cinematic Detail View:** Tap any movie to pull up a bottom sheet with full plot details, cast, runtimes, and ratings using a secondary ID-based API query.

- **Offline Watchlist:** Save your favorite movies to a persistent local SQLite database. Your vault is always available, even offline.

- **Optimized Image Loading:** Uses cached_network_image to save data and load posters instantly on subsequent visits, complete with shimmer placeholders and broken-link fallbacks.

## 🏗️ Technical Architecture

This project strictly adheres to Clean Architecture and SOLID principles to ensure the codebase remains scalable, testable, and maintainable.

1. **The Strategy Pattern (Search Logic)**

Searching by "Title" requires a different API query format than searching by "ID". By implementing an `ISearchStrategy` interface, the app can hot-swap between `TitleSearchStrategy` and `IdSearchStrategy` without bloating the API manager (Open-Closed Principle).

2. **The Repository Facade**

The UI never talks directly to the database or the API. Instead, it speaks to the `CineRepository`, which acts as a Facade. It orchestrates the `IRemoteDataSource` (HTTP API) and `ILocalDataSource` (SQLite) so the business logic stays completely decoupled from the tools.

3. **The Manager Pattern**

The `WatchlistManager` enforces business rules (like preventing duplicate movie saves) before delegating data to the Repository. It acts as the single source of truth for the local state.

4. **Advanced Riverpod State Management**

`AsyncNotifier:` Used to safely handle API search results, automatically exposing `.loading`, `.data`, and `.error` states to the UI.

`FutureProvider.family`: Used to fetch specific movie details and home-screen rows, leveraging Riverpod's built-in caching so previously viewed movies load instantly without extra network requests.

## 🛠️ Tech Stack

- **Framework:** Flutter

- **State Management:** flutter_riverpod (Notifiers & Family Providers)

- **Local Database:** sqflite & path (Relational Database)

- **Networking:** http

- **Environment Security:** flutter_dotenv

- **Image Caching:** cached_network_image

## 🚀 Getting Started

1. **Prerequisites**

Flutter SDK installed on your machine.

A free API key from OMDb API.

2. **Environment Setup**

Create a `.env` file in the `lib/` directory of your project:

```bash
touch lib/.env
```

Add your OMDb API key to the `.env` file:

```bash
OMDB_API_KEY=your_api_key_here
```

3. **Installation**

Clone the repository and install dependencies:

```bash
git clone https://github.com/yourusername/cine_vault.git
cd cine_vault
flutter pub get
```

4. **Run the App**

```bash
flutter run
```

## 📂 Project Structure

```bash
lib/
├── model/ # Core data models (CineItem, Watchlist)
├── enum/ # Strict typing (CineType)
├── managers/ # Business logic (ApiManager, PersistenceManager, WatchlistManager)
├── providers/ # Riverpod Dependency Injection and State Notifiers
├── repository/ # Facade pattern bridging local and remote data
├── screens/ # Main UI views (Home, Search, Watchlist, Main Navigation)
├── strategy/ # Interfaces & implementations for API/DB logic
├── theme/ # Global Netflix-inspired dark theme styling
└── widgets/ # Reusable UI components (CineDetail modal, etc.)
```
