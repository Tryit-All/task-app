import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/all_team/views/all_team_view.dart';

import '../controllers/add_tim_controller.dart';

class AddTimView extends GetView<AddTimController> {
  const AddTimView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final AddTimController addTim = Get.put(AddTimController());
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Obx(
            () => Text(
              "Tambah Anggota${addTim.progress.value == 0 ? '' : ' (${addTim.progress.value})'}",
              style: TextStyle(
                color: Colors.black,
                fontSize: textScaleFactor <= 1.15 ? 18 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(AllTeamView());
                  },
                  child: Text(
                    "Selesai",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/page-search');
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Color(0xFF969696),
                                fontSize: textScaleFactor <= 1.15 ? 15 : 13,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.search,
                            color: Color(0xFF969696),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: addTim.member.length,
                  itemBuilder: (context, index) {
                    final member = addTim.member[index];
                    return ListTile(
                        onTap: () => addTim.toggleTaskCompletion(index),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(member.image),
                        ),
                        title: Text(
                          member.nama,
                          style: TextStyle(
                              fontSize: textScaleFactor <= 1.15 ? 13 : 10,
                              color: Colors.black),
                        ),
                        trailing: Obx(
                          () => CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              member.isCompleted.value
                                  ? Icons.check_box
                                  : Icons.crop_square,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
