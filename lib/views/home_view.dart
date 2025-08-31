import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanban_issues_app/models/issue.dart';
import 'package:kanban_issues_app/widgets/issues/issue_card.dart';

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
      backgroundColor: const Color(0xFF3A6DE2),
      appBar: AppBar(title: const Text('Last tickets')),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: 3,
        separatorBuilder: (_, __) =>
            const SizedBox(height: 10), //distancia entre componentes
        itemBuilder: (_, i) {
          switch (i) {
            case 0:
              return _issuesLane(context, 'BACKLOG', IssueStatus.backlog);
            case 1:
              return _issuesLane(
                context,
                'IN PROGRESS',
                IssueStatus.inProgress,
              );
            default:
              return _issuesLane(context, 'DONE', IssueStatus.done);
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

  Widget _issuesLane(BuildContext context, String title, IssueStatus status) {
    const cardWidth = 300.0;
    const cardHeight = 150.0;
    final items = _issues.where((i) => i.status == status).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
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
