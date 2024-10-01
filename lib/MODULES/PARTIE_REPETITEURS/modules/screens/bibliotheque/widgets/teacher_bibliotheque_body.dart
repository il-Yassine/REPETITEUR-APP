import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherBibliothequeBody extends StatefulWidget {
  const TeacherBibliothequeBody({super.key});

  @override
  State<TeacherBibliothequeBody> createState() => _TeacherBibliothequeBodyState();
}

class _TeacherBibliothequeBodyState extends State<TeacherBibliothequeBody> {
 List<dynamic> epreuves = [];

  @override
  void initState() {
    super.initState();
    fetchEpreuvesData();
  }

  Future<void> fetchEpreuvesData() async {
    const epreuvesUrl =
        'http://api-mon-encadreur.com/api/epreuves';

    final response = await http.get(Uri.parse(epreuvesUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];

      setState(() {
        epreuves = responseData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        title: const Text("Bibliothèque", style: TextStyle(color: kWhite),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No.')),
                    DataColumn(
                        label: Text(
                      "Classe",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    )),
                    DataColumn(
                        label: Text(
                      "Matière",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    )),
                    DataColumn(
                        label: Text(
                      "Epreuve(s)",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    )),
                    DataColumn(
                        label: Text(
                      "Corrigé",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ))
                  ],
                  rows: epreuves.asMap().entries.map((entry) {
                    final int index = entry.key + 1;
                    final Map<String, dynamic> epreuve = entry.value;

                    final String classe = epreuve['classe']['name'];
                    final String matiere = epreuve['matiere']['name'];
                    final String epreuveUrl = epreuve['epreuve'];
                    final String corrigeUrl = epreuve['corrige'] ?? 'N/A';

                    return DataRow(cells: [
                      DataCell(Text('$index')),
                      DataCell(Text(classe)),
                      DataCell(Text(matiere)),
                      DataCell(TextButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(epreuveUrl),
                                mode: LaunchMode.inAppBrowserView);
                          },
                          child: const Text(
                            "Télécharger",
                            style: TextStyle(color: kPrimaryColor),
                          ))),
                      DataCell(TextButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(corrigeUrl),
                                mode: LaunchMode.inAppBrowserView);
                          },
                          child: const Text("Télécharger",
                              style: TextStyle(color: kPrimaryColor))))
                    ]);
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
