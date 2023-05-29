class Projet {
  final int id;
  final String nom;

  const Projet({
    required this.id,
    required this.nom
  });

  factory Projet.fromJson(Map<String, dynamic> json) {
    return Projet(
        id: json['id'],
        nom: json['nom']
    );
  }
}