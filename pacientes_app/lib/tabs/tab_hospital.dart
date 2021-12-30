import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pacientes_app/provider/pacientes_provider.dart';
import 'package:pacientes_app/tabs/agregar_hospital.dart';
import 'package:pacientes_app/tabs/editar_hospital.dart';

class TabHospital extends StatefulWidget {
  TabHospital({Key? key}) : super(key: key);

  @override
  _TabHospitalState createState() => _TabHospitalState();
}

class _TabHospitalState extends State<TabHospital> {
  PacientesProvider provider = PacientesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.hospital),
        title: Text('Hospitales'),
        backgroundColor: Color(0XFF026597),
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
              future: provider.getHospitales(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                    width: 100,
                    height: 100,
                    child: LiquidCircularProgressIndicator(
                      value: 0.65, // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(Color(
                          0XFF026597)), // Defaults to the current Theme's accentColor.
                      backgroundColor: Colors
                          .white, // Defaults to the current Theme's backgroundColor.
                      borderColor: Colors.purple,
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
                        leading: Icon(MdiIcons.hospitalBuilding,
                            color: Colors.orange),
                        title: Text(snapshot.data[index]['nombre']),
                        subtitle: Text(snapshot.data[index]['direccion']),
                        trailing:
                            Icon(MdiIcons.hospitalMarker, color: Colors.green),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => HospitalesEditar(
                              id: snapshot.data[index]['id'],
                              nombre: snapshot.data[index]['nombre'],
                              direccion: snapshot.data[index]['direccion'],
                              telefono: snapshot.data[index]['telefono'],
                              num_camas: snapshot.data[index]['num_camas'],
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
                                    .hospitalBorrar(snapshot.data[index]['id'])
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
                                      content:
                                          Text('Hospital $nombre eliminado'),
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
        child: Icon(MdiIcons.plusThick),
        backgroundColor: Colors.purple,
        tooltip: 'Agregar Hospital',
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => HospitalAgregar(),
          );
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
      ),
      //backgroundColor: Color(0XFF026597),
    );
  }

  void _showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(mensaje),
    ));
  }

  Future<dynamic> confirmDialog(BuildContext context, String hospital) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmar borrado del hospital'),
            content: Text('¿Quiere eliminar el $hospital?'),
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
