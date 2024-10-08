class SquadMemberHours {
  final int employeeId;
  final int spentHours;

  const SquadMemberHours({
    required this.employeeId,
    required this.spentHours,
  });

  factory SquadMemberHours.fromJson(Map<String, dynamic> json) => SquadMemberHours(
        employeeId: json["employeeId"],
        spentHours: json["spentHours"],
      );

  Map<String, dynamic> toJson(SquadMemberHours model) => {
        'employeeId': model.employeeId,
        'spentHours': model.spentHours,
      };
}
