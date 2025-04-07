import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: const ExampleScreen(),
    );
  }
}

class ChatItem {
  final String title;
  final String date;

  ChatItem({required this.title, required this.date});
}

class ChatSidebar extends StatefulWidget {
  final Function()? onClose;

  const ChatSidebar({Key? key, this.onClose}) : super(key: key);

  @override
  State<ChatSidebar> createState() => _ChatSidebarState();
}

class _ChatSidebarState extends State<ChatSidebar> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedItemIndex;

  // Chat data organized by date sections
  final Map<String, List<ChatItem>> _chatsByDate = {
    'Сегодня': [
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: 'Сегодня'),
      ChatItem(
          title: 'Бюджетная смета на ремонт полоооооооо...', date: 'Сегодня'),
    ],
    'Вчера': [
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: 'Вчера'),
      ChatItem(
          title: 'Бюджетная смета на ремонт полоооооооо...', date: 'Вчера'),
    ],
    '02.04.25': [
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: '02.04.25'),
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: '02.04.25'),
      ChatItem(
          title: 'Бюджетная смета на ремонт полоооооооо...', date: '02.04.25'),
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: '02.04.25'),
      ChatItem(
          title: 'Бюджетная смета на ремонт полоооооооо...', date: '02.04.25'),
    ],
    '01.04.25': [
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: '01.04.25'),
      ChatItem(
          title: 'Бюджетная смета на ремонт полоооооооо...', date: '01.04.25'),
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: '01.04.25'),
      ChatItem(
          title: 'Бюджетная смета на ремонт полоооооооо...', date: '01.04.25'),
      ChatItem(title: 'Бюджетная смета на ремонт полов', date: '01.04.25'),
    ],
  };

  // To keep track of selected item globally
  String? _selectedItemTitle;
  String? _selectedItemDate;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _deleteChat(String title, String date) {
    setState(() {
      _chatsByDate[date]?.removeWhere((item) => item.title == title);

      // If the section becomes empty, you might want to remove it
      if (_chatsByDate[date]?.isEmpty == true) {
        _chatsByDate.remove(date);
      }

      _selectedItemIndex = null;
      _selectedItemTitle = null;
      _selectedItemDate = null;
    });
  }

  void _showDeleteConfirmation(
      BuildContext context, String title, String date) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        title: Text(
          'Удаление',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Вы действительно хотите удалить?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Подтвердите удаление',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Нет'),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _deleteChat(title, date);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Да'),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.white,
      child: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                suffixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),

          // Chat history title
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
              child: Text(
                'История чатов',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Chat list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _chatsByDate.length,
              itemBuilder: (context, sectionIndex) {
                String date = _chatsByDate.keys.elementAt(sectionIndex);
                List<ChatItem> chats = _chatsByDate[date] ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateHeader(date),
                    ...List.generate(chats.length, (itemIndex) {
                      final globalIndex =
                          _getGlobalIndex(sectionIndex, itemIndex);
                      final isSelected =
                          _selectedItemTitle == chats[itemIndex].title &&
                              _selectedItemDate == chats[itemIndex].date;

                      return _buildChatItem(chats[itemIndex].title,
                          chats[itemIndex].date, isSelected, globalIndex);
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getGlobalIndex(int sectionIndex, int itemIndex) {
    int count = 0;
    for (int i = 0; i < sectionIndex; i++) {
      count += _chatsByDate[_chatsByDate.keys.elementAt(i)]!.length;
    }
    return count + itemIndex;
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 5.0),
      child: Text(
        date,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildChatItem(String title, String date, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        // Handle chat item tap
      },
      onLongPress: () {
        setState(() {
          _selectedItemIndex = index;
          _selectedItemTitle = title;
          _selectedItemDate = date;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        color: isSelected ? Color(0xFFF8E0EC) : Colors.transparent,
        child: Stack(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            if (isSelected)
              Positioned(
                right: 0,
                top: -8,
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _showDeleteConfirmation(context, title, date);
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.delete, color: Colors.red, size: 18),
                            SizedBox(width: 4),
                            Text(
                              'Удалить',
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Row(
        children: [
          // Left sidebar
          ChatSidebar(),

          // Main content
          Expanded(
            child: Center(
              child: Text(
                'Main Content Area',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
