import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class SearchTeacherField extends StatelessWidget {
  SearchTeacherField({super.key,});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
          width: SizeConfig.screenWidth * 0.90,
          height: 50,
          decoration: BoxDecoration(
              color: kBackgroundForRestaurant,
              borderRadius: BorderRadius.circular(20.0),
              /*boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 0)
                )
              ]*/
          ),
          child: TextFormField(
           // controller: searchController,
            /*onChanged: (value) {
              onSearch(value);
            },*/
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusColor: Theme.of(context).primaryColor,
                focusedBorder: InputBorder.none,
                hintText: "                       🔍  Rechercher...",
                hintStyle: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.7)),
                /*prefixIcon: Icon(CupertinoIcons.search, color: Theme.of(context).primaryColor,),*/
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(9))),
          )),
    );
  }
}
