import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final tr = transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child:
                    FittedBox(child: Text('R\$${tr.value.toStringAsFixed(2)}')),
              ),
            ),
            title: Text(
              tr.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(DateFormat('d MMM y').format(tr.date)),
            trailing: IconButton(
              onPressed: () {
                onRemove(tr.id);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        );
      },
    );
  }
}
