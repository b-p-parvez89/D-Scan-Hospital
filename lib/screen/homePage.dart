// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_hospital/widgets/banners.dart';
import 'package:d_scan_hospital/widgets/top_doctors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/category.dart';
import '../widgets/searchBox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream dataList;
  @override
  void initState() {
    dataList = FirebaseFirestore.instance.collection("banners").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.4),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                ListTile(
                    leading: Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://th.bing.com/th?id=OIP.SzixlF6Io24jCN67HHZulAHaLH&w=204&h=306&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2"))),
                      // child: Image.network(
                      //     "https://th.bing.com/th?id=OIP.SzixlF6Io24jCN67HHZulAHaLH&w=204&h=306&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2"),
                    ),
                    title: Text(
                      "Hi Parvez",
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    subtitle: Text(
                      "How is your health",
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 26,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    )),
                SizedBox(
                  height: 12.h,
                ),
                SearchBox(),
                SizedBox(height: 10),
                Banners(),
                CategoryData(),
                TopDoctor(
                  height: 200.h,
                )
              ],
            ),
          ),
        ));
  }
}
