class Tache {
  final int id;
  final String nom;
  final String deadline;
  final int etat;

  const Tache({
    required this.id,
    required this.nom,
    required this.deadline,
    required this.etat
  });

  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
        id: json['id'],
        nom: json['nom'],
        deadline: json['datefin'],
        etat: json['id_etat']
    );
  }
}