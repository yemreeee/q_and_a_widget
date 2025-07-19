// This class is used to hold a question, its unique ID, and multiple-choice options.
// It also provides methods for converting to and from JSON format.
class QuestionChoices {
  // Unique identifier for the question.
  final String id; // Made final
  // Property to store the question.
  final String question; // Made final
  // Property to store multiple-choice options.
  final List<String> choices; // Made final

  // Const constructor for the QuestionChoices class.
  // It creates a new instance by taking an id, question, and a list of choices.
  const QuestionChoices(this.id, this.question, this.choices); // Made const

  // Converts a QuestionChoices object into a Map<String, dynamic> (JSON-compatible format).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'choices': choices,
    };
  }

  // Creates a QuestionChoices object from a Map<String, dynamic> (parsed from JSON).
  factory QuestionChoices.fromJson(Map<String, dynamic> json) {
    return QuestionChoices(
      json['id'] as String,
      json['question'] as String,
      List<String>.from(json['choices'] as List<dynamic>),
    );
  }
}
