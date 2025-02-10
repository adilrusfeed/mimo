  import 'package:dfine_task/controller/auth_controller.dart';
  import 'package:dfine_task/controller/theme_controller.dart';
  import 'package:dfine_task/controller/user_controller.dart';
  import 'package:dfine_task/view/auth/login_screen.dart';
  import 'package:dfine_task/view/widgets/custom_text_field.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';



  class drawer_widget extends StatelessWidget {
    const drawer_widget({
      super.key,
    });

    @override
    Widget build(BuildContext context) {
          final themeProvider = Provider.of<ThemeController>(context);

      final AuthProvi = Provider.of<AuthController>(context, listen: false);
      return Drawer(
        shape: const BeveledRectangleBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              
              child: Consumer<UserController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  
                Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          value.isEdit
                              ? Flexible(
                                  child: TextField(
                                    controller: value.nameContoller,
                                    decoration:
                                        const InputDecoration(hintText: 'Name'),
                                  ),
                                )
                              : CustomText(
                                  text: value.user?.fullname ?? '',
                                  size: 25,
                                  overflow: true,
                                  fontWeight: FontWeight.bold),
                          IconButton(
                              onPressed: () async {
                                if (value.isEdit) {
                                  // await value.uploadProfileImage();
                                  await value.updateUser();
                                } else {
                                  value.isEditName();
                                }
                              },
                              icon: Icon(value.isEdit
                                  ? Icons.check
                                  : Icons.edit_outlined))
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const CustomText(text: 'Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const CustomText(text: 'General Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const CustomText(text: 'Account Settings'),
              onTap: () {},
            ),
            ListTile(
              leading:  Icon(Icons.dark_mode, color: themeProvider.textColor),
              title: Text(
                  'Dark / Light',
                  style: TextStyle(
                    fontSize: 16,
                    color: themeProvider.textColor,
                  ),
                ),
                onTap: () {
                  themeProvider.changeTheme();
                },
              ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const CustomText(text: 'Abouts'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const CustomText(text: 'Logout'),
              onTap: () {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title:  Text('Are you sure you want to log out?',style: TextStyle(fontSize:20),),
                  actions: [
                    TextButton(onPressed: (){
                      AuthProvi  .logoutUser();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
                    }, child: Text("Yes")),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("No"))
                  ],
                );
              });
                  
              },
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomText(
                text: 'Version 1.0.0',
                size: 13,
              ),
            ),
          ],
        ),
      );
    }
  }