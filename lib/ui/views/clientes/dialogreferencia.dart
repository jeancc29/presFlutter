import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';

class DialogReferencia extends StatefulWidget {
  final BuildContext context;
  DialogReferencia({Key key,@required this.context}) : super(key: key);

  @override
  _DialogReferenciaState createState() => _DialogReferenciaState();
}

class _DialogReferenciaState extends State<DialogReferencia> {
  var _formKey = GlobalKey<FormState>();
  String _tipo = "Personal";
  String _parentesco = "Personal";
  var _txtNombre = TextEditingController();
  var _txtTelefono = TextEditingController();

  _tipoChange(value){
    setState(() => _tipo = value);
  }
  
  _parentescoChange(value){
    setState(() => _parentesco = value);
  }

  _retornarReferencia({Referencia referencia}){
    Navigator.pop(context, referencia);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context = widget.context;
    return AlertDialog(
      title: Text("Agregar referencia", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w600)),
      content: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width / 4,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyDropdownButton(title: "Tipo*", onChanged: _tipoChange, elements: ["Personal", "Comercial"],),
              MyTextFormField(title: "Nombre completo*", controller: _txtNombre,),
              MyTextFormField(title: "Telefono", controller: _txtTelefono,),
              MyDropdownButton(title: "Parentesco*", onChanged: _parentescoChange, elements: ["Hermano", "Cunado", "Vecino", "Primo", "Padre", "Madre", "Conyugue"], ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold)), onPressed: _retornarReferencia),
        // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
        SizedBox(
          width: 145,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: RaisedButton(
                elevation: 0,
                color: Utils.colorPrimaryBlue,
                child: Text('Agregar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: (){
                  // _connect();
                  if(_formKey.currentState.validate()){
                    _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco));
                  }
                },
            ),
          ),
        ),
      ],
    );
  }
}