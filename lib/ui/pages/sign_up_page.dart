import 'dart:async';
import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:airplane/ui/widgets/custom_text_form_field.dart';
import 'package:airplane/ui/widgets/reuseable_text_auto_complete.dart';
import 'package:airplane/ui/widgets/reuseable_text_field.dart';
import 'package:airplane/ui/widgets/reuseable_text_picker.dart';
import 'package:flutter/material.dart';
import 'package:airplane/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController(text: '');

  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  final TextEditingController hobbyController = TextEditingController(text: '');

  String result = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          "Join us and get\nyour next journey",
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
      submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/bonus',
                (route) => false,
              );
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kRedColor,
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomButton(
              title: "Get Started",
              onPressed: () {
                // print(nameController.text);
                // Navigator.pushNamed(
                //   context,
                //   "/bonus",
                // );
                context.read<AuthCubit>().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      hobby: hobbyController.text,
                    );
              },
            );
          },
        );
      }

      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            CustomTextFormField(
              title: 'Full Name',
              hintText: 'Your full name',
              controller: nameController,
              onChanged: (value) => {},
            ),
            CustomTextFormField(
              title: 'Email Address',
              hintText: 'Your email address',
              controller: emailController,
              onChanged: (value) => {},
            ),
            CustomTextFormField(
              title: 'Password',
              hintText: 'Your password',
              obscureText: true,
              controller: passwordController,
              onChanged: (value) => {},
            ),
            CustomTextFormField(
              title: 'Hobby',
              hintText: 'Your hobby',
              controller: hobbyController,
              onChanged: (value) => {},
            ),
            // ReuseAutoComplete(
            //   label: "AutoComplete",
            //   value: "John",
            //   options: const [
            //     'Angela',
            //     'Ardy',
            //     'Fizfat',
            //     'Dita',
            //     'Rimuru',
            //     'Deny',
            //     'John',
            //     'Roy',
            //   ],
            //   onItemSelected: (e) {
            //     print(e);
            //   },
            // ),
            // ReusePicker(
            //   label: "Picker",
            //   value: "John",
            //   onItemSelected: (e) {
            //     print(e);
            //   },
            //   options: const [
            //     'Angela',
            //     'Ardy',
            //     'Fizfat',
            //     'Dita',
            //     'Rimuru',
            //     'Deny',
            //     'John',
            //     'Roy',
            //   ],
            // ),
            // ReuseTextField(
            //   label: "Text Input",
            //   value: "Joohn",
            //   onChanged: (e) {
            //     result = e;
            //   },
            // ),
            // const SizedBox(
            //   height: 20.0,
            // ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.blueGrey,
            //   ),
            //   onPressed: () {
            //     loading = true;
            //     Timer(
            //       const Duration(seconds: 2),
            //       () {
            //         loading = false;
            //         setState(() {});
            //       },
            //     );
            //     setState(() {});
            //   },
            //   child: const Text("Click"),
            // ),
            const SizedBox(
              height: 20.0,
            ),
            submitButton(),
          ],
        ),
      );
    }

    Widget signInButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-in');
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            top: 50,
            bottom: 73,
          ),
          child: Text(
            "Have an account? Sign In",
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            title(),
            inputSection(),
            signInButton(),
          ],
        ),
      ),
    );
  }
}
