import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_in_event.dart';
import 'bloc/sign_in_state.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: SafeArea(
          child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
            if (state is SignInErrorState) {
              return Text(state.errorMessage);
            } else {
              return Container();
            }
          }),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: emailController,
            onChanged: (val) {
              BlocProvider.of<SignInBloc>(context).add(SingInTextChangedEvent(
                  emailController.text, passwordController.text));
            },
            decoration: const InputDecoration(
              hintText: "Email Address",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            onChanged: (val) {
              BlocProvider.of<SignInBloc>(context).add(SingInTextChangedEvent(
                  emailController.text, passwordController.text));
            },
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return CupertinoButton(
                  onPressed: (() {
                    if (state is SignInValidState) {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(
                              emailController.text, passwordController.text));
                    }
                  }),
                  color:
                      (state is SignInValidState) ? Colors.blue : Colors.grey,
                  child: const Text("Sign In"));
            },
          )
        ],
      )),
    );
  }
}
