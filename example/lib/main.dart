import 'package:flutter/material.dart';
// Import your package here.
import 'package:q_and_a_widget/q_and_a_widget.dart';
import 'dart:convert'; // Required for JsonEncoder

void main() {
  runApp(const MyApp());
}

// The MyApp class creates the ViewModel and manages the Views.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Define a custom list of questions and choices.
  // This list will be passed to the ViewModel.
  final List<QuestionChoices> _myCustomQuestions = const [
    QuestionChoices(
      'c1', // Custom unique ID for the question
      'What is the largest animal on Earth?',
      ['Elephant', 'Blue Whale', 'Giraffe', 'Great White Shark'],
    ),
    QuestionChoices(
      'c2', // Custom unique ID for the question
      'Which gas do plants absorb from the atmosphere?',
      ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
    ),
    QuestionChoices(
      'c3', // Custom unique ID for the question
      'How many continents are there?',
      ['5', '6', '7', '8'],
    ),
  ];

  // Declare _viewModel as 'late final' because it will be initialized in initState.
  late final QuestionViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Initialize _viewModel here, after _myCustomQuestions has been initialized.
    _viewModel = QuestionViewModel(questions: _myCustomQuestions);
  }

  // Local method to handle choice selection and print JSON output.
  void _handleChoiceSelected(
      String questionId, String questionText, String selectedChoice) {
    // Call the ViewModel's method, which returns the list of selected answers.
    List<Map<String, String>> allSelectedAnswersJson =
        _viewModel.handleChoiceSelected(
      questionId,
      questionText,
      selectedChoice,
    );

    // Encode the list to a pretty-printed JSON string.
    String jsonOutput =
        const JsonEncoder.withIndent('  ').convert(allSelectedAnswersJson);

    // Print the JSON output to the debug console.
    debugPrint('JSON Output (All Selected Answers): $jsonOutput');

    // You can now use 'allSelectedAnswersJson' here to send it to a web service,
    // update UI based on all answers, etc.
    // Example:
    // myWebService.sendData(jsonOutput);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questions and Radio Buttons',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Q&A Widget Example'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loop through the list of questions from the ViewModel
                // and create a QuestionWidget for each question.
                ..._viewModel.questions.map<Widget>((questionData) {
                  return Column(
                    children: [
                      QuestionWidget(
                        questionData: questionData,
                        // Pass the local _handleChoiceSelected method as the callback.
                        onChoiceSelected: _handleChoiceSelected,
                      ),
                      const SizedBox(height: 30), // Space between widgets
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
