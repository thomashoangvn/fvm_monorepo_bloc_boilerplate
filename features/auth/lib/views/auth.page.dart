// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: avoid-unnecessary-stateful-widgets, prefer-extracting-callbacks, prefer-moving-to-variable

import 'package:deps/design/design.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/reactive_forms.dart';
import 'package:feature_auth/_core/_i18n/auth_i18n_cubit_locale.ext.dart';
import 'package:feature_auth/views/cubits/auth.cubit.dart';
import 'package:feature_auth/views/forms/login.form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AuthPage] is responsible for displaying the login UI and handling user authentication.
/// It uses [ReactiveForms] for handling form controls and validation, and the [AuthCubit] for managing authentication logic.
@RoutePage()
class AuthPage extends StatefulWidget {
  /// Creates a new instance of [AuthPage].
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => $.get<AuthCubit>(),
      child: ReactiveForm(
        formGroup: LoginForm.form,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: $.tr.auth.title.text(style: $.theme.fonts.h1),
          ),
          child: PaddingAll.sm(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                $.tr.auth.header.styled(style: $.theme.fonts.h2.regular),
                PaddingGap.xxs(),
                ReactiveTextField<void>(
                  formControlName: 'username',
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: $.theme.fonts.body1,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: $.theme.colors.blue),
                    ),
                  ),
                ),
                ReactiveTextField<void>(
                  formControlName: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: $.theme.fonts.body1,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: $.theme.colors.blue),
                    ),
                  ),
                ),
                PaddingGap.md(),
                ReactiveFormConsumer(
                  builder: (_, FormGroup form, ___) {
                    final String username = form.control('username').value;
                    final String password = form.control('password').value;

                    return Center(
                      child: CupertinoButton(
                        color: $.theme.colors.blue,
                        child: $.tr.auth.button.login
                            .styled(style: $.theme.fonts.h2.white),
                        onPressed: form.valid
                            ? () => $
                                .get<AuthCubit>()
                                .login(username: username, password: password)
                                .ignore()
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
