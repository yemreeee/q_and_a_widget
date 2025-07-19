import 'package:flutter/material.dart';
import 'package:q_and_a_widget/src/models/question_choices.dart'; // Import the Model class.

// This widget displays a question and its choices as radio buttons,
// using a QuestionChoices object.
class QuestionWidget extends StatefulWidget {
  final QuestionChoices questionData;
  // Callback function to be called when a choice is selected.
  // It passes the question ID, question text, and the selected choice.
  final Function(String questionId, String questionText, String selectedChoice)?
  onChoiceSelected;

  // Constructor for QuestionWidget. It takes a QuestionChoices object and an optional callback.
  const QuestionWidget({
    super.key,
    required this.questionData,
    this.onChoiceSelected,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  // Variable to hold the selected choice. Initially null.
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text displaying the question.
            Text(
              widget.questionData.question,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 15.0), // Adds vertical space
            // Lists the choices as radio buttons.
            ...widget.questionData.choices.map<Widget>((choice) {
              return RadioListTile<String>(
                title: Text(choice, style: const TextStyle(fontSize: 16.0)),
                value: choice,
                groupValue: _selectedChoice,
                onChanged: (String? value) {
                  setState(() {
                    _selectedChoice = value; // Updates the selected choice.
                  });
                  // Call the callback function if it's provided.
                  if (widget.onChoiceSelected != null && value != null) {
                    widget.onChoiceSelected!(
                      widget.questionData.id, // Pass the question ID.
                      widget.questionData.question, // Pass the question text.
                      value,
                    );
                  }
                },
                activeColor: Colors.deepPurpleAccent,
                controlAffinity: ListTileControlAffinity
                    .leading, // Places the radio button at the start.
              );
            }),
            // The "Selected Choice" text display is removed as per the requirement.
          ],
        ),
      ),
    );
  }
}
