class EmployeeEntity {
  final int id;
  final String name;
  final int estimatedHours;
  final int squadId;

  const EmployeeEntity({
    required this.id,
    required this.name,
    required this.estimatedHours,
    required this.squadId,
  });

  factory EmployeeEntity.fromJson(Map<String, dynamic> json) => EmployeeEntity(
        id: json['id'],
        name: json['name'],
        estimatedHours: json['estimatedHours'],
        squadId: json['squadId'],
      );

  Map<String, dynamic> toJson(EmployeeEntity entity) => {
        'id': entity.id,
        'name': entity.name,
        'estimated_hours': entity.estimatedHours,
        'squad_id': entity.squadId,
      };

  @override
  String toString() {
    return 'EmployeeEntity{id: $id, name: $name, estimatedHours: $estimatedHours, squadId: $squadId}';
  }
}
