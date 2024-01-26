import 'package:flutter/material.dart';
import 'package:task/Photo%20tab.dart';
import 'package:task/Video%20tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTabs(),
    );
  }
}

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Task'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.photo), text: 'Photos'),
              Tab(icon: Icon(Icons.video_library), text: 'Videos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PhotoTab(),
            VideoTab(),
          ],
        ),
      ),
    );
  }
}
