import 'package:flutter/material.dart';

class HistorySheet extends StatelessWidget {
  final List<String> history;
  final VoidCallback onClearHistory;
  final Function(String) onSelectHistoryItem;

  const HistorySheet({
    super.key,
    required this.history,
    required this.onClearHistory,
    required this.onSelectHistoryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 16),
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: history.isEmpty ? null : onClearHistory,
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    color: history.isEmpty ? Colors.grey : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // History list
          Expanded(
            child: history.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No calculations yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your calculation history will appear here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[800],
                        margin: EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            history[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'monospace',
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[400],
                            size: 16,
                          ),
                          onTap: () => onSelectHistoryItem(history[index]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}