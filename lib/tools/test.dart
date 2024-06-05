import 'package:flutter/material.dart';

class AmazingTabBarView extends StatefulWidget {
  final Duration? duration;
  const AmazingTabBarView({
    this.duration,
    super.key,
  });

  @override
  State<AmazingTabBarView> createState() => _AmazingTabBarViewState();
}

class _AmazingTabBarViewState extends State<AmazingTabBarView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(
      animationDuration: widget.duration ?? const Duration(milliseconds: 400),
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    return Material(
      child: Column(
        children: [
          Expanded(
            child: TabBar(
              controller: tabController,
              unselectedLabelColor: Colors.grey.shade600,
              labelColor: Colors.blue,
              labelStyle: TextStyle(fontSize: 20),
              unselectedLabelStyle: TextStyle(fontSize: 15),
              tabs: [
                Tab(
                  child: Text('Details'),
                ),
                Tab(
                  child: Text('Edit'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: TabBarView(
              controller: tabController,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      color: Colors.blue,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
