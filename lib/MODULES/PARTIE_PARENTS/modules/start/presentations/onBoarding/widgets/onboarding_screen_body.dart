import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/terms_&_conditions/terms_and_conditions.screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/landing/landing_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/onBoarding/widgets/onboarding_screen_content.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/widgets/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreenBody extends StatefulWidget {
  const OnBoardingScreenBody({super.key});

  @override
  State<OnBoardingScreenBody> createState() => _OnBoardingScreenBodyState();
}

class _OnBoardingScreenBodyState extends State<OnBoardingScreenBody> {
  int currentPage = 0;

  List<Map<String, String>> onBoardingData = [
    {
      "text": "Bienvenue sur MON ENCADREUR",
      "image": "assets/onboarding_images/1.png",
    },
    {
      "text": "Avec MON ENCADREUR, vous pouvez faire des demandes de cours de maison pour vos enfants",
      "image": "assets/onboarding_images/2.png",
    },
    {
      "text":
      "Consultez toujours MON ENCADREUR pour suivre l'evolution d'etudes de vos enfants",
      "image": "assets/onboarding_images/3.png",
    },
    // {
    //   "text": "Avec MON REPETITEUR, l'enprentissage en ligne est également accessible",
    //   "image": "assets/onboarding_images/4.png",
    // }
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onBoardingData.length,
                itemBuilder: ((context, index) => OnBoardingScreenContent(
                    text: onBoardingData[index]["text"]!,
                    images: onBoardingData[index]["image"]!)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onBoardingData.length,
                              (index) => buildDot(index: index)),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultButton(
                        text: "Commencer",
                        press: () async {
                          final onBoardingPrefs = await SharedPreferences.getInstance();
                          await onBoardingPrefs.setBool('showOnboarding', false);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsAndConditionsScreen()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 18 : 6,
      decoration: BoxDecoration(
          color: currentPage == index
              ? kPrimaryColor
              : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
