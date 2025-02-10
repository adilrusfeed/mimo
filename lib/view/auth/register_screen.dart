import 'package:dfine_task/controller/auth_controller.dart';
import 'package:dfine_task/controller/theme_controller.dart';
import 'package:dfine_task/view/auth/login_screen.dart';
import 'package:dfine_task/view/screens/home.dart';
import 'package:dfine_task/view/widgets/custom_snackbar.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    Size size = MediaQuery.of(context).size;
    final authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      backgroundColor: themeProvider.textColor,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: size.height * 0.18),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: themeProvider.buttonColor,
                        )),
                    SizedBox(width: size.width * 0.1),
                    Text(
                      "Create an Account",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: themeProvider.backgroundColor,),
                    ),
                    SizedBox()
                  ],
                ),
                SizedBox(height: size.height * 0.2),
                CustomTextFields(
                  hint: "Full Name",

                  controller: authController.fullNameController,
                  type: TextFieldType.name,
                ),
                CustomTextFields(
                  hint: "Email",
                  controller: authController.emailController,
                  type: TextFieldType.email,
                ),
                CustomTextFields(
                  hint: "Password",
                  controller: authController.passwordController,
                  type: TextFieldType.password,
                ),
                CustomTextFields(
                  hint: "Confirm Password",
                  controller: authController.confirmPasswordController,
                  type: TextFieldType.confirmPassword,
                ),
                SizedBox(height: size.height * 0.05),
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
                            final result = await authController.registerUser();
                            if (result == null) {
                              showCustomSnackBar(
                                  context: context,
                                  type: SnackBarType.error,
                                  content: result);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
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
                                    : const Text(
                                        "Register",
                                        style: TextStyle(
                                            fontSize: 15, color:  Color.fromARGB(255, 255, 0, 0))));
                  },
                ),
                SizedBox(height: size.height * 0.05),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Already have an account? ",
                        color: themeProvider.buttonColor,
                        size: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen())),
                        child: CustomText(
                          text: "Login",
                          size: 11,
                          fontWeight: FontWeight.w600,
                          color: themeProvider.buttonColor,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
