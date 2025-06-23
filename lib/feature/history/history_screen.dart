import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_vault/feature/history/provider/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              TabBar(
                tabs: const [Tab(text: 'Scanned'), Tab(text: 'Generated')],
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Theme.of(context).colorScheme.primary,
                dividerColor: Colors.grey,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _HistoryList(isGenerated: false),
                    _HistoryList(isGenerated: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryList extends StatelessWidget {
  final bool isGenerated;

  const _HistoryList({required this.isGenerated});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HistoryProvider>(context);
    final history = isGenerated ? provider.generated : provider.scanned;
    if (history.isEmpty) {
      return const Center(child: Text("No history found."));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (_, index) {
        final item = history[index];
        return ListTile(
          leading: Icon(
            isGenerated ? Icons.qr_code : Icons.qr_code_scanner,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(item.data),
          subtitle: Text(item.timeStamp.toLocal().toString()),
        );
      },
    );
  }
}
