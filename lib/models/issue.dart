class Issue {
  final String id;
  String title;
  String description;
  final DateTime createdAt = DateTime.now();

  Issue({
    required this.id,
    required this.title,
    required this.description,
   
  });

  String get createdAtString => createdAt.toLocal().toString().split('.').first;

}