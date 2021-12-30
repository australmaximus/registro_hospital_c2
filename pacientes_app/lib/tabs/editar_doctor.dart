import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';

class DoctoresEditar extends StatefulWidget {
  String rut_dr;
  String nombre, apellido, apellido2, especialidad;
  int hospital_id;

  DoctoresEditar(
      {Key? key,
      this.rut_dr = '',
      this.nombre = '',
      this.apellido = '',
      this.apellido2 = '',
      this.especialidad = '',
      this.hospital_id = 0})
      : super(key: key);
  @override
  _DoctoresEditarState createState() => _DoctoresEditarState();
}

class _DoctoresEditarState extends State<DoctoresEditar> {
  int hospital_id = 0;
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController apellido2Ctrl = TextEditingController();
  TextEditingController especialidadCtrl = TextEditingController();
  PacientesProvider provider = PacientesProvider();
  String nombreError = '',
      apellidoError = '',
      apellido2Error = '',
      especialidadError = '',
      hospitalError = '';

  @override
  void initState() {
    super.initState();
    nombreCtrl.text = widget.nombre;
    apellidoCtrl.text = widget.apellido;
    apellido2Ctrl.text = widget.apellido2;
    especialidadCtrl.text = widget.especialidad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Editar Doctor'),
        backgroundColor: Color(0XFF009DAE),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: nombreCtrl,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Doctor',
                hintText: 'Nombre del doctor',
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
              controller: apellidoCtrl,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Primer apellido',
                hintText: 'Apellido Paterno',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                apellidoError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: apellido2Ctrl,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Segundo Apellido',
                hintText: 'Apellido Materno',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                apellido2Error,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: especialidadCtrl,
              decoration: InputDecoration(
                labelText: 'Especialidad',
                hintText: 'Especialidad del Doctor',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                especialidadError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Container(
              width: double.infinity,
              child: FutureBuilder(
                future: provider.getHospitales(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DropdownButton<int>(
                    //menuMaxHeight: 150,
                    value: hospital_id == 0 ? null : hospital_id,
                    hint: Text('Hospital'),
                    isExpanded: true,
                    items: snapshot.data.map<DropdownMenuItem<int>>((hospital) {
                      return DropdownMenuItem<int>(
                        child: Text(hospital['nombre']),
                        value: hospital['id'],
                      );
                    }).toList(),
                    onChanged: (hospitalSeleccionado) {
                      setState(() {
                        hospital_id = hospitalSeleccionado!;
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                hospitalError,
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
                  PacientesProvider provider = PacientesProvider();
                  var respuesta = await provider.doctoresEditar(
                      widget.rut_dr,
                      nombreCtrl.text.trim(),
                      apellidoCtrl.text.trim(),
                      apellido2Ctrl.text.trim(),
                      especialidadCtrl.text.trim(),
                      hospital_id);
                  if (respuesta['message'] != null) {
                    setState(() {
                      var errores = respuesta['errors'];

                      nombreError =
                          errores['nombre'] != null ? errores['nombre'][0] : '';
                      apellidoError = errores['apellido'] != null
                          ? errores['apellido'][0]
                          : '';
                      apellido2Error = errores['apellido2'] != null
                          ? errores['apellido2'][0]
                          : '';
                      especialidadError = errores['especialidad'] != null
                          ? errores['especialidad'][0]
                          : '';
                      hospitalError = errores['hospital_id'] != null
                          ? errores['hospital_id'][0]
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
