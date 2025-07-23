# Q&A Widget

![Q&A Widget Header](https://github.com/yemreeee/q_and_a_widget/blob/main/example/header_(Medium).png?raw=true)

A Flutter package for displaying questions with multiple-choice radio button options, designed with the MVVM (Model-View-ViewModel) architecture in mind. This package provides a reusable `QuestionWidget` and a `QuestionViewModel` to manage your question data and user selections, making your UI logic clean and testable.

## Features

* **MVVM Architecture:** Separates UI, UI logic, and data for better maintainability and testability.

* **Dynamic Question Display:** Easily display a list of questions with their respective radio button choices.

* **JSON Output:** Provides a JSON output to the debug console for each selected answer, including the question ID and text, suitable for database storage.

* **Customizable Questions:** Use your own list of `QuestionChoices` objects to populate the widgets.

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  q_and_a_widget: ^0.0.1 # Replace with the latest version
```

Then, run `flutter pub get` in your project's root directory.

## How to Use

### 1. Define Your Questions

Your questions should be represented by the `QuestionChoices` model provided by the package.

```dart
import 'package:q_and_a_widget/q_and_a_widget.dart';

final List<QuestionChoices> myQuestions = const [
  QuestionChoices(
    id: 'q1', // Unique ID for the question
    question: 'What is the capital of France?',
    choices: ['Berlin', 'Madrid', 'Paris', 'Rome'],
  ),
  QuestionChoices(
    id: 'q2', // Unique ID for the question
    question: 'Which planet is closest to the Sun?',
    choices: ['Earth', 'Mars', 'Mercury', 'Venus'],
  ),
  // Add more questions as needed
];
```

### 2. Initialize the ViewModel

In your StatefulWidget's `initState` method, create an instance of `QuestionViewModel`, optionally passing your custom list of questions.

```dart
import 'package:flutter/material.dart';
import 'package:q_and_a_widget/q_and_a_widget.dart';

class MyQuizPage extends StatefulWidget {
  const MyQuizPage({Key? key}) : super(key: key);

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  final List<QuestionChoices> _myCustomQuestions = const [
    QuestionChoices(id: 'c1', question: 'What is the largest animal on Earth?', choices: ['Elephant', 'Blue Whale', 'Giraffe', 'Great White Shark']),
    QuestionChoices(id: 'c2', question: 'Which gas do plants absorb from the atmosphere?', choices:['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen']),
  ];

  late final QuestionViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = QuestionViewModel(questions: _myCustomQuestions); // Pass your custom questions
    // If you want to use the default dummy questions, simply do:
    // _viewModel = QuestionViewModel();
  }

  @override
  Widget build(BuildContext context) {
    // ... your UI code ...
    return Scaffold(
      appBar: AppBar(title: const Text('My Quiz')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Loop through questions from the ViewModel
            ..._viewModel.questions.map<Widget>((questionData) {
              return QuestionWidget(
                questionData: questionData,
                onChoiceSelected: _viewModel.handleChoiceSelected,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
```

### 3. Display the Widgets

Use the `QuestionWidget` within your Flutter UI, passing the `QuestionChoices` object and the `handleChoiceSelected` callback from your ViewModel.

```dart
// Inside your build method, after initializing _viewModel:

Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ..._viewModel.questions.map<Widget>((questionData) {
      return Column(
        children: [
          QuestionWidget(
            questionData: questionData,
            onChoiceSelected: _viewModel.handleChoiceSelected,
          ),
          const SizedBox(height: 30), // Space between widgets
        ],
      );
    }).toList(),
  ],
)
```

### Preview

Here's how the Q&A Widget looks in action:

![Q&A Widget Example](https://github.com/yemreeee/q_and_a_widget/blob/main/example/image.png?raw=true)

## JSON Output Format

When a user selects an answer, the `handleChoiceSelected` method in `QuestionViewModel` will print a JSON object representing *all currently selected answers* as a list to the debug console (e.g., in VS Code's Debug Console or your terminal where `flutter run` is executing).

Example JSON output for multiple selections:

```json
[
  {
    "question_id": "c1",
    "question_text": "What is the largest animal on Earth?",
    "selected_answer": "Blue Whale"
  },
  {
    "question_id": "c2",
    "question_text": "Which gas do plants absorb from the atmosphere?",
    "selected_answer": "Carbon Dioxide"
  }
]
```

This output is designed to be easily parsed and stored in a database.

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/yemreeee/q_and_a_widget).

## License

This package is distributed under the [MIT License](https://github.com/yemreeee/q_and_a_widget/blob/main/LICENSE).
