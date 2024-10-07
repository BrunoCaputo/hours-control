class ReportEntity {
  final int id;
  final String description;
  final int employeeId;
  final int spentHours;
  final DateTime createdAt;

  const ReportEntity({
    required this.id,
    required this.description,
    required this.employeeId,
    required this.spentHours,
    required this.createdAt,
  });

  ReportEntity fromJson(Map<String, dynamic> json) => ReportEntity(
        id: json['id'],
        description: json['description'],
        employeeId: json['employee_id'],
        spentHours: json['spent_hours'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson(ReportEntity entity) => {
        'id': entity.id,
        'description': entity.description,
        'employee_id': entity.employeeId,
        'spent_hours': entity.spentHours,
        'created_at': entity.createdAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'ReportEntity{id: $id, description: $description, employeeId: $employeeId, spentHours: $spentHours, createdAt: $createdAt}';
  }
}
