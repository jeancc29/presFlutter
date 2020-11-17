import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';

class MyDropdownButton extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String initialValue;
  final String title;
  final String hint;
  final bool enabled;
  final bool isAllBorder;

  final double small;
  final double medium;
  final double large;
  final double xlarge;

  final List<String> elements;
  final EdgeInsets padding;
  MyDropdownButton({Key key, this.initialValue, this.title = "", @required this.onChanged, this.hint, this.elements, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = const EdgeInsets.only(left: 8.0, right: 8.0, top: 8), this.enabled = true, this.isAllBorder = false}) : super(key: key);
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    _initialValue();
    super.initState();
  }

  _initialValue(){
    if(widget.initialValue != null){
      if(widget.elements.length > 0){
        var idx = widget.elements.indexWhere((element) => element == widget.initialValue);
        if(idx != -1)
          _index = idx;
      }
    }
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

  _dropdownFormField(){
    return DropdownButtonFormField(
      decoration: InputDecoration(
        
        // contentPadding: EdgeInsetsGeometry.lerp(a, b, t),
        // contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(borderSide: BorderSide(width: 1))
      ),
      
      itemHeight: 50,
      disabledHint: Text("${widget.elements[_index]}"),
      isDense: false, 
      
      items: widget.elements.map<DropdownMenuItem>((e) => DropdownMenuItem(child: Text(e, style: TextStyle(fontSize: 13),), value: e,)).toList(), 
      onChanged: (!widget.enabled) ? null : (data){
        widget.onChanged(data);
        int idx = widget.elements.indexWhere((element) => element == data);
        setState(() => _index = idx);
      }, 
      value: widget.elements[_index],
    );
                  
  }

  _dropdowHideUnderline(){
    return DropdownButtonHideUnderline(
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            child: ButtonTheme(
              alignedDropdown: true,
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: DropdownButton(
                
                disabledHint: Text("${(widget.elements.length == 0) ? '' : widget.elements[_index]}"),
                isExpanded: true, 
                
                items: widget.elements.map<DropdownMenuItem>((e) => DropdownMenuItem(child: Text(e, style: TextStyle(fontSize: 13),), value: e,)).toList(), 
                onChanged: (!widget.enabled) ? null : (data){
                  widget.onChanged(data);
                  int idx = widget.elements.indexWhere((element) => element == data);
                  setState(() => _index = idx);
                }, 
                value: widget.elements[_index],
        ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxconstraints) {
        return Padding(
          padding: widget.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.title != "",
                child: Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontFamily: "GoogleSans"),)
              ),
              Container(
                  width: getWidth(boxconstraints.maxWidth) - (widget.padding.left + widget.padding.right),
                  child: 
                  (widget.isAllBorder)
                  ?
                  _dropdownFormField()
                  :
                  DropdownButton(
                    disabledHint: Text("${widget.elements[_index]}"),
                    isExpanded: true, 
                    
                    items: widget.elements.map<DropdownMenuItem>((e) => DropdownMenuItem(child: Text(e, style: TextStyle(fontFamily: "GoogleSans")), value: e,)).toList(), 
                    onChanged: (!widget.enabled) ? null : (data){
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