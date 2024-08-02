import 'package:flutter/material.dart';

class Todocard extends StatefulWidget {
  const Todocard({
    required this.todotitle,
    required this.onDelete, // Add this line to accept a callback
    super.key,
  });

  final String todotitle;
  final VoidCallback onDelete; // Define the callback type

  @override
  State<Todocard> createState() => _TodocardState();
}

class _TodocardState extends State<Todocard> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      elevation: 2.0, // Reduced elevation for a lighter shadow
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.grey[400]!, // Lighter border color
            width: 1.0), // Reduced border width
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
            Expanded(
              child: Text(
                widget.todotitle,
                style: TextStyle(
                  fontSize: 16.0,
                  decoration: _isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                widget.onDelete(); // Call the provided callback
              },
            ),
          ],
        ),
      ),
    );
  }
}
