import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

import '../../../../../../core/constants/REPETITEURS/constants.dart';

class AllObservationsBody extends StatefulWidget {
  const AllObservationsBody({super.key});

  @override
  State<AllObservationsBody> createState() => _AllObservationsBodyState();
}

class _AllObservationsBodyState extends State<AllObservationsBody> {

  List<dynamic> appreciations = [];
  List<String> repetiteursList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    final teacherUserId = GetStorage().read("teacherUserId");
    final url =
        "http://api-mon-encadreur.com/api/postes?user_id=$teacherUserId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        appreciations = responseData;

        repetiteursList = List<String>.from(responseData
            .map((appreciation) =>
            appreciation['demande']['repetiteur']['user']['name'].toString())
            .toSet());

      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('No.')),
              DataColumn(label: Text('Enfant(s)')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Appréciation')),
              DataColumn(label: Text('Réponse Admin')),
            ],
            rows: appreciations.asMap().entries.map((entry) {
              final int index = entry.key + 1;
              final Map<String, dynamic> appreciation = entry.value;

              // Accéder aux informations souhaitées

              final String dateAppreciation = formatDate(appreciation['created_at']);
              final String nomEnfant = appreciation['demande']['enfants']['fname'];
              final String prenomEnfant = appreciation['demande']['enfants']['lname'];
              final String appreciationSurEnfant = appreciation['appreciation_repetiteur'];
              final String reponseParents = appreciation['reponse_parents'] ?? '';

              TextEditingController _appreciationSurEnfant = TextEditingController(text: appreciationSurEnfant);
              TextEditingController _reponseParents = TextEditingController(text: reponseParents);

              return DataRow(cells: [
                DataCell(Text('$index')),
                DataCell(Text('$nomEnfant $prenomEnfant')),
                DataCell(Text(dateAppreciation)),
                DataCell(
                  IconButton(
                    onPressed: reponseParents != null ? () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                insetPadding:
                                const EdgeInsets.all(10),
                                child: Container(
                                    width: double.infinity,
                                    height: SizeConfig
                                        .screenHeight *
                                        0.45,
                                    decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius:
                                      BorderRadius.circular(
                                          12),
                                    ),
                                    padding: const EdgeInsets
                                        .fromLTRB(
                                        20, 50, 20, 20),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          maxLines: 8,
                                          readOnly: true,
                                          controller: _appreciationSurEnfant,
                                          textAlign: TextAlign.justify,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: kTextColor),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: kTextColor),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig
                                            .screenHeight *
                                            0.03,),
                                        AppFilledButton(text: 'Fermer', color: Colors.red, onPressed: () {
                                          Navigator.of(context).pop();
                                        },)
                                      ],
                                    )
                                ));
                          });
                    } : null,
                    icon: const Icon(Icons.mail_outline, color: kPrimaryColor)
                    /*Text(
                      "Lire le message",
                      style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.02,
                          color: kPrimaryColor
                      ),
                    ),*/
                  ),
                ),
                DataCell(
                  IconButton(
                    onPressed:
                    reponseParents != "null" ? () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                insetPadding:
                                const EdgeInsets.all(10),
                                child: Container(
                                    width: double.infinity,
                                    height: SizeConfig
                                        .screenHeight *
                                        0.45,
                                    decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius:
                                      BorderRadius.circular(
                                          12),
                                    ),
                                    padding: const EdgeInsets
                                        .fromLTRB(
                                        10, 50, 10, 20),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          maxLines: 8,
                                          readOnly: true,
                                          controller: _reponseParents,
                                          textAlign: TextAlign.justify,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: kTextColor),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: kTextColor),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig
                                            .screenHeight *
                                            0.03,),
                                        AppFilledButton(text: 'Fermer', color: Colors.red, onPressed: () {
                                          Navigator.of(context).pop();
                                        },)
                                      ],
                                    )
                                ));
                          });
                    } : null,
                    icon: const Icon(Icons.visibility_outlined, color: kPrimaryColor)
                    /*Text(
                      "Lire réponse",
                      style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.02,
                          color: kPrimaryColor
                      ),
                    ),*/
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
