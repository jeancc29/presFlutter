import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';

class MyHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  final String actionFuncion;
  final Function function;
  MyHeader({Key key, @required this.title, this.subtitle, this.actionFuncion, this.function}) : super(key: key);
  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  // padding: const EdgeInsets.all(8.0),
                  // child: Text("Clientes", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                  // ),
                  // Padding(
                  // padding: const EdgeInsets.all(8.0),
                  // child: Text("Clientes", style: TextStyle(fontFamily: 'OpenSans', fontSize: 27, fontWeight: FontWeight.w700)),
                  // ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.title, style: TextStyle(fontFamily: 'Roboto', fontSize: 27, fontWeight: FontWeight.w600)),
                  ),
                  
                  // SizedBox(
                  //   child: RaisedButton(
                  //     color: Utils.colorPrimaryBlue,
                  //     child: Text("Guardar", style: TextStyle(color: Colors.white),),
                  //     onPressed: (){},
                  //   ),
                  // )
                  Visibility(
                    visible: widget.function != null,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: 
                      InkWell(
                        onTap: widget.function,
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15, left: 15.0),
                          decoration: BoxDecoration(
                            color: Utils.colorPrimaryBlue,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text(widget.actionFuncion, style: TextStyle(color: Colors.white, fontFamily: "Roboto", fontWeight: FontWeight.w600),)
                        )
                      )
                      // SizedBox(
                      //   width: 145,
                      //   child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(5),
                      //             child: RaisedButton(
                      //               // elevation: 0,
                      //               color: Utils.colorPrimaryBlue,
                      //               child: Text('Guardar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      //               onPressed: () async {
                      //                 // _connect();
                      //                 if(_formKey.currentState.validate()){
                      //                   // _guardar();
                      //                   //Set document data
                      //                   _documento.id = 0;
                      //                   _documento.descripcion = _txtDocumento.text;
                      //                   _documento.idTipo = 1;
                      //                   _cliente.documento = _documento;

                      //                   //Set cliente data
                      //                   _cliente.nombres = _txtNombres.text;
                      //                   _cliente.apellidos = _txtApellidos.text;
                      //                   _cliente.apellidos = _txtApellidos.text;
                      //                   _cliente.apodo = _txtApodo.text;
                      //                   _cliente.fechaNacimiento = _fechaNacimiento;
                      //                   _cliente.numeroDependientes = Utils.toInt(_txtNumeroDependientes.text);
                      //                   _cliente.sexo = _sexo;
                      //                   _cliente.estadoCivil = _estadoCivil;
                      //                   _cliente.nacionalidad = _nacionalidad;
                      //                   _direccionCliente.direccion = _txtDireccion.text;
                      //                   _direccionCliente.sector = _txtSector.text;
                      //                   _cliente.direccion = _direccionCliente;
                      //                   _contactoCliente.telefono = _txtTelefeno.text;
                      //                   _contactoCliente.celular = _txtCelular.text;
                      //                   _contactoCliente.correo = _txtCorreo.text;
                      //                   _contactoCliente.facebook = _txtFacebook.text;
                      //                   _contactoCliente.instagram = _txtInstagram.text;
                      //                   _cliente.contacto = _contactoCliente;
                      //                   _cliente.tipoVivienda = _tipoVivienda;
                      //                   _cliente.tiempoEnVivienda = _txtTiempoEnResidencia.text;
                      //                   _cliente.referidoPor = _txtReferidoPor.text;

                      //                   //Set trabajo data
                      //                   _trabajo.nombre = _txtNombreTrabajo.text;
                      //                   _trabajo.ocupacion = _txtOcupacionTrabajo.text;
                      //                   _trabajo.ingresos = Utils.toDouble(_txtIngresosTrabajo.text);
                      //                   _trabajo.otrosIngresos = Utils.toDouble(_txtOtrosIngresosTrabajo.text);
                      //                   _trabajo.fechaIngreso = _fechaIngresoTrabajo;
                      //                   _contactoTrabajo.telefono = _txtTelefonoTrabajo.text;
                      //                   _contactoTrabajo.extension = _txtExtensionTrabajo.text;
                      //                   _contactoTrabajo.correo = _txtCorreoTrabajo.text;
                      //                   _contactoTrabajo.fax = _txtFaxTrabajo.text;
                      //                   _trabajo.contacto = _contactoTrabajo;
                      //                   _direccionTrabajo.direccion = _txtDireccionTrabajo.text;
                      //                   _direccionTrabajo.sector = _txtSectorTrabajo.text;
                      //                   _direccionTrabajo.numero = _txtNumeroTrabajo.text;
                      //                   _trabajo.direccion = _direccionTrabajo;

                      //                   //Set data negocio
                      //                   _negocio.nombre = _txtNombreNegocio.text;
                      //                   _negocio.tipo = _txtTipoNegocio.text;
                      //                   _negocio.tiempoExistencia = _txtTiempoExistenciaNegocio.text;
                      //                   _direccionNegocio.direccion = _txtDireccionNegocio.text;
                      //                   _negocio.direccion = _direccionNegocio;
                                        
                      //                   _cliente.trabajo = _trabajo;
                      //                   _cliente.negocio = _negocio;
                      //                   _cliente.referencias = listaReferencia;
                      //                   // print("trabajo is null ${_cliente.toJson()}");
                      //                   // return;
                      //                   try {
                      //                     setState(() => _cargando = true);
                      //                      await CustomerService.store(context: context, cliente: _cliente);
                      //                     setState(() => _cargando = false);
                      //                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ClientesScreen()));
                      //                   } catch (e) {
                      //                     setState(() => _cargando = false);
                      //                   }
                      //                 }
                      //               },
                      //           ),
                      //         ),
                      // ),
                    ),
                  ),
                  
                ],
              ),
              Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Divider(color: Colors.grey.shade300, thickness: 0.9, height: 1,),
                  ),
      ],
    );
  }
}