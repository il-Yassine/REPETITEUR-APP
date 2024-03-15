import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/widgets/add_teacher_success_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_PARENT/add_children/parent_add_child_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddChildForm extends StatefulWidget {
  const AddChildForm({super.key});

  @override
  State<AddChildForm> createState() => _AddChildFormState();
}

class _AddChildFormState extends State<AddChildForm> {
  final _formKey = GlobalKey<FormState>();

  String? lastname;
  String? firstname;
  String? phone;
  String? address;
  String? sexe;

  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _lastnameController.clear();
    _firstnameController.clear();
    _sexeController.clear();
    _phoneController.clear();
    _addressController.clear();
  }

  final userId = GetStorage().read("userId");

  Future<String> getParentId() async {
  // L'URL de votre API
  var url = Uri.parse('http://apirepetiteur.sevenservicesplus.com/api/parents?user_id=$userId');

  // Récupérez le token de l'utilisateur connecté
  String token = GetStorage().read("token");

  // Effectuez la requête GET avec le token dans l'en-tête
  var response = await http.get(url, headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  });

  // Vérifiez si la requête a réussi
  if (response.statusCode == 200 || response.statusCode == 201) {
    // Si la requête a réussi, parsez la réponse en JSON
    var jsonResponse = jsonDecode(response.body);

    // Obtenez le parent_id du premier élément de la liste 'data'
    var parentId = jsonResponse['data'][0]['id'];

    print('ID USER PARENT CONNECT : $userId');

    // Retournez le parent_id
    return parentId;
  } else {
    // Si la requête a échoué, lancez une exception
    throw Exception('Failed to load parent_id');
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                AppInputField(
                  controller: _lastnameController,
                  title: 'Nom de l\'enfant',
                  borderColor: Colors.grey,
                  hintText: 'Entrez le nom de l\'enfant',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                AppInputField(
                  controller: _firstnameController,
                  title: 'Prénom de l\'enfant',
                  borderColor: Colors.grey,
                  hintText: 'Entrez le(s) prénom(s) de l\'enfant',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                AppInputField(
                  controller: _sexeController,
                  title: 'Sexe de l\'enfant',
                  borderColor: Colors.grey,
                  hintText: 'Masculin/Féminin',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                AppInputField(
                  controller: _phoneController,
                  title: 'Numéro de téléphone',
                  borderColor: Colors.grey,
                  hintText: 'Entrez votre numéro de téléphone',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                AppInputField(
                  controller: _addressController,
                  title: 'Votre adresse de localisation',
                  borderColor: Colors.grey,
                  hintText: 'Entrez votre adresse',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                /*FormError(errors: errors),*/
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Consumer<ParentAddChildProvider>(
                        builder: (context, addingChild, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (addingChild.resMessage != '') {
                          showMessage(
                              message: addingChild.resMessage,
                              context: context);
                          addingChild.clear();
                        }
                      });
                      return AppFilledButton(
                        text: "Envoyer",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            var parentId = await getParentId();

                            addingChild.parentAddChilds(
                              lname: _lastnameController.text.trim(),
                              fname: _firstnameController.text.trim(),
                              sexe: _sexeController.text.trim(),
                              phone: _phoneController.text.trim(),
                              adresse: _addressController.text.trim(),
                              parents_id: parentId,
                              context: context,
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTeacherSuccessScreen()));
                            dispose();
                          } else if (_lastnameController.text.isEmpty ||
                              _firstnameController.text.isEmpty ||
                              _sexeController.text.isEmpty ||
                              _phoneController.text.isEmpty ||
                              _addressController.text.isEmpty) {
                            showMessage(
                              message: 'Tous les champs sont obligatoires',
                              backgroundColor: Colors.red,
                              context: context,
                            );
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
