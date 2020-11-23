import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';


class MyTextFormField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String title;
  final String info;
  final String sideTitle;
  final String labelText;
  final TextEditingController controller;
  final String hint;
  final maxLines;
  final bool enabled;
  final bool isDigitOnly;
  final bool isDecimal;
  final bool isMoneyFormat;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final EdgeInsets padding;

  final bool isRequired;
  MyTextFormField({Key key, this.title = "", this.info = "", this.onChanged, this.sideTitle, this.labelText = "", this.controller, this.hint, this.maxLines = 1, this.enabled = true, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = const EdgeInsets.only(left: 8.0, right: 8.0), this.isRequired = false, this.isDigitOnly = false, this.isDecimal = false, this.isMoneyFormat = false}) : super(key: key);
  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  double _width;
  static const _locale = 'en';
  // String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(Utils.toDouble(s));
String get _currency => NumberFormat.simpleCurrency(locale: _locale, decimalDigits: 2).currencySymbol;
  @override
  void initState() {
    // TODO: implement initState
    // _width = getWidth();
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

  _getkeyboardType(){
    if(widget.maxLines != 1) 
      return TextInputType.multiline;
    if(widget.isDigitOnly || widget.isDecimal || widget.isMoneyFormat)
      return TextInputType.number;
    
    return null;
  }

  List<TextInputFormatter> _getInputFormatters(){
    List<TextInputFormatter> listFormatters = [];
    if(widget.isDigitOnly)
      listFormatters.add(FilteringTextInputFormatter.digitsOnly);

    if(widget.isDecimal)
      listFormatters.add(FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$')));
    if(widget.isMoneyFormat)
      listFormatters.add(FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9,]{0,}))(\\.[0-9]{0,})?\$')));

    return listFormatters;
  }



  _getPrefixText(){
    if(widget.isMoneyFormat){
      return _currency;
    }
    return null;
  }
 
  _converToMoneyFormat(String data){
    // print("_converToMoneyFormat $data");
    // data = '${_formatNumber(data.replaceAll(',', ''))}';
    String punto = '';
    //Si al final del string hay un punto (.) entonces le quitamos ese punto
    //para que la funcion toCurrency no lo elimine y despues se lo anadimos al final nuevamente
    if(data.endsWith(".")){
      punto += ".";
      data = data.substring(0, data.length - 1);
    }
    
    // data = '${Utils.toCurrency(data.replaceAll('\$', '').replaceAll(',', ''))}$punto';
    if(data.isNotEmpty)
      data = '${_formatNumber(data.replaceAll(',', ''))}$punto';
    // print("_converToMoneyFormat2 $data");
    widget.controller.value = TextEditingValue(
      text: data,
      selection: TextSelection.collapsed(offset: data.length),
    );
  }

  _textFormFieldWithoutLabel(){
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      maxLines: widget.maxLines,
      style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          prefixText: _getPrefixText(),
          hintText: widget.hint,
          // contentPadding: EdgeInsets.all(10),
          isDense: true,
          border: new OutlineInputBorder(
            // borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        keyboardType: _getkeyboardType(),
        inputFormatters: _getInputFormatters(),
        //  [
        //   // WhitelistingTextInputFormatter.digitsOnly
        //   FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))

        // ],
        validator: (data){
          if(data.isEmpty && widget.isRequired)
            return "Campo requerido";
          return null;
        },
        onChanged: (data){
          if(widget.onChanged != null)
            widget.onChanged(data);

          if(widget.isMoneyFormat){
            _converToMoneyFormat(data);
          }
          
        },
      );
  }

  _textFormFieldWithLabel(){
    return TextFormField(
                    controller: widget.controller,
                    maxLines: widget.maxLines,
                    keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
                    style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        labelText: widget.labelText
                      ),
                      validator: (data){
                        if(data.isEmpty && widget.isRequired)
                          return "Campo requerido";
                        return null;
                      },
                    );
  }

  _screen(double width){
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(visible: widget.title != "",child: Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontFamily: "GoogleSans"))),
              Container(
                // color: Colors.red,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
                // ),
                width: getWidth(width) - (widget.padding.left + widget.padding.right), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
                // height: 50,
                child:
                Column(
                  children: [
                    (widget.labelText == "")
                    ?
                    _textFormFieldWithoutLabel()
                    :
                    _textFormFieldWithLabel(),
                    Visibility(visible: widget.info != "",child: Text(widget.info, textAlign: TextAlign.start, style: TextStyle(fontSize: 13, fontFamily: "GoogleSans", color: Utils.fromHex("#5f6368"), letterSpacing: 0.4))),
                  ],
                )
              ),
            ],
          );
          
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxconstraints) {
        // print("mytextformfield boxconstrants: ${boxconstraints.maxWidth}");
        return Padding(
          padding: widget.padding,
          child: 
          _screen(boxconstraints.maxWidth)
        );
      }
    );
  }
}