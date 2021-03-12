///
/// venosyd © 2016-2021
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.logs.home.fragment.logs;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opensyd_flutter/opensyd_flutter.dart';
import 'package:opensyd_providers/opensyd_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../app.dart';
import '../../../../dialogs/_dialogs_.dart';

part 'large.dart';
part 'mobile.dart';

///
class LogsFragment extends StatelessWidget {
  ///
  const LogsFragment(this.namespace, this.type);

  ///
  final Namespace namespace;

  ///
  final int type;

  @override
  Widget build(BuildContext context) => ScreenTypeLayout(
        mobile: _MobileFragment(namespace, type),
        tablet: _LargeFragment(namespace, type),
        desktop: _LargeFragment(namespace, type),
      );
}

///
mixin _Logics {
  ///
  String space(int times) => '\t' * times;

  String _shrink(String value) {
    value ??= '';
    value = value.length > 50 ? '${value.substring(0, 47)}...' : value;

    return value;
  }

  ///
  Future<List<Log>> logs(
    BuildContext context,
    TextEditingController queryctrl,
    String namespace,
    double type,
  ) async {
    final entities = Providers.of<EntitiesRepository>(context);
    var logs = await entities.listByQuery<Log>(<String, dynamic>{
      if (namespace != 'Todos') 'namespace': namespace,
      'type': type,
    });

    final query = (queryctrl.text ?? '').toLowerCase();
    if (query.isNotEmpty)
      logs = logs.where((l) => '$l'.toLowerCase().contains(query)).toList();

    return logs.reversed.toList();
  }

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
