import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  // Variável de instância, caso ela estivesse dentro do método build,
  // ela passaria a ser uma variável local.

  // Cada vez que o método build é executado, uma nova instância da variável
  // selecionadas é criada, e ela começa com um estado vazio.
  List<Moeda> selecionadas = [];
  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepository.tabela;
    // Package para trabalhar com moedas de um determinado país, nesse caso o Brasil.
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cripto Moedas'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[moeda]))
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    width: 40,
                    child: Image.asset(tabela[moeda].icone),
                  ),
            title: Text(
              tabela[moeda].nome,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);

                debugPrint(selecionadas.toString());
              });
            },
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: tabela.length,
      ),
    );
  }
}
