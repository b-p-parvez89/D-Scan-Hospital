import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryData extends StatefulWidget {
  const CategoryData({super.key});

  @override
  State<CategoryData> createState() => _CategoryDataState();
}

class _CategoryDataState extends State<CategoryData> {
  late Stream dataList;
  @override
  void initState() {
    dataList = FirebaseFirestore.instance.collection("catagory").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Categories",
                style: GoogleFonts.roboto(fontSize: 22, color: Colors.black)),
            TextButton(
                onPressed: () {},
                child:
                    Text("See All", style: GoogleFonts.roboto(fontSize: 16))),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error Please chack your connection");
              } else {
                return Container(
                  height: 80.h,
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var banners = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;

                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(banners['image']),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              (banners['name']),
                            )
                          ],
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
            stream: dataList),
      ],
    );
  }
}
