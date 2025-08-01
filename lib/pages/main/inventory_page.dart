import 'package:fixero/components/bars/fixero_bottomappbar.dart';
import 'package:fixero/components/bars/fixero_mainappbar.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  static const routeName = '/inventory';

  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int stockAlertCount = 15;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: FixeroMainAppBar(
          title: "Inventory",
          searchHints: ["Spare Parts", "Tools"],
          searchTerms: [
            "Oil Change",
            "Tire Rotation",
            "Battery Check",
            "Brake Inspection",
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: <Widget>[
            // Stock Alerts
            _buildInventoryOptionCard(
              theme: theme,
              icon: Icons.trolley,
              title: "Stock Alerts",
              badgeCount: stockAlertCount,
              onTap: () {
                // Handle Stock Alert tap
              },
            ),

            const SizedBox(height: 10),

            Row(
              spacing: 10.0,
              children: [
                // Issue History
                Expanded(
                  child: _buildInventoryOptionCard(
                    theme: theme,
                    icon: Icons.article,
                    title: "Issued History",
                    onTap: () {
                      // Handle Stock Alert tap
                    },
                  ),
                ),

                // Browse Inventory
                Expanded(
                  child: _buildInventoryOptionCard(
                    theme: theme,
                    icon: Icons.article,
                    title: "Browse Inventory",
                    onTap: () {
                      // Handle Stock Alert tap
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: FixeroBottomAppBar(),
      ),
    );
  }

  Widget _buildInventoryOptionCard({
    required ThemeData theme,
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          if (badgeCount > 0)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.pink, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  '$badgeCount',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          Card(
            color: theme.colorScheme.inversePrimary.withAlpha(70),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Icon
                  Icon(icon, size: 50, color: theme.colorScheme.inversePrimary),
                  const SizedBox(height: 16),
                  // Title
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
