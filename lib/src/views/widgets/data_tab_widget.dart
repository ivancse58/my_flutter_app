import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';

class DataTabWidget extends StatefulWidget {
  final GridView listView;
  final GridView gridView;

  DataTabWidget(this.listView, this.gridView);

  @override
  _DataTabWidgetState createState() => _DataTabWidgetState();
}

class _DataTabWidgetState extends State<DataTabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.lightBlue,
                ),
                labelColor: Colors.white,
                labelStyle: Theme.of(context).textTheme.headline6,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.view_list, size: 24),
                        const SizedBox(width: 4),
                        Text(AppMessages.labelList),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.grid_4x4, size: 24),
                        const SizedBox(width: 4),
                        Text(AppMessages.labelGrid),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                widget.listView,
                widget.gridView,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
