
import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/text/app_text.dart';

class RequiredText extends StatelessWidget {
  const RequiredText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.02),
        border: Border.all(color: Colors.orangeAccent, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: AppText.caption('REQUIS', color: Colors.orangeAccent),
    );
  }
}
