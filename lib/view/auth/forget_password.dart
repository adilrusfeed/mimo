import 'package:dfine_task/controller/auth_controller.dart';
import 'package:dfine_task/controller/theme_controller.dart';
import 'package:dfine_task/view/auth/register_screen.dart';
import 'package:dfine_task/view/widgets/custom_snackbar.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    Size size = MediaQuery.of(context).size;
    final authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
       backgroundColor: themeProvider.textColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                     CustomText(
                      text: 'Forgot Password',
                      fontWeight: FontWeight.bold,
                      color: themeProvider.textColor,
                      size: 18,
                    ),
                    const SizedBox()
                  ],
                ),
                
                CustomTextFields(
                  hint: 'Email',
                hintStyle: TextStyle(color: Colors.black38),
                  controller: authController.emailController,
                  type: TextFieldType.email,
                ),
                CustomText(
                  text:
                      "Enter the email address you used to create your account, and we will email you a link to reset your password.",color: themeProvider.textColor,
                  size: 11,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Consumer<AuthController>(builder: (context, value, child) {
                  return ElevatedButton(

                      style: ButtonStyle(
                        backgroundColor:WidgetStatePropertyAll(themeProvider.buttonColor),
                            elevation: WidgetStatePropertyAll(0),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * .01)))),
                           
                                ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final result = await authController.forgotPassword();
                          if (result != null) {
                            showCustomSnackBar(
                                context: context,
                                type: SnackBarType.error,
                                content: result);
                          } else {
                            showCustomSnackBar(
                              context: context,
                              type: SnackBarType.success,
                              content:
                                  'An email has been sent to your address for verification. Please check your inbox.',
                            );
                          }
                        }
                      },
                      child: value.isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : null);
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
                        color: themeProvider.textColor,
                        size: 11,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}