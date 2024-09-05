# Thriftly - Expense Tracker App

Welcome to **Thriftly**, your go-to expense tracker app designed to help you manage and analyze your expenses with ease. This app is built using **Flutter**, incorporating **BLoC** for state management, adhering to **Clean Architecture** principles, and utilizing **Isar DB** for efficient local storage and **Firebase** for cloud integration.

## Features

### 1. Categories
- Organize your expenses into customizable categories for better financial insight.
- Easily track where your money is going by grouping transactions into categories such as Food, Transportation, Entertainment, and more.

### 2. Transactions
- **Daily**, **Weekly**, and **Monthly** tracking of all your expenses.
- Add, edit, and delete transactions with an intuitive interface.
- View past transactions filtered by date and category for comprehensive oversight.

### 3. Analysis (Coming Soon)
- Visual analysis tools to help you understand your spending habits.
- Compare daily, weekly, and monthly expenses through charts and graphs to make informed financial decisions.

## Technologies Used

- **Flutter**: Cross-platform framework for building iOS and Android applications.
- **BLoC**: Business Logic Component (BLoC) pattern for reactive state management.
- **Clean Architecture**: Structured project following separation of concerns for scalability and maintainability.
- **Isar DB**: A fast, efficient local NoSQL database for offline storage.
- **Firebase**: Used for cloud storage, authentication, and other backend services.

## Getting Started

### Prerequisites

Before you can run the app, ensure you have the following tools installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Isar CLI](https://isar.dev/)
- Firebase configuration (you will need to set up Firebase for your project)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repo/thriftly.git
   cd thriftly
   ```

2. Install the required dependencies:

   ```bash
   flutter pub get
   ```

3. Set up **Firebase**:

   - Follow the instructions to connect your Firebase project for both Android and iOS.

4. Run the app:

   ```bash
   flutter run
   ```

### Folder Structure

- **lib/core**: Contains core utilities, services, and base classes.
- **lib/features**: Organized by feature (e.g., transactions, categories, analysis).
- **lib/presentation**: UI components like screens, widgets, and styles.
- **lib/data**: Repositories and models that handle data storage and retrieval.
- **lib/domain**: Business logic and entities following the Clean Architecture structure.

## Contributions

Contributions are welcome! If you'd like to contribute to Thriftly, feel free to submit a pull request, or open an issue for suggestions and improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

Happy tracking with **Thriftly**!
