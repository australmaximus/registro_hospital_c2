import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PacientesProvider {
  final String apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getHospitales() async {
    var uri = Uri.parse('$apiURL/hospitales');
    var respuesta = await http.get(uri);

    await Future.delayed(Duration(seconds: 1));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> hospitalesAgregar(
      String nombre, String direccion, int telefono, int num_camas) async {
    //print('$nombre $direccion $telefono $num_camas');

    var uri = Uri.parse('$apiURL/hospitales');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombre,
        'direccion': direccion,
        'telefono': telefono,
        'num_camas': num_camas
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<bool> hospitalBorrar(int id) async {
    var uri = Uri.parse('$apiURL/hospitales/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> hospitalesEditar(
      int id,
      String nombreHospital,
      String direccionHospital,
      int telefonoHospital,
      int numCamHospital) async {
    var uri = Uri.parse('$apiURL/hospitales/$id');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombreHospital,
        'direccion': direccionHospital,
        'telefono': telefonoHospital,
        'num_camas': numCamHospital,
      }),
    );

    return json.decode(respuesta.body);
  }

  //////////////

  Future<List<dynamic>> getDoctores() async {
    var uri = Uri.parse('$apiURL/doctores');
    var respuesta = await http.get(uri);

    await Future.delayed(Duration(seconds: 1));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> doctoresAgregar(
      String rut_dr,
      String nombre,
      String apellido,
      String apellido2,
      String especialidad,
      int hospital_id) async {
    var uri = Uri.parse('$apiURL/doctores');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'rut_dr': rut_dr,
        'nombre': nombre,
        'apellido': apellido,
        'apellido2': apellido2,
        'especialidad': especialidad,
        'hospital_id': hospital_id,
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<bool> doctorBorrar(String rut_dr) async {
    var uri = Uri.parse('$apiURL/doctores/$rut_dr');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> doctoresEditar(
      String rut_dr,
      String nombreDoctor,
      String apellidoDoctor,
      String apellido2Doctor,
      String especialidad,
      int hospital_id) async {
    var uri = Uri.parse('$apiURL/doctores/$rut_dr');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'rut_dr': rut_dr,
        'nombre': nombreDoctor,
        'apellido': apellidoDoctor,
        'apellido2': apellido2Doctor,
        'especialidad': especialidad,
        'hospital_id': hospital_id,
      }),
    );

    return json.decode(respuesta.body);
  }

  //////////////
  Future<List<dynamic>> getPacientes() async {
    var uri = Uri.parse('$apiURL/pacientes');
    var respuesta = await http.get(uri);

    await Future.delayed(Duration(seconds: 1));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // Future<LinkedHashMap<String, dynamic>> getDoctor(String rut_dr) async {
  //   var uri = Uri.parse('$apiURL/doctores/$rut_dr');
  //   var respuesta = await http.get(uri);
  //   return json.decode(respuesta.body);
  // }

  Future<LinkedHashMap<String, dynamic>> getPaciente(String rut_pc) async {
    var uri = Uri.parse('$apiURL/pacientes/$rut_pc');
    var respuesta = await http.get(uri);
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> pacientesAgregar(
      String rut_pc,
      String nombre,
      String apellido,
      String apellido2,
      String prevision,
      int tipo_atencion,
      int edad,
      String rut_dr) async {
    var uri = Uri.parse('$apiURL/pacientes');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'rut_pc': rut_pc,
        'nombre': nombre,
        'apellido': apellido,
        'apellido2': apellido2,
        'prevision': prevision,
        'tipo_atencion': tipo_atencion,
        'edad': edad,
        'rut_dr': rut_dr,
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<bool> pacienteBorrar(String rut_pc) async {
    var uri = Uri.parse('$apiURL/pacientes/$rut_pc');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> pacientesEditar(
      String rut_pc,
      String nombre,
      String apellido,
      String apellido2,
      String prevision,
      int tipo_atencion,
      int edad,
      String rut_dr) async {
    var uri = Uri.parse('$apiURL/pacientes/$rut_pc');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'rut_pc': rut_pc,
        'nombre': nombre,
        'apellido': apellido,
        'apellido2': apellido2,
        'prevision': prevision,
        'tipo_atencion': tipo_atencion,
        'edad': edad,
        'rut_dr': rut_dr,
      }),
    );

    return json.decode(respuesta.body);
  }

  // Future<LinkedHashMap<String, dynamic>> getAuto(String patente) async {
  //   var uri = Uri.parse('$apiURL/autos/$patente');
  //   var respuesta = await http.get(uri);
  //   return json.decode(respuesta.body);
  // }

  // Future<bool> autosBorrar(String patente) async {
  //   var uri = Uri.parse('$apiURL/autos/$patente');
  //   var respuesta = await http.delete(uri);
  //   return respuesta.statusCode == 200;
  // }

  // Future<LinkedHashMap<String, dynamic>> autosAgregar(
  //     String patente, String modelo, int precio, int marcaId) async {
  //   print('$patente $modelo $precio $marcaId');

  //   var uri = Uri.parse('$apiURL/autos');
  //   var respuesta = await http.post(
  //     uri,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       'patente': patente,
  //       'modelo': modelo,
  //       'precio': precio,
  //       'marca': marcaId,
  //     }),
  //   );

  //   return json.decode(respuesta.body);
  // }
}
