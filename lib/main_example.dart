///
/// sergio lisan <sels@venosyd.com>
///
/// venosyd ©2016-2020
///
library opensyd.logs.app.example;

import 'opensyd_logs.dart';

///
void main() => const OpensydLogs(
      login_database: '<login_database_name>',
      logs_database: '<logs_database_name>',
      logs_authkey: '<logs_authkey>',
      host: 'http(s)://<host>',
      local_database: 'opensyd_logs',
      app_name: 'Opensyd Logs',
      flavor: 'production',
      isdev: false,
    ).run();
