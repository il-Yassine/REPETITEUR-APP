import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/login/login_screen.dart';

import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/fetch_all_users_role.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/role_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/register/teacher_register_auth_provider.dart';

import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:repetiteur_mobile_app_definitive/widgets/form_errors.dart';

class TeacherRegisterFormScreen extends StatefulWidget {
  const TeacherRegisterFormScreen({super.key, this.selectedRole});

  final Role? selectedRole;

  @override
  State<TeacherRegisterFormScreen> createState() =>
      _TeacherRegisterFormScreenState();
}

class _TeacherRegisterFormScreenState extends State<TeacherRegisterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRole = "";

  String? name;
  String? phone;
  String? email;
  String? password;
  String? confirm_password;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRepetiteurRoleId();
  }

  Future<void> _fetchRepetiteurRoleId() async {
    try {
      String roleId = await fetchRepetiteurRoleId();
      setState(() {
        selectedRole = roleId;
      });
    } catch (error) {
      print("Erreur lors de la récupération de l'ID du rôle : $error");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
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
                _buildFullNameFormField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                _buildPhoneNumberFormField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                _buildEmailFormField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                _buildPasswordFormField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                _buildConfirmPasswordFormField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                FormError(errors: errors),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Consumer<TeacherRegisteringProvider>(
                        builder: (context, teacher_register, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (teacher_register.resMessage != '') {
                          showMessage(
                            message: teacher_register.resMessage,
                            context: context,
                          );
                          teacher_register.clear();
                        }
                      });
                      bool status = teacher_register.isLoading;
                      return AppFilledButton(
                        text: status == false ? "Inscription" : "Veuillez patienter...",
                        color: kPrimaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            teacher_register.registerTeacher(
                              name: _nameController.text.trim(),
                              phone: _phoneController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              role_id: selectedRole!,
                              context: context,
                            );
                            debugPrint(
                                "::::::::::::::::::::::::::  $selectedRole");
                            /*  Navigator.pushNamed(context,
                                TeacherAddingInformationScreen.routeName); */
                          } else if (_nameController.text.isEmpty ||
                              _phoneController.text.isEmpty ||
                              _emailController.text.isEmpty ||
                              _passwordController.text.isEmpty ||
                              _confirmPasswordController.text.isEmpty) {
                            showMessage(
                              message: 'Tous les champs sont obligatoires',
                              backgroundColor: Colors.red,
                              context: context,
                            );
                          }
                        },
                        context: context,
                        buttonStatus: teacher_register.isLoading,
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Vous avez un compte?',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, TeacherLoginScreen.routeName);
                        },
                        child: const Text(
                          'Connectez-vous',
                          style: TextStyle(
                              color: kPrimaryColor,
                              decorationColor: kPrimaryColor,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildConfirmPasswordFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Confirmation",
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
            controller: _confirmPasswordController,
            obscureText: true,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => confirm_password = newValue!,
            decoration: const InputDecoration(
                hintText: "Confirmez le mot de passe",
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
                addError(error: kPassNullError);
                return "";
              } else if (password != value) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.isNotEmpty && password == confirm_password) {
                removeError(error: kMatchPassError);
              }
              confirm_password = value;
            },
          ),
        ),
      ],
    );
  }

  Column _buildPasswordFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mot de passe",
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
            controller: _passwordController,
            cursorColor: Colors.deepPurple,
            obscureText: true,
            onSaved: (newValue) => password = newValue!,
            decoration: const InputDecoration(
                hintText: "Mot de passe",
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
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                password = value;
              });

              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
          ),
        ),
      ],
    );
  }

  Column _buildEmailFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
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
            controller: _emailController,
            cursorColor: Colors.deepPurple,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue!,
            decoration: const InputDecoration(
                hintText: "exemple@gmail.com",
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
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                email = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
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
            cursorColor: Colors.blue,
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
              setState(() {
                phone = value;
              });
              if (value.isNotEmpty) {
                return;
              }
            },
          ),
        ),
      ],
    );
  }

  Column _buildFullNameFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nom Complet",
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
            controller: _nameController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.deepPurple,
            onSaved: (newValue) => name = newValue!,
            decoration: const InputDecoration(
                hintText: "AGON Gilbert",
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
                addError(error: kNameNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kNameNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                name = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kNameNullError);
              } else if (value.length > 2) {
                removeError(error: kNameNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
