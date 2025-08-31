import 'package:flutter/material.dart';

import '../../models/issue.dart';

class StatusDropdownPill extends StatelessWidget {
  const StatusDropdownPill({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final IssueStatus value;
  final ValueChanged<IssueStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    const pillBlue = Color(0xFFE9F2FF);
    const textBlue = Color(0xFF0052CC); 
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: pillBlue,
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<IssueStatus>(
          isDense: true,
          value: value,
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          items: IssueStatus.values.map((s) {
            return DropdownMenuItem(
              value: s,
              child: Text(
                statusLabel(s),
                style: const TextStyle(fontWeight: FontWeight.w600, color: textBlue),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  //  TODO -> ENCAPSULARLO EN UN UTILS
  static String statusLabel(IssueStatus s) => switch (s) {
    IssueStatus.backlog => 'Backlog',
    IssueStatus.inProgress => 'In Progress',
    IssueStatus.done => 'Done',
  };
}
