
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nsu_financial_app/widgets/base_widgets/top_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/base_widgets/bottom_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/home_widgets/home_screen_menu_widget.dart';


class HomeScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {

        return Scaffold(
        appBar: TopAppBar(),
        bottomNavigationBar: BottomBaseBar(),
        body: SafeArea(
              child: HomeScreenWidget()),
        );

  }
}
