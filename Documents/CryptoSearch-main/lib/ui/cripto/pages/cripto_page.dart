import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:order_manager/domain/entities/core/request_state_entity.dart';
import 'package:order_manager/ui/cripto/view_model/cripto_factory_viewmodel.dart';
import 'package:order_manager/ui/cripto/view_model/cripto_viewmodel.dart';
import 'package:order_manager/domain/entities/cripto/cripto_entity.dart';

class CriptoPage extends StatelessWidget {
  const CriptoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CriptoViewMOdel>(
      create: CriptoFactoryViewmodel().create,
      child: const _CriptoPage(),
    );
  }
}

class _CriptoPage extends StatefulWidget {
  const _CriptoPage({super.key});

  @override
  State<_CriptoPage> createState() => _CriptoPageState();
}

class _CriptoPageState extends State<_CriptoPage> {
  late final CriptoViewMOdel criptoViewModel;
  final TextEditingController _controller = TextEditingController();
  final double usdToBrl = 5.20;

  @override
  void initState() {
    super.initState();
    criptoViewModel = context.read<CriptoViewMOdel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      criptoViewModel.onGetCripto('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Pesquisar Cripto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        criptoViewModel.onGetCripto(_controller.text.trim());
                      },
                      child: Text(
                        'Buscar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                BlocBuilder<CriptoViewMOdel, IRequestState<List<CriptoEntity>>>(
                  builder: (context, state) {
                    if (state is RequestProcessingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state
                        is RequestCompletedState<List<CriptoEntity>>) {
                      final list = state.value ?? [];
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final cripto = list[index];
                          final priceUsd = cripto.price;
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: ListTile(
                              title: Text(cripto.name),
                              subtitle: Text(cripto.symbol),
                              trailing: Text(
                                'USD \$${priceUsd.toStringAsFixed(2)}',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => CriptoDetailPage(
                                          cripto: cripto,
                                          usdToBrl: usdToBrl,
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is RequestErrorState) {
                      return Center(child: Text('Erro: ${state.error}'));
                    }
                    return const Center(
                      child: Text('Nenhuma pesquisa feita ainda.'),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class CriptoDetailPage extends StatelessWidget {
  final CriptoEntity cripto;
  final double usdToBrl;

  const CriptoDetailPage({
    super.key,
    required this.cripto,
    required this.usdToBrl,
  });

  @override
  Widget build(BuildContext context) {
    final priceBrl = cripto.price * usdToBrl;
    final formatDate = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(title: Text(cripto.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nome: ${cripto.name}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Símbolo: ${cripto.symbol}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Preço em USD: \$${cripto.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Preço em BRL: R\$${priceBrl.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Data de adição: ${formatDate.format(cripto.dateAdded)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
