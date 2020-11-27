///
/// venosyd ©2016-2020
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.logs.dialogs.escopos;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opensyd_flutter/opensyd_flutter.dart';
import 'package:opensyd_providers/opensyd_providers.dart';

import '../app.dart';

///
class EscoposDialog extends StatefulWidget {
  ///
  const EscoposDialog(this.refresh);

  ///
  final void Function() refresh;

  @override
  _EscoposDialogState createState() => _EscoposDialogState();
}

///
class _EscoposDialogState extends State<EscoposDialog> {
  ///
  EntitiesRepository get entities => Providers.of<EntitiesRepository>(context);

  ///
  final _newscopectrl = TextEditingController();

  @override
  Widget build(BuildContext context) => SobreposeDialog(
        padding: const EdgeInsets.all(16),
        width: 500,
        height: 400,
        child: Column(
          children: [
            //
            //
            Row(
              children: [
                //
                RoundedTextField(
                  text: 'Adicione um novo escopo',
                  controller: _newscopectrl,
                ).Expanded(),
                //
                const FaIcon(
                  FontAwesomeIcons.plusCircle,
                  color: Colors.grey,
                  size: 16,
                ) //
                    .Ripplefy(action: _add)
                    .Centered()
                    .Width(48),
              ],
            ) //
                .Centered()
                .Height(56),
            //
            //
            FutureBuilder<List<Namespace>>(
              future: entities.all<Namespace>(),
              builder: (_, snap) => snap.hasData
                  //
                  ? ListView.builder(
                      itemCount: snap.data.length,
                      itemBuilder: (_, index) => Text(snap.data[index].name)
                          .Padding(all: 12)
                          .Ripplefy(action: () => _remove(_, snap.data[index])),
                    )
                  //
                  : Container(),
            ).Expanded(),
          ],
        ),
      );

  ///
  Future<void> _add() async {
    if (_newscopectrl.text.isNotEmpty)
      await entities.save<Namespace>(Namespace()..name = _newscopectrl.text);

    (widget.refresh ?? () {})();
    setState(() {});
  }

  ///
  void _remove(BuildContext ctx, Namespace namespace) => OpenSyDialogs.choice(
        context: ctx,
        message: 'Deseja remover este Escopo?',
        yesOnPressed: () async {
          await entities.delete<Namespace>(namespace);
          (widget.refresh ?? () {})();
          setState(() {});
        },
      );
}
