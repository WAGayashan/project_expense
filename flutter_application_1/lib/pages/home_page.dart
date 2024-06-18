import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/data/data.dart';
import 'package:flutter_application_1/models/cost_model.dart';
import 'package:flutter_application_1/models/type_model.dart';
import 'package:flutter_application_1/pages/detail_screen.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/request_money_page.dart'; // Import the RequestMoneyPage
import 'package:flutter_application_1/widgets/custom_chart.dart';
import 'package:flutter_application_1/widgets/icon_btn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Request Money'),
              onTap: () {
                // Navigate to RequestMoneyPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestMoneyPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Navigate to login page and remove the current page from the stack
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.settings_outlined),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Dashboard',
          style: GoogleFonts.roboto(
            fontSize: 12.sp,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w500,
            color: kTextColor,
          ),
        ),
        actions: [
          CustomBtn(
            onPress: () {},
            iconData: Icons.add_outlined,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, int index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.only(
                    left: 2.w,
                    right: 2.w,
                    top: 2.h,
                    bottom: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(3.h),
                  ),
                  child: CustomChart(
                    expenses: weeklySpending,
                  ),
                );
              } else {
                final TypeModel typeModel = typeNames[index - 1];
                double tAmountSpent = 0;
                typeModel.expenses!.forEach((CostModel expense) {
                  tAmountSpent += expense.cost!;
                });
                return _buildCategories(typeModel, tAmountSpent);
              }
            }, childCount: 1 + typeNames.length),
          ),
        ],
      ),
    );
  }

  _buildCategories(TypeModel category, double tAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      typeModel: category,
                    )));
      },
      child: Container(
        width: 100.w,
        height: 13.h,
        margin: kMargin,
        padding: kPadding,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: kRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name!,
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  '\Rs.${(category.maxAmount! - tAmountSpent).toStringAsFixed(2)} / \Rs${category.maxAmount!.toStringAsFixed(2)}',
                  style: GoogleFonts.atma(
                    fontSize: 14.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            LayoutBuilder(builder: (context, constraints) {
              final double maxBarWidth = constraints.maxWidth;
              final double percentage =
                  (category.maxAmount! - tAmountSpent) / category.maxAmount!;
              double width = percentage * maxBarWidth;
              if (width < 0) {
                width = 0;
              }
              return Stack(
                children: [
                  Container(
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.h),
                        bottomRight: Radius.circular(2.h),
                      ),
                    ),
                  ),
                  Container(
                    height: 3.h,
                    width: width,
                    decoration: BoxDecoration(
                      color: setupColor(percentage),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.h),
                        bottomRight: Radius.circular(2.h),
                      ),
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
