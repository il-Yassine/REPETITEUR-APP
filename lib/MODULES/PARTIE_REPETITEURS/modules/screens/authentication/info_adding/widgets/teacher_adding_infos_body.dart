import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/widgets/adding_info_success_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/communes/commune__model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/register/teacher_adding_information_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/register/teacher_file_upload_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherAddingInformationsBody extends StatefulWidget {
  const TeacherAddingInformationsBody({super.key});

  @override
  State<TeacherAddingInformationsBody> createState() =>
      _TeacherAddingInformationsBodyState();
}

class _TeacherAddingInformationsBodyState
    extends State<TeacherAddingInformationsBody> {
  final _formKey = GlobalKey<FormState>();

  String? adresse;
  String? phone;
  String? imagePath;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController(text: GetStorage().read("teacherUserPhone"));
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _diplomaPathController = TextEditingController();
  final TextEditingController _criminalRecordPathController =
      TextEditingController();
  final TextEditingController _homeCertificateController =
      TextEditingController();
  final TextEditingController _identityPathController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _birthdayAndPlaceController =
      TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _studyDegreeController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  String selectedSexe = '';
  String selectedCycle = '';
  List<Communes> allCommunes = [];
  String selectedCommune = '';
  List<String> cycles = ["Primaires", "Secondaires", "Universitaires"];
  List<String> sexe = ["Feminin", "Masculin"];

  String? imageUrl;
  String? diplomeUrl;
  String? criminalRecordUrl;
  String? homeCertificateUrl;
  String? identityUrl;

  @override
  void initState() {
    super.initState();
    fetchAllCommunes();
  }

  Future<List<Communes>> fetchAllCommunes() async {
    try {
      const allCommunesUrl =
          'http://api-mon-encadreur.com/api/communes';
      final response = await http.get(Uri.parse(allCommunesUrl));

      final body = jsonDecode(response.body);

      final List<Communes> communes =
          List<Communes>.from(body['data'].map((e) => Communes.fromJson(e)));

      setState(() {
        allCommunes = communes;
      });

      return communes;
    } catch (e) {
      debugPrint("Erreur : $e");
      return [];
    }
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.clear();
    _phoneController.clear();
    _imagePathController.clear();
    _diplomaPathController.clear();
    _criminalRecordPathController.clear();
    _homeCertificateController.clear();
    _identityPathController.clear();
    _descriptionController.clear();
    _schoolController.clear();
    _availabilityController.clear();
    _levelController.clear();
    _birthdayAndPlaceController.clear();
    _maritalStatusController.clear();
    _studyDegreeController.clear();
    _sexeController.clear();
    _experienceController.clear();
  }

  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  Future<void> _openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      String imagePath = result.files.single.path!;

      print(
          "Chemin du fichier : $imagePath"); // Ajoutez cette ligne pour afficher le chemin du fichier

      var imageUrl =
          await TeacherFileUploadProvider().uploadeFiles(filePath: imagePath);

      print(
          "URL du fichier : $imageUrl"); // Ajoutez cette ligne pour afficher l'URL du fichier
      setState(() {
        _imagePathController.text = imageUrl!;
      });

      this.imageUrl = imageUrl;
    }
  }

  Future<void> _openDiplomaPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      String diplomaPath = result.files.single.path!;
      var diplomeUrl =
          await TeacherFileUploadProvider().uploadeFiles(filePath: diplomaPath);
      setState(() {
        _diplomaPathController.text = diplomeUrl!;
      });

      this.diplomeUrl = diplomeUrl;
    }
  }

  Future<void> _openCriminalRecordPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      String criminalRecordPath = result.files.single.path!;

      var criminalRecordUrl = await TeacherFileUploadProvider()
          .uploadeFiles(filePath: criminalRecordPath);

      setState(() {
        _criminalRecordPathController.text = criminalRecordUrl!;
      });

      this.criminalRecordUrl = criminalRecordUrl;
    }
  }

  Future<void> _openHomeCertificatePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      String homeCertificatePath = result.files.single.path!;

      var homeCertificateUrl = await TeacherFileUploadProvider()
          .uploadeFiles(filePath: homeCertificatePath);
      setState(() {
        _homeCertificateController.text = homeCertificateUrl!;
      });

      this.homeCertificateUrl = homeCertificateUrl;
    }
  }

  Future<void> _openIdentityPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      String identityPath = result.files.single.path!;
      var identityUrl = await TeacherFileUploadProvider()
          .uploadeFiles(filePath: identityPath);
      setState(() {
        _identityPathController.text = identityUrl!;
      });

      this.identityUrl = identityUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        title: const Text("Completez vos informations", style: TextStyle(color: kWhite)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPhoneNumberFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  BaseInputField(
                      title: "Commune",
                      inputControl: DropdownButtonFormField<Communes>(
                        items: allCommunes.map((commune) {
                          return DropdownMenuItem<Communes>(
                            value: commune,
                            child: Text(commune.name),
                          );
                        }).toList(),
                        onChanged: (Communes? value) {
                          selectedCommune = value!.id;
                        },
                        isDense: true,
                        isExpanded: true,
                        iconSize: 22,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        hint: const Text(
                          'Sélectionner une commune...',
                          style: TextStyle(
                              color: kcDarkGreyColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0),
                        ),
                        decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      )),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildFullAddressFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  BaseInputField(
                      title: "Cycle",
                      inputControl: DropdownButtonFormField<String>(
                        items: cycles.map((cycle) {
                          return DropdownMenuItem<String>(
                            value: cycle,
                            child: Text(cycle),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCycle = value!;
                          });
                        },
                        isDense: true,
                        isExpanded: true,
                        iconSize: 22,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        hint: const Text(
                          'Sélectionner un cycle...',
                          style: TextStyle(
                              color: kcDarkGreyColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0),
                        ),
                        decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      )),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildPicturePathFormField(),
                  AppFilledButton(
                    text: "Choisir un fichier",
                    color: kPrimaryColor,
                    onPressed: () async {
                      _openImagePicker();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildDiplomaPathFormField(),
                  AppFilledButton(
                    text: "Choisir un fichier",
                    color: kPrimaryColor,
                    onPressed: () {
                      _openDiplomaPicker();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildCriminalRecordPathFormField(),
                  AppFilledButton(
                    text: "Choisir un fichier",
                    color: kPrimaryColor,
                    onPressed: () {
                      _openCriminalRecordPicker();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildHomeCertificatePathFormField(),
                  AppFilledButton(
                    text: "Choisir un fichier",
                    color: kPrimaryColor,
                    onPressed: () {
                      _openHomeCertificatePicker();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildIDPathFormField(),
                  AppFilledButton(
                    text: "Choisir un fichier",
                    color: kPrimaryColor,
                    onPressed: () {
                      _openIdentityPicker();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildDescriptionFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildSchoolFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildAvailabilityFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildLevelFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildBirthdayAndPlaceFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildMaritalStatusFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildStudyDegreeFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  BaseInputField(
                      title: "Sexe",
                      inputControl: DropdownButtonFormField<String>(
                        items: sexe.map((sexe) {
                          return DropdownMenuItem<String>(
                            value: sexe,
                            child: Text(sexe),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedSexe = value!;
                        },
                        isDense: true,
                        isExpanded: true,
                        iconSize: 22,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        hint: const Text(
                          'Feminin/Masculin',
                          style: TextStyle(
                              color: kcDarkGreyColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0),
                        ),
                        decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      )),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  _buildExperienceFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  Consumer<TeacherAddingInformationProvider>(
                      builder: (context, uploading, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (uploading.resMessage != '') {
                        showMessage(
                          message: uploading.resMessage,
                          context: context,
                        );
                        uploading.clear();
                      }
                    });
                    return AppFilledButton(
                      text: "Mettre à jour",
                      color: Colors.green,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          List<Teachers> teachersList = await TeacherList
                              .getAllTeacherWithoutEvaluation();
                          int matriculeNumber = teachersList.length + 1;
                          String matricule = "E0000$matriculeNumber";

                          debugPrint(matricule);
                          debugPrint("nombre de repetiteur: $matriculeNumber");

                          print("url de l'image : $imageUrl");

                          uploading.addTeacherInformations(
                            adresse: _addressController.text.trim(),
                            commune_id: selectedCommune.toString(),
                            cycle: selectedCycle,
                            matricule: matricule,
                            phone: _phoneController.text.trim(),
                            profil_imageUrl: imageUrl,
                            diplome_imageUrl: diplomeUrl,
                            casierJudiciaire: criminalRecordUrl,
                            attestationResidence: homeCertificateUrl,
                            identite: identityUrl,
                            description: _descriptionController.text.trim(),
                            ecole: _schoolController.text.trim(),
                            heureDisponibilite:
                                _availabilityController.text.trim(),
                            grade: _levelController.text.trim(),
                            dateLieuNaissance:
                                _birthdayAndPlaceController.text.trim(),
                            situationMatrimoniale:
                                _maritalStatusController.text.trim(),
                            niveauEtude: _studyDegreeController.text.trim(),
                            sexe: selectedSexe,
                            experience: _experienceController.text.trim(),
                            context: context,
                          );

                          showMessage(
                            message:
                                "Vos informations ont été mises à jour avec succès !",
                            backgroundColor: Colors.green,
                            context: context,
                          );
                          Navigator.pushNamed(
                              context, AddingInfoSuccessScreen.routeName);
                        } else if (_addressController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _imagePathController.text.isEmpty ||
                            _diplomaPathController.text.isEmpty ||
                            _criminalRecordPathController.text.isEmpty ||
                            _homeCertificateController.text.isEmpty ||
                            _identityPathController.text.isEmpty ||
                            _availabilityController.text.isEmpty ||
                            _schoolController.text.isEmpty ||
                            _levelController.text.isEmpty ||
                            _descriptionController.text.isEmpty ||
                            _birthdayAndPlaceController.text.isEmpty ||
                            _studyDegreeController.text.isEmpty ||
                            _maritalStatusController.text.isEmpty ||
                            _experienceController.text.isEmpty) {
                          showMessage(
                            message: 'Certains champs sont obligatoires',
                            backgroundColor: Colors.red,
                            context: context,
                          );
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildExperienceFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Expérience",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _experienceController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "3 ans",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildStudyDegreeFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Niveau d'étude",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _studyDegreeController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "BAC",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildMaritalStatusFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Situation Matrimoniale",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _maritalStatusController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Célibataire",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildBirthdayAndPlaceFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date et Lieu de naissance",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _birthdayAndPlaceController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "01/01/1999 à Cotonou",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildLevelFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Grade",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _levelController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Agent Permanent de l'Etat (APE)",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildAvailabilityFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Disponibilité",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _availabilityController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Mercredi 14h à 18h et Samedi 09h à 12h",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildSchoolFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ecole",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _schoolController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Sainte Felicite",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildDescriptionFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _descriptionController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Dites quelque chose sur vous...",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildIDPathFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pièce d'identité en format PDF",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _identityPathController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Aucun fichier choisi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildHomeCertificatePathFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Attestation de résidence en format PDF",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _homeCertificateController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Aucun fichier choisi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildCriminalRecordPathFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Casier judiciaire en format PDF",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _criminalRecordPathController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Aucun fichier choisi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildDiplomaPathFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Diplome en format PDF",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _diplomaPathController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Aucun fichier choisi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildPicturePathFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Photo de profile",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _imagePathController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Aucun fichier choisi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                imagePath = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildPhoneNumberFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Numéro de téléphone",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _phoneController,
            cursorColor: Colors.deepPurple,
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phone = newValue!,
            decoration: const InputDecoration(
                hintText: "99887733",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                return "Renseignez votre numéro de téléphone";
              }

              if (value.length == 8 ||
                  value.length == 12 ||
                  value.length == 13) {
                return null; // La taille du numéro de téléphone est valide
              } else {
                return "Le numéro de téléphone n'est pas valide";
              }
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                return;
              }
            },
          ),
        ),
      ],
    );
  }

  Column _buildFullAddressFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Details Adresse",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _addressController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Abomey-Calavi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
