import 'package:q_and_a_widget/src/models/question_choices.dart'; // Imports the Model class.
// import 'package:http/http.dart' as http; // Uncomment if you plan to use HTTP requests.

/// [QuestionViewModel] manages the application's logic and data related to questions.
/// It acts as an intermediary between the UI (View) and the data (Model).
/// It does not depend on Flutter widgets directly, making it easily testable.
class QuestionViewModel {
  /// A default, immutable list of dummy questions.
  /// Used if no custom questions are provided during ViewModel initialization.
  final List<QuestionChoices> _dummyQuestions = const [
    QuestionChoices(
      'q1',
      'What is the capital of Turkey?',
      ['Istanbul', 'İzmir', 'Ankara', 'Bursa'],
    ),
    QuestionChoices(
      'q2',
      'What is the highest mountain in the world?',
      ['K2', 'Mount Everest', 'Kangchenjunga', 'Lhotse'],
    ),
    QuestionChoices(
      'q3',
      'Which planet is known as the Red Planet?',
      ['Earth', 'Mars', 'Jupiter', 'Venus'],
    ),
    QuestionChoices(
      'q4',
      'What is the largest ocean on Earth?',
      ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
    ),
  ];

  /// The actual list of questions that this ViewModel will provide to the UI.
  /// It is initialized either with [_dummyQuestions] or a custom list.
  late final List<QuestionChoices> _questions;

  /// A private map to store the currently selected answer for each question.
  /// The key is the question ID, and the value is the selected choice string.
  final Map<String, String> _allSelectedAnswers = {};

  /// Constructs a [QuestionViewModel].
  ///
  /// If a [questions] list is provided, it will be used. Otherwise,
  /// the [_dummyQuestions] list will be used as the default.
  QuestionViewModel({List<QuestionChoices>? questions}) {
    _questions = questions ?? _dummyQuestions;
  }

  /// Provides the list of questions managed by this ViewModel.
  ///
  /// This getter allows the View to access the questions without directly
  /// modifying the ViewModel's internal state.
  List<QuestionChoices> get questions => _questions;

  /// Handles the selection of a choice for a specific question.
  ///
  /// This method updates the internal state of selected answers,
  /// prints the complete list of selected answers as JSON to the debug console,
  /// and returns this list.
  ///
  /// [questionId]: The unique ID of the question for which a choice was selected.
  /// [questionText]: The text of the question for which a choice was selected.
  /// [selectedChoice]: The text of the choice that was selected by the user.
  /// Returns a [List<Map<String, String>>] representing all currently
  /// selected answers, formatted for potential database storage or API calls.
  List<Map<String, String>> handleChoiceSelected(
      String questionId, String questionText, String selectedChoice) {
    // Update the map with the latest selected answer for the given question ID.
    // If the question was answered before, its answer will be overwritten.
    _allSelectedAnswers[questionId] = selectedChoice;

    // Convert the map of all selected answers into a list of maps.
    // Each map in the list represents a single question's selected answer.
    List<Map<String, String>> jsonOutputList = _allSelectedAnswers.entries
        .map((entry) => {
              'question_id': entry.key,
              // Retrieve the original question text using its ID from the _questions list.
              // This assumes that all question IDs in _allSelectedAnswers exist in _questions.
              'question_text':
                  _questions.firstWhere((q) => q.id == entry.key).question,
              'selected_answer': entry.value,
            })
        .toList();

    return jsonOutputList; // Return the list of maps for further processing (e.g., by the View).
  }

  // Example method to demonstrate how to send data to a web service.
  // This method is commented out as it requires the 'http' package and a real API endpoint.
  /*
  Future<void> sendDataToService(List<Map<String, String>> dataToSend) async {
    try {
      // Convert the list of maps to a JSON string, which is typically expected by APIs.
      final String jsonData = jsonEncode(dataToSend);

      final response = await http.post(
        Uri.parse('YOUR_API_ENDPOINT_HERE'), // Replace with your actual API endpoint URL.
        headers: {'Content-Type': 'application/json'}, // Specify content type as JSON.
        body: jsonData, // The JSON data to be sent in the request body.
      );

      if (response.statusCode == 200) {
        debugPrint('Data successfully sent to service!');
        // You might parse the response.body here if the service returns data.
      } else {
        debugPrint('Failed to send data. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}'); // Log the error response from the server.
      }
    } catch (e) {
      debugPrint('Error sending data to service: $e'); // Log any exceptions during the network call.
    }
  }
  */
}
