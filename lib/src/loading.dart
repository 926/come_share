import 'package:come_share/src/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/stores/app.dart';
//import 'package:come_share/src/stores/cart.dart';
import 'package:flutter/widgets.dart';
import 'package:come_share/src/stores/flocks.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    final appStore = Provider.of<AppStore>(context, listen: false);
    final flocksStore = Provider.of<FlocksStore>(context, listen: false);

    when(
      (_) => !appStore.initialLoading,
      () {
        if (flocksStore.flocks.length > 1) {
          //Navigator.of(context).pushReplacementNamed(SellRoute.routePath);
        } else {
          //initPlatformState();
          Navigator.of(context).pushReplacementNamed(MyHomePage.routePath);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
