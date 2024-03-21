import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/parents_childs.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class SingleChildCard extends StatelessWidget {
  const SingleChildCard({
    super.key,
    required this.child,
    /* required this.press */
  });

  final Child child;
  /* final GestureTapCallback press; */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
      child: Container(
        width: SizeConfig.screenWidth * 0.9,
        height: SizeConfig.screenHeight * 0.4,
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
                    child.lastname,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.normal,
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
                    child.firstname,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.normal,
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
                    child.level,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.normal,
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
                    child.matiere,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.normal,
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
                    child.repetiteur,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Status : ",
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    child.status,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Motif : ",
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    child.motif,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              Center(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Appréciation",
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.02,
                        color: kPrimaryColor,
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