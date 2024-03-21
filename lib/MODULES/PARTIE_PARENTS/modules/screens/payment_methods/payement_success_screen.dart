import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/provider/payment_provider/parent_payment_provider.dart';

class SuccessScreen extends StatelessWidget {
  final int? amount;
  final String transactionId;
  final Function postOrderCallback;
  final String? paiementId;

  SuccessScreen({
    required this.amount,
    required this.transactionId,
    required this.postOrderCallback,
    this.paiementId,
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
              'Montant: $amount FCFA',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'ID de la transaction: $transactionId',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Consumer<ParentPaymentProvider>(
                builder: (context, snapshot, child) {
              return ElevatedButton(
                onPressed: () {
                  print('Paiement ID: $paiementId');
                  snapshot.makePayment(
                      paymentId: paiementId,
                      reference: transactionId,
                      status: "Payer");

                      Navigator.pushNamed(context, ParentHomeScreen.routeName);
                },
                child: const Text(
                    'Fermer'), // 0d691183-c73d-11ee-bbd3-00163e6e7997
              );
            })
          ],
        ),
      ),
    );
  }
}
