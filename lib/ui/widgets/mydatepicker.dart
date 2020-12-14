import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/ui/widgets/mydropdown.dart';

class MyDatePicker extends StatefulWidget {
  final DateTime fecha;
  final String title;
  final ValueChanged<DateTime> onDateTimeChanged;
  final DatePickerEntryMode initialEntryMode;
  final bool isDropdown;
  final String initialHint;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final double padding;

  MyDatePicker({Key key,@required this.title, this.fecha, @required this.onDateTimeChanged, this.initialEntryMode = DatePickerEntryMode.input, this.isDropdown = false, this.initialHint, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = 8}) : super(key: key);

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime fecha;
  String initialHint = null;
  @override
  void initState() {
    // TODO: implement initState
    fecha = (widget.fecha != null) ? widget.fecha : DateTime.now();
    initialHint = widget.initialHint;
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

  _dateChanged() async {
    DateTime f = await showDatePicker(initialEntryMode: widget.initialEntryMode, context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
    widget.onDateTimeChanged((f != null) ? f : fecha);
    setState((){
      initialHint = null;
      fecha = (f != null) ? f : fecha;
    });
  }

  _mydropdownScreen(double width){
    return SizedBox(
      width: getWidth(width) - (widget.padding * 2),
      // height: 30,
      child: 
      MyDropdown(title: widget.title, onTap: _dateChanged, hint: (initialHint != null) ? initialHint : "${fecha.year}-${fecha.month}-${fecha.day}",)
    );
  }

  _screen(double width){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontFamily: "GoogleSans")),
        SizedBox(
          width: getWidth(width) - (widget.padding * 2),
          // height: 30,
          child: 
          widget.isDropdown
          ?
          MyDropdown(title: widget.title, onTap: _dateChanged, hint: "${fecha.year}-${fecha.month}-${fecha.day}",)
          :
          RaisedButton(
            elevation: 0, 
            padding: EdgeInsets.only(top: 15, bottom: 15),
            color: Colors.transparent, 
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey, width: 1)),
            child: Text((initialHint != null) ? initialHint : "${fecha.year}-${fecha.month}-${fecha.day}", style: TextStyle(fontSize: 16, fontFamily: "GoogleSans")),
            onPressed: _dateChanged,
          ),
        ),
      ],
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxconstraints) {
        return Padding(
          padding: EdgeInsets.all(widget.padding),
          child:  
            widget.isDropdown
            ?
            _mydropdownScreen(boxconstraints.maxWidth)
            :
            _screen(boxconstraints.maxWidth)
        );
      }
    );
  }
}