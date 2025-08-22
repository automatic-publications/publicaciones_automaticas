import 'dart:convert';

import 'package:http/http.dart' as http; 

class GetServices {
  
   /*
    ************ COMENTARIOS *************** 
    #1: SE VALIDAN LOS PARA,ETROS REQUERIDOS
    #2: SE OBTIENE LOS PARAMTROS PARA ARMAR LA SOLICITUD: ENDPOINT, METHOD, HEADERS ECT...
      #2.1: SI SE REQUIEREN ENVIAR OTROS HEADERS SE PASAN POR MEDIO DE LA VARIABE extraHeaders.
    #3: SE CREA LA URL                   
    #4: SE DECLARA UNA VARIABLE DE TIPO RESPONSE
    #5: SE VALIDA EL METHODO DE LA SOLICITUD
    #6: SE DECODIFICA LA REPUESTA DE LA SOLICITUD
    #7: SE RETORNA LA REPUESTA CON EL ESTADO DE LA SOLICITUD Y LA DATA 
    #8: EN CASO DE ALGUN ERROR SE RETORNA UNA RESPUESTA CON ESTADO 500 Y EL ERROR.

    ESTRUCTURA DATA:
    {
      'url': 'http://100.10.1.0:4000',
      'endpoint': '/api/get_users',
      'method': 'GET',
      'params': '?userId=123',
      'access_token': 'token',
      'body': {},
      'extraHeaders': {
        'Header-1': 'Value1',
        'Header-2': 'Value2',
      },
    }

   */

  Future<Map> services(Map data) async {
    try {
      
      //#1
      if (!data.containsKey('url') || !data.containsKey('endpoint') || !data.containsKey('method')) {
        throw ArgumentError('Los parámetros "Url" "Endpoint" y "Method" son obligatorios.');
      }

      //#2
      final String url = data['url'];
      final String endpoint = data['endpoint'];
      final String method = data['method'];
      final Map<String, String> headers = {
        //#2.1
        ...?data['extraHeaders'], 
      };
      final Map<String, dynamic>? body = data['body'];
      final String params = data['params'] ?? "";

      //#3
      final uri = Uri.parse('$url$endpoint$params');

      //#4
      late http.Response response;

      //#5
      switch (method.toUpperCase()) {
        case "GET":
          response = await http.get(uri, headers: headers);
          break;
        case "POST":
          response = await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case "PUT":
          response = await http.put(uri, headers: headers, body: body);
          break;
        case "DELETE":
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw ArgumentError('Método HTTP no soportado: $method');
      }

      //#6
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

      //#7
      return {
        'status': response.statusCode,
        'data': decodedResponse,
      };

    } catch (e) {

      //#8
      return {
        'status': 500,
        'error': e.toString(),
      };
    }
  }

}
