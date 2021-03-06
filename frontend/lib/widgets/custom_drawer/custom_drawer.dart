import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/bloc.dart';
import 'package:frontend/screens/screens.dart';
import 'package:frontend/utilities/utilities.dart';
import 'package:frontend/widgets/custom_drawer/widget/header.dart';
import 'package:frontend/widgets/custom_drawer/widget/item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Header(),
          Item(
            icon: Icons.home,
            text: Strings.home(),
            onTap: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName, arguments: false);
            },
          ),
          Item(
            icon: Icons.settings,
            text: Strings.settings(),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          Divider(),
          Item(
            icon: Icons.exit_to_app,
            text: Strings.sign_out(),
            onTap: () => context.read<AuthBloc>().signOut(),
          ),
        ],
      ),
    );
  }

  // Widget _header(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).primaryColor,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Theme.of(context).primaryColorDark.withOpacity(0.6),
  //           spreadRadius: 1,
  //           blurRadius: 1,
  //           offset: Offset(0, 1),
  //         ),
  //       ],
  //     ),
  //     child: DrawerHeader(
  //         margin: EdgeInsets.zero,
  //         padding: EdgeInsets.zero,
  //         decoration: BoxDecoration(color: Theme.of(context).primaryColor),
  //         child: GestureDetector(
  //           onTap: () {},
  //           child: Stack(children: <Widget>[
  //             Positioned(
  //               bottom: 40.0,
  //               left: 16.0,
  //               child: CircleAvatar(
  //                 radius: 55,
  //                 backgroundColor: Colors.black12,
  //                 child: CachedNetworkImage(
  //                   imageUrl: "",
  //                   imageBuilder: (context, imageProvider) => Container(
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       border: Border.all(color: Colors.black87, width: 1.0),
  //                       image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
  //                     ),
  //                   ),
  //                   placeholder: (context, url) => CircularProgressIndicator(),
  //                   errorWidget: (context, url, error) => Icon(
  //                     Icons.account_circle,
  //                     size: 110,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //                 bottom: 8.0,
  //                 left: 16.0,
  //                 child: Text(
  //                   "",
  //                   style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
  //                 )),
  //           ]),
  //         )),
  //   );
  // }

  // Widget _drawerItem({
  //   required IconData icon,
  //   required String text,
  //   required GestureTapCallback onTap,
  //   bool inactive = false,
  // }) {
  //   return ListTile(
  //     title: Row(
  //       children: <Widget>[
  //         Icon(icon),
  //         Padding(
  //           padding: EdgeInsets.only(left: 8.0),
  //           child: Text(text, style: inactive ? TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey) : null),
  //         )
  //       ],
  //     ),
  //     onTap: onTap,
  //   );
  // }
}
