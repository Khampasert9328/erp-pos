import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAmount extends StatefulWidget {
  String? title;
  AddAmount({this.title});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  int number = 0;

  void setNumber(bool isAdd) {
    if (isAdd) {
      setState(() {
        number += 1;
      });
    } else {
      if (number > 0) {
        setState(() {
          number -= 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.title ?? 'ຈຳນວນ',
            style: TextStyle(fontSize: 14.sp, color: ERPTheme.BASE_COLOR)),
        SizedBox(
          width: 10.w,
        ),
        buildButton(Icons.add, () {
          setNumber(true);
        }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(
                number < 10 ? '0$number' : '$number',
                style: TextStyle(color: ERPTheme.BASE_COLOR, fontSize: 14.sp),
              ),
              Container(
                width: 20.w,
                height: 2.h,
                decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
              )
            ],
          ),
        ),
        buildButton(Icons.minimize, () {
          setNumber(false);
        }),
      ],
    );
  }

  Container buildButton(IconData iconData, VoidCallback onPressed) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: ERPTheme.BASE_COLOR),
            shape: BoxShape.circle),
        child: IconButton(onPressed: onPressed, icon: Icon(iconData)));
  }
}
