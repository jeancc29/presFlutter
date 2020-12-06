import 'package:flutter/material.dart';

class MyTable extends StatefulWidget {
  final List<String> columns;
  final List<List<String>> rows;
  final List<String> totals;
  final EdgeInsets padding;
  final int indexCellKeyToReturnOnClick;
  MyTable({Key key, @required this.columns, @required this.rows, this.totals, this.indexCellKeyToReturnOnClick = 0, this.padding = const EdgeInsets.only(bottom: 15, top: 15)}) : super(key: key);
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  List<DataRow> rows;
  @override
  void initState() {
    // TODO: implement initState
    // _init();
    super.initState();
  }

  List<DataRow> _init(){
    rows = List();
    print("befoore first if");
    if(widget.rows == null)
      return [];
    print("first if");
    if(widget.rows.length == 0)
      return [];
    print("second if");

    rows = widget.rows.map((row) => DataRow(cells: row.map((string) => DataCell(Text(string, style: TextStyle(fontFamily: "GoogleSans"), textAlign: TextAlign.center,))).toList() )).toList();
    var totals = getTotalsDataRow();
    if(totals != null)
      rows.add(totals);

    return rows;
    setState(() => rows = widget.rows.map((row) => DataRow(cells: row.map((string) => DataCell(Text(string, style: TextStyle(fontFamily: "GoogleSans"), textAlign: TextAlign.center,))).toList() )).toList());
    // _addTotalsToRows();
  }

  DataRow getTotalsDataRow(){
    if(widget.totals == null)
      return null;
    
    if(rows.length == 0)
      return null;

    widget.rows.forEach((element) {element.forEach((element2) {print("MyTable _addTotalsToRows: ${element2}");});});
    // setState(() => rows.add(DataRow(cells: widget.totals.map((string) => DataCell(Text(string, style: TextStyle(fontSize: 15, fontFamily: "GoogleSans", fontWeight: FontWeight.w500), textAlign: TextAlign.center,))).toList() )) );   
    return DataRow(cells: widget.totals.map((string) => DataCell(Text(string, style: TextStyle(fontSize: 17, fontFamily: "GoogleSans", fontWeight: FontWeight.w500), textAlign: TextAlign.center,))).toList() );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        columns: widget.columns.map((e) => DataColumn(label: Text(e, style: TextStyle(fontFamily: "GoogleSans"), textAlign: TextAlign.center,))).toList(),
        rows: _init(),
      )
    );
  }
}