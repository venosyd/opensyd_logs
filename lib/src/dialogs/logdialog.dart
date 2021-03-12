///
/// venosyd © 2016-2021
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.logs.dialogs.logdialog;

import 'package:opensyd_providers/opensyd_providers.dart';
import 'package:opensyd_flutter/opensyd_flutter.dart';
import 'package:flutter/material.dart';

///
class LogDialog extends StatelessWidget {
  ///
  const LogDialog(this.log);

  ///
  final Log log;

  @override
  Widget build(BuildContext context) => OpenSyBasicDialog(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        color: color(log.type),
        width: 600,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //
            //
            if (log.title != null && log.title.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //
                  const _Texto('Título', bold: true).Width(80),
                  _Texto(log.title).Padding(horizontal: 12).Expanded(),
                ],
              ).Height(36),
            //
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //
                const _Texto('Timestamp', bold: true).Width(80),
                _Texto(log.timestampDT).Padding(horizontal: 12).Expanded(),
                //
                const _Texto('Escopo', bold: true).Width(80),
                _Texto(log.namespace ?? '').Padding(horizontal: 12).Expanded(),
              ],
            ).Height(36),

            //
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //
                const _Texto('Módulo', bold: true).Width(80),
                _Texto(log.module ?? '').Padding(horizontal: 12).Expanded(),
                //
                const _Texto('Usuário', bold: true).Width(80),
                _Texto(log.user ?? '').Padding(horizontal: 12).Expanded(),
              ],
            ).Height(36),
            //
            //
            const SizedBox(height: 12),
            //
            //
            _Texto(log.details) //
                .Scrollable()
                .Padding(all: 12)
                .Colored(Colors.black.withAlpha(25))
                .Rounded(const BorderRadius.all(Radius.circular(16)))
                .Expanded(),
            //
            //
            const SizedBox(height: 12),
            //
            //
            OpenSyButton(action: () => Navigator.pop(context), text: 'OK')
                .Height(36),
          ],
        ),
      );

  ///
  Color color(int type) {
    switch (type) {
      case 3:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.blue;
    }

    return Colors.grey;
  }
}

///
class _Texto extends StatelessWidget {
  ///
  const _Texto(this.texto, {this.bold = false});

  ///
  final String texto;

  ///
  final bool bold;

  @override
  Widget build(BuildContext context) => SelectableText(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      );
}
