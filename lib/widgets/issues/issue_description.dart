import 'package:flutter/material.dart';
import 'package:kanban_issues_app/models/issue.dart';

class IssueDescriptionSection extends StatelessWidget {
  const IssueDescriptionSection({
    super.key,
    required this.issue
  });

  final Issue issue;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                issue.description,
                style: const TextStyle(
                  fontFamily: 'calibri',
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
