///
/// venosyd © 2016-2021
///
/// sergio lisan <sels@venosyd.com>
///
part of opensyd.logs.screens.home;

///
class _LargeScreen extends StatefulWidget {
  ///
  const _LargeScreen();

  @override
  __LargeScreenState createState() => __LargeScreenState();
}

///
class __LargeScreenState extends State<_LargeScreen> with _Logics {
  ///
  int type = 3;

  ///
  Namespace current = _Logics.TODOS;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          //
          Column(
            children: [
              //
              // lista de namespaces
              FutureBuilder<List<Namespace>>(
                future: namespaces(context),
                builder: (_, snap) => snap.hasData
                    ? Row(
                        children: [
                          //
                          OpenSyButton(
                            text: 'Escopos',
                            action: () => showDialog<EscoposDialog>(
                              context: context,
                              builder: (_) => EscoposDialog(
                                () => setState(() {}),
                              ),
                            ),
                          ).Margin(all: 8),
                          //
                          for (final namespace in snap.data)
                            OpenSyButton(
                              text: namespace.name,
                              action: () => setState(
                                () => current = namespace,
                              ),
                              foreground: Colors.white,
                              background: current == namespace
                                  ? const Color(0xFF424242)
                                  : Colors.grey,
                            ).Margin(all: 8),
                        ],
                      ) //
                        .Padding(all: 8)
                        .Scrollable(direction: Axis.horizontal)
                    : Container(),
              ).Height(56),
              //
              // conteudo
              LogsFragment(current, type).Expanded()
            ],
          ) //
              .Colored(Colors.white)
              .Expanded(),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //
              HomeIcon(
                icone: FontAwesomeIcons.carCrash,
                descricao: 'Crashes',
                action: () => setState(() => type = 3),
                selectedcolor: Colors.red,
                selected: type == 3,
              ),
              //
              HomeIcon(
                icone: FontAwesomeIcons.exclamationTriangle,
                descricao: 'Warnings',
                action: () => setState(() => type = 2),
                selectedcolor: Colors.orange,
                selected: type == 2,
              ),
              //
              HomeIcon(
                icone: FontAwesomeIcons.infoCircle,
                descricao: 'Info',
                action: () => setState(() => type = 1),
                selectedcolor: Colors.blue,
                selected: type == 1,
              ),
              //
              HomeIcon(
                icone: FontAwesomeIcons.signOutAlt,
                descricao: 'Sair',
                action: () => OpenSyDialogs.choice(
                  context: context,
                  message: 'Sair do Opensyd Logs?',
                  yesOnPressed: () => logout(context),
                ),
              ),
            ],
          ) //
              .Centered()
              .Sizedbox(width: 500, height: 64),
        ],
      ) //
          .Colored(const Color(0xFF424242))
          .Sizedbox();
}
