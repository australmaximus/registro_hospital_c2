import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';
import 'package:pacientes_app/tabs/editar_paciente.dart';

class DetallePaciente extends StatefulWidget {
  String rut_pc;
  DetallePaciente({Key? key, this.rut_pc = ''}) : super(key: key);

  @override
  _DetallePacienteState createState() => _DetallePacienteState();
}

class _DetallePacienteState extends State<DetallePaciente> {
  PacientesProvider provider = PacientesProvider();
  String atencion = '';
  String nombreDoctor = '', nombreHospital = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del paciente'),
        backgroundColor: Color(0XFFFCAF27),
      ),
      backgroundColor: Colors.brown[100],
      body: FutureBuilder(
        future: provider.getPaciente(widget.rut_pc),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var paciente = snapshot.data;
          if (paciente['tipo_atencion'] == 1) {
            atencion = '1.png';
          } else if (paciente['tipo_atencion'] == 2) {
            atencion = '2.png';
          } else {
            atencion = '3.png';
          }

          try {
            nombreDoctor = paciente['doctor']['nombre'] +
                ' ' +
                paciente['doctor']['apellido'] +
                ' ' +
                paciente['doctor']['apellido2'];
          } catch (e) {
            nombreDoctor = 'Sin Doctor Asociado';
          }

          try {
            nombreHospital = paciente['doctor']['hospital']['nombre'];
          } catch (e) {
            nombreHospital = 'Sin Hospital Asociado';
            //print(paciente['doctor']['hospital']);
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image(
                    width: 250,
                    image: AssetImage('assets/images/atencion/' + atencion),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.cardAccountDetails),
                              Text(
                                ' ' + widget.rut_pc,
                                style: TextStyle(fontSize: 20),
                              ),
                            ]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.account),
                              Flexible(
                                child: Container(
                                  child: Text(
                                      paciente['nombre'] +
                                          ' ' +
                                          paciente['apellido'] +
                                          ' ' +
                                          paciente['apellido2'],
                                      style: TextStyle(fontSize: 20),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.cake),
                              Text(paciente['edad'].toString() + ' años',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.information),
                              Text('Previsión: ' + paciente['prevision'],
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.doctor),
                              Flexible(
                                  child: Container(
                                      child: Text(
                                'Doctor a cargo: ' + nombreDoctor,
                                style: TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.doctor),
                              Flexible(
                                  child: Container(
                                      child: Text(
                                'Hospital: ' + nombreHospital,
                                style: TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.brown),
                          onPressed: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => PacientesEditar(
                                rut_pc: paciente['rut_pc'],
                                nombre: paciente['nombre'],
                                apellido: paciente['apellido'],
                                apellido2: paciente['apellido2'],
                                prevision: paciente['prevision'],
                                tipo_atencion: paciente['tipo_atencion'],
                                edad: paciente['edad'],
                                rut_dr: paciente['rut_dr'],
                              ),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                          child: Text('Editar')),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () async {
                            confirmDialog(context, paciente['nombre'])
                                .then((confirma) {
                              if (confirma) {
                                var nombre = paciente['nombre'] +
                                    ' ' +
                                    paciente['apellido'] +
                                    ' ' +
                                    paciente['apellido2'];
                                provider.pacienteBorrar(widget.rut_pc);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text(
                                      'Paciente: ' + nombre + ' eliminado'),
                                ));
                              }
                              return true;
                            });
                          },
                          child: Text('Eliminar')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, String paciente) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmación de eliminación'),
            content: Text('¿Quiere eliminar al paciente $paciente?'),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Aceptar'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }
}
