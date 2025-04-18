import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../widgets/drawer.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  bool _generalNotification = true;
  bool _sound = false;
  bool _vibrate = true;

  bool _appUpdates = false;
  bool _billReminder = true;
  bool _promotion = true;
  bool _discountAvailable = false;
  bool _paymentRequest = false;

  bool _newServiceAvailable = false;
  bool _newTipsAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Center(child: Text('Notifications')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Section: Common
            ExpansionTile(
              title: Text('Common'),
              children: [
                SwitchListTile(
                  title: Text('General Notification'),
                  value: _generalNotification,
                  onChanged: (value) {
                    setState(() {
                      _generalNotification = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Sound'),
                  value: _sound,
                  onChanged: (value) {
                    setState(() {
                      _sound = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Vibrate'),
                  value: _vibrate,
                  onChanged: (value) {
                    setState(() {
                      _vibrate = value;
                    });
                  },
                ),
              ],
            ),

            // Section: System & Services Update
            ExpansionTile(
              title: Text('System & Services Update'),
              children: [
                SwitchListTile(
                  title: Text('App updates'),
                  value: _appUpdates,
                  onChanged: (value) {
                    setState(() {
                      _appUpdates = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Bill Reminder'),
                  value: _billReminder,
                  onChanged: (value) {
                    setState(() {
                      _billReminder = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Promotion'),
                  value: _promotion,
                  onChanged: (value) {
                    setState(() {
                      _promotion = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Discount Available'),
                  value: _discountAvailable,
                  onChanged: (value) {
                    setState(() {
                      _discountAvailable = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Payment Request'),
                  value: _paymentRequest,
                  onChanged: (value) {
                    setState(() {
                      _paymentRequest = value;
                    });
                  },
                ),
              ],
            ),

            // Section: Others
            ExpansionTile(
              title: Text('Others'),
              children: [
                SwitchListTile(
                  title: Text('New Service Available'),
                  value: _newServiceAvailable,
                  onChanged: (value) {
                    setState(() {
                      _newServiceAvailable = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('New Tips Available'),
                  value: _newTipsAvailable,
                  onChanged: (value) {
                    setState(() {
                      _newTipsAvailable = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}