import 'package:dfine_task/controller/auth_controller.dart';
import 'package:dfine_task/controller/theme_controller.dart';
import 'package:dfine_task/view/auth/forget_password.dart';
import 'package:dfine_task/view/auth/register_screen.dart';
import 'package:dfine_task/view/screens/home.dart';
import 'package:dfine_task/view/widgets/custom_snackbar.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
        final themeProvider = Provider.of<ThemeController>(context);

    Size size = MediaQuery.of(context).size;
    final authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      
        backgroundColor: themeProvider.backgroundColor,
         appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        actions: [
          Consumer<ThemeController>(
            builder: (context, themeController, child) => IconButton(
              onPressed: () {
                themeController.changeTheme();
              },
              icon: const Icon(Icons.light_mode),
            ),
          )
        ],
      ),
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * .1,
                          ),
                        Center(
                    child: Hero(
                        tag: "hi",
                        child: Image.asset(themeProvider.imageDark))),
                          SizedBox(
                            height: size.height * .1,
                          ),
                          CustomTextFields(
                            controller: authController.emailController,
                            hint: "Email",
                            hintStyle: TextStyle(color: themeProvider.textColor),
                            type: TextFieldType.email,
                          ),
                          CustomTextFields(
                            controller: authController.passwordController,
                            hint: "password",
                            hintStyle: TextStyle(color: themeProvider.textColor),
                            type: TextFieldType.password,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen(),
                                )),
                            child:  CustomText(
                              text: 'Forgot Password?',
                              color:themeProvider.textColor,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Consumer<AuthController>(
                              builder: (context, value, child) {
                            return ElevatedButton(
                              
                                style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      // backgroundColor: themeProvider.buttonColor,
                    ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final result =
                                        await authController.loginUser();
                                    if (result != null) {
                                      showCustomSnackBar(
                                          context: context,
                                          type: SnackBarType.error,
                                          content: result);
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const HomeScreen(),
                                          ));
                                    }
                                  }
                                },
                                child:  value.isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    :  Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 15, color: themeProvider.buttonColor),
                                      ));
                                
                              
                          }),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 CustomText(
                                  text: "Don't have an account? ",
                                  size: 11,
                                  color: themeProvider.textColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      )),
                                  child:  CustomText(
                                    text: "Register",
                                    decoration: TextDecoration.underline,
                                    color: themeProvider.textColor,
                                    fontWeight: FontWeight.w700,
                                    size: 11,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ])))));
  }
}
