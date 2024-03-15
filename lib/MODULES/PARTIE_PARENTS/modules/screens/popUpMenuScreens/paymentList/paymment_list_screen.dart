import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/paymentList/widgets/payment_list_screen_body.dart';

class PayementListScreen extends StatelessWidget {
  const PayementListScreen({super.key});

  static String routeName = '/payement_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de vos paiements'),
        centerTitle: true,
        elevation: 0,
      ),
      body: PaymentListScreenBody(),
    );
  }
}
