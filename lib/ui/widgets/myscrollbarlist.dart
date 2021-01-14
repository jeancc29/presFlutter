import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyScrollbarList extends StatefulWidget {
  final List<Widget> children;
  final double height;
  MyScrollbarList({Key key, this.children, this.height}) : super(key: key);
  @override
  _MyScrollbarListState createState() => _MyScrollbarListState();
}

class _MyScrollbarListState extends State<MyScrollbarList> {

  ScrollController _controller;
  

  @override
  void initState() {
    _controller = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
        controller: _controller,
        child: CupertinoScrollbar(
        controller: _controller,
          isAlwaysShown: true,
          thickness: 5,
          child: ListView(
            children: widget.children
          )
        )
      );
  }
}