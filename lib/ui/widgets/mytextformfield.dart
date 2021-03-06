import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/mydescription.dart';

class MyType {
  const MyType._(this.index);

  /// The encoded integer value of this font weight.
  final int index;

  /// Thin, the least thick
  static const MyType normal = MyType._(0);

  /// Extra-light
  static const MyType border = MyType._(1);

  /// Light
  static const MyType rounded = MyType._(2);

  /// A list of all the font weights.
  static const List<MyType> values = <MyType>[
    normal, border, rounded
  ];
}


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
  final bool isPassword;
  final ValueChanged<String> validator;
  final MyType type;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final EdgeInsets padding;

  final bool isRequired;
  MyTextFormField({Key key, this.title = "", this.info = "", this.onChanged, this.sideTitle, this.labelText = "", this.controller, this.hint, this.maxLines = 1, this.enabled = true, this.small = 1, this.validator, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = const EdgeInsets.only(left: 8.0, right: 8.0), this.isRequired = false, this.isDigitOnly = false, this.isDecimal = false, this.isMoneyFormat = false, this.isPassword = false, this.type = MyType.border}) : super(key: key);
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
    // if(widget.isMoneyFormat)
    //   listFormatters.add(FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9,?][0-9,?]{0,}))(\\.[0-9]{0,})?\$')));

    if(widget.isMoneyFormat)
      listFormatters.add(CustomTextInputFormatter());
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
    // print("_converToMoneyFormat2 before $data text: ${widget.controller.text}");

    if(data.isNotEmpty)
      data = '${_formatNumber(data.replaceAll(',', ''))}$punto';
    // print("_converToMoneyFormat2 $data text: ${widget.controller.text}");
    // widget.controller.text = data;
    widget.controller.value = TextEditingValue(
      // text: data.isNotEmpty ? data.replaceAll(',', '') : data,
      text: data,
      selection: TextSelection.collapsed(offset: data.length, ),
    );
  }

  _textFormField(){
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      maxLines: widget.maxLines,
      style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          prefixText: _getPrefixText(),
          hintText: widget.hint,
          labelText: widget.title,
          // contentPadding: EdgeInsets.all(10),
          isDense: true,
          
        ),
        obscureText: widget.isPassword,
        keyboardType: _getkeyboardType(),
        inputFormatters: _getInputFormatters(),
        //  [
        //   // WhitelistingTextInputFormatter.digitsOnly
        //   FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))

        // ],
        validator: (widget.validator != null)
        ?
        widget.validator
        :
        (data){
          if(data.isEmpty && widget.isRequired)
            return "Campo requerido";
          return null;
        },
        onChanged: (data){
    // print("_converToMoneyFormat2 $data");

          

          if(widget.isMoneyFormat){
            _converToMoneyFormat(data);
          }

          if(widget.onChanged != null)
            widget.onChanged(data);
          
        },
      );
  }

  _textFormFieldRounded(){
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      maxLines: widget.maxLines,
      // style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          prefixText: _getPrefixText(),
          hintText: widget.hint,
          contentPadding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          isDense: true,
          // contentPadding: EdgeInsets.all(0),
          alignLabelWithHint: true,
          // border: InputBorder.none,
          fillColor: Colors.transparent,
          // filled: true,
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          focusedBorder: new OutlineInputBorder(
            // borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(width: 0.2, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          errorBorder: new OutlineInputBorder(
            // borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(width: 0.2, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          focusedErrorBorder: new OutlineInputBorder(
            // borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(width: 0.2, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          enabledBorder: new OutlineInputBorder(
            // borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(width: 0.2, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          // border: new OutlineInputBorder(
          //   // borderRadius: new BorderRadius.circular(25.0),
          //   borderSide: new BorderSide(width: 0.2, color: Colors.black),
          // ),
        ),
        obscureText: widget.isPassword,
        keyboardType: _getkeyboardType(),
        inputFormatters: _getInputFormatters(),
        //  [
        //   // WhitelistingTextInputFormatter.digitsOnly
        //   FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))

        // ],
        validator: (widget.validator != null)
        ?
        widget.validator
        :
        (data){
          if(data.isEmpty && widget.isRequired)
            return "Campo requerido";
          return null;
        },
        onChanged: (data){
    // print("_converToMoneyFormat2 $data");

          

          if(widget.isMoneyFormat){
            _converToMoneyFormat(data);
          }

          if(widget.onChanged != null)
            widget.onChanged(data);
          
        },
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
          // focusedBorder: new OutlineInputBorder(
          //   // borderRadius: new BorderRadius.circular(25.0),
          //   borderSide: new BorderSide(width: 2, color: Colors.blue),
          // ),
          // enabledBorder: new OutlineInputBorder(
          //   // borderRadius: new BorderRadius.circular(25.0),
          //   borderSide: new BorderSide(width: 0.2, color: Colors.black),
          // ),
          border: new OutlineInputBorder(
            // borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(width: 0.2, color: Colors.black),
          ),
        ),
        obscureText: widget.isPassword,
        keyboardType: _getkeyboardType(),
        inputFormatters: _getInputFormatters(),
        //  [
        //   // WhitelistingTextInputFormatter.digitsOnly
        //   FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))

        // ],
        validator: (widget.validator != null)
        ?
        widget.validator
        :
        (data){
          if(data.isEmpty && widget.isRequired)
            return "Campo requerido";
          return null;
        },
        onChanged: (data){
    // print("_converToMoneyFormat2 $data");

          

          if(widget.isMoneyFormat){
            _converToMoneyFormat(data);
          }

          if(widget.onChanged != null)
            widget.onChanged(data);
          
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
                        labelText: widget.labelText,
                      ),
                      obscureText: widget.isPassword,
                      validator: (widget.validator != null) 
                      ? 
                      widget.validator
                      :
                       (data){
                        if(data.isEmpty && widget.isRequired)
                          return "Campo requerido";
                        return null;
                      },
                    );
  }

  _typeOfTextFormField(){
    switch (widget.type) {
      case MyType.normal:
        return _textFormField();
        break;
      case MyType.rounded:
        return _textFormFieldRounded();
        break;
      default:
        return _textFormFieldWithoutLabel();
    }
  }

  _screen(double width){
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(visible: widget.title != "" && widget.type == MyType.border,child: Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontFamily: "GoogleSans"))),
                  
              // Visibility(visible: widget.title != "",child: MyDescripcon(title: "Proximo pago",),),
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
                    // (widget.labelText == "")
                    // ?
                    // _textFormFieldWithoutLabel()
                    // :
                    // _textFormFieldWithLabel(),
                    _typeOfTextFormField(),
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

class CustomTextInputFormatter extends TextInputFormatter {
  toMoney(String data){
    const _locale = 'en';
  // String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
    String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(Utils.toDouble(s));
    return _formatNumber(data.replaceAll(',', ''));
  }
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      // int selectionIndexFromTheRight =
      //     newValue.text.length - newValue.selection.extentOffset;
      // List<String> chars = newValue.text.replaceAll(' ', '').split('');
      // String newString = '';
      // for (int i = 0; i < chars.length; i++) {
      //   if (i % 3 == 0 && i != 0) newString += ' ';
      //   newString += chars[i];
      // }
      // newString = newString.replaceAll(' ', ',');
      // print("newValue: ${newValue.text}");
      String newString = '${(!newValue.text.endsWith(".")) ? toMoney(newValue.text) : newValue.text}';
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length,
        ),
      );
    } else {
      return newValue;
    }
  }
}