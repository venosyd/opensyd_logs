///
/// venosyd © 2016-2021
///
/// sergio lisan <sels@venosyd.com>
///
part of opensyd.logs.home.fragment.logs;

///
class _LargeFragment extends StatefulWidget {
  ///
  const _LargeFragment(this.namespace, this.type);

  ///
  final Namespace namespace;

  ///
  final int type;

  @override
  __LargeFragmentState createState() => __LargeFragmentState();
}

///
class __LargeFragmentState extends State<_LargeFragment> with _Logics {
  ///
  final TextEditingController _queryctrl = TextEditingController();

  ///
  String get namespace => widget.namespace.name;

  ///
  double get type => widget.type.toDouble();

  @override
  Widget build(BuildContext context) => FutureBuilder<List<Log>>(
        future: logs(context, _queryctrl, namespace, type),
        builder: (_, snap) => snap.hasData
            ? Column(
                children: [
                  if (snap.data.isNotEmpty)
                    OpenSyTable(
                      flex: const [3, 3, 3, 3, 3, 1],
                      headers: const [
                        OpenSyLabel('Timestamp', color: Colors.grey),
                        OpenSyLabel('Escopo', color: Colors.grey),
                        OpenSyLabel('Módulo', color: Colors.grey),
                        OpenSyLabel('Título', color: Colors.grey),
                        OpenSyLabel('Usuário', color: Colors.grey),
                        OpenSyLabel('Detalhes', color: Colors.grey),
                      ],
                      rows: snap.data
                          .map((log) => [
                                //
                                OpenSyLabel(
                                  log.timestamp.datetime.readabledatetime,
                                ),
                                //
                                OpenSyLabel(log.namespace ?? ''),
                                //
                                OpenSyLabel(log.module ?? ''),
                                //
                                OpenSyLabel(log.title ?? ''),
                                //
                                OpenSyLabel(log.user ?? ''),
                                //
                                OpenSyLabel(_shrink(log.details)),
                                //
                                OpenSyIconButton(
                                  icon: FontAwesomeIcons.infoCircle,
                                  action: () => showDialog<LogDialog>(
                                    context: context,
                                    builder: (_) => LogDialog(log),
                                  ),
                                ),
                              ])
                          .toList(),
                    ).Expanded(),

                  //
                  if (snap.data.isNotEmpty)
                    RoundedTextField(
                      text: 'Busca',
                      controller: _queryctrl,
                      onchanged: (_) => setState(() {}),
                    ) //
                        .Padding(all: 16)
                        .Width(400)
                        .Centered()
                        .Height(72),

                  //
                  if (snap.data.isEmpty)
                    const Text(
                      'Nenhum log nessa categoria ainda',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'Open Sans Light',
                      ),
                    ) //
                        .Centered()
                        .Height(MediaQuery.of(context).size.height - 120),
                ],
              )
            : const CircularLoader(),
      );
}
