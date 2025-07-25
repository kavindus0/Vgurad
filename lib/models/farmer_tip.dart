class FarmerTip {
  final String? id;
  final String title;
  final String content;
  final String category;
  final DateTime dateAdded;

  FarmerTip({
    this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.dateAdded,
  });

  factory FarmerTip.fromFirestore(Map<String, dynamic> data, String id) {
    return FarmerTip(
      id: id,
      title: data['title'] ?? 'N/A',
      content: data['content'] ?? 'N/A',
      category: data['category'] ?? 'General',
      dateAdded: (data['dateAdded']?.toDate()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'dateAdded': dateAdded,
    };
  }
}
