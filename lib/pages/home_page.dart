import 'package:avaliacao_2/models/pedido_model.dart';
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

  String retornoStatus = "";

  String getStatusName(String status) {
    switch (status) {
      case "em_preparo":
        retornoStatus = "Em preparo";
        break;
      case "pendente":
        retornoStatus = "Pendente";
        break;
      case "a_caminho":
        retornoStatus = "A caminho";
        break;
      case "entregue":
        retornoStatus = "Entregue";
        break;
      case "cancelado":
        retornoStatus = "Cancelado";
        break;
    }

    return retornoStatus;
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
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 14,
                    child: Text(pedidos[index].id.toString()),
                  ),
                  title: Row(
                    spacing: 14,
                    children: [
                      Flexible(flex: 3, child: Text(pedidos[index].descricao)),
                      Flexible(
                        child: Text(
                          pedidos[index].valorTotal
                              .toStringAsFixed(2)
                              .toString(),
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    spacing: 14,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          pedidos[index].pago == true
                              ? "Pago: Sim"
                              : "Pago: Não",
                        ),
                      ),
                      Flexible(
                        child: Text(getStatusName(pedidos[index].status)),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(flex: 3, child: IconButton(icon: Icon(Icons.edit), color: Colors.blue, onPressed: () {},)),
                      Flexible(flex: 3, child: IconButton(icon: Icon(Icons.delete), color: Colors.red, onPressed: () {},))
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
