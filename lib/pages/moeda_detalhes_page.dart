import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/moeda.dart';
import 'package:flutter/services.dart';

class MoedaDetalhesPage extends StatefulWidget {
  final Moeda moeda;

  const MoedaDetalhesPage({Key? key, required this.moeda}) : super(key: key);

  @override
  State<MoedaDetalhesPage> createState() => _MoedaDetalhesPageState();
}

class _MoedaDetalhesPageState extends State<MoedaDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(widget.moeda.icone),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    real.format(widget.moeda.preco),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            (quantidade > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.05),
                      ),
                      child: Text(
                        '$quantidade ${widget.moeda.sigla}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 24),
                  ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: const TextStyle(
                  fontSize: 18,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    'reais',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
                // Não permite a cola de texto no input
                //Também é possível a criação de máscara usando o inputFormatter
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor de compra';
                  } else if (double.parse(value) < 50) {
                    return 'A compra mínima é de R\$ 50,00';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    quantidade = (value.isEmpty)
                        ? 0
                        : double.parse(value) / widget.moeda.preco;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    // Salvar a compra

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Compra realizada com sucesso!'),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: -0.3,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
