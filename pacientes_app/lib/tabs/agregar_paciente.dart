import 'package:flutter/material.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';

class PacienteAgregar extends StatefulWidget {
  PacienteAgregar({Key? key}) : super(key: key);

  @override
  _PacienteAgregarState createState() => _PacienteAgregarState();
}

class _PacienteAgregarState extends State<PacienteAgregar> {
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController apellido2Ctrl = TextEditingController();
  TextEditingController previsionCtrl = TextEditingController();
  TextEditingController edadCtrl = TextEditingController();
  PacientesProvider provider = PacientesProvider();
  String rut_dr = '';
  int atencion = 0;
  String rutError = '',
      nombreError = '',
      apellidoError = '',
      apellido2Error = '',
      previsionError = '',
      doctorError = '',
      tipoAtencionError = '',
      edadError = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Agregar Paciente'),
        backgroundColor: Color(0XFFFCAF27),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: rutCtrl,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'RUT',
                hintText: 'RUT del paciente',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                rutError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: nombreCtrl,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Paciente',
                hintText: 'Nombre del paciente',
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
              controller: previsionCtrl,
              decoration: InputDecoration(
                labelText: 'Prevision',
                hintText: 'Previsión del paciente',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                previsionError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Container(
              child: DropdownButton<int>(
                isExpanded: true,
                hint: Text('Tipo de atención'),
                value: atencion == 0 ? null : atencion,
                items: [
                  DropdownMenuItem(child: Text('Consulta'), value: 1),
                  DropdownMenuItem(child: Text('Ambulatorio'), value: 2),
                  DropdownMenuItem(child: Text('Hospitalizado'), value: 3),
                ],
                onChanged: (atencionSeleccionada) {
                  setState(() {
                    atencion = atencionSeleccionada!;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                tipoAtencionError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: edadCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Edad',
                hintText: 'Edad de paciente',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                edadError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Container(
              width: double.infinity,
              child: FutureBuilder(
                future: provider.getDoctores(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DropdownButton<String>(
                    //menuMaxHeight: 150,
                    value: rut_dr == '' ? null : rut_dr,
                    hint: Text('Doctor'),
                    isExpanded: true,
                    items:
                        snapshot.data.map<DropdownMenuItem<String>>((doctor) {
                      return DropdownMenuItem<String>(
                        child: Text(doctor['nombre'] +
                            ' ' +
                            doctor['apellido'] +
                            ' ' +
                            doctor['apellido2']),
                        value: doctor['rut_dr'],
                      );
                    }).toList(),
                    onChanged: (doctorSeleccionado) {
                      setState(() {
                        rut_dr = doctorSeleccionado!;
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                doctorError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text('Agregar Paciente'),
                onPressed: () async {
                  int edad;
                  if (edadCtrl.text.trim().isEmpty) {
                    edad = 0;
                  } else if (int.tryParse(edadCtrl.text.trim()) == null) {
                    edad = 0;
                  } else {
                    edad = int.parse(edadCtrl.text.trim());
                  }

                  var respuesta = await provider.pacientesAgregar(
                      rutCtrl.text.trim(),
                      nombreCtrl.text.trim(),
                      apellidoCtrl.text.trim(),
                      apellido2Ctrl.text.trim(),
                      previsionCtrl.text.trim(),
                      atencion,
                      edad,
                      rut_dr);

                  if (respuesta['message'] != null) {
                    setState(() {
                      var errores = respuesta['errors'];
                      rutError =
                          errores['rut_pc'] != null ? errores['rut_pc'][0] : '';
                      nombreError =
                          errores['nombre'] != null ? errores['nombre'][0] : '';
                      apellidoError = errores['apellido'] != null
                          ? errores['apellido'][0]
                          : '';
                      apellido2Error = errores['apellido2'] != null
                          ? errores['apellido2'][0]
                          : '';
                      previsionError = errores['prevision'] != null
                          ? errores['prevision'][0]
                          : '';
                      tipoAtencionError = errores['tipo_atencion'] != null
                          ? errores['tipo_atencion'][0]
                          : '';
                      edadError =
                          errores['edad'] != null ? errores['edad'][0] : '';
                      doctorError =
                          errores['rut_dr'] != null ? errores['rut_dr'][0] : '';
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
