import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constats.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
      alignment: Alignment(-0.80, -0.80),
      child: Text(
        "Categoties",
        style: GoogleFonts.comfortaa(
          textStyle: HeaderTextStyle,
        ),
      ),
    ));
  }
}
