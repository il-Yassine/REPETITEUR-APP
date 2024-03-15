import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/eleves.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class SingleStudentCard extends StatefulWidget {
  const SingleStudentCard({
    super.key,
    required this.student,
    /* required this.press */
  });

  final Student student;

  @override
  State<SingleStudentCard> createState() => _SingleStudentCardState();
}

class _SingleStudentCardState extends State<SingleStudentCard> {
  /* final GestureTapCallback press; */

  TextEditingController _appreciationController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
      child: Container(
        width: SizeConfig.screenWidth * 0.9,
        height: SizeConfig.screenHeight * 0.3,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Nom : ",
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.student.lastname,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Prénom(s) : ",
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.student.firstname,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Classe : ",
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.student.studentClass,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Matiere : ",
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.student.course,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Repititeur : ",
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.student.teacher,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Center(
                child: TextButton(
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
                                      borderRadius: BorderRadius.circular(12),
                                      color: kWhite,
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 50, 20, 20),
                                    child: Form(
                                        child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Appréciation",
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.04,
                                          ),
                                          AppInputField(
                                            title: "Appréciation sur l'enfant",
                                            controller: _appreciationController,
                                            keyboardType: TextInputType.text,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.02,
                                          ),
                                          AppInputField(
                                            title: "Presence au poste",
                                            controller: _dateController,
                                            suffixIcon: const Icon(
                                                Icons.calendar_today),
                                            onTap: () {
                                              _selectDate();
                                            },
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.02,
                                          ),
                                          AppInputField(
                                            title: "Observation(Optionnelle)",
                                            //controller: ,
                                            maxLines: 4,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.04,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              AppFilledButton(
                                                text: "Annuler",
                                                color: Colors.red,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              SizedBox(width: SizeConfig.screenWidth * 0.03,),
                                              AppFilledButton(
                                                text: "Envoyer",
                                                color: Colors.green,
                                                onPressed: () {},
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))));
                          });
                      /* Get.defaultDialog(
                  backgroundColor: Colors.deepPurple.shade50,
                  title: "Appréciation",
                  content: Column(
                    children: [
                      Divider(),
                      AppInputField(
                        title: "Appréciation sur l'enfant",
                        controller: _appreciationController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      AppInputField(
                        title: "Presence au poste",
                        controller: _dateController,
                        suffixIcon: Icon(Icons.calendar_today),
                        onTap: () {
                          _selectDate();
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      AppFilledButton(text: "Envoyer", onPressed: () {},)
                    ],
                  )
                ); */
                    },
                    child: Text(
                      "Appréciation",
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.02,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
