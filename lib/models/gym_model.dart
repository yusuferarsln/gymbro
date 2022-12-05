// ignore_for_file: public_member_api_docs, sort_constructors_first

class GymModel {
  final int id;
  final String gymName;
  final String gymImage;
  final int gymToolCount;
  final int gymMemberCount;
  final String gymAddress;
  GymModel({
    required this.id,
    required this.gymName,
    required this.gymImage,
    required this.gymToolCount,
    required this.gymMemberCount,
    required this.gymAddress,
  });

  GymModel copyWith({
    int? id,
    String? gymName,
    String? gymImage,
    int? gymToolCount,
    int? gymMemberCount,
    String? gymAddress,
  }) {
    return GymModel(
      id: id ?? this.id,
      gymName: gymName ?? this.gymName,
      gymImage: gymImage ?? this.gymImage,
      gymToolCount: gymToolCount ?? this.gymToolCount,
      gymMemberCount: gymMemberCount ?? this.gymMemberCount,
      gymAddress: gymAddress ?? this.gymAddress,
    );
  }

  factory GymModel.fromJson(Map<String, dynamic> map) {
    return GymModel(
      id: map['id'] as int,
      gymName: map['gym_name'] as String,
      gymImage: map['gym_image'] as String,
      gymToolCount: map['gym_tool_count'] as int,
      gymMemberCount: map['gym_member_count'] as int,
      gymAddress: map['gym_address'] as String,
    );
  }
}
