import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/answer_provider/parent_answer_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class AppreciationBody extends StatefulWidget {
  const AppreciationBody({Key? key}) : super(key: key);

  @override
  State<AppreciationBody> createState() => _AppreciationBodyState();
}

class _AppreciationBodyState extends State<AppreciationBody> {
  final _formKey = GlobalKey<FormState>();

  final _teacherAnswerController =
      TextEditingController(text: GetStorage().read("appreciationRepetiteur"));
  final TextEditingController _parentAnswerController = TextEditingController();

  List<dynamic> appreciations = [];
  List<String> repetiteursList = [];
  List<String> enfantsList = [];
  bool showAllMessages = true;
  bool showPendingMessages = false;
  bool showAnsweredMessages = false;

  String? selectedRepetiteur;
  String? selectedEnfant;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _parentAnswerController.clear();
  }

  Future<void> fetchData() async {
    final userId = GetStorage().read("userId");
    final url =
        "http://apirepetiteur.wadounnou.com/api/postes?user_id=$userId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        appreciations = responseData;

        repetiteursList = List<String>.from(responseData
            .map((appreciation) =>
                appreciation['repetiteur']['user']['name'].toString())
            .toSet());

        enfantsList = List<String>.from(responseData
            .map((appreciation) =>
                '${appreciation['demande']['enfants']['lname']} ${appreciation['demande']['enfants']['fname']}')
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

  Widget buildFilterButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: AppFilledButton(
          text: text,
          color: color,
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget buildDropdowns() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: buildDropdown(
              "Rechercher par répétiteur...",
              repetiteursList,
              (selectedRepetiteur) {
                updateDropdownSelection(selectedRepetiteur, null);
              },
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.04),
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: buildDropdown(
              "Rechercher par enfants...",
              enfantsList,
              (selectedEnfant) {
                updateDropdownSelection(null, selectedEnfant);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(
      String hint, List<String> items, ValueChanged<String?> onChanged) {
    return BaseInputField(
      title: "Rechercher",
      inputControl: DropdownButtonFormField<String>(
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        isDense: true,
        isExpanded: true,
        iconSize: 22,
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        hint: Text(
          hint,
          style: const TextStyle(
            color: kcDarkGreyColor,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
          ),
        ),
        decoration: const InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return Expanded(
      child: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No.')),
                DataColumn(
                  label: Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Nom & Prénom(s)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Matière",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Appréciation sur l'enfant",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Répétiteur",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Action",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
              rows: appreciations.asMap().entries.where((entry) {
                final Map<String, dynamic> appreciation = entry.value;
                final bool hasResponse =
                    appreciation['reponse_parents'] != null;

                return (showAllMessages ||
                        (showPendingMessages && !hasResponse) ||
                        (showAnsweredMessages && hasResponse)) &&
                    (selectedRepetiteur == null ||
                        appreciation['repetiteur']['user']['name'] ==
                            selectedRepetiteur) &&
                    (selectedEnfant == null ||
                        '${appreciation['demande']['enfants']['lname']} ${appreciation['demande']['enfants']['fname']}' ==
                            selectedEnfant);
              }).map((entry) {
                final int index = entry.key + 1;
                final Map<String, dynamic> appreciation = entry.value;

                final String dateMessage = formatDate(appreciation['created_at']);
                final String nomDeLenfant =
                    appreciation['demande']['enfants']['lname'];
                final String prenomDeLenfant =
                    appreciation['demande']['enfants']['fname'];
                final String matiere =
                    appreciation['demande']['tarification']['matiere']['name'];
                final String appreciationRepetiteur =
                    appreciation['appreciation_repetiteur'];
                final String nomPrenomRepetiteur =
                    appreciation['repetiteur']['user']['name'];
                final String? reponseParents = appreciation['reponse_parents'];
                final String appreciationId = appreciation['id'];

                GetStorage()
                    .write("appreciationRepetiteur", appreciationRepetiteur);

                return DataRow(cells: [
                  DataCell(Text('$index')),
                  DataCell(Text(dateMessage)),
                  DataCell(Text('$nomDeLenfant $prenomDeLenfant')),
                  DataCell(Text(matiere)),
                  DataCell(Text(appreciationRepetiteur, maxLines: 3,)),
                  DataCell(Text(nomPrenomRepetiteur)),
                  reponseParents == null
                      ? DataCell(TextButton(
                          onPressed: () {
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
                                      borderRadius: BorderRadius.circular(12),
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
                                              "Observation",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.04,
                                            ),
                                            BaseInputField(
                                                title:
                                                    "Appréciation du Répétiteur",
                                                inputControl: TextFormField(
                                                  controller:
                                                      _teacherAnswerController,
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    hintStyle: TextStyle(
                                                        color: kcLightGreyColor,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14.0),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black54),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black54),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    border: InputBorder.none,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                )),
                                            /* AppInputField(
                                              title:
                                                  "Appréciation du Répétiteur",
                                              keyboardType:
                                                  TextInputType.text,
                                              controller:
                                                  _teacherAnswerController,
                                            ), */
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.02,
                                            ),
                                            AppInputField(
                                              title: "Votre Réponse",
                                              keyboardType: TextInputType.text,
                                              maxLines: 3,
                                              controller:
                                                  _parentAnswerController,
                                            ),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.04,
                                            ),
                                            Consumer<ParentAnswerProvider>(
                                                builder: (context, sendAnswer,
                                                    child) {
                                              return AppFilledButton(
                                                text: "Envoyer",
                                                color: Colors.green,
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();

                                                    sendAnswer.sendAnswer(
                                                        appreciationId:
                                                            appreciationId,
                                                        reponseParents:
                                                            _parentAnswerController
                                                                .text
                                                                .trim(),
                                                        context: context);
                                                    dispose();
                                                    showMessage(
                                                      message:
                                                          'Méssage envoyé ! ',
                                                      backgroundColor:
                                                          Colors.green,
                                                      context: context,
                                                    );
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const OperationSuccessScreen()));
                                                  } else if (_parentAnswerController
                                                      .text.isEmpty) {
                                                    showMessage(
                                                      message:
                                                          'Le champ appreciation est obligatoire',
                                                      backgroundColor:
                                                          Colors.red,
                                                      context: context,
                                                    );
                                                  }
                                                },
                                              );
                                            })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            "Répondre",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ))
                      : const DataCell(Text(
                          "Déjà répondu",
                          style: TextStyle(color: Colors.grey),
                        )),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void updateFilterState(bool all, bool pending, bool answered) {
    setState(() {
      showAllMessages = all;
      showPendingMessages = pending;
      showAnsweredMessages = answered;
    });
  }

  void updateDropdownSelection(String? repetiteur, String? enfant) {
    setState(() {
      selectedRepetiteur = repetiteur;
      selectedEnfant = enfant;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        title: const Text("Boîte de réception", style: TextStyle(color: kWhite),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildFilterButton("Tous",
                        const Color.fromARGB(255, 17, 135, 232), () {
                      updateFilterState(true, false, false);
                    }),
                    buildFilterButton("En attente",
                        const Color.fromARGB(255, 22, 190, 56), () {
                      updateFilterState(false, true, false);
                    }),
                    buildFilterButton("Répondus",
                        const Color.fromARGB(255, 227, 172, 5), () {
                      updateFilterState(false, false, true);
                    }),
                  ],
                ),
              ),
              buildDropdowns(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              buildDataTable(),
            ],
          ),
        ),
      ),
    );
  }
}

class OperationSuccessScreen extends StatelessWidget {
  const OperationSuccessScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Opération réussie avec succès !",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Lottie.asset(
              "assets/lotties/Animation - 1707306278755.json",
              height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth * 1.5,
            ),
            AppFilledButton(
              text: "Retour à l'accueil",
              color: kWhite,
              txtColor: kPrimaryColor,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, ParentHomeScreen.routeName, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
