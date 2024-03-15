import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key, required this.text, required this.icon, required this.press});

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: MaterialButton(
        elevation: 0,
        color: const Color(0xFFF5F6F9),
        onPressed: press,
        padding: const EdgeInsets.all(20),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: kPrimaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
            const Icon(Icons.arrow_forward_ios, size: 20,)
          ],
        ),
      ),
    );
  }
}
