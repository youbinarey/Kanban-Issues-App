import 'package:flutter/material.dart';
import 'package:kanban_issues_app/models/issue.dart';

import '../../widgets/issues/status_dropdow_issue.dart';

class IssueDetails extends StatefulWidget {
  const IssueDetails({super.key, required this.issue});
  final Issue issue;

  @override
  State<IssueDetails> createState() => _IssueDetailsState();

}

class _IssueDetailsState extends State<IssueDetails> {
  late Issue issue;

  @override
  void initState() {
    super.initState();
    issue = widget.issue;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // bloque el pop bydefault
      onPopInvokedWithResult:(didPop, result)  {
        if (didPop) return;
        Navigator.pop(context, result ?? issue);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Issue ID: ${issue.id}'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: StatusDropdownPill(
                value: issue.status,
                onChanged: (newStatus) {
                  setState(() {
                    issue = issue.copyWith(status: newStatus, description: 'EDITADO');
                  });
                },
              ),
            )
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                issue.status.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // State manangement
      
              Text(
                'Created At: ${issue.createdAtString}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                issue.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }



}