///
/// sergio lisan <sels@venosyd.com>
///
/// venosyd © 2016-2021
///
part of opensyd.logs.screens.login;

///
class _MobileScreen extends StatefulWidget {
  ///
  const _MobileScreen();

  @override
  __MobileScreenState createState() => __MobileScreenState();
}

///
class __MobileScreenState extends State<_MobileScreen> with _Logics {
  ///
  final _loginctrl = TextEditingController();

  ///
  final _passwdctrl = TextEditingController();

  ///
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) => setState(() => _loading = value);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //
          Image.asset('assets/png/logo_white.png', height: 42).Height(42),
          //
          const SizedBox(height: 8),
          //
          RoundedTextField(
            text: 'login',
            controller: _loginctrl,
            inputType: TextInputType.emailAddress,
          ).Sizedbox(width: 256, height: 42),
          //
          RoundedTextField(
            text: 'passwd',
            controller: _passwdctrl,
            obscure: true,
          ).Sizedbox(width: 256, height: 42),
          //
          OpenSyButton(
            text: loading ? 'entrando...' : 'entrar',
            action: () {
              loading = !loading;
              login(context, _loginctrl.text, _passwdctrl.text)
                  .then((_) => loading = !loading);
            },
            background: const Color(0xFF616161),
            foreground: Colors.white,
          ).Sizedbox(width: 196, height: 48),
        ],
      ) //
          .Height(400)
          .Centered()
          .Colored(const Color(0xFF212121));
}
