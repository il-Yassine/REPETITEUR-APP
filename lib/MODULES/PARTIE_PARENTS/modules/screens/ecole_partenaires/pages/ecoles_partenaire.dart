import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/ecole_partenaires/widgets/single_school_card_widget.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/ecole/school_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/ecole/school_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class PatnerSchoolScreen extends StatefulWidget {
  const PatnerSchoolScreen(
      {super.key, required this.searchQuery, required this.press});

  final String searchQuery;
  final VoidCallback press;

  @override
  State<PatnerSchoolScreen> createState() => _PatnerSchoolScreenState();
}

class _PatnerSchoolScreenState extends State<PatnerSchoolScreen> {
  List schools = [];

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  bool isRefresh = false;

  Future<void> _onRefresh() async {
    try {
      setState(() {
        isRefresh = true;
      });
      List<School> schools = await SchoolList.getAllSchool();
      /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La page a été mis à jour'),
        ),
      ); */
    } catch (e) {
      /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Erreur lors de l'actualisation de la page. Vérifier votre connexion internet..."),
        ),
      ); */
      print(("Erreur: ${e}"));
    } finally {
      setState(() {
        isRefresh = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: _onRefresh,
      child: FutureBuilder<List<School>>(
        future: SchoolList.getAllSchool(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<School> filteredSchool =
              (snapshot.data as List<School>?)?.where((school) {
                    String schoolName = school.name.toLowerCase();
                    return schoolName.contains(widget.searchQuery.toLowerCase());
                  }).toList() ??
                  [];
      
          return (snapshot.connectionState != ConnectionState.done)
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("Veuillez patienter un moment..."),
                    ],
                  ),
                )
              : (filteredSchool.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: SizeConfig.screenHeight * 0.18,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kWhite,
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Center(
                          child: Text(
                            "Aucunes données n'est présent sur les écoles",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  : CarouselSlider(
                      items: filteredSchool
                          .map<Widget>((school) => SingleSchoolCardWidget(
                              school: school, press: () {}))
                          .toList(),
                      options: CarouselOptions(
                          height: SizeConfig.screenHeight * 0.3,
                          enableInfiniteScroll: false,
                          initialPage: 0,
                          viewportFraction: 0.95,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 10)));
        },
      ),
    );
  }
}
