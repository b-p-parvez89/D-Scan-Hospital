// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TopDoctor extends StatefulWidget {
  double height;
  TopDoctor({required this.height});
  @override
  State<TopDoctor> createState() => _TopDoctorState();
}

class _TopDoctorState extends State<TopDoctor> {
  late Stream topDoctors;
  @override
  void initState() {
    topDoctors = FirebaseFirestore.instance.collection("to_doctor").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Top Doctors",
                style: GoogleFonts.roboto(fontSize: 22, color: Colors.black)),
            TextButton(
              onPressed: () {},
              child: Text("See All",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                  )),
            ),
          ],
        ),
        StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error Please chack your connection");
              } else {
                return Container(
                  height: widget.height,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var doctors = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.blue.withOpacity(0.3),
                            child: Row(children: [
                              Container(
                                height: 70.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue.withOpacity(0.7),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(doctors['image']))),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doctors['name'],
                                      style: GoogleFonts.roboto(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(doctors['type'],
                                      style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w800)),
                                  Text(doctors['degree'],
                                      style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          color: Colors.black.withOpacity(0.6),
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 12.w,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                );
              }
            },
            stream: topDoctors),
      ],
    );
  }
}
