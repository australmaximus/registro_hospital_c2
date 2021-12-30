import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';
import 'package:pacientes_app/tabs/agregar_paciente.dart';
import 'package:pacientes_app/tabs/detalle_paciente.dart';

class TabPaciente extends StatefulWidget {
  TabPaciente({Key? key}) : super(key: key);

  @override
  _TabPacienteState createState() => _TabPacienteState();
}

class _TabPacienteState extends State<TabPaciente> {
  Color colorAtencion = Colors.white;

  PacientesProvider provider = PacientesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.thermometer),
        title: Text('Pacientes'),
        backgroundColor: Color(0XFFFCAF27),
        actions: <Widget>[
          IconButton(
            icon: const Icon(MdiIcons.refresh),
            tooltip: 'Actualizar',
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: provider.getPacientes(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 268),
                  width: 100,
                  height: 100,
                  child: LiquidCircularProgressIndicator(
                    value: 0.65, // Defaults to 0.5.
                    valueColor: AlwaysStoppedAnimation(Color(
                        0XFFFCAF27)), // Defaults to the current Theme's accentColor.
                    backgroundColor: Colors
                        .white, // Defaults to the current Theme's backgroundColor.
                    borderColor: Colors.red,
                    borderWidth: 3.0,
                    direction: Axis
                        .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                    center: Text(
                      "Cargando...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ));
              }

              return DataTable(
                columnSpacing: 10,
                columns: [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Previsión')),
                  DataColumn(label: Text('Detalle')),
                ],
                rows: snapshot.data.map<DataRow>((paciente) {
                  if (paciente['tipo_atencion'] == 1) {
                    //consulta simple
                    colorAtencion = Color(0xFF3DB2FF);
                  } else if (paciente['tipo_atencion'] == 2) {
                    //ambulatorio
                    colorAtencion = Color(0xFFFFCA03);
                  } else {
                    //hospitalizado
                    colorAtencion = Color(0xFFF90716);
                  }
                  return DataRow(cells: [
                    DataCell(Row(
                      children: [
                        Icon(MdiIcons.accountArrowRight, color: Colors.cyan),
                        Flexible(
                          child: Container(
                            child: Text(
                                paciente['nombre'] +
                                    ' ' +
                                    paciente['apellido'] +
                                    ' ' +
                                    paciente['apellido2'],
                                overflow: TextOverflow.fade),
                          ),
                        ),
                      ],
                    )),
                    DataCell(Text(paciente['prevision'])),
                    DataCell(
                      OutlinedButton(
                        child: Icon(
                          MdiIcons.information,
                          color: colorAtencion,
                        ),
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => DetallePaciente(
                              rut_pc: paciente['rut_pc'],
                            ),
                          );
                          Navigator.push(context, route).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ]);
                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.accountPlus),
        backgroundColor: Colors.red,
        tooltip: 'Agregar Paciente',
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => PacienteAgregar(),
          );
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
