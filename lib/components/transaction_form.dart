import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _onSubmit() {
    String title = titleController.text;
    double value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0.0 || _selectDate == null) return;

    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Titulo"),
          ),
          TextField(
            controller: valueController,
            decoration: InputDecoration(labelText: "Valor: R\$"),
            // por causa do IOS coloca decimal true
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            //Voce chama o submite quando da ok no teclado
            onSubmitted: (_) => _onSubmit(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectDate == null
                        ? "Nenhuma data selecionada."
                        : "Data Selecionada: ${DateFormat('d/MM/y').format(_selectDate as DateTime)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Selecionar Data",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _onSubmit();
            },
            child: Text("Nova Transação"),
          ),
        ],
      ),
    );
  }
}
