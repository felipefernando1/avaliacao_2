import 'package:avaliacao_2/models/cliente_model.dart';
import 'package:avaliacao_2/models/pedido_model.dart';
import 'package:avaliacao_2/services/cliente_service.dart';
import 'package:avaliacao_2/services/pedido_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = PedidoService();
  Future<List<PedidoModel>>? _futurePedidos;
  List<PedidoModel> pedidos = [];
  //var String statusFiltrados =

  @override
  void initState() {
    super.initState();
    _futurePedidos = _service.getPedidos(<String>[]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Delivery Hub',
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _futurePedidos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Text('Erro ao carregar pedidos.');
            }

            final pedidos = snapshot.data ?? [];

            if (pedidos.isEmpty) {
              return const Center(child: Text('Nenhum pedido encontrado.'));
            }

            return ListView.separated(
              padding: const EdgeInsets.only(bottom: 80.0),
              separatorBuilder: (_, _) => const Divider(),
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pedidos[index].descricao),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
