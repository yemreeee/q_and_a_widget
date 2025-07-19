import 'package:flutter_test/flutter_test.dart';
import 'package:q_and_a_widget/q_and_a_widget.dart'; // Import your package

void main() {
  group('QuestionChoices', () {
    // Test 1: QuestionChoices constructor
    test('QuestionChoices can be instantiated with valid data', () {
      const question = 'Test Question';
      const choices = ['Option A', 'Option B'];
      const id = 'q_test_1';

      const qc = QuestionChoices(id, question, choices);

      expect(qc.id, id);
      expect(qc.question, question);
      expect(qc.choices, choices);
    });

    // Test 2: toJson method
    test('QuestionChoices can be converted to JSON map', () {
      const question = 'Test Question';
      const choices = ['Option A', 'Option B'];
      const id = 'q_test_2';

      const qc = QuestionChoices(id, question, choices);
      final jsonMap = qc.toJson();

      expect(jsonMap['id'], id);
      expect(jsonMap['question'], question);
      expect(jsonMap['choices'], choices);
      expect(jsonMap.length, 3); // Check if all fields are present
    });

    // Test 3: fromJson factory method
    test('QuestionChoices can be created from JSON map', () {
      final jsonMap = {
        'id': 'q_test_3',
        'question': 'Another Test Question',
        'choices': ['Opt 1', 'Opt 2', 'Opt 3'],
      };

      final qc = QuestionChoices.fromJson(jsonMap);

      expect(qc.id, 'q_test_3');
      expect(qc.question, 'Another Test Question');
      expect(qc.choices, ['Opt 1', 'Opt 2', 'Opt 3']);
    });
  });

  group('QuestionViewModel', () {
    // Test 1: Default dummy questions are loaded
    test('ViewModel loads dummy questions when no questions are provided', () {
      final viewModel = QuestionViewModel();
      expect(viewModel.questions.isNotEmpty, true);
      expect(viewModel.questions.length, 4); // Based on your dummy data
      expect(viewModel.questions[0].id, 'q1');
    });

    // Test 2: Custom questions are loaded
    test('ViewModel loads custom questions when provided', () {
      const customQuestions = [
        QuestionChoices('custom1', 'Custom Q1', ['C1 A', 'C1 B']),
        QuestionChoices('custom2', 'Custom Q2', ['C2 A', 'C2 B']),
      ];
      final viewModel = QuestionViewModel(questions: customQuestions);
      expect(viewModel.questions, customQuestions);
      expect(viewModel.questions.length, 2);
      expect(viewModel.questions[0].id, 'custom1');
    });

    // Test 3: handleChoiceSelected updates internal state and returns correct JSON list
    test('handleChoiceSelected updates state and returns correct JSON list',
        () {
      final viewModel = QuestionViewModel(); // Uses dummy questions

      // Select an answer for q1
      final result1 = viewModel.handleChoiceSelected(
          'q1', 'What is the capital of Turkey?', 'Ankara');
      expect(result1.length, 1);
      expect(result1[0]['question_id'], 'q1');
      expect(result1[0]['selected_answer'], 'Ankara');

      // Select an answer for q2
      final result2 = viewModel.handleChoiceSelected(
          'q2', 'What is the highest mountain in the world?', 'Mount Everest');
      expect(result2.length, 2); // Now contains 2 selected answers
      expect(result2[0]['question_id'], 'q1');
      expect(result2[0]['selected_answer'], 'Ankara');
      expect(result2[1]['question_id'], 'q2');
      expect(result2[1]['selected_answer'], 'Mount Everest');

      // Change answer for q1
      final result3 = viewModel.handleChoiceSelected(
          'q1', 'What is the capital of Turkey?', 'Istanbul');
      expect(result3.length, 2); // Still 2 answers, but q1's answer is updated
      expect(result3[0]['question_id'], 'q1');
      expect(result3[0]['selected_answer'], 'Istanbul'); // Updated
      expect(result3[1]['question_id'], 'q2');
      expect(result3[1]['selected_answer'], 'Mount Everest');
    });
  });
}
