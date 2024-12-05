import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/model/member_model.dart';

class AllTeamController extends GetxController {
  final count = 0.obs;
  final selectFilter = false.obs;
  var participants = <Member>[].obs;
  var invites = <Member>[].obs;
  final RxInt selectedTabIndex = 0.obs;
  final List<String> tabs = [
    'Partisipan',
    'Undang',
  ];

  @override
  void onInit() {
    super.onInit();
    participants.addAll([
      Member(
        nama: 'Amy Vis',
        status: 'Admin',
        image: 'https://randomuser.me/api/portraits/women/70.jpg',
        type: 'participant',
      ),
      Member(
        nama: 'John Smith',
        status: 'Member',
        image: 'https://randomuser.me/api/portraits/men/71.jpg',
        type: 'participant',
      ),
      Member(
        nama: 'Sarah Johnson',
        status: 'Member',
        image: 'https://randomuser.me/api/portraits/women/72.jpg',
        type: 'participant',
      ),
      Member(
        nama: 'Michael Brown',
        status: 'Member',
        image: 'https://randomuser.me/api/portraits/men/73.jpg',
        type: 'participant',
      ),
    ]);

    // Initialize invites with selection states
    invites.addAll([
      Member(
        nama: 'Emma Wilson',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/women/74.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'James Davis',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/men/75.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'Olivia Martinez',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/women/76.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'William Anderson',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/men/77.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'Sophia Taylor',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/women/78.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'Lucas Garcia',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/men/79.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'Isabella Moore',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/women/80.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'Ethan Lee',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/men/81.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'Ava White',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/women/82.jpg',
        type: 'invite',
        isSelected: false,
      ),
      Member(
        nama: 'Mason King',
        status: 'Pending',
        image: 'https://randomuser.me/api/portraits/men/83.jpg',
        type: 'invite',
        isSelected: false,
      ),
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Get current list based on selected tab
  List<Member> getCurrentList() {
    return selectedTabIndex.value == 0 ? participants : invites;
  }

  // Toggle selection for invite members
  void toggleSelection(int index) {
    if (selectedTabIndex.value == 1) {
      final member = invites[index];
      invites[index] = Member(
        nama: member.nama,
        status: member.status,
        image: member.image,
        type: member.type,
        isSelected: !member.isSelected,
      );
    }
  }

  void addSelectedParticipants() {
    // Filter selected invites
    final selectedInvites =
        invites.where((member) => member.isSelected).toList();

    // Convert selected invites to participants
    final newParticipants = selectedInvites
        .map((invite) => invite.copyWith(
              status: 'Member',
              type: 'participant',
              isSelected: false,
            ))
        .toList();

    // Add to participants list
    participants.addAll(newParticipants);

    // Remove selected invites from invites list
    invites.removeWhere((member) => member.isSelected);

    // Switch to participants tab
    selectedTabIndex.value = 0;

    // Show success message
    Get.snackbar(
      'Success',
      '${newParticipants.length} new participants added',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  // Get count of selected invites
  int get selectedInvitesCount =>
      invites.where((member) => member.isSelected).length;
}
