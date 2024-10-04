import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hours_control/presentation/components/action_button.dart';
import 'package:hours_control/presentation/themes/grayscale_color_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray3,
                      ),
                )
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
                    const ActionButton(),
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
            )
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
