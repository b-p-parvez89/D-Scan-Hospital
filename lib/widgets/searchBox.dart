import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 35.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sh),
            color: Colors.white.withOpacity(0.6)),
        child: Center(
          child: TextFormField(
              style:
                  GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              )),
        ),
      ),
    );
  }
}
