import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF10236E),
        title: Text('Wallet'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WalletPendingScreen(),
          WalletHistoryScreen(),
        ],
      ),
    );
  }
}

class WalletPendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          WalletTransactionCard(
            from: 'admin',
            date: '24/03/2024',
            time: '10:30 AM',
            amount: '50 THB',
          ),
        ],
      ),
    );
  }
}

class WalletHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          WalletTransactionCard(
            from: 'admin',
            date: '24/03/2024',
            time: '10:30 AM',
            amount: '50 THB',
          ),
        ],
      ),
    );
  }
}

class WalletTransactionCard extends StatelessWidget {
  final String from;
  final String date;
  final String time;
  final String amount;

  WalletTransactionCard({
    required this.from,
    required this.date,
    required this.time,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFD8E8F6),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_circle,
                      size: 24, color: Color(0xFF10236E)),
                  SizedBox(width: 8),
                  Text('From: $from', style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 8),
              Text('Date: $date', style: TextStyle(color: Colors.black54)),
              Text('Time: $time', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
