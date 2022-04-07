import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_pic.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        onPressed: () {},
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/User Icon.svg",
              width: 22,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                "My Account",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
