import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/ecole/school_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class SingleSchoolCardWidget extends StatefulWidget {
  const SingleSchoolCardWidget(
      {super.key, required this.school, required this.press});

  final School school;
  final GestureTapCallback press;

  @override
  State<SingleSchoolCardWidget> createState() => _SingleSchoolCardWidgetState();
}

class _SingleSchoolCardWidgetState extends State<SingleSchoolCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: widget.press,
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: NetworkImage(widget.school.ecoleUrl),
                fit: BoxFit.cover,
                colorFilter:
                    const ColorFilter.mode(Colors.black45, BlendMode.darken)),
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
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.school.name,
                  style: TextStyle(
                    fontSize: SizeConfig.screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                    color: kWhite,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Résultats : ",
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.016,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.school.resultat,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.016,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Description : ",
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.016,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.school.description,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.016,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
