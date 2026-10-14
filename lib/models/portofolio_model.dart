class PortofolioItem {
  final String id;
  final String title;
  final String category;
  final String year;
  final String description;
  final String techStack;
  final String? imagePath;

  PortofolioItem({
    required this.id,
    required this.title,
    required this.category,
    required this.year,
    required this.description,
    required this.techStack,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'year': year,
      'description': description,
      'techStack': techStack,
      'imagePath': imagePath,
    };
  }

  factory PortofolioItem.fromMap(Map<String, dynamic> map) {
    return PortofolioItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      year: map['year'] ?? '',
      description: map['description'] ?? '',
      techStack: map['techStack'] ?? '',
      imagePath: map['imagePath'],
    );
  }
}
