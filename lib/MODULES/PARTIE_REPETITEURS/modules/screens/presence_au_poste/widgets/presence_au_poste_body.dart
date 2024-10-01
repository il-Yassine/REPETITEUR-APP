import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/presence_au_poste/presence_poste_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

import '../../../../../../core/constants/REPETITEURS/constants.dart';

class PresenceAuPosteBody extends StatefulWidget {
  const PresenceAuPosteBody({super.key});

  @override
  State<PresenceAuPosteBody> createState() => _PresenceAuPosteBodyState();
}

class _PresenceAuPosteBodyState extends State<PresenceAuPosteBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  List<dynamic> presences = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.clear();
    _messageController.clear();
  }

  Future<void> fetchData() async {
    final teacherUserId = GetStorage().read("teacherUserId");

    final url =
        "http://api-mon-encadreur.com/api/presenceaupostes?user_id=$teacherUserId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        presences = responseData;
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
    return ListView(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight:
              SizeConfig.screenHeight * 0.06, // Hauteur de la ligne d'en-tête
          dataRowMaxHeight: SizeConfig.screenHeight * 0.06,
          columns: const [
            DataColumn(label: Text('No.')),
            DataColumn(label: Text('Nom et Prénom(s)')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Présence')),
            DataColumn(label: Text('Action')),
          ],

          rows: presences.asMap().entries.map((entry) {
            final int index = entry.key + 1;
            final Map<String, dynamic> presence = entry.value;

            final String id_presence = presence['id'];
            final String nomRepetiteur = presence['repetiteur']['user']['name'];
            final String date = formatDate(presence['created_at']);

            GetStorage().write('presenceAuPosteId', id_presence);

            return DataRow(cells: [
              DataCell(Text('$index')),
              DataCell(Text(nomRepetiteur)),
              DataCell(Text(date)),
              DataCell(presence['poste'] == null ? Container(
                width: double.infinity,
                  decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(18),
              ), child: const Text("Non", style: TextStyle(color: kWhite), textAlign: TextAlign.center,)) : Container(width: double.infinity,decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(18),
              ), child: const Text("Oui", style: TextStyle(color: kWhite),textAlign: TextAlign.center,))),
              DataCell(
                presence['poste'] == null
                    ? TextButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    insetPadding: const EdgeInsets.all(10),
                                    child: Container(
                                        width: double.infinity,
                                        height: SizeConfig.screenHeight * 0.6,
                                        decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 50, 20, 20),
                                        child: Form(
                                            key: _formKey,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Marquer la présence au poste",
                                                    style: TextStyle(
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.04,
                                                  ),
                                                  AppInputField(
                                                    title: "Date",
                                                    controller: _dateController,
                                                    suffixIcon: const Icon(
                                                        Icons.calendar_today),
                                                    onTap: () {
                                                      _selectDate();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.02,
                                                  ),
                                                  AppInputField(
                                                    title: "Appréciation",
                                                    controller:
                                                        _messageController,
                                                    maxLines: 4,
                                                  ),
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.04,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      AppFilledButton(
                                                        text: "Fermer",
                                                        color: Colors.red,
                                                        onPressed: () {
                                                          dispose();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: SizeConfig
                                                                .screenWidth *
                                                            0.03,
                                                      ),
                                                      Consumer<
                                                              PresenceAuPosteProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) {
                                                          if (snapshot
                                                                  .resMessage !=
                                                              '') {
                                                            showMessage(
                                                                message: snapshot
                                                                    .resMessage,
                                                                context:
                                                                    context);
                                                            snapshot.clear();
                                                          }
                                                        });
                                                        return AppFilledButton(
                                                          text: "Envoyer",
                                                          color: Colors.green,
                                                          onPressed: () async {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              _formKey
                                                                  .currentState!
                                                                  .save();
                                                              final teacherId =
                                                                  GetStorage().read(
                                                                      "teacherId");

                                                              snapshot
                                                                  .postPresenceAuPoste(
                                                                presencePosteId: id_presence.toString(),
                                                                poste:
                                                                    _dateController
                                                                        .text
                                                                        .trim(),
                                                                message:
                                                                    _messageController
                                                                        .text
                                                                        .trim(),
                                                                context:
                                                                    context,
                                                              );
                                                              showMessage(
                                                                message:
                                                                    'Appréciation envoyée ! ',
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                context:
                                                                    context,
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              dispose();
                                                            } else if (
                                                                _dateController
                                                                    .text
                                                                    .isEmpty) {
                                                              showMessage(
                                                                message:
                                                                    'Le champs date est obligatoire',
                                                                backgroundColor:
                                                                    Colors.red,
                                                                context:
                                                                    context,
                                                              );
                                                            }
                                                          },
                                                        );
                                                      }),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ))));
                              });
                        },
                        child: Text(
                          "Marquer",
                          style: TextStyle(
                            fontSize: SizeConfig.screenHeight * 0.02,
                            color: kPrimaryColor
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ]);
          }).toList(),
        ),
      ),
    ]);
  }
}
