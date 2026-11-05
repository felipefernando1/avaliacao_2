import 'package:avaliacao_2/api/api_config.dart';
import 'package:avaliacao_2/models/cliente_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ClienteService {
  final _dio = Dio();

  Future<List<ClienteModel>> getClientes() async {
    try {
      var response = await _dio.get('${ApiConfig.baseUrl}/clientes');

      final list = response.data as List;

      return list.map((item) => ClienteModel.fromMap(item)).toList();
    } on DioException catch (e) {
      debugPrint('Erro na requisicao: ${e.message}');
      return [];
    }
  }
}
