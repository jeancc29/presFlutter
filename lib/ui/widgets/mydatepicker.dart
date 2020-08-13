import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final DateTime fecha;
  final String title;
  final ValueChanged<DateTime> onDateTimeChanged;
  MyDatePicker({Key key,@required this.title, this.fecha, @required this.onDateTimeChanged}) : super(key: key);

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime fecha;

  @override
  void initState() {
    // TODO: implement initState
    fecha = (widget.fecha != null) ? widget.fecha : DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, textAlign: TextAlign.start,),
        RaisedButton(
          elevation: 0, 
          color: Colors.transparent, 
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey, width: 1)),
          child: Text("${fecha.year}-${fecha.month}-${fecha.day}", style: TextStyle(fontSize: 16)),
          onPressed: () async {
            DateTime f = await showDatePicker(initialEntryMode: DatePickerEntryMode.input, context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
            widget.onDateTimeChanged((f != null) ? f : fecha);
            setState(() => fecha = (f != null) ? f : fecha);
          },
        ),
      ],
    );
  }
}