import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardListView extends StatelessWidget {
  final Function(String) onRemove;
  final Transaction trIndex;

  const CardListView(
      {super.key, required this.onRemove, required this.trIndex});

  @override
  Widget build(BuildContext context) {
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
            child: FittedBox(
                child: Text('R\$${trIndex.value.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          trIndex.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat('d MMM y').format(trIndex.date)),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () {
                  onRemove(trIndex.id);
                },
                icon: Icon(
                  Icons.delete,
                ),
                label: Text(
                  "Excluir",
                  style: TextStyle(color: Colors.red),
                ),
              )
            : IconButton(
                onPressed: () {
                  onRemove(trIndex.id);
                },
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
