import 'package:beloved_care/provider/products.dart';
import 'package:beloved_care/screens/create_meeting_screen.dart';
import 'package:beloved_care/screens/join_meeting_screen.dart';
import 'package:beloved_care/universal_variables.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class MeetingScreen extends StatefulWidget {
  static const routeName = '/MeetingScreen';

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  tabBuilder(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: ralewayStyle(
              15,
              Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    productsData.fetchProducts();

    final popularItems = productsData.popularProducts;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beloved Care",
          style: ralewayStyle(20, Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF07A8B2),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            tabBuilder("Join Meeting"),
            tabBuilder("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeetingScreen(),
          CreateMeeetingScreen(),
        ],
      ),
    );
  }
}
