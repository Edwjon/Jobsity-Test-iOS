# 📺 Jobsity Test - TV Series App

## 📖 About the Project
Jobsity Test is an iOS application that allows users to browse TV series, view episodes, mark their favorite shows, explore detailed information about actors, and securely authenticate with a PIN. The app follows the **VIPER architecture** and adheres to **SOLID principles** for maintainability and scalability.

## 🚀 Features
- 🔍 **Search & Browse TV Series**
- 🎭 **Search for People & View Actor Details**
- 📅 **View Episode Details**
- ⭐ **Mark Series as Favorite**
- 🔒 **Secured with PIN**
- 🎬 **Browse Episodes by Season**
- 🔄 **Dynamic UI Updates on Favorite Changes**
- 🛠 **Test Coverage with Unit Tests**

## 🛠️ Tech Stack
- **Swift**
- **UIKit**
- **VIPER Architecture**
- **Keychain** (for PIN security)
- **TVMaze API** (for fetching TV series & people data)
- **UserDefaults** (for favorite series storage)
- **Unit Testing with XCTest**

## 📂 Project Structure (VIPER)
```
Jobsity Test/
│── Core/
│── Modules/
│   ├── Authentication/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
|   ├── EpisodesDetail/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
|   ├── FavoritesList/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
|   ├── PeopleSearch/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
|   ├── PersonDetail/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
|   ├── PinSetup/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
|   ├── SeriesDetail/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
|   ├── SeriesList/
│   │   ├── View/
│   │   ├── Presenter/
│   │   ├── Interactor/
│   │   ├── Router/
│   │   ├── Entity/
│── Networking/
│── Utilities/
│── Tests/
│   ├── AuthenticationTests/
│   ├── EpisodeDetailTests/
│   ├── FavoritesManagerTests/
│   ├── FavoritesListTests/
│   ├── KeychainHelperTests/
│   ├── PeopleSearchTests/
│   ├── PersonDetailTests/
│   ├── PinSetupTests/
│   ├── SeriesDetailTests/
│   ├── SeriesListTests/
│── Resources/
```

## 📦 Installation & Run
### ▶️ **How to Run the App**
1. **Clone the repository**  
   ```sh
   git clone https://github.com/your-username/jobsity-test.git
   cd jobsity-test
   ```

2. **Open the project in Xcode**  
   ```sh
   open Jobsity Test.xcodeproj
   ```

3. **Run on a simulator or device**  
   - Select a simulator
   - Press **Cmd + R** to run

## 🏆 Bonus Features Implemented
- ✅ **Favorite Series**: Users can save and remove their favorite shows.
- ✅ **Authentication**: Users can set a **PIN code** for secure access.
- ✅ **Keychain Storage**: PINs are securely stored using Apple's **Keychain API**.
- ✅ **Search Actors**: Users can search for actors and view their details.
- ✅ **Episode Browser**: Browse episodes by season dynamically.
- ✅ **Offline Support for Favorites**: Favorite series are stored in **UserDefaults**.
- ✅ **VIPER & SOLID**: The app is modular and scalable.
- ✅ **Unit Testing**: Comprehensive test coverage with **XCTest**.

## 🧪 Unit Test Coverage
| Module          | Test Coverage |
|----------------|--------------|
| Authentication | ✅ Yes |
| Episode Detail | ✅ Yes |
| Favorites List | ✅ Yes |
| Favorites Manager | ✅ Yes |
| Keychain Helper | ✅ Yes |
| People Search | ✅ Yes |
| Person Detail | ✅ Yes |
| PIN Setup | ✅ Yes |
| Series Detail | ✅ Yes |
| Series List | ✅ Yes |
| API Client | ✅ Yes |
