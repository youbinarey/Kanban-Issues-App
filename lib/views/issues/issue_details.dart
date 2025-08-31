import 'package:flutter/material.dart';
import 'package:kanban_issues_app/models/issue.dart';

import '../../widgets/issues/issue_description.dart';
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
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, result ?? issue);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Issue ${issue.id}'), actions: [
            
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: StatusDropdownPill(
                  value: issue.status,
                  onChanged: (newStatus) {
                    setState(() {
                      issue = issue.copyWith(
                        status: newStatus,
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Created At: ${issue.createdAtString}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              //BLOQUE DESCRIPCION
              Expanded(
                child: IssueDescriptionSection(
                  issue: issue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
