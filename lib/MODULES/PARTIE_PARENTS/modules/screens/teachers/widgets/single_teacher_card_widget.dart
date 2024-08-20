import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class SingleTeacherCardWidget extends StatelessWidget {
  const SingleTeacherCardWidget(
      {super.key, required this.teachers, required this.press});

  final Teachers teachers;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: SizeConfig.screenWidth * 0.89,
          height: SizeConfig.screenHeight * 0.29,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              InkWell(
                onTap: press,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: teachers.profilImageUrl.toString() != 'null' ? NetworkImage(
                        teachers.profilImageUrl.toString(),
                      ) : const NetworkImage('https://apibackout.s3.amazonaws.com/images/1713947852vectoriel.jpg'),
                      radius: 85,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  GestureDetector(
                    // GestureDetector pour détecter le long appui.
                    onLongPress: () {
                      // Le presse-papiers pour copier le texte.
                      Clipboard.setData(
                          ClipboardData(text: teachers.matricule.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Le matricule a été copié dans le presse-papier')));
                    },
                    child: SelectableText(
                      teachers.matricule.toString(),
                      style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.02,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Text(
                    teachers.user.name.toString() ,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.016,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.005,
                  ),
                  Text(
                    teachers.adresse.toString(),
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.016,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.005,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.4,
                    child: Text(
                      '${teachers.cycle}/${teachers.status}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.016,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.005,
                  ),
                  Text(
                    '${teachers.evaluation}/${teachers.etats}',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.016,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.012,
                  ),
                  Text(
                    teachers.commune.name.toString(),
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.016,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.015,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
