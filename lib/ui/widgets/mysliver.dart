import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';

class MySliver extends StatefulWidget {
  final MySliverAppBar sliverAppBar;
  final Widget sliver;

  MySliver({Key key, @required this.sliverAppBar, @required this.sliver}) : super(key: key);

  @override
  _MySliverState createState() => _MySliverState();
}

class _MySliverState extends State<MySliver> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
          controller: _controller,
          child: CupertinoScrollbar(
            controller: _controller,
            isAlwaysShown: true,
            child: CustomScrollView(
              slivers: [
                widget.sliverAppBar,
                widget.sliver
                // SliverFillRemaining(),
                // SliverList(delegate: SliverChildListDelegate(widget.elements))
              ],
            ),
          ),
        );
      
  }
}

class MySliverButton extends StatefulWidget {
  final dynamic title;
  final dynamic iconWhenSmallScreen;
  final Function onTap;
  final bool isFlatButton;
  final bool visibleOnlyWhenSmall;
  MySliverButton({Key key, @required this.title, @required this.iconWhenSmallScreen, @required this.onTap, this.isFlatButton = false, this.visibleOnlyWhenSmall = false}) : super(key: key);

  @override
  _MySliverButtonState createState() => _MySliverButtonState();
}

class _MySliverButtonState extends State<MySliverButton> {

  _iconScreen(){
    return (widget.iconWhenSmallScreen is IconData) ? IconButton(icon: Icon(widget.iconWhenSmallScreen), onPressed: widget.onTap) : widget.iconWhenSmallScreen;
  }

  _buttonScreen(){
    return 
    // widget.visibleOnlyWhenSmall
    // ?
    // SizedBox()
    // :
    widget.isFlatButton
    ?
    FlatButton(onPressed: widget.onTap, child: Text(widget.title, style: TextStyle(fontFamily: "GoogleSans", fontWeight: FontWeight.w600)))
    :
     Padding(
       padding: EdgeInsets.only(left: 5, right: 5.0),
       child: myButton(
          text: widget.title,
          function: widget.onTap,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return 
    (Utils.isSmallOrMedium(MediaQuery.of(context).size.width))
        ?
        _iconScreen()
        :
        _buttonScreen();
    // LayoutBuilder(
    //   builder: (context, boxconstraint) {
    //     return 
    //     (ScreenSize.isMedium(boxconstraint.maxWidth) || ScreenSize.isSmall(boxconstraint.maxWidth))
    //     ?
    //     _iconScreen()
    //     :
    //     _buttonScreen();
    //   }
    // );
  }
}

class MySliverAppBar extends StatefulWidget {
  final dynamic title;
  final dynamic subtitle;
  final double expandedHeight;
  final bool cargando;
  final List<MySliverButton> actions;
  MySliverAppBar({Key key, this.title, this.subtitle, this.expandedHeight = 110, this.cargando = false, this.actions = const []}) : super(key: key);

  @override
  _MySliverAppBarState createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  var _txtSearch = TextEditingController();

  _titleScreen(BoxConstraints boxconstraint){
    return AnimatedDefaultTextStyle(
    duration: Duration(milliseconds: 300), 
    style: TextStyle(fontSize: Utils.isSmallOrMedium(boxconstraint.maxWidth) ? boxconstraint.biggest.height < 57 ? 18 : 20 : boxconstraint.biggest.height < 57 ? 20 : 32, color: Utils.fromHex("#202124"), fontFamily: 'GoogleSans', fontWeight: FontWeight.w500, letterSpacing: 0.2),
    child: Text(widget.title, )
    );
  }

  _flexibleSpace(){
    return LayoutBuilder(
        builder: (context, boxconstraint) {
          print("Pruebasliver: ${boxconstraint.biggest.height}");
          return SingleChildScrollView(
            child: 
            // (ScreenSize.isMedium(MediaQuery.of(context).size.width) || ScreenSize.isSmall(MediaQuery.of(context).size.width))
            // ?
            Padding(
              padding: EdgeInsets.only( left: Utils.isSmallOrMedium(boxconstraint.maxWidth) ? 0 : 8.0, top: boxconstraint.biggest.height <= 57 ? 10 : 14,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _titleScreen(boxconstraint),
                      Expanded(child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Wrap(
                            children: widget.actions
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: boxconstraint.biggest.height < 57 ? 20 : 10,),
                  Visibility(
                    visible: widget.subtitle != "",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(widget.subtitle, style: TextStyle(color: Utils.fromHex("#5f6368"), fontFamily: "GoogleSans", fontSize: 14, letterSpacing: 0.4),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, top: 20),
                    child: Divider(color: Colors.grey.shade300, thickness: 0.9, height: 1,),
                  ),
                ],
              ),
            )
            // :
            // Padding(
            //   padding: const EdgeInsets.only(top: 53.0),
            //   child: MyHeader(title: "Clientes", subtitle: widget.subtitle,),
            // )

          );
        }
      );
      
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      onStretchTrigger: (){
        print("Holaaa sliver trigger");
        return;
      },

      // backgroundColor: Colors.white,
      pinned: true,
      expandedHeight: widget.expandedHeight,
      flexibleSpace: _flexibleSpace()
      
      
    );
  }
}