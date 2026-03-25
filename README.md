# UserExplorerPro

`UserExplorerPro` is a SwiftUI iOS app that fetches and displays user profiles from the `randomuser.me` API. It presents a scrollable user list with pagination and a detail screen for profile information.

## Features

- Infinite scrolling user list
- Profile detail screen
- Remote image loading with `AsyncImage`
- Layered project structure with presentation, domain, data, and core modules
- Lightweight dependency wiring through `AppDI`

## Tech Stack

- Swift
- SwiftUI
- Swift Concurrency (`async/await`)
- `URLSession`
- `randomuser.me` API

## Project Structure

```text
UserExplorerPro/
├── Core
│   ├── DI
│   └── Network
├── Data
│   ├── DTO
│   └── RepositoryImpl
├── Domain
│   ├── Models
│   ├── Repository
│   └── UseCases
└── Presentation
    ├── Screens
    └── ViewModels
```

## Architecture

The app follows a simple clean architecture style:

- `Presentation` contains SwiftUI views and the `UserViewModel`
- `Domain` contains models, repository contracts, and use cases
- `Data` contains DTOs and repository implementations
- `Core` contains networking and dependency injection

## Running the App

1. Open the project in Xcode.
2. Build and run on an iOS Simulator.
3. The app fetches users from `https://randomuser.me/api/`.

## Public Repository Notes

- Generated files and build artifacts are excluded through `.gitignore`
- You can add screenshots to this README before publishing
- If you want a public license, add `LICENSE` with your preferred choice such as MIT
# IOS_UserExplorerPro_MVVM_Clean_SwiftUI
