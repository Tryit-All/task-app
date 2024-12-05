import 'package:get/get.dart';

class Member {
  final String nama;
  final String status;
  final String image;
  final String type; // 'participant' or 'invite'
  final bool isSelected; // For invite selection state
  var isCompleted = false.obs;

  Member({
    required this.nama,
    required this.status,
    required this.image,
    required this.type,
    this.isSelected = false,
  });

  // Create a copy of Member with modified fields
  Member copyWith({
    String? nama,
    String? status,
    String? image,
    String? type,
    bool? isSelected,
  }) {
    return Member(
      nama: nama ?? this.nama,
      status: status ?? this.status,
      image: image ?? this.image,
      type: type ?? this.type,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
