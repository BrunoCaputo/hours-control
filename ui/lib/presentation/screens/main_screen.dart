import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/presentation/components/action_button.dart';
import 'package:hours_control/presentation/themes/grayscale_color_theme.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/logo.svg",
                  width: 50,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Interface para lançamento de horas",
                  style: (platformStore.isMobile
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context).textTheme.bodyMedium)
                      ?.copyWith(
                    color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray3,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "PD Hours",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ActionButton(
                      text: "Lançar horas",
                      onPressed: () {
                        print("PRESSED");
                      },
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Squads",
            ),
            Tab(
              text: "Usuários",
            ),
          ],
        ),
      ),
      body: Container(
        color: Theme.of(context).extension<GrayscaleColorTheme>()?.grayBody,
        child: TabBarView(
          controller: _tabController,
          children: [
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
