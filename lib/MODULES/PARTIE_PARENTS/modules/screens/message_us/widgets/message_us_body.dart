import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/parent_sent_message_provider/parent_message_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class MessageUsBody extends StatefulWidget {
  const MessageUsBody({super.key});

  @override
  State<MessageUsBody> createState() => _MessageUsBodyState();
}

class _MessageUsBodyState extends State<MessageUsBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController =
      TextEditingController(text: GetStorage().read('userName'));
  final TextEditingController _userPhoneController =
      TextEditingController(text: GetStorage().read('userPhone'));
  final TextEditingController _userEmailController =
      TextEditingController(text: GetStorage().read('userMail'));
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
        title: const Text("Laissez-nous un message"),
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
                BaseInputField(
                    title: "Nom Complet (Champ Obligatoire)",
                    inputControl: TextFormField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'AGOSSOU Gilbert',
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
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Champ obligatoire";
                        } else if (value.length <= 2) {
                          return "Veuillez saisir votre nom complet";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                        if (value.isNotEmpty) {
                          return;
                        } else if (value.length > 2) {
                          return;
                        }
                        return null;
                      },
                    )),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                BaseInputField(
                    title: "Téléphone (Champ Obligatoire)",
                    inputControl: TextFormField(
                      controller: _userPhoneController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: '97882454',
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
                      keyboardType: TextInputType.phone,
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
                          phone = value;
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
                BaseInputField(
                    title: "Objet",
                    inputControl: TextFormField(
                      controller: _userObjectController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Remerciements',
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
                      keyboardType: TextInputType.text,
                    )),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                BaseInputField(
                    title: "Message (Champ Obligatoire)",
                    inputControl: TextFormField(
                      controller: _userMessageController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Merci...',
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
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Champ obligatoire";
                        } else if (value.length <= 2) {
                          return "Saisissez un message valide";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          message = value;
                        });
                        if (value.isNotEmpty) {
                          return;
                        } else if (value.length > 2) {
                          return;
                        }
                        return;
                      },
                    )),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Consumer<ParentSentMessageProvider>(
                      builder: (context, sendMessage, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (sendMessage.resMessage != '') {
                        showMessage(
                            message: sendMessage.resMessage, context: context);
                        sendMessage.clear();
                      }
                    });
                    return AppFilledButton(
                      text: "Envoyer le message",
                      color: Colors.green,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          sendMessage.parentSentMessage(
                              fullName: _userNameController.text.trim(),
                              phoneNumber: _userPhoneController.text.trim(),
                              emailAddress: _userEmailController.text.trim(),
                              messageObject: _userObjectController.text.trim(),
                              userMessage: _userMessageController.text.trim(),
                              context: context);
                          /*showMessage(
                            message: 'Message envoyé avec succès !',
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
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
