import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/tugas/controllers/tugas_controller.dart';

class PageKebiasaan extends StatefulWidget {
  const PageKebiasaan({Key? key}) : super(key: key);

  @override
  State<PageKebiasaan> createState() => _PageKebiasaanState();
}

class _PageKebiasaanState extends State<PageKebiasaan> {
  TugasController controller = Get.find<TugasController>();
  // ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final query = MediaQuery.of(context);

    return MediaQuery(
      data: query.copyWith(
          textScaler:
              TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.15))),
      child: RefreshIndicator(
        onRefresh: () async => await controller,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                content(context),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // final baseColorHex = 0xFFE0E0E0;
    // final highlightColorHex = 0xFFC0C0C0;
    final mediaHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
        child: ListView.builder(
      itemCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        // final orderData = controller.pesananProses.data![index];
        // final totalHarga = (orderData.transaksi?.totalHarga ?? 0);
        return GestureDetector(
          onTap: () {
            // Get.to(const DetailTransaksiView(),
            //     arguments: orderData.transaksi?.kodeTr);
          },
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 5),
              child: ListTile(
                title: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        'lib/app/data/images/Vector3.png',
                        height:
                            25, // Sesuaikan dengan tinggi yang Anda inginkan
                        width: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Membaca Buku",
                          style: TextStyle(
                              fontSize: textScaleFactor <= 1.15 ? 15 : 11),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            decoration: BoxDecoration(
                                color: AppColors.trinaryColor,
                                borderRadius: BorderRadius.circular(3)),
                            child: Text(
                              "Sen - Kam",
                              style: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 9 : 5),
                            ))
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    )
        // Obx(() {
        //   return
        // if (controller.isLoading.value) {
        //   return Shimmer.fromColors(
        //     baseColor: Color(baseColorHex),
        //     highlightColor: Color(highlightColorHex),
        //     child: Padding(
        //       padding: const EdgeInsets.all(10),
        //       child: SizedBox(
        //         height: mediaHeight,
        //         child: ListView.builder(
        //             physics: const NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             itemCount: 5,
        //             itemBuilder: (BuildContext context, index) {
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   height: mediaHeight * 0.25,
        //                   decoration: const BoxDecoration(
        //                     color: Colors.orange,
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(
        //                         20,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             }),
        //       ),
        //     ),
        //   );
        // } else if (controller.pesananProses.data?.isEmpty ?? true) {
        //   return SizedBox(
        //     height: mediaHeight * 0.25,
        //     child: Center(
        //       child: Lottie.asset('assets/notList.json', repeat: true),
        //     ),
        //   );
        // } else {
        //   return ListView.builder(
        //     itemCount: 2,
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     itemBuilder: (BuildContext context, int index) {
        //       // final orderData = controller.pesananProses.data![index];
        //       // final totalHarga = (orderData.transaksi?.totalHarga ?? 0);
        //       return GestureDetector(
        //         onTap: () {
        //           // Get.to(const DetailTransaksiView(),
        //           //     arguments: orderData.transaksi?.kodeTr);
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.only(
        //               top: 10, left: 10, right: 10, bottom: 5),
        //           child: Card(
        //               color: Colors.white,
        //               key: ValueKey(
        //                   orderData.transaksi?.kodeTr), // Gunakan key unik
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(
        //                     10.0), // Sesuaikan dengan radius yang diinginkan
        //               ),
        //               elevation: 5,
        //               // color: Colors.red,
        //               child: Column(
        //                 children: [
        //                   ListTile(
        //                     leading: CircleAvatar(
        //                       backgroundImage:
        //                           AssetImage("assets/logo_dikantin.png"),
        //                     ),
        //                     title: Text(
        //                       "Data 1",
        //                       style: GoogleFonts.poppins(
        //                           textStyle: const TextStyle(
        //                               fontSize: 14,
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.bold)),
        //                     ),
        //                     subtitle: Text(
        //                       orderData.transaksi!.tanggal.toString(),
        //                       style: GoogleFonts.poppins(
        //                           textStyle: const TextStyle(
        //                               fontSize: 12,
        //                               fontWeight: FontWeight.normal)),
        //                     ),
        //                   ),
        //                   Container(
        //                     padding: const EdgeInsets.all(10),
        //                     // color: Colors.blue,
        //                     child: Column(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceAround,
        //                         children: [
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Text(
        //                                 "Total Menu",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.normal)),
        //                               ),
        //                               Text(
        //                                 "Data ",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.bold)),
        //                               ),
        //                             ],
        //                           ),
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Text(
        //                                 "Total",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.normal)),
        //                               ),
        //                               Text(
        //                                 'data',
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.bold)),
        //                               )
        //                             ],
        //                           ),
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Text("Status",
        //                                   style: GoogleFonts.poppins(
        //                                       fontSize: 14,
        //                                       color: Colors.black,
        //                                       fontWeight: FontWeight.normal)),
        //                               Text(
        //                                 "Data",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.red,
        //                                         fontWeight: FontWeight.bold)),
        //                               ),
        //                             ],
        //                           ),
        //                         ]),
        //                   )
        //                 ],
        //               )),
        //         ),
        //       );
        //     },
        //   );
        // }
        // }),
        );
  }
}
