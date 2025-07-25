class Expert {
  final String? id;
  final String name;
  final String specialty;
  final String experience;
  final List<String> languages;
  final double rating;

  Expert({
    this.id,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.languages,
    required this.rating,
  });

  factory Expert.fromFirestore(Map<String, dynamic> data, String id) {
    return Expert(
      id: id,
      name: data['name'] ?? 'N/A',
      specialty: data['specialty'] ?? 'N/A',
      experience: data['experience'] ?? 'N/A',
      languages: List<String>.from(data['languages'] ?? []),
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'specialty': specialty,
      'experience': experience,
      'languages': languages,
      'rating': rating,
    };
  }
}
