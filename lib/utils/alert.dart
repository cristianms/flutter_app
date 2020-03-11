import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

/// Método responsável por emitir alertas
alert(BuildContext context, String msg, {Function callback}) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(appName),
            content: Text(msg),
            actions: <Widget>[
//              FlatButton(
//                child: Text("Cancelar"),
//                onPressed: () {
//                  Navigator.pop(context);
//                  print("Cancelado");
//                },
//              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  print("OK");
                  if (callback != null) {
                    callback();
                  }
                },
              ),
            ],
          ),
        );
      });
}