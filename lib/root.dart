import 'package:docki/features/dashboard/app/pages/movies_page.dart';
import 'package:docki/features/discover/app/pages/discover.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'features/dashboard/app/pages/favorites_page.dart';
import 'features/dashboard/app/pages/search_page.dart';
import 'features/notification/app/pages/notification_page.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snap) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    DashboardPage(),
                    DiscoverPage(),
                    SearchPage(),
                    FavoritesPage(),
                    NotificationPage(),
                  ],
                ),
              ),
              SafeArea(
                child: TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(
                      child: Icon(
                        FontAwesomeIcons.house,
                        color: Colors.grey,
                      ),
                    ),
                    Tab(
                      child: Icon(
                        FontAwesomeIcons.compass,
                        color: Colors.grey,
                      ),
                    ),
                    Tab(
                      child: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey,
                      ),
                    ),
                    Tab(
                      child: Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.grey,
                      ),
                    ),
                    Tab(
                      child: Icon(
                        FontAwesomeIcons.bell,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
