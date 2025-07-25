class Disease {
  final String? id;
  final String name;
  final String symptoms;
  final String treatment;
  final String prevention;
  final String category;
  final String? imageUrl;

  Disease({
    this.id,
    required this.name,
    required this.symptoms,
    required this.treatment,
    required this.prevention,
    required this.category,
    this.imageUrl,
  });

  factory Disease.fromFirestore(Map<String, dynamic> data, String id) {
    return Disease(
      id: id,
      name: data['name'] ?? 'N/A',
      symptoms: data['symptoms'] ?? 'N/A',
      treatment: data['treatment'] ?? 'N/A',
      prevention: data['prevention'] ?? 'N/A',
      category: data['category'] ?? 'General',
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'symptoms': symptoms,
      'treatment': treatment,
      'prevention': prevention,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
