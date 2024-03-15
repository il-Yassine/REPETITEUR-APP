
import 'package:flutter/material.dart';


class SuccessScreen extends StatelessWidget {
  final int? amount;
  final String transactionId;

  SuccessScreen({
    required this.amount,
    required this.transactionId, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement effectué avec Succès👍'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Paiement réussi !',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Montant: ${amount} FCFA',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'ID de la transaction: $transactionId',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text('Fermer'),
                    )
          ],
        ),
      ),
    );
  }
}
