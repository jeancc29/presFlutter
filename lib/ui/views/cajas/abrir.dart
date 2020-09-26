import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/services/boxservice.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';

abrirCaja({BuildContext context, List<Caja> cajas}){
  var _formKey = GlobalKey<FormState>();
  var _txtMontoInicial = TextEditingController();
  bool _cargando = false;
  int _indexCaja = 0;
  
  showDialog(
    context: context,
    child: StatefulBuilder(
      builder: (context, setState){
        
        _close(){
          Navigator.pop(context);
        }
        _abrirCaja(Caja caja) async {
          if(!_formKey.currentState.validate())
            return;

          try {
            setState(() => _cargando = true);
            caja.balanceInicial = Utils.toDouble(_txtMontoInicial.text);
            await BoxService.open(context: context, caja: caja);
            setState(() => _cargando = false);
            _close();
          } catch (e) {
          }
        }

        return AlertDialog(
          title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Apertura de caja"),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Visibility(
                        visible: _cargando,
                        child: Theme(
                          data: Theme.of(context).copyWith(accentColor: Utils.colorPrimary),
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          content: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Wrap(
              children: [
                (cajas.length> 0)
                ?
                Center(
                  child: MyDropdownButton(
                    padding: 0,
                    onChanged: (data){
                      int idx = cajas.indexWhere((element) => element.descripcion == data);
                      if(idx != -1)
                        setState(() => _indexCaja = idx);
                    },
                    elements: cajas.map((e) => e.descripcion).toList(),
                    large: 1.2,
                    medium: 1.2,
                    small: 1,
                  ),
                  
                )
                :
                Center(
                  child: MyDropdownButton(
                    padding: 0,
                    onChanged: null,
                    elements: ["No hay cajas registradas"],
                    large: 1.2,
                    medium: 1.2,
                    small: 1,
                  ),
                  
                ),
                Form(
                  key: _formKey,
                  child: Center(
                    child: MyTextFormField(
                      padding: 0,
                      labelText: "BalanceInicial",
                      controller: _txtMontoInicial,
                      isRequired: true,
                      large: 1.2,
                      medium: 1.2,
                      small: 1,
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            FlatButton(onPressed: _close, child: Text("Cancelar")),
            FlatButton(onPressed: (){
              if(cajas.length > 0)
                _abrirCaja(cajas[_indexCaja]);
            }, child: Text("Abrir")),
          ],
        );
      }
    )
  );
}

//primera 65, segunda 12, tercera 4, super pale 1300, pale 1200, tripleta 20,000
//quiniela 2000 limite, super pale 50 limite, tripleta 15 limite