import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/enum.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_size.dart';
import 'package:erp_pos/pages/food_menu_detail/components/food_menu_detail_body.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/theme.dart';

class FoodMenuCard extends StatefulWidget {
  @override
  State<FoodMenuCard> createState() => _FoodMenuCardState();
}

class _FoodMenuCardState extends State<FoodMenuCard> {
  int? number;

  Product data = Product();

  ERPFoodSize erpFoodSize = ERPFoodSize.Small;

  List<Product> listdata = [];

  final _refresh = GlobalKey<RefreshIndicatorState>();
  int index = 0;
  bool selectone = false;
   bool selecttwo = false;
    bool selectree = false;
  int add = 0;
  int smalsize = 0;
  int meduimsize = 1;
  int largesize = 2;
  @override
  @override
  Widget build(BuildContext context) {
    return Consumer2<FoodMenuProvider, GetFoodMenuProvider>(
      builder: (context, foodModel, getFoodModel, child) {
        return Scrollbar(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<GetFoodMenuProvider>().getProduct(true);
            },
            key: _refresh,
            child: ListView.builder(
                itemCount: getFoodModel.listProduct.length,
                itemBuilder: (context, index) {
                  final data = getFoodModel.listProduct[index];
                  int mainsize = data.size;
                  // for (var size in data.data.size!) {
                  //   print("sizesmall:${size.size}");
                  // }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              decoration: BoxDecoration(
                                color: Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: CachedNetworkImage(
                                      memCacheHeight: 63,
                                      memCacheWidth: 69,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.image_outlined,
                                              size: 70,
                                              color: AppTheme.GREY_COLOR),
                                      imageUrl:
                                          data.data.thumbnails!.first.uri!,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: AppTheme.BASE_COLOR,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 11.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.data.name!,
                                          style: TextStyle(
                                            fontFamily: 'Phetsarath-OT',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppTheme.BASE_COLOR,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text.rich(TextSpan(
                                            text: 'ລາຄາ ',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppTheme.BASE_COLOR,
                                              fontFamily: 'Phetsarath-OT',
                                            ),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(data.data.pricesale)} ກີບ',
                                                style: TextStyle(
                                                  fontFamily: 'Phetsarath-OT',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ])),
                                        AddAmount(
                                          index: index,
                                        )
                                      ],
                                    ),
                                  ),
                                  LikeButton(
                                    size: 55,
                                    animationDuration: Duration(seconds: 1),
                                    likeBuilder: ((isLiked) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: AppTheme.YELLOW_COLOR,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3))
                                            ]),
                                        child: Image.asset(
                                          ERPImages.categcory,
                                          color: AppTheme.WHITE_COLOR,
                                          cacheHeight: 30,
                                          cacheWidth: 30,
                                        ),
                                      );
                                    }),
                                    onTap: ((isLiked) async {
                                      int? amount = context
                                          .read<FoodMenuProvider>()
                                          .counter;
                                      int totalAmount =
                                          data.data.pricesale! * amount!;
                                      getFoodModel.setFoodMenuData(
                                          data.data, amount, totalAmount);
                                      foodModel.increment(add);
                                      getFoodModel.addTotalAmount(totalAmount);
                                      return !isLiked;
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FoodMenuSize(
                             select: !selectone,
                              onPressed: (() {
                                context.read<GetFoodMenuProvider>().setProductSize(smalsize, index);    
                             }),
                              mainsize: mainsize,
                              size: smalsize,
                              title: setSize(0),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            FoodMenuSize(
                             select: !selecttwo,
                              onPressed: () {
                                 context.read<GetFoodMenuProvider>().setProductSize(meduimsize, index);
                              },
                              mainsize: mainsize,
                              size: meduimsize,
                              title: setSize(1),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            FoodMenuSize(
                             select: !selectree,
                              onPressed: () {
                                  context.read<GetFoodMenuProvider>().setProductSize(largesize, index);
                              },
                              mainsize: mainsize,
                              size: largesize,
                              title: setSize(2),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
