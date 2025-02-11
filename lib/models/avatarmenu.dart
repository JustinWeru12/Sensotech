import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sensotech/constants/theme.dart';

class UserAvatarMenu extends StatelessWidget {
  final VoidCallback onLogout;

  const UserAvatarMenu({
    super.key,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Container(
        padding: EdgeInsets.all(2),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          border: Border.all(color: kBackgroundColor, width: 2),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset(
            "assets/icons/icon.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      color: kBackgroundColor,
      menuPadding: EdgeInsets.all(2),
      offset: Offset(0, 50),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            leading: Icon(PhosphorIconsBold.signOut, color: kAlertColor),
            title: Text('Logout',
                style: kTitleTextstyle.copyWith(color: kAlertColor)),
            onTap: onLogout,
          ),
        ),
      ],
    );
  }
}
