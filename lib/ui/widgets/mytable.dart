import 'package:flutter/material.dart';

class MyTable extends StatefulWidget {
  final List<String> columns;
  final List<List<String>> rows;
  final EdgeInsets padding;
  MyTable({Key key, @required this.columns, @required this.rows, this.padding = const EdgeInsets.only(bottom: 15, top: 15)}) : super(key: key);
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        columns: widget.columns.map((e) => DataColumn(label: Text(e, style: TextStyle(fontFamily: "GoogleSans")))),
        rows: widget.rows.map((row) => DataRow(cells: row.map((string) => DataCell(Text(string, style: TextStyle(fontFamily: "GoogleSans")))))),
      )
    );
  }
}