# Flutter Calculator App

A modern and responsive calculator built with Flutter. This app supports basic and advanced arithmetic operations, memory functions, error handling, history tracking, and theming—all packed into a single screen experience.

## ✨ Features

* **Basic Arithmetic**: Addition, subtraction, multiplication, and division
* **Advanced Functions**: Percentage, square root, negation (+/-)
* **Memory Functions**:

  * `MC`: Memory Clear
  * `MR`: Memory Recall
  * `M+`: Memory Add
  * `M-`: Memory Subtract
* **Calculation History**: Toggleable display of past operations
* **Clear Operations**:

  * `C`: Clears entire expression
  * `CE`: Clears last character entry
* **Error Handling**:

  * Divide-by-zero prevention
  * Graceful error messages
* **Responsive Layout**: Button grid adapts to screen size
* **Visual Feedback**: Themed buttons with animations

## 📱 Screenshots

*Add your screenshots here to showcase UI and features.*

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (latest stable version)
* Compatible IDE (VS Code, Android Studio, etc.)

### Installation

```bash
git clone https://github.com/yourusername/flutter_calculator_app.git
cd flutter_calculator_app
flutter pub get
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart         # Main entry point and app logic
```

## 🔧 How It Works

* The app uses a `StatefulWidget` to manage internal states like expression, result, memory, and history.
* User inputs are parsed and evaluated using custom logic (including operator precedence).
* Memory values persist in runtime using a `double _memory` variable.
* Tapping `H` toggles the history panel.

## 📌 Usage Notes

* Tap `=` to evaluate the current expression.
* `+/-` toggles the sign of the current number.
* `%` converts the current number into percentage.
* `√` computes square root of the current number.

## 🎨 Theming

* Dark theme with accent colors for primary actions.
* Responsive design ensures usability across various screen sizes.


## 🤝 Contributions

Contributions are welcome! Open issues, submit PRs, or suggest features.

## 📄 License

This project is licensed under the MIT License.

---

Built with ❤️ using Flutter.
