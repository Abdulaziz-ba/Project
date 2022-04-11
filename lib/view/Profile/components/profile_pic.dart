import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/logo_size_invert.jpg"),
          ),
          Positioned(
            bottom: -10,
            right: -15,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white)),
                color: Colors.grey[200],
                onPressed: () {},
                  child: CircleAvatar(
                  backgroundImage: AssetImage("assets/cc.jpeg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
