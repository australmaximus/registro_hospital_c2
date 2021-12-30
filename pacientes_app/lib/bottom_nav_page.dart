import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pacientes_app/tabs/tab_doctor.dart';
import 'package:pacientes_app/tabs/tab_hospital.dart';
import 'package:pacientes_app/tabs/tab_paciente.dart';

class BottomNavPage extends StatefulWidget {
  BottomNavPage({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  var _paginas = [
    {
      'pagina': TabHospital(),
      'texto': 'Hospitales',
      'icono': MdiIcons.hospitalBuilding,
      'color': 0XFF026597,
      'colorIcon': 0XFFFF5403,
    },
    {
      'pagina': TabDoctor(),
      'texto': 'Doctores',
      'icono': MdiIcons.doctor,
      'color': 0XFF009DAE,
      'colorIcon': 0xFF9AE66E,
    },
    {
      'pagina': TabPaciente(),
      'texto': 'Pacientes',
      'icono': MdiIcons.thermometer,
      'color': 0XFFFCAF27,
      'colorIcon': 0xFFF90716,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_currentIndex]['pagina'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: _paginas.map((p) {
          return BottomNavigationBarItem(
            icon: Icon(
              p['icono'] as IconData,
              color: Color(int.parse(p['colorIcon'].toString())),
            ),
            label: p['texto'].toString(),
            backgroundColor: Color(int.parse(p['color'].toString())),
          );
        }).toList(),
        //se selecciona el indice de la pagina
        currentIndex: _currentIndex,
        onTap: (index) {
          //selecciona el icono del indice
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
