import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_textefield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_datepicker.dart';

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

    if (title.isEmpty || value <= 0.0 || _selectDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AdaptiveTextField(
                controllerRe: titleController,
                inputLabel: "Titulo",
                onSubmit: (_) => _onSubmit,
                keyboardType: TextInputType.text,
              ),

              AdaptiveTextField(
                controllerRe: valueController,
                inputLabel: "Valor: R\$",
                onSubmit: (_) => _onSubmit,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              // TextField(
              //   controller: titleController,
              //   decoration: InputDecoration(labelText: "Titulo"),
              // ),
              // TextField(
              //   controller: valueController,
              //   decoration: InputDecoration(labelText: "Valor: R\$"),
              //   // por causa do IOS coloca decimal true
              //   keyboardType: TextInputType.numberWithOptions(decimal: true),
              //   //Voce chama o submite quando da ok no teclado
              //   onSubmitted: (_) => _onSubmit(),
              // ),
              AdaptativeDatePicker(
                selectDate: _selectDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectDate = newDate;
                  });
                },
              ),
              // Container(
              //   height: 70,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Text(
              //           _selectDate == null
              //               ? "Nenhuma data selecionada."
              //               : "Data Selecionada: ${DateFormat('d/MM/y').format(_selectDate as DateTime)}",
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.grey[600],
              //           ),
              //         ),
              //       ),
              //       Row(
              //         children: [
              //           TextButton(
              //             onPressed: _showDatePicker,
              //             child: Text(
              //               "Selecionar Data",
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 16,
              //               ),
              //             ),
              //           ),
              //           Icon(
              //             Icons.search,
              //             color: Colors.purple,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              AdaptiveButton(label: 'Nova Transação', onPressed: _onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
