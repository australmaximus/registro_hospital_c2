import 'package:flutter/material.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';

class PacientesEditar extends StatefulWidget {
  String rut_pc, nombre, apellido, apellido2, prevision, rut_dr;
  int tipo_atencion, edad;
  PacientesEditar(
      {Key? key,
      this.rut_pc = '',
      this.nombre = '',
      this.apellido = '',
      this.apellido2 = '',
      this.prevision = '',
      this.tipo_atencion = 0,
      this.edad = 0,
      this.rut_dr = ''})
      : super(key: key);

  @override
  _PacientesEditarState createState() => _PacientesEditarState();
}

class _PacientesEditarState extends State<PacientesEditar> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController apellido2Ctrl = TextEditingController();
  TextEditingController previsionCtrl = TextEditingController();
  TextEditingController edadCtrl = TextEditingController();
  PacientesProvider provider = PacientesProvider();
  String rut_dr = '';
  int atencion = 0;
  String nombreError = '',
      apellidoError = '',
      apellido2Error = '',
      previsionError = '',
      doctorError = '',
      tipoAtencionError = '',
      edadError = '';

  @override
  void initState() {
    super.initState();
    nombreCtrl.text = widget.nombre;
    apellidoCtrl.text = widget.apellido;
    apellido2Ctrl.text = widget.apellido2;
    previsionCtrl.text = widget.prevision;
    atencion = widget.tipo_atencion;
    edadCtrl.text = widget.edad.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Editar Paciente'),
        backgroundColor: Color(0XFFFCAF27),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
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
                value: widget.tipo_atencion,
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
                  primary: Colors.brown,
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text('Actualizar'),
                onPressed: () async {
                  int edad;
                  if (edadCtrl.text.trim().isEmpty) {
                    edad = 0;
                  } else if (int.tryParse(edadCtrl.text.trim()) == null) {
                    edad = 0;
                  } else {
                    edad = int.parse(edadCtrl.text.trim());
                  }

                  var respuesta = await provider.pacientesEditar(
                      widget.rut_pc,
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
