import 'package:avaliacao_2/api/api_config.dart';
import 'package:avaliacao_2/models/pedido_model.dart';
import 'package:dio/dio.dart';

class PedidoService {
  final _dio = Dio();

  Future<List<PedidoModel>> getPedidos() async {
    var response = await _dio.get ('${ApiConfig.baseUrl}/pedidos');
    final list = response.data as List;
    return list.map((item) => PedidoModel.fromMap(item)).toList();
  }
}