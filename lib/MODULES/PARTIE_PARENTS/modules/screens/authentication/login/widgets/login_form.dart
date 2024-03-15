import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/forgot_password/parent_forgot_password_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/register/register_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_PARENT/login/parent_login_auth_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:repetiteur_mobile_app_definitive/widgets/form_errors.dart';

class ParentLoginFormScreen extends StatefulWidget {
  const ParentLoginFormScreen({super.key});

  @override
  State<ParentLoginFormScreen> createState() => _ParentLoginFormScreenState();
}

class _ParentLoginFormScreenState extends State<ParentLoginFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? phone;

  String? password;
  bool rememberMe = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPhoneFieldVisible = true;
  bool isEmailFieldVisible = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.clear();
     _phoneController.clear();
    _passwordController.clear();
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
                  height: SizeConfig.screenHeight * 0.06,
                ),
                if (isPhoneFieldVisible) _buildPhoneNumberFormField(),
                if (isEmailFieldVisible)
                  Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Visibility(
                        visible: (isPhoneFieldVisible || isEmailFieldVisible) ? false : true,
                        child: Center(
                          child: Text(
                            "OU",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: SizeConfig.screenHeight * 0.015),
                          ),
                        ),
                      ),
                      _buildEmailFormField(),
                    ],
                  ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                _buildPasswordFormField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                      hoverColor: kPrimaryColor,
                    ),
                    const Text(
                      "Se souvenir de moi",
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text(
                        "Mot de passe oublié",
                        style: TextStyle(
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: kPrimaryColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ParentForgotPassworsScreen.routeName);
                      },
                    )
                  ],
                ),
                FormError(errors: errors),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Consumer<ParentLoginProvider>(
                        builder: (context, parent_login, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (parent_login.resMessage != '') {
                          showMessage(
                              message: parent_login.resMessage,
                              context: context);
                          parent_login.clear();
                        }
                      });
                      bool status = parent_login.isLoading;
                      return AppFilledButton(
                        text: status == false ? "Connexion" : "Veuillez patienter...",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            parent_login.loginParent(
                                email: _emailController.text.trim(),
                                phone: _phoneController.text.trim(),
                                password: _passwordController.text.trim(),
                                context: context);
                            /* Navigator.pushNamed(
                                context, ParentHomeScreen.routeName); */
                          } else if ((_emailController.text.isEmpty || _phoneController.text.isEmpty) &&
                              _passwordController.text.isEmpty) {
                            showMessage(
                              message: 'Certains champs sont obligatoires',
                              backgroundColor: Colors.red,
                              context: context,
                            );
                          }
                        },
                        context: context,
                        buttonStatus: parent_login.isLoading,
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Vous n\'avez pas encore un compte?',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ParentRegisterScreen.routeName);
                        },
                        child: const Text(
                          'Inscrivez-vous',
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
                isEmailFieldVisible = value.isEmpty;
              });
              /*if (value.isNotEmpty) {
                return;
              }*/
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
            cursorColor: Colors.blue,
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
            /* validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            }, */
            onChanged: (value) {
              setState(() {
                email = value;
                isPhoneFieldVisible = value.isEmpty;
              });
              /*if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;*/
            },
          ),
        ),
      ],
    );
  }
}
