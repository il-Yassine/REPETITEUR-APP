
import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

// import 'package:shop_app/size_config.dart';

const kPrimaryColor = Color.fromRGBO(162, 127, 85, 1) ;
const kOnBoardingBackgroundColor = Color(0xFFFF9D61);
const kStandartDeepGreenColor = Color.fromRGBO(106, 173, 96, 1);
const kLightGreenColor = Color.fromRGBO(211, 229, 207, 1);
const Color kYellowColor = Color(0xFFFDBF30);
const kPrimaryLightColor = Color(0xFFFFECDF);
const Color kBackground = Color.fromRGBO(250, 250, 250, 1);
const Color kBackgroundForRestaurant = Color.fromRGBO(237, 237, 237, 1);
const Color inActiveIconColor = Color(0xFFB6B6B6);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kWhite = Color(0xFFFFFFFF);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Entrez votre email s'il vous plait";
const String kInvalidEmailError = "S'il vous plaît, entrez un email valide";
const String kPassNullError = "Entrez votre mot de passe s'il vous plait";
const String kShortPassError = "Le mot de passe est trop court";
const String kMatchPassError = "Mot de passe différents";
const String kNameNullError = "Entrez votre nom complet s'il vous plaît";
const String kPhoneNumberNullError = "Entrez votre numéro de téléphone s'il vous plaît";
const String kAddressNullError = "Saisissez votre adresse svp";
const String kRestaurantNameNullError = "Entrez le nom de votre restaurant";
const String kRestaurantLocalisationNullError = "L'adresse du restaurant est requise";
const String kRestaurantContactNullError = "Renseignez un numéro";
const String kRestaurantDescriptionNullError = "Une petite description est requise";
const String kDeliveryPersonNullError = "Nom et Prénoms requis !";
const String kDeliveryPersonAdressLocationNullError = "Adresse est requise";
const String kDeliveryPersonPhoneNumberNullError = "Numéro de téléphone requis !";
const String kDeliveryPersonAboutInfoNullError = "Dites-nous qqch sur vous !";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(18)),
    borderSide: BorderSide(color: kTextColor),
  );
}