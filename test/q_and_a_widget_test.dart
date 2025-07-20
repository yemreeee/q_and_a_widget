import 'package:flutter_test/flutter_test.dart'; // Core Flutter testing library.
import 'package:q_and_a_widget/q_and_a_widget.dart'; // Imports your custom package, making its classes available for testing.

/// The main function where all unit tests are defined and executed.
void main() {
  // Group of tests specifically for the QuestionChoices model.
  group('QuestionChoices', () {
    // Test case: Verifies that a QuestionChoices object can be correctly instantiated.
    test('QuestionChoices can be instantiated with valid data', () {
      const question = 'Test Question';
      const choices = ['Option A', 'Option B'];
      const id = 'q_test_1';

      // Instantiate the QuestionChoices object using its const constructor.
      const qc = QuestionChoices(id, question, choices);

      // Assert that the properties of the instantiated object match the input data.
      expect(qc.id, id);
      expect(qc.question, question);
      expect(qc.choices, choices);
    });

    // Test case: Verifies that the toJson method correctly converts the object to a JSON-compatible map.
    test('QuestionChoices can be converted to JSON map', () {
      const question = 'Test Question';
      const choices = ['Option A', 'Option B'];
      const id = 'q_test_2';

      const qc = QuestionChoices(id, question, choices);
      final jsonMap = qc.toJson(); // Call the toJson method.

      // Assert that the keys and values in the generated map are correct.
      expect(jsonMap['id'], id);
      expect(jsonMap['question'], question);
      expect(jsonMap['choices'], choices);
      // Assert that the map contains the expected number of fields.
      expect(jsonMap.length, 3);
    });

    // Test case: Verifies that the fromJson factory method correctly creates an object from a JSON map.
    test('QuestionChoices can be created from JSON map', () {
      final jsonMap = {
        'id': 'q_test_3',
        'question': 'Another Test Question',
        'choices': ['Opt 1', 'Opt 2', 'Opt 3'],
      };

      final qc =
          QuestionChoices.fromJson(jsonMap); // Call the fromJson factory.

      // Assert that the properties of the created object match the data from the input map.
      expect(qc.id, 'q_test_3');
      expect(qc.question, 'Another Test Question');
      expect(qc.choices, ['Opt 1', 'Opt 2', 'Opt 3']);
    });
  });

  // Group of tests specifically for the QuestionViewModel.
  group('QuestionViewModel', () {
    // Test case: Verifies that the ViewModel loads its default dummy questions when none are provided.
    test('ViewModel loads dummy questions when no questions are provided', () {
      final viewModel =
          QuestionViewModel(); // Instantiate ViewModel without custom questions.
      // Assert that the questions list is not empty.
      expect(viewModel.questions.isNotEmpty, true);
      // Assert that the number of loaded questions matches the expected dummy data count.
      expect(viewModel.questions.length, 4);
      // Assert that the ID of the first dummy question is as expected.
      expect(viewModel.questions[0].id, 'q1');
    });

    // Test case: Verifies that the ViewModel loads custom questions when provided.
    test('ViewModel loads custom questions when provided', () {
      // Define a list of custom questions.
      const customQuestions = [
        QuestionChoices('custom1', 'Custom Q1', ['C1 A', 'C1 B']),
        QuestionChoices('custom2', 'Custom Q2', ['C2 A', 'C2 B']),
      ];
      final viewModel = QuestionViewModel(
          questions: customQuestions); // Instantiate with custom questions.
      // Assert that the loaded questions match the provided custom questions.
      expect(viewModel.questions, customQuestions);
      // Assert the length of the loaded custom questions.
      expect(viewModel.questions.length, 2);
      // Assert the ID of the first custom question.
      expect(viewModel.questions[0].id, 'custom1');
    });

    // Test case: Verifies that handleChoiceSelected correctly updates the internal state
    // and returns the accurate JSON list of all selected answers.
    test('handleChoiceSelected updates state and returns correct JSON list',
        () {
      final viewModel =
          QuestionViewModel(); // Use default dummy questions for this test.

      // Simulate selecting an answer for 'q1'.
      final result1 = viewModel.handleChoiceSelected(
          'q1', 'What is the capital of Turkey?', 'Ankara');
      // Assert that the returned list contains one item.
      expect(result1.length, 1);
      // Assert the content of the first selected answer.
      expect(result1[0]['question_id'], 'q1');
      expect(result1[0]['selected_answer'], 'Ankara');
      expect(result1[0]['question_text'],
          'What is the capital of Turkey?'); // Ensure question_text is also correct

      // Simulate selecting an answer for 'q2'.
      final result2 = viewModel.handleChoiceSelected(
          'q2', 'What is the highest mountain in the world?', 'Mount Everest');
      // Assert that the returned list now contains two items.
      expect(result2.length, 2);
      // Assert the content of both selected answers.
      expect(result2[0]['question_id'], 'q1');
      expect(result2[0]['selected_answer'], 'Ankara');
      expect(result2[1]['question_id'], 'q2');
      expect(result2[1]['selected_answer'], 'Mount Everest');
      expect(result2[1]['question_text'],
          'What is the highest mountain in the world?');

      // Simulate changing the answer for 'q1'.
      final result3 = viewModel.handleChoiceSelected(
          'q1', 'What is the capital of Turkey?', 'Istanbul');
      // Assert that the list still contains two items (answer for q1 was updated, not added).
      expect(result3.length, 2);
      // Assert that the answer for 'q1' has been updated.
      expect(result3[0]['question_id'], 'q1');
      expect(result3[0]['selected_answer'], 'Istanbul'); // Updated value
      expect(result3[1]['question_id'], 'q2');
      expect(result3[1]['selected_answer'], 'Mount Everest'); // Unchanged value
    });
  });
}
