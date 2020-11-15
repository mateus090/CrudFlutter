import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CrudMedicamentos/model/medicamento.dart';
import 'package:CrudMedicamentos/db/database_helper.dart';

class MedicamentoScreen extends StatefulWidget {
  final Medicamento medicamento;
  MedicamentoScreen(this.medicamento);
  @override
  State<StatefulWidget> createState() => new _MedicamentoScreenState();
}
class _MedicamentoScreenState extends State<MedicamentoScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _principioController;
  TextEditingController _concentracaoController;
  TextEditingController _precoController;
  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.medicamento.nome);
    _principioController = new TextEditingController(text: widget.medicamento.principio);
    _concentracaoController = new TextEditingController(text: widget.medicamento.concentracao);
    _precoController = new TextEditingController(text: widget.medicamento.preco);
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/cadastro.png', fit: BoxFit.cover, height: 100,),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Column(
          children:[
            TextField(
              controller: _nomeController,
              decoration: 
              InputDecoration(labelText: 'Nome do Medicamento',
                              prefixIcon: Icon(Icons.local_pharmacy, color: Colors.red[900]),
                              labelStyle: new TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[900])),
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
    // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange),),        
        //  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: 
              
            ),)),
            TextField(
              controller: _principioController,
              decoration: 
              InputDecoration(labelText: 'Princípio Ativo',
                              prefixIcon: Icon(Icons.add_box, color: Colors.red[900]),
                              labelStyle: new TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[900])),
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
              
            ),)),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _concentracaoController,
              decoration: 
              InputDecoration(labelText: 'Concentração',
                              prefixIcon: Icon(Icons.opacity, color: Colors.red[900]),
                              labelStyle: new TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[900])),
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
              ),
            ),),
            TextField(
              maxLength: 8,
              controller: _precoController,
              decoration: 
              InputDecoration(labelText: 'Preço',
                              prefixIcon: Icon(Icons.attach_money, color: Colors.red[900]),
                              labelStyle: new TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[900])),
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              
               
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.red,
              child: (widget.medicamento.id != null) ? Text('Alterar') : Text('Inserir'),
              onPressed: () {
                if (widget.medicamento.id != null) {
                  db.updateMedicamento(Medicamento.fromMap({
                    'id': widget.medicamento.id,
                    'nome': _nomeController.text,
                    'principio': _principioController.text,
                    'concentracao': _concentracaoController.text,
                    'preco': _precoController.text
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                } 
                else {
                  db.inserirMedicamento(Medicamento(_nomeController.text, _principioController.text, _concentracaoController.text, _precoController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
