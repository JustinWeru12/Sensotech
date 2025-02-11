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
        decoration: BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/icons/icon.png",
          ),
          radius: 20,
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
