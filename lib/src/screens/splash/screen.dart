///
/// sergio lisan <sels@venosyd.com>
///
/// venosyd ©2016-2020
///
library opensyd.logs.screens.splash;

import 'package:flutter/material.dart';
import 'package:opensyd_flutter/opensyd_flutter.dart';
import 'package:opensyd_providers/opensyd_providers.dart';

import '../../app.dart';
import '../_screens_.dart';

///
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
        future: _islogged(context),
        //
        builder: (_, snap) => snap.hasData
            ? (snap.data ? HomeScreen() : LoginScreen())
            : const CircularLoader(),
      );

  ///
  Future<bool> _islogged(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    return await Providers.of<LoginProvider>(context).islogged;
  }
}
