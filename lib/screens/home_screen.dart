
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nsu_financial_app/widgets/appBar_widget.dart';
import 'package:nsu_financial_app/widgets/bottom_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/home_screen_menu_widget.dart';


class HomeScreen extends ConsumerWidget {



  @override
  Widget build(BuildContext context, ScopedReader watch) {

        return Scaffold(
        appBar: BaseAppBar(),
        bottomNavigationBar: BottomBaseBar(),
        body: SafeArea(
              child: HomeScreenWidget()),
        );

  }
}
