import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanban_issues_app/models/issue.dart';
import 'package:kanban_issues_app/res/app_styles.dart';
import 'package:kanban_issues_app/widgets/issues/issue_card.dart';

import '../widgets/issues/status_dropdow_issue.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Lista de issues en el padre
  late List<Issue> _issues;

  @override
  void initState() {
    super.initState();

    /// Cargar datos de demo
    _issues = [];
    _loadIssuesFromJson();
  }

  // Reemplaza la issue actualizada en la lista y refresca UI
  void _onIssueUpdated(Issue updated) {
    setState(() {
      _issues = _issues.map((i) => i.id == updated.id ? updated : i).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 19, 151, 228),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(title: const Text('ISSUES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2)), backgroundColor:const Color.fromARGB(255, 255, 255, 255),
),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: 3,
        separatorBuilder: (_, __) =>
            const SizedBox(height: 10), //distancia entre componentes
        itemBuilder: (_, i) {
          switch (i) {
            case 0:
              return _issuesLane(context, IssueStatus.backlog);
            case 1:
              return _issuesLane(
                context,
                IssueStatus.inProgress,
              );
            default:
              return _issuesLane(context, IssueStatus.done);
          }
        
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
            label: 'Tickets',
          ),
        ],
      ),
    );
  }

  Widget _issuesLane(BuildContext context, IssueStatus status) {
    const cardWidth = 300.0;
    const cardHeight = 150.0;
    final items = _issues.where((i) => i.status == status).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StatusDropdownPill.statusLabel(status),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace',letterSpacing: 3, wordSpacing: 5)
              .copyWith(color: AppColor.issueTypeTitle),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: cardHeight + 24,
          child: items.isEmpty
              ? const Center(child: Text('Sin issues'))
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => SizedBox(
                    width: cardWidth,
                    child: IssueCard(
                      issue: items[i],
                      onUpdated: _onIssueUpdated,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _loadIssuesFromJson() async {
    final jsonStr = await rootBundle.loadString('assets/data/issues.json');
    final List<dynamic> jsonList = json.decode(jsonStr);
    setState(() {
      _issues = jsonList.map((json) => Issue.fromJson(json)).toList();
    });
  }
}
