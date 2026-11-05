import 'dart:developer';

import 'package:avaliacao_2/api/api_config.dart';
import 'package:avaliacao_2/models/pedido_model.dart';
import 'package:dio/dio.dart';

class PedidoService {
  final _dio = Dio();

  //GET - read
  Future<List<PedidoModel>> getPedidos(List<String>? statusFiltrados) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (statusFiltrados != null && statusFiltrados.isEmpty) {
        queryParams["status"] = statusFiltrados;
      }

      var response = await _dio.get(
        '${ApiConfig.baseUrl}/pedidos',
        queryParameters: queryParams,
      );

      final list = response.data as List;

      return list.map((item) => PedidoModel.fromMap(item)).toList();
    } on DioException catch (e, s) {
      log('Erro na requisicao ${e.message}', stackTrace: s);
      rethrow;
    }
  }

  //POST - create
  Future<void> createPedidos({
    required int clienteId,
    required String descricao,
    required double valorTotal,
    required String status,
    required bool pago,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/pedidos',
        data: <String, dynamic>{
          "clienteId": clienteId,
          "descricao": descricao,
          "valorTotal": valorTotal,
          "status": status,
          "pago": pago,
          "criadoEm": DateTime.now().toIso8601String(),
        },
      );

      return response.data;
    } on DioException catch (e) {
      //log('Erro ao criar pedido: ${e.message}', stackTrace: s);
      rethrow;
    }
  }

  //PUT - update
  Future<void> updatePedidos(
    int id, {
    required int clienteId,
    required String descricao,
    required double valorTotal,
    required String status,
    required bool pago,
  }) async {
    try {
      final response = await _dio.put(
        '${ApiConfig.baseUrl}/pedidos$id',
        data: <String, dynamic>{
          "clienteId": clienteId,
          "descricao": descricao,
          "valorTotal": valorTotal,
          "status": status,
          "pago": pago,
        },
      );

      return response.data;
    } on DioException catch (e) {
      //log('Erro ao editar pedido: ${e.message}', stackTrace: s);
      rethrow;
    }
  }

  //DELETE - delete
  Future<void> deletePedido(int id) async {
    try {
      await _dio.delete('${ApiConfig.baseUrl}/pedidos/$id');
    } on DioException catch (e) {
      //log('Erro ao excluir pedido: ${e.message}', stackTrace: s);
      rethrow;
    }
  }
}
