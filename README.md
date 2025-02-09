# 📺 Jobsity Test - TV Series App

## 📖 About the Project
Jobsity Test is an iOS application that allows users to browse TV series, view episodes, mark their favorite shows, and explore detailed information about each episode. The app follows the **VIPER architecture** and adheres to **SOLID principles** for maintainability and scalability.

## 🚀 Features
- 🔍 **Search & Browse TV Series**
- 📅 **View Episode Details**
- ⭐ **Mark Series as Favorite**
- 🔒 **Secured with PIN**

## 🛠️ Tech Stack
- **Swift**
- **UIKit**
- **VIPER Architecture**
- **Keychain** (for PIN security)
- **TVMaze API** (for fetching TV series data)

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
|   ├── Pin Setup/
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

## 📦 Distribution
- The `.ipa` file is available in the **distribution/** folder for testing on physical devices.

## 🏆 Bonus Features Implemented
- ✅ **Favorite Series**: Users can save and remove their favorite shows.
- ✅ **Authentication**: Users can set a **PIN code** for secure access.
- ✅ **Keychain Storage**: PINs are securely stored using Apple's **Keychain API**.
- ✅ **VIPER & SOLID**: The app is modular and scalable.

