import 'package:flutter/material.dart';
import 'package:kanban_issues_app/models/issue.dart';

import '../../views/issues/issue_details.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;
  final ValueChanged<Issue>? onUpdated;

  const IssueCard({super.key, required this.issue, this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 1.0, bottom: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: SizedBox(
        width: 300,
        height: 200,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 143, 42, 42),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    issue.id,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final updated = await Navigator.push<Issue>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IssueDetails(issue: issue),
                        ),
                      );
                      if(updated != null && onUpdated != null) onUpdated!(updated);
                    },
                    child: const Text(
                      'View Details',
                  
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            // BODY
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITULO
                  Text(
                    issue.title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      issue.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
