import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:repetiteur_mobile_app_definitive/widgets/form_errors.dart';

class ParentForgotPasswordBody extends StatefulWidget {
  const ParentForgotPasswordBody({super.key});

  @override
  State<ParentForgotPasswordBody> createState() => _ParentForgotPasswordBodyState();
}

class _ParentForgotPasswordBodyState extends State<ParentForgotPasswordBody> {
  final _formKey = GlobalKey<FormState>();
  String? email;

   final TextEditingController _emailController = TextEditingController();

   @override
  void dispose() {
    super.dispose();
    _emailController.clear();
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
    return  SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                 _buildEmailFormField(),
                 FormError(errors: errors),
                 SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: AppFilledButton(
                    text: "Suivant",
                    color: kPrimaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        /* Navigator.pushNamed(context, TeacherHomeScreen.routeName); */
                      } else if (_emailController.text.isEmpty) {
                        showMessage(
                          message: 'Le champ email est obligatoire dans ce cas',
                          backgroundColor: Colors.red,
                          context: context,
                        );
                      }
                    },
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
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
}