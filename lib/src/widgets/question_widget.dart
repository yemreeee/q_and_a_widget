import 'package:flutter/material.dart';
import 'package:q_and_a_widget/src/models/question_choices.dart'; // Imports the Model class for data structure.

/// A Flutter widget that displays a single question with its multiple-choice
/// options as radio buttons. It's a reusable UI component.
class QuestionWidget extends StatefulWidget {
  /// The data model containing the question text, ID, and choices.
  final QuestionChoices questionData;

  /// A callback function that is invoked when a user selects a radio button.
  /// It provides the question's ID, its text, and the selected choice.
  final Function(String questionId, String questionText, String selectedChoice)?
      onChoiceSelected;

  /// Creates a [QuestionWidget].
  ///
  /// [questionData] is required and provides the content for the widget.
  /// [onChoiceSelected] is an optional callback to notify the parent
  /// (typically the ViewModel or another View) about the user's selection.
  const QuestionWidget({
    super.key,
    required this.questionData,
    this.onChoiceSelected,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

/// The mutable state for the [QuestionWidget].
class _QuestionWidgetState extends State<QuestionWidget> {
  /// Stores the currently selected choice for this specific question.
  /// It's nullable, indicating no choice has been made yet.
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0), // Provides spacing around the card.
      elevation: 8.0, // Adds a shadow effect to the card.
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0)), // Rounds the card corners.
      child: Padding(
        padding: const EdgeInsets.all(
            20.0), // Internal padding for the card content.
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns content to the start (left).
          children: [
            // Displays the question text.
            Text(
              widget.questionData.question,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, // Custom text color for the question.
              ),
            ),
            const SizedBox(
                height:
                    15.0), // Adds vertical space between the question and choices.
            // Dynamically generates a list of RadioListTile widgets for each choice.
            ...widget.questionData.choices.map<Widget>((choice) {
              return RadioListTile<String>(
                title: Text(
                  choice,
                  style: const TextStyle(fontSize: 16.0),
                ),
                value: choice, // The value associated with this radio button.
                groupValue:
                    _selectedChoice, // The currently selected value in this group.
                onChanged: (String? value) {
                  setState(() {
                    _selectedChoice =
                        value; // Updates the selected choice, triggering a UI rebuild.
                  });
                  // Invokes the provided callback function if it's not null and a value is selected.
                  if (widget.onChoiceSelected != null && value != null) {
                    widget.onChoiceSelected!(
                      widget.questionData.id, // Passes the question ID.
                      widget.questionData.question, // Passes the question text.
                      value, // Passes the newly selected choice.
                    );
                  }
                },
                activeColor: Colors
                    .deepPurpleAccent, // Color of the radio button when selected.
                controlAffinity: ListTileControlAffinity
                    .leading, // Places the radio button icon at the start of the tile.
              );
            }), // Converts the iterable of widgets to a List<Widget>.
            // The "Selected Choice" text display is intentionally removed as per previous requirements.
          ],
        ),
      ),
    );
  }
}
