import 'package:flutter/material.dart';
import 'package:kanban_issues_app/models/issue.dart';
import 'package:kanban_issues_app/widgets/issues/issue_card.dart';

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
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, result ?? issue);
      },
      child: Scaffold(
              backgroundColor:Color.fromARGB(255, 19, 151, 228),
  

        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 1,
          title: Text(
            issue.id,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // STATUS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusDropdownPill(
                        value: issue.status,
                        onChanged: (newStatus) {
                          setState(() {
                            issue = issue.copyWith(status: newStatus);
                          });
                        },
                      ),
                      Text(
                        issue.createdAtString,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // TITLE
                  Text(
                    issue.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // SEPARADOR
                  Divider(
                    color: IssueCard.headerColor(issue.status),
                    thickness: 5,
                  ),

                  // DESCRIPTION
                  Expanded(child: IssueDescriptionSection(issue: issue)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
