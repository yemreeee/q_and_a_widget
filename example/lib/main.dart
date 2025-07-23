import 'package:flutter/material.dart';
// Import your package here.
import 'package:q_and_a_widget/q_and_a_widget.dart';
import 'dart:convert'; // Required for JsonEncoder

void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
/// It sets up the [MaterialApp] and defines the home page.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questions and Radio Buttons',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const QAPage(), // The home page is now a separate widget.
    );
  }
}

/// A StatefulWidget that represents the main page of the Q&A application.
/// It manages the state, including the questions, answers, and ViewModel.
class QAPage extends StatefulWidget {
  const QAPage({super.key});

  @override
  State<QAPage> createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  final List<QuestionChoices> _myCustomQuestions = const [
    QuestionChoices(
      id: 'c1', // Custom unique ID for the question
      question: 'What is the largest animal on Earth?',
      choices: ['Elephant', 'Blue Whale', 'Giraffe', 'Great White Shark'],
    ),
    QuestionChoices(
      id: 'c2', // Custom unique ID for the question
      question: 'Which gas do plants absorb from the atmosphere?',
      choices: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
    ),
    QuestionChoices(
      id: 'c3', // Custom unique ID for the question
      question: 'How many continents are there?',
      choices: ['5', '6', '7', '8'],
    ),
    QuestionChoices(
      id: 'c4',
      question: 'Which country is known as the Land of the Rising Sun?',
      choices: ['China', 'South Korea', 'Japan', 'Thailand'],
    ),
    QuestionChoices(
      id: 'c5',
      question: 'What is the chemical symbol for gold?',
      choices: ['Ag', 'Au', 'G', 'Go'],
    ),
    QuestionChoices(
      id: 'c6',
      question: 'Who wrote "Romeo and Juliet"?',
      choices: [
        'Charles Dickens',
        'William Shakespeare',
        'Jane Austen',
        'Mark Twain'
      ],
    ),
    QuestionChoices(
      id: 'c7',
      question: 'What is the smallest prime number?',
      choices: ['0', '1', '2', '3'],
    ),
    QuestionChoices(
      id: 'c8',
      question: 'In which year did the Titanic sink?',
      choices: ['1905', '1912', '1918', '1923'],
    ),
    QuestionChoices(
      id: 'c9',
      question: 'What is the main ingredient in guacamole?',
      choices: ['Tomato', 'Onion', 'Avocado', 'Cilantro'],
    ),
    QuestionChoices(
      id: 'c10',
      question: 'Which artist painted the Mona Lisa?',
      choices: [
        'Vincent van Gogh',
        'Pablo Picasso',
        'Claude Monet',
        'Leonardo da Vinci'
      ],
    ),
  ];

  // Declare _viewModel as 'late final' because it will be initialized in initState.
  late final QuestionViewModel _viewModel;

  // A state variable to hold the list of all selected answers.
  List<Map<String, String>> _allSelectedAnswers = [];

  @override
  void initState() {
    super.initState();
    _viewModel = QuestionViewModel(questions: _myCustomQuestions);
  }

  // A method to display the selected answers in a dialog.
  void _showSelectedAnswersDialog() {
    showDialog(
      context: context,
      // The context used here is now from _QAPageState, which is a descendant
      // of MaterialApp, thus resolving the 'No MaterialLocalizations found' error.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Answers (JSON)'),
          content: SingleChildScrollView(
            // Use SingleChildScrollView in case the JSON is long
            child: Text(_allSelectedAnswers.isEmpty
                ? 'No answer has been selected yet.'
                : const JsonEncoder.withIndent('  ')
                    .convert(_allSelectedAnswers)),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Local method to handle choice selection and print JSON output.
  void _handleChoiceSelected(
      String questionId, String questionText, String selectedChoice) {
    // Call the ViewModel's method, which returns the list of selected answers.
    final allSelectedAnswers = _viewModel.handleChoiceSelected(
      questionId,
      questionText,
      selectedChoice,
    );

    // Update the state with the new list of answers.
    setState(() {
      _allSelectedAnswers = allSelectedAnswers;
    });

    // For demonstration, also print the JSON to the console.
    debugPrint(
        'JSON Output (All Selected Answers): ${const JsonEncoder.withIndent('  ').convert(allSelectedAnswers)}');

    // You can now use 'allSelectedAnswersJson' here to send it to a web service,
    // update UI based on all answers, etc.
    // Example:
    // myWebService.sendData(jsonOutput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showSelectedAnswersDialog,
        tooltip: 'Show JSON Output',
        child: const Icon(Icons.data_object),
      ),
    );
  }
}
