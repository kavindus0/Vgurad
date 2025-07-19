// lib/models/disease_model.dart
class Disease {
  final String name;
  final String affectedCrop;
  final String severity;
  final String cause;
  final List<String> symptoms;
  final String treatment;
  final String prevention;

  Disease({
    required this.name,
    required this.affectedCrop,
    required this.severity,
    required this.cause,
    required this.symptoms,
    required this.treatment,
    required this.prevention,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['name'],
      affectedCrop: json['affectedCrop'],
      severity: json['severity'],
      cause: json['cause'],
      symptoms: List<String>.from(json['symptoms']),
      treatment: json['treatment'],
      prevention: json['prevention'],
    );
  }
}
