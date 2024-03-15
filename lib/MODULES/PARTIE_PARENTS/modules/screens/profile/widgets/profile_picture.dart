import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, required this.profilePic, required this.press});

  final AssetImage profilePic;
  final GestureTapCallback press;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: widget.profilePic,
          ),
          Positioned(
            bottom: 0,
            right: -12,
            child: SizedBox(
              height: 46,
              width: 46,
              child: MaterialButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white)),
                color: const Color(0xFFF5F6F9),
                onPressed: widget.press,
                child: const Icon(LineIcons.camera),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
