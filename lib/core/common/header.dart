import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/core/utils/greet.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          textWidget(
            text: "${AppStrings.hi}, ${greet()}",
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                color: ColorCodes.lightGreen,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: const Icon(
                CupertinoIcons.bell,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
