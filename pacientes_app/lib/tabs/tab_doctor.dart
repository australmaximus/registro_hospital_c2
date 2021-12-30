import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';
import 'package:pacientes_app/tabs/agregar_doctor.dart';
import 'package:pacientes_app/tabs/editar_doctor.dart';

class TabDoctor extends StatefulWidget {
  TabDoctor({Key? key}) : super(key: key);

  @override
  _TabDoctorState createState() => _TabDoctorState();
}

class _TabDoctorState extends State<TabDoctor> {
  PacientesProvider provider = PacientesProvider();
  String nombreHospital = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.doctor),
        title: Text('Doctores'),
        backgroundColor: Color(0XFF009DAE),
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: provider.getDoctores(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                    width: 100,
                    height: 100,
                    child: LiquidCircularProgressIndicator(
                      value: 0.65, // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(Color(
                          0XFF009DAE)), // Defaults to the current Theme's accentColor.
                      backgroundColor: Colors
                          .white, // Defaults to the current Theme's backgroundColor.
                      borderColor: Colors.green,
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

                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    try {
                      nombreHospital =
                          snapshot.data[index]['hospital']['nombre'];
                    } catch (e) {
                      nombreHospital = 'Sin Hospital';
                    }

                    return Dismissible(
                      //direction: DismissDirection.startToEnd,
                      key: ObjectKey(snapshot.data[index]),
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        color: Colors.brown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Editar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(MdiIcons.pencil, color: Colors.white),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Borrar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(MdiIcons.trashCan, color: Colors.white),
                          ],
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(MdiIcons.doctor, color: Colors.red),
                        title: Text(snapshot.data[index]['nombre'] +
                            ' ' +
                            snapshot.data[index]['apellido'] +
                            ' ' +
                            snapshot.data[index]['apellido2']),
                        subtitle: Row(
                          children: [
                            Text(snapshot.data[index]['especialidad']),
                            Spacer(),
                            Flexible(
                                child: Container(
                                    child: Text('Hospital: ' + nombreHospital,
                                        overflow: TextOverflow.clip))),
                          ],
                        ),
                        trailing: Icon(
                          MdiIcons.hospitalBox,
                          color: Color(0XFF026597),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => DoctoresEditar(
                              rut_dr: snapshot.data[index]['rut_dr'],
                              nombre: snapshot.data[index]['nombre'],
                              apellido: snapshot.data[index]['apellido'],
                              apellido2: snapshot.data[index]['apellido2'],
                              especialidad: snapshot.data[index]
                                  ['especialidad'],
                              hospital_id: snapshot.data[index]['hospital_id'],
                            ),
                          );
                          Navigator.push(context, route).then((value) {
                            setState(() {});
                          });
                        } else {
                          confirmDialog(context, snapshot.data[index]['nombre'])
                              .then((confirma) {
                            if (confirma) {
                              var nombre = snapshot.data[index]['nombre'];
                              setState(() {
                                provider
                                    .doctorBorrar(
                                        snapshot.data[index]['rut_dr'])
                                    .then((borradoExitoso) {
                                  if (!borradoExitoso) {
                                    //error
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                          'Ha ocurrido un problema en el servidor'),
                                    ));
                                  } else {
                                    //borrado ok
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('Doctor $nombre eliminado'),
                                    ));
                                  }
                                });
                                snapshot.data.removeAt(index);
                              });
                            }
                            return true;
                          });
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.accountPlus),
        backgroundColor: Colors.green,
        tooltip: 'Agregar Doctor',
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => DoctorAgregar(),
          );
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }

  void _showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(mensaje),
    ));
  }

  Future<dynamic> confirmDialog(BuildContext context, String doctor) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmar borrado del doctor'),
            content: Text('¿Quiere eliminar el $doctor?'),
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
