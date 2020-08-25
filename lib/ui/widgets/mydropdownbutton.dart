import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';

class MyDropdownButton extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String title;
  final String hint;

  final double small;
  final double medium;
  final double large;
  final double xlarge;

  final List<String> elements;
  final double padding;
  MyDropdownButton({Key key, @required this.title, @required this.onChanged, this.hint, this.elements, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = 8}) : super(key: key);
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getWidth(double screenSize){
    double width = 0;
    if(ScreenSize.isSmall(screenSize))
      width = (widget.small != null) ? screenSize / widget.small : screenSize / getNotNullScreenSize();
    else if(ScreenSize.isMedium(screenSize))
      width = (widget.medium != null) ? screenSize / widget.medium : screenSize / getNotNullScreenSize();
    else if(ScreenSize.isLarge(screenSize))
      width = (widget.large != null) ? screenSize / widget.large : screenSize / getNotNullScreenSize();
    else if(ScreenSize.isXLarge(screenSize))
      width = (widget.xlarge != null) ? screenSize / widget.xlarge : screenSize / getNotNullScreenSize();
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
    return LayoutBuilder(
      builder: (context, boxconstraints) {
        return Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontSize: 15),),
              Container(
                  width: getWidth(boxconstraints.maxWidth) - (widget.padding * 2),
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
          ),
        );
      }
    );
  }
}