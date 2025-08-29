class Issue {
  final String id;
  String title;
  String description;
  final DateTime createdAt;

  Issue({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}