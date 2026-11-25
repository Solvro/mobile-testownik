import 'package:flutter/material.dart';

import '../../../features/account/presentation/screens/account_screen.dart';
import '../../../features/grades/presentation/screens/grades_screen.dart';
import '../../../features/quizzes/data/quizzes_mock_data.dart';
import '../../../features/quizzes/presentation/screens/folder_screen.dart';
import '../../../features/quizzes/presentation/screens/quizzes_screen.dart';
import '../widgets/app_bottom_nav_bar.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({
    super.key,
    this.initialIndex = 0,
  });

  final int initialIndex;

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _currentIndex = widget.initialIndex;
  MockFolderItem? _openedFolder;

  void _onSelectTab(int index) {
    setState(() {
      if (index == 0 && _currentIndex == 0 && _openedFolder != null) {
        _openedFolder = null;
      } else {
        _currentIndex = index;
      }
    });
  }

  void _openFolder(MockFolderItem folder) {
    setState(() {
      _openedFolder = folder;
    });
  }

  void _closeFolder() {
    setState(() {
      _openedFolder = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = !(_currentIndex == 0 && _openedFolder != null);

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _currentIndex == 0 && _openedFolder != null) {
          _closeFolder();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _openedFolder != null
                ? FolderScreen(
                    folder: _openedFolder!,
                    onBack: _closeFolder,
                  )
                : QuizzesScreen(
                    onOpenFolder: _openFolder,
                  ),
            const GradesScreen(),
            const AccountScreen(),
          ],
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: _currentIndex,
          onSelect: _onSelectTab,
        ),
      ),
    );
  }
}
