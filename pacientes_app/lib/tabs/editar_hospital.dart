import 'package:flutter/material.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';

class HospitalesEditar extends StatefulWidget {
  int id;
  String nombre, direccion;
  int telefono, num_camas;

  HospitalesEditar(
      {Key? key,
      this.id = 0,
      this.nombre = '',
      this.direccion = '',
      this.telefono = 0,
      this.num_camas = 0})
      : super(key: key);

  @override
  _HospitalesEditarState createState() => _HospitalesEditarState();
}

class _HospitalesEditarState extends State<HospitalesEditar> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController numCamasCtrl = TextEditingController();
  String nombreError = '',
      direccionError = '',
      telefonoError = '',
      numCamasError = '';

  @override
  void initState() {
    super.initState();
    nombreCtrl.text = widget.nombre;
    direccionCtrl.text = widget.direccion;
    telefonoCtrl.text = widget.telefono.toString();
    numCamasCtrl.text = widget.num_camas.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Editar Hospital'),
        backgroundColor: Color(0XFF026597),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                labelText: 'Hospital',
                hintText: 'Nombre del hospital',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                nombreError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: direccionCtrl,
              decoration: InputDecoration(
                labelText: 'Direccion',
                hintText: 'Dirección del hospital',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                direccionError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: telefonoCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                hintText: 'Número de teléfono del hospital',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                telefonoError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: numCamasCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Camas',
                hintText: 'Número de camas del hospital',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                numCamasError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text('Actualizar'),
                onPressed: () async {
                  int telefono;
                  int num_camas;

                  if (telefonoCtrl.text.trim().isEmpty) {
                    telefono = 0;
                  } else if (int.tryParse(telefonoCtrl.text.trim()) == null) {
                    telefono = 0;
                  } else {
                    telefono = int.parse(telefonoCtrl.text.trim());
                  }

                  if (numCamasCtrl.text.trim().isEmpty) {
                    num_camas = 0;
                  } else if (int.tryParse(numCamasCtrl.text.trim()) == null) {
                    num_camas = 0;
                  } else {
                    num_camas = int.parse(numCamasCtrl.text.trim());
                  }
                  PacientesProvider provider = PacientesProvider();
                  var respuesta = await provider.hospitalesEditar(
                      widget.id,
                      nombreCtrl.text.trim(),
                      direccionCtrl.text.trim(),
                      telefono,
                      num_camas);
                  if (respuesta['message'] != null) {
                    setState(() {
                      var errores = respuesta['errors'];
                      nombreError =
                          errores['nombre'] != null ? errores['nombre'][0] : '';
                      direccionError = errores['direccion'] != null
                          ? errores['direccion'][0]
                          : '';
                      ;
                      telefonoError = errores['telefono'] != null
                          ? errores['telefono'][0]
                          : '';
                      ;
                      numCamasError = errores['num_camas'] != null
                          ? errores['num_camas'][0]
                          : '';
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
