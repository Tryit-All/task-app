import 'package:get/get.dart';

class Member {
  final String nama;
  final String status;
  final String image;
  var isCompleted = false.obs;

  Member(this.nama, this.status, this.image);
}
