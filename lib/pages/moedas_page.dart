import 'package:cripto_moedas/models/moeda.dart';
import 'package:cripto_moedas/pages/moeda_detalhes_page.dart';
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

    appBarDinamica() {
      if (selecionadas.isEmpty) {
        return AppBar(
          centerTitle: true,
          title: const Text('Cripto Moedas'),
        );
      } else {
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                selecionadas = [];
              });
            },
          ),
          centerTitle: true,
          title: Text(
            '${selecionadas.length} selecionadas',
            style: const TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.blueGrey[50],
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.black87),
          toolbarTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    }

    mostrarDetalhes(Moeda moeda) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MoedaDetalhesPage(moeda: moeda),
        ),
      );
    }

    return Scaffold(
      appBar: appBarDinamica(),
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
            onTap: () => mostrarDetalhes(tabela[moeda]),
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: selecionadas.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.star),
                label: const Text(
                  'FAVORITAR',
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
