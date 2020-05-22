

import 'package:anappnewsportal/ui/otherNewsPage.dart';
import 'package:anappnewsportal/ui/sportsNewsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageofNews extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _HomePageOfNews();
  }
}

class _HomePageOfNews extends State<HomePageofNews> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          'NEWS',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          controller: controller,
          tabs: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Sports',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Other',
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          HomePage(),
          OtherHomePage(),
        ],
      ),
    );
  }

}