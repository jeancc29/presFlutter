import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prestamo/core/models/cliente.dart';
import '../services/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDcliente extends ChangeNotifier {
  Api _api = Api('clientes');

  List<Cliente> clientes;


  Future<List<Cliente>> fetchclientes() async {
    var result = await _api.getDataCollection();
    clientes = result.docs
        .map((doc) => Cliente.fromMap(doc.data(), doc.id))
        .toList();
    return clientes;
  }

  Stream<QuerySnapshot> fetchclientesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Cliente> getclienteById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Cliente.fromMap(doc.data(), doc.documentID) ;
  }


  Future removecliente(String id) async{
     await _api.removeDocument(id) ;
     return ;
  }
  Future updatecliente(Cliente data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addcliente(Cliente data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }


}
