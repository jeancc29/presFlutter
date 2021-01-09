import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';

class PruebaScroll2 extends StatefulWidget {
  @override
  _PruebaScroll2State createState() => _PruebaScroll2State();
}

class _PruebaScroll2State extends State<PruebaScroll2> {
  final ScrollController myScrollWorks = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrimaryScrollController(
        controller: myScrollWorks,
        child: CupertinoScrollbar(
        controller: myScrollWorks,
          isAlwaysShown: true,
          thickness: 5,
          child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
          )
        )
      )
      // MyScrollbar(
      //   child: Column(
      //     children: [
      //       Container(
      //         color: Colors.green,
      //         height: MediaQuery.of(context).size.height,
      //         width: MediaQuery.of(context).size.width,
      //       ),
      //       Container(
      //         color: Colors.blue,
      //         height: MediaQuery.of(context).size.height,
      //         width: MediaQuery.of(context).size.width,
      //       ),
      //       Container(
      //         color: Colors.red,
      //         height: MediaQuery.of(context).size.height,
      //         width: MediaQuery.of(context).size.width,
      //       ),
      //     ],
      //   ),
      // ),
    
    );
  }
}