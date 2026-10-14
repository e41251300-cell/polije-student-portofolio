class ProjectItem {
  final String id;
  final String title;
  final String category;
  final String description;
  final String techStack;

  ProjectItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.techStack,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'techStack': techStack,
    };
  }

  factory ProjectItem.fromMap(Map<String, dynamic> map) {
    return ProjectItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      techStack: map['techStack'] ?? '',
    );
  }
}
