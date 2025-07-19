import 'package:q_and_a_widget/src/models/question_choices.dart'; // Import the Model class.

// QuestionViewModel class manages the logic and data for the View.
class QuestionViewModel {
  // The default list of dummy questions to be displayed if none are provided.
  final List<QuestionChoices> _dummyQuestions = const [
    QuestionChoices(
      'q1', // Unique ID for the question
      'What is the capital of Turkey?',
      ['Istanbul', 'İzmir', 'Ankara', 'Bursa'],
    ),
    QuestionChoices(
      'q2', // Unique ID for the question
      'What is the highest mountain in the world?',
      ['K2', 'Mount Everest', 'Kangchenjunga', 'Lhotse'],
    ),
    QuestionChoices(
      'q3', // Unique ID for the question
      'Which planet is known as the Red Planet?',
      ['Earth', 'Mars', 'Jupiter', 'Venus'],
    ),
    QuestionChoices(
      'q4', // Unique ID for the question
      'What is the largest ocean on Earth?',
      ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
    ),
  ];

  // The actual list of questions that this ViewModel will use.
  // It can be initialized with _dummyQuestions or a custom list.
  late final List<QuestionChoices> _questions;

  // Map to store the selected answer for each question.
  // Key: Question ID, Value: Selected choice string.
  final Map<String, String> _allSelectedAnswers = {};

  // Constructor for QuestionViewModel.
  // It can optionally take a list of questions; otherwise, it uses _dummyQuestions.
  QuestionViewModel({List<QuestionChoices>? questions}) {
    _questions = questions ?? _dummyQuestions;
  }

  // Provides the list of questions to the View.
  List<QuestionChoices> get questions => _questions;

  // Method called when an option is selected.
  // It processes the selected answer and prints the JSON output to the debug console.
  List<Map<String, String>> handleChoiceSelected(
      String questionId, String questionText, String selectedChoice) {
    // Update the map with the latest selected answer for the given question ID.
    _allSelectedAnswers[questionId] = selectedChoice;

    // Convert the map of all selected answers into a list of maps for JSON output.
    List<Map<String, String>> jsonOutputList = _allSelectedAnswers.entries
        .map((entry) => {
              'question_id': entry.key,
              // Find the original question text using the ID for the output
              // This assumes that all question IDs in _allSelectedAnswers exist in _questions.
              'question_text':
                  _questions.firstWhere((q) => q.id == entry.key).question,
              'selected_answer': entry.value,
            })
        .toList();
    return jsonOutputList;
  }
}
