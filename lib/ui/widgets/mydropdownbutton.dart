import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';

class MyDropdownButton extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final double screenSize;
  final String title;
  final String hint;

  final int small;
  final int medium;
  final int large;
  final int xlarge;

  final List<String> elements;
  MyDropdownButton({Key key, @required this.screenSize, @required this.title, @required this.onChanged, this.hint, this.elements, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5}) : super(key: key);
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  int _index = 0;
  double _width;
  @override
  void initState() {
    // TODO: implement initState
    _width = getWidth();
    super.initState();
  }

  getWidth(){
    double width = 0;
    if(ScreenSize.isSmall(widget.screenSize))
      width = (widget.small != null) ? widget.screenSize / widget.small : widget.screenSize / getNotNullScreenSize();
    else if(ScreenSize.isMedium(widget.screenSize))
      width = (widget.medium != null) ? widget.screenSize / widget.medium : widget.screenSize / getNotNullScreenSize();
    else if(ScreenSize.isLarge(widget.screenSize))
      width = (widget.large != null) ? widget.screenSize / widget.large : widget.screenSize / getNotNullScreenSize();
    else if(ScreenSize.isXLarge(widget.screenSize))
      width = (widget.xlarge != null) ? widget.screenSize / widget.xlarge : widget.screenSize / getNotNullScreenSize();
    return width;
    
  }
  getNotNullScreenSize(){
    
    if(widget.small != null)
      return widget.small;
    else if(widget.medium != null)
      return widget.medium;
    else if(widget.large != null)
      return widget.large;
    else
      return widget.xlarge;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, textAlign: TextAlign.start,),
        Container(
            width: _width,
            child: DropdownButton(
              isExpanded: true, 
              items: widget.elements.map<DropdownMenuItem>((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(), 
              onChanged: (data){
                widget.onChanged(data);
                int idx = widget.elements.indexWhere((element) => element == data);
                setState(() => _index = idx);
              }, 
              value: widget.elements[_index],
            )
          )
      ],
    );
  }
}