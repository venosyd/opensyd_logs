///
/// venosyd ©2016-2020
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.logs.screens.login;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:opensyd_flutter/opensyd_flutter.dart';
import 'package:opensyd_providers/opensyd_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../app.dart';

part 'large.dart';
part 'mobile.dart';

///
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: EmptyAppBar(),
          //
          body: ScreenTypeLayout(
            mobile: const _MobileScreen(),
            tablet: const _LargeScreen(),
            desktop: const _LargeScreen(),
          ),
        ),
      );
}

///
mixin _Logics {
  ///
  Future<bool> login(
    BuildContext context,
    String credential,
    String passwd,
  ) async {
    if (!Validate.validateEmail(credential)) {
      OpenSyDialogs.alert(
        context: context,
        message: 'Insira um email válido!',
      );

      return false;
    }

    final login = Providers.of<LoginProvider>(context);

    if (await login.check(credential)) {
      final result = await login.login(
        credential,
        sha256.convert(passwd.codeUnits).toString(),
      );

      if (result == 'SUCCESS') {
        Navigator.popAndPushNamed(context, '/home');
      }
      //
      else {
        OpenSyDialogs.alert(
          context: context,
          message: 'Login ou senha incorretos',
        );
      }

      return true;
    }
    //
    else {
      OpenSyDialogs.alert(
        context: context,
        message: 'Seu acesso aqui não está autorizado',
      );
    }

    return false;
  }
}
