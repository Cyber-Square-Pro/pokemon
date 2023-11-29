import 'dart:async';

import 'package:app/modules/no_internet/no_internet_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  StreamController<ConnectivityResult> connectivityController =
      StreamController<ConnectivityResult>();

  Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  void initConnectivity() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    connectivityController.add(result);

    subscription = connectivity.onConnectivityChanged.listen((result) {
      connectivityController.add(result);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    connectivityController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: connectivityController.stream,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data == ConnectivityResult.none) {
          // No internet connection
          return const Directionality(textDirection: TextDirection.ltr, child: NoInternetPage());
        } else {
          // Internet connection available, navigate to the child route
          return widget.child;
        }
      },
    );
  }
}
