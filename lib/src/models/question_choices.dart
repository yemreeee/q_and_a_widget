/// A model class representing a single question with its unique identifier and multiple-choice options.
/// This class handles the data structure and provides methods for JSON serialization/deserialization.
class QuestionChoices {
  /// A unique identifier for the question. Useful for database operations or tracking.
  final String id;

  /// The text content of the question.
  final String question;

  /// A list of strings representing the multiple-choice options for the question.
  final List<String> choices;

  /// Creates a [QuestionChoices] instance.
  ///
  /// All parameters are required and immutable. The `const` constructor
  /// allows for compile-time constants, which can improve performance
  /// when creating fixed lists of questions.
  const QuestionChoices({
    required this.id,
    required this.question,
    required this.choices,
  });

  /// Converts a [QuestionChoices] object into a [Map<String, dynamic>]
  /// that is compatible with JSON serialization.
  ///
  /// Returns a map containing the question's ID, question text, and choices.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'choices': choices,
    };
  }

  /// Creates a [QuestionChoices] object from a [Map<String, dynamic>].
  ///
  /// This factory constructor is typically used when deserializing JSON data
  /// back into a [QuestionChoices] object.
  ///
  /// [json]: A map parsed from a JSON string, expected to contain 'id',
  /// 'question', and 'choices' keys.
  /// Returns a new [QuestionChoices] instance.
  factory QuestionChoices.fromJson(Map<String, dynamic> json) {
    return QuestionChoices(
      id: json['id'] as String,
      question: json['question'] as String,
      choices: List<String>.from(json['choices'] as List<dynamic>),
    );
  }
}
