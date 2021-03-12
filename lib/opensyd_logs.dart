///
/// sergio lisan <sels@venosyd.com>
///
/// venosyd © 2016-2021
///
library opensyd.logs;

import 'package:flutter/material.dart';
import 'package:opensyd_providers/opensyd_providers.dart';

import 'src/app.dart';

///
class OpensydLogs {
  ///
  const OpensydLogs({
    @required this.login_database,
    @required this.logs_database,
    @required this.logs_authkey,
    @required this.host,
    this.local_database = 'opensyd-logs',
    this.app_name = 'Opensyd Logs',
    this.flavor = 'production',
    this.isdev = false,
  });

  ///
  final String app_name;

  ///
  final String flavor;

  ///
  final String login_database;

  ///
  final String logs_database;

  ///
  final String logs_authkey;

  ///
  final String local_database;

  ///
  final String host;

  ///
  final bool isdev;

  ///
  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    final localdb = HybridDatabase(local_database);

    final login = LoginProvider(
      host,
      localdb,
      login_database,
    );

    if (!await login.islogged) {
      // generic token only for basic operations
      login.token = 'c394637108ae3fb38e5c2acc8dd673521'
          '906f7942518a21658e3a0243d94475d';
    }

    final entities = EntitiesRepository.build(
      authkey: logs_authkey,
      localdb: localdb,
      login: login,
      fromjson: opensydEntitiesMap,
      collectionmap: opensydCollectionMap,
    );

    final logs = LogsProvider.build(isdev, login, '$app_name App');

    runApp(AppConfig(
      appName: app_name,
      flavorName: flavor,
      login: login,
      logs: logs,
      entities: entities,
      localstorage: localdb,
      isdev: isdev,
      child: OpensydLogsApp(),
    ));
  }
}
