import 'package:flutter/material.dart';

import '../../models/issue.dart';

class StatusDropdownPill extends StatelessWidget {
  const StatusDropdownPill({super.key, required this.value, required this.onChanged});
  final IssueStatus value;
  final ValueChanged<IssueStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:12, vertical:6),
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: primary.withValues(alpha: 0.2),

      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<IssueStatus>(
          isDense: true,
          value: value,
          onChanged: (v) { if (v != null) onChanged(v); },
          items: IssueStatus.values.map((s) {
            return DropdownMenuItem(
              value: s,
              child: Text(statusLabel(s), style: const TextStyle(fontWeight: FontWeight.w600)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
String statusLabel(IssueStatus s) => switch (s) {
      IssueStatus.backlog => 'Backlog',
      IssueStatus.inProgress => 'In Progress',
      IssueStatus.done => 'Done',
    };