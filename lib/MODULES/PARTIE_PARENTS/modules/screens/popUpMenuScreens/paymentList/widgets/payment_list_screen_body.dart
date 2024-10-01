// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/payment_methods/payement_success_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/provider/payment_provider/parent_payment_provider.dart';

import '../../../payment_methods/kkiaPay_Sample.dart';

class PaymentListScreenBody extends StatefulWidget {
  const PaymentListScreenBody({super.key});

  @override
  State<PaymentListScreenBody> createState() => _PaymentListScreenBodyState();
}

class _PaymentListScreenBodyState extends State<PaymentListScreenBody> {
  List<dynamic> paiementList = [];
  String? paiementId;
  String? transactionId;
  String? selectedPaiementId;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final userId = GetStorage().read("userId");
    final url =
        "http://api-mon-encadreur.com/api/payements?user_id=$userId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        paiementList = responseData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void successCallback(response, context) {
    switch (response['status']) {
      case PAYMENT_CANCELLED:
        debugPrint(PAYMENT_CANCELLED);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PAYMENT_CANCELLED),
        ));
        break;

      case PENDING_PAYMENT:
        debugPrint(PENDING_PAYMENT);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PENDING_PAYMENT),
        ));
        break;

      case PAYMENT_INIT:
        debugPrint(PAYMENT_INIT);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PAYMENT_INIT),
        ));
        break;

      case PAYMENT_SUCCESS:
        transactionId = response['transactionId'];
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              amount: response['requestData']['amount'],
              transactionId: transactionId.toString(),
              postOrderCallback: () {
                /* postPayement(transactionId.toString()); */
                Provider.of<ParentPaymentProvider>(context, listen: false).makePayment(
                  paymentId: paiementId,
                  reference: transactionId.toString(),
                  status: "Payer",
                  context: context,

                );
              },
               paiementId: selectedPaiementId,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PAYMENT_SUCCESS),
        ));
        break;

      case PAYMENT_FAILED:
        debugPrint(PAYMENT_FAILED);
        break;

      default:
        break;
    }
  }

  Future<bool> openKkiapayPayment(
      String montantString, String paiementId) async {
    final montant = double.parse(montantString);

    final kkiapay = KKiaPay(
        amount: montant.toInt(),
        countries: ["BJ"],
        phone: GetStorage().read("parentPhone").toString(),
        name: GetStorage().read("parentName").toString(),
        email: GetStorage().read("parentEmail").toString(),
        reason: 'transaction reason',
        data: 'Fake data',
        sandbox: true,
        apikey: 'd81f7db084ba11eea99e794f985e5009',
        callback: successCallback,
        theme: defaultTheme,
        paymentMethods: ["momo", "card"]);

// Ouvrez l'écran Kkiapay
    final success = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KkiapaySample(kkiapay: kkiapay)),
    );

    return success ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
      child: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No.')),
                DataColumn(
                    label: Text(
                  "Echéance",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                )),
                DataColumn(
                    label: Text(
                  "Nom & Prénom(s)",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                )),
                DataColumn(
                    label: Text(
                  "Montant",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                )),
                DataColumn(
                    label: Text(
                  "Status",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                )),
                DataColumn(
                    label: Text(
                  "Actions",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ))
              ],
              rows: paiementList.asMap().entries.map((entry) {
                final int index = entry.key + 1;
                final Map<String, dynamic> paiement = entry.value;

                final String echeance = paiement['date'];
                final String nomEnfant =
                    paiement['demande']['enfants']['lname'];
                final String prenomEnfant =
                    paiement['demande']['enfants']['fname'];
                final String montant =
                    paiement['demande']['tarification']['prix'];
                final String status = paiement['status'];

                final String paiementId = paiement['id'];

                final String parentName =
                    paiement['demande']['enfants']['parents']['user']['name'];
                final String parentEmail =
                    paiement['demande']['enfants']['parents']['user']['email'];
                final String parentPhone =
                    paiement['demande']['enfants']['phone'];

                GetStorage().write("parentName", parentName);
                GetStorage().write("parentEmail", parentEmail);
                GetStorage().write("parentPhone", parentPhone);
                GetStorage().write("paiementId", paiementId);

                return DataRow(cells: [
                  DataCell(Text('$index')),
                  DataCell(Text(echeance)),
                  DataCell(Text('$nomEnfant $prenomEnfant')),
                  DataCell(Text(montant)),
                  DataCell(Text(status, style: TextStyle(
                    color: () {
                      if (status == 'Impayer') {
                        return Colors.red;
                      } else {
                        return Colors.green;
                      }
                    }(),
                  ))),
                  status == 'Impayer'
                      ? DataCell(TextButton(
                          onPressed: () async {
                            print(paiementId);

                            setState(() {
                              selectedPaiementId = paiementId;
                              
                            });

                            print(selectedPaiementId);

                            final success =
                                await openKkiapayPayment(montant, paiementId);
                            if (success) {
                              showMessage(
                                  message: 'Paiement réussi !',
                                  backgroundColor: Colors.green,
                                  context: context);
                            } else {
                              showMessage(
                                  message: 'Échec du paiement',
                                  backgroundColor: Colors.red,
                                  context: context);
                            }
                          },
                          child: const Text("Payer",
                              style: TextStyle(color: kPrimaryColor))))
                      : const DataCell(Text(
                          "Déjà payé",
                          style: TextStyle(color: Colors.grey),
                        )),
                ]);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
