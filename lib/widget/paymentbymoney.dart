import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PaymentMmoney extends StatefulWidget {
  final tablename;
  const PaymentMmoney({Key? key, required this.tablename}) : super(key: key);

  @override
  State<PaymentMmoney> createState() => _PaymentMmoneyState();
}

DateTime time = DateTime.now();
final timenow = DateFormat('HH:mm').format(time);

class _PaymentMmoneyState extends State<PaymentMmoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ERPTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          widget.tablename,
          style: TextStyle(color: ERPTheme.BASE_COLOR),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ERPImages.mmoney,
                height: 63.h,
                width: 63.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "ສະແກນເພື່ອຊຳລະ",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: ERPTheme.BASE_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 63.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ERPTheme.RED_COLOR,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "ຊື່ຮ້ານ:",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ERPTheme.WHITE_COLOR,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                      "Xaiy",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ERPTheme.WHITE_COLOR,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "70,000 ກີບ",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ERPTheme.RED_COLOR),
                    ),
                  ),
                  //ສຳລັບ generate code
                  Container(
                    height: 226.h,
                    width: 228.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: ERPTheme.BASE_COLOR,
                    )),
                    child: Image.asset(
                      ERPImages.mmoney,
                    ),
                  ),
                  ///////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(
                      timenow,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
