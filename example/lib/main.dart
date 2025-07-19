import 'package:flutter/material.dart';
// Import your package here.
import 'package:q_and_a_widget/q_and_a_widget.dart';

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
                        // Pass the selected choice event from QuestionWidget to the ViewModel.
                        onChoiceSelected: _viewModel.handleChoiceSelected,
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
