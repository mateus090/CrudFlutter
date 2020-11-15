import 'package:flutter/material.dart';
import 'package:CrudMedicamentos/model/medicamento.dart';
import 'package:CrudMedicamentos/db/database_helper.dart';
import 'package:CrudMedicamentos/ui/medicamento_screen.dart';
class ListViewMedicamento extends StatefulWidget {
  @override
  _ListViewMedicamentoState createState() => new _ListViewMedicamentoState();
}
class _ListViewMedicamentoState extends State<ListViewMedicamento> {
  List<Medicamento> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getMedicamentos().then((medicamentos) {
      setState(() {
        medicamentos.forEach((medicamento) {
          items.add(Medicamento.fromMap(medicamento));
        });
      });
    });
  }
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Cadastro',
      home: Scaffold(
        
        appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', fit: BoxFit.cover, height: 100,),
        backgroundColor: Colors.white,
        ),
        body: Center(
          child: ListView.builder(
              
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              
              itemBuilder: (context, position) {

return Column(
  
         children: [
           Divider(height: 5.0),
           
           ListTile(
            
           //isThreeLine: true,
            title: Text(
                  '${items[position].nome} - ${items[position].principio}',
                  style: TextStyle(
                  fontSize: 15.0,
                  ),
              ),
            subtitle: Row(children: [
              Text(' ${items[position].concentracao} mL - ',
                  style: new TextStyle(
                  fontSize: 15.0,
              )),
              Text(' R\$${items[position].preco}',
                  style: new TextStyle(
                  fontSize: 15.0,
              )),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => _deleteMedicamento(
                      context, items[position], position)),
          ],),
          leading: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 15.0,
              child: Text(
                '${items[position].id}',
                style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                ),
              ),
          ),
onTap: () => _navigateToMedicamento(context, items[position]),
),
],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewMedicamento(context),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
void _deleteMedicamento(BuildContext context, Medicamento medicamento, int position) async {
    db.deleteMedicamento(medicamento.id).then((medicamentos) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
void _navigateToMedicamento(BuildContext context, Medicamento medicamento) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicamentoScreen(medicamento)),
    );
    if (result == 'update') {
      db.getMedicamentos().then((medicamentos) {
        setState(() {
          items.clear();
          medicamentos.forEach((medicamento) {
            items.add(Medicamento.fromMap(medicamento));
          });
        });
      });
    }
  }
void _createNewMedicamento(BuildContext context) async {
    //aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicamentoScreen(Medicamento('', '', '', ''))),
    );
    //se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getMedicamentos().then((medicamentos) {
        setState(() {
          items.clear();
          medicamentos.forEach((medicamento) {
            items.add(Medicamento.fromMap(medicamento));
          });
        });
      });
    }
  }
}