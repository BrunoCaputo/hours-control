class SquadEntity {
  final int id;
  final String name;

  const SquadEntity({
    required this.id,
    required this.name,
  });

  factory SquadEntity.fromJson(Map<String, dynamic> json) => SquadEntity(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson(SquadEntity entity) => {
        'id': entity.id,
        'name': entity.name,
      };

  @override
  String toString() {
    return 'SquadEntity{id: $id, name: $name}';
  }
}
