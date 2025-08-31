enum IssueStatus { backlog, inProgress, done }

class Issue {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final IssueStatus status;

  Issue({
    required this.id,
    required this.title,
    required this.description,
    DateTime? createdAt,
    this.status = IssueStatus.backlog,
  }) : createdAt = createdAt ?? DateTime.now();

  String get createdAtString => createdAt.toLocal().toString().split('.').first;

  Issue copyWith({
    String? id,
    String? title,
    String? description,
    IssueStatus? status,
    DateTime? createdAt,
  }) {
    return Issue(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
    id: json['id'],
    title: json['title'], 
    description: json['description'],
    createdAt: DateTime.parse(json['createdAt']),
    status: IssueStatus.values.firstWhere(
      
      // convierte string a enum
      (s) => s.name == json['status'],
      orElse: () => IssueStatus.backlog,
    ),
  );
}
