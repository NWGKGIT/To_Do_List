# Flutter SQLite To-Do App

A simple, clean, and elegant to-do list application built with Flutter. It demonstrates core concepts including state management, local data persistence with SQLite, and building a user-friendly interface.

## 📋 Features

- **Create, Read, Update, Delete (CRUD):** Full support for task management.
- **Local SQLite Database:** All tasks are stored locally on your device, ensuring data is available offline.
- **Clean, Modern UI:** A minimalist and intuitive user interface.
- **State Management:** Efficiently manages the app's state to keep the UI in sync with the data.
- **Toggle Task Status:** Mark tasks as complete or incomplete with a simple tap.

## 📸 Screenshots

*(Add your app screenshots here. You can drag and drop them onto the GitHub README editor.)*

| Task List (Empty) | Task List (With Items) | Add Task Dialog |
| :---------------: | :--------------------: | :---------------: |
| ![Empty State](https://placehold.co/300x600/e8eaf6/7c7c7c?text=Empty+List)      | ![Task List](https://placehold.co/300x600/e8eaf6/7c7c7c?text=Task+List)           | ![Add Task](https://placehold.co/300x600/e8eaf6/7c7c7c?text=Add+Task+Dialog)        |


## 📂 Project Structure

The project follows a clean and scalable folder structure:


lib/
├── main.dart                 // App entry point
├── models/
│   └── task.dart             // Data model for a task
├── db/
│   └── database_helper.dart  // SQLite database helper class
├── screens/
│   └── home_screen.dart      // Main UI screen
└── widgets/
└── task_tile.dart        // Reusable widget for displaying a task


## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

- You need to have the Flutter SDK installed on your machine. For instructions, see the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/your-username/flutter-sqlite-todo-app.git](https://github.com/your-username/flutter-sqlite-todo-app.git)
    cd flutter-sqlite-todo-app
    ```

2.  **Install dependencies:**
    Run the following command in your terminal to get all the required packages:
    ```sh
    flutter pub get
    ```

3.  **Run the application:**
    Connect a device or start an emulator, then run the app with:
    ```sh
    flutter run
    ```

## 📦 Key Dependencies

This project utilizes the following packages:

-   [`sqflite`](https://pub.dev/packages/sqflite): For local storage using SQLite.
-   [`path`](https://pub.dev/packages/path): For handling file system paths.
-   [`google_fonts`](https://pub.dev/packages/google_fonts): For clean and beautiful typography.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
