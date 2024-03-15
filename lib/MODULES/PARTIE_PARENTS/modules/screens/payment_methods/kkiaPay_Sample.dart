

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';

class KkiapaySample extends StatelessWidget {
  final KKiaPay kkiapay;
  const KkiapaySample({
    Key? key, required this.kkiapay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kBackground,
      statusBarIconBrightness: Brightness.dark
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement par Kkiapay"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: 500.0,
                height: 100.0,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xff222F5A)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    'Procéder au paiement',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => kkiapay),
                    );
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}