import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/add_food_type_dialog.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:erp_pos/widget/food_menu_card.dart';
import 'package:erp_pos/widget/place_to_eat_card.dart';
import 'package:erp_pos/widget/selected_menu_card.dart';
import 'package:erp_pos/widget/selected_menu_card_expand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:erp_pos/constant/routes.dart' as custom_route;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FoodMenuBody extends StatefulWidget {
  @override
  State<FoodMenuBody> createState() => _FoodMenuBodyState();
}

class _FoodMenuBodyState extends State<FoodMenuBody> {
  TextEditingController searchMenu = TextEditingController();

  List<String> foodType = [
    'ເຂົ້າລາດໜ້າ',
    'ເຄື່ອງດື່ມ',
    'ນ້ຳ',
  ];

  String selectedFoodType = 'ເຂົ້າລາດໜ້າ';
  int amount = 50000;
  double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  bool isSelectedMenuCard = true;
  @override
  Widget build(BuildContext context) {
    _initFabHeight = MediaQuery.of(context).size.height * 0.14;
    _panelHeightClosed = MediaQuery.of(context).size.height * 0.12;
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.9;
    return Stack(
      children: [
        SlidingUpPanel(
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: .5,
          body: buildBody(context),
          panelBuilder: (sc) => _panel(sc),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          onPanelSlide: (double pos) => setState(() {
            _fabHeight =
                pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
          }),
        ),
        // Positioned(
        //   right: 20.0,
        //   bottom: _fabHeight,
        //   child: buildFloatingButton(context),
        // ),
      ],
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Text(
            'ລາຍການອາຫານ',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ERPTextfield(
                      controller: searchMenu, hintText: 'ຄົ້ນຫາອາຫານ')),
              SizedBox(
                width: 15.w,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: (45.w + 45.h) / 2,
                  ))
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          // SizedBox(
          //   height: 30.h,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       IconButton(
          //           color: Colors.red,
          //           onPressed: () {
          //             addFoodTypeDialog(context);
          //           },
          //           icon: Icon(
          //             Icons.add,
          //             color: AppTheme.BASE_COLOR,
          //             size: 30,
          //           )),
          //       SizedBox(
          //         width: 10.w,
          //       ),
          //       Expanded(
          //           child: ListView.builder(
          //         itemCount: foodType.length,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (context, index) {
          //           return GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 selectedFoodType = foodType[index];
          //               });
          //             },
          //             child: Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 30),
          //               child: Text(
          //                 foodType[index],
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w700,
          //                     color: Color(selectedFoodType == foodType[index]
          //                         ? 0xFF283150
          //                         : 0xFF999DAA),
          //                     fontSize: 18.sp,
          //                     decoration: selectedFoodType == foodType[index]
          //                         ? TextDecoration.underline
          //                         : TextDecoration.none),
          //               ),
          //             ),
          //           );
          //         },
          //       ))
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(child: FoodMenuCard()),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: isSelectedMenuCard
            ? SelectedMenuCardExpand(
                onNext: () async {
                  setState(() {
                    isSelectedMenuCard = !isSelectedMenuCard;
                  });
                },
                scrollController: sc,
                selectMenu: isSelectedMenuCard,
              )
            : PlaceToEatCard(
                scrollController: sc,
              ));
  }
}
