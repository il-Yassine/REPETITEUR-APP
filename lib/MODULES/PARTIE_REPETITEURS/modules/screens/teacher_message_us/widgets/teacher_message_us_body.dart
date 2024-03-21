import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/teacher_sent_message_provider/teacher_sent_message_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherMessageUsBody extends StatefulWidget {
  const TeacherMessageUsBody({super.key});

  @override
  State<TeacherMessageUsBody> createState() => _TeacherMessageUsBodyState();
}

class _TeacherMessageUsBodyState extends State<TeacherMessageUsBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController =
      TextEditingController(text: GetStorage().read('teacherUserName'));
  final TextEditingController _userPhoneController =
      TextEditingController(text: GetStorage().read('teacherUserPhone'));
  final TextEditingController _userEmailController =
      TextEditingController(text: GetStorage().read('teacherUserEmail'));
  final TextEditingController _userObjectController = TextEditingController();
  final TextEditingController _userMessageController = TextEditingController();

  String? name;
  String? phone;
  String? email;
  String? object;
  String? message;

  @override
  void dispose() {
    super.dispose();
    _userObjectController.clear();
    _userMessageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Laisser nous un message", style: TextStyle(color: kWhite),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                AppInputField(
                  title: "Nom Complet (Champ Obligatoire)",
                  hintText: "AGOSSOU Gilbert",
                  controller: _userNameController,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                AppInputField(
                  title: "Téléphone (Champ Obligatoire)",
                  hintText: "97882454",
                  keyboardType: TextInputType.phone,
                  controller: _userPhoneController,
                  maxLines: 1,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                BaseInputField(
                    title: "Email (Champ Obligatoire)",
                    inputControl: TextFormField(
                      controller: _userEmailController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'test@gmail.com',
                        hintStyle: TextStyle(
                            color: kcLightGreyColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Champ obligatoire";
                          /*  } else if (value.length <= 2) {
                        return "Veuillez saisir votre nom complet"; */
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                        if (value.isNotEmpty) {
                          return;
                          /* } else if (value.length > 2) {
                        return ""; */
                        }
                        return;
                      },
                    )),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                AppInputField(
                  title: "Objet",
                  hintText: "Remerciements",
                  keyboardType: TextInputType.phone,
                  controller: _userObjectController,
                  maxLines: 1,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                AppInputField(
                  title: "Message (Champ Obligatoire)",
                  keyboardType: TextInputType.phone,
                  controller: _userMessageController,
                  maxLines: 5,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Consumer<TeacherSentMessageProvider>(
                    builder: (context, snapshot, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (snapshot.resMessage != '') {
                      showMessage(
                          message: snapshot.resMessage, context: context);
                      snapshot.clear();
                    }
                  });
                  return AppFilledButton(
                    text: "Envoyer le message",
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        snapshot.teacherSentMessage(
                          fullName: _userNameController.text.trim(),
                          phoneNumber: _userPhoneController.text.trim(),
                          messageObject: _userObjectController.text.trim(),
                          emailAddress: _userEmailController.text.trim(),
                          userMessage: _userMessageController.text.trim(),
                          context: context,
                        );
                        /*showMessage(
                          message: 'Votre message a été bien envoyée !',
                          backgroundColor: Colors.green,
                          context: context,
                        );*/
                        dispose();
                      } else if (_userEmailController.text.isEmpty ||
                          _userPhoneController.text.isEmpty ||
                          _userEmailController.text.isEmpty ||
                          _userMessageController.text.isEmpty) {
                        showMessage(
                          message: 'Tous les champs sont obligatoires',
                          backgroundColor: Colors.red,
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
  }
}
