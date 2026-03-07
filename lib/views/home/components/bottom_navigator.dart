// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:words625/gen/assets.gen.dart';

class BottomNavigator extends StatelessWidget {
  final Function(int) onPress;
  final int currentIndex;

  const BottomNavigator({
    required this.currentIndex,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        unselectedItemColor: Colors.grey.shade400,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/learn-off.png',
              height: 36,
            ),
            activeIcon: Image.asset(
              'assets/images/learn-on.png',
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.images.kannadaAlphabet.path,
              height: 36,
            ),
            activeIcon: Image.asset(
              Assets.images.kannadaAlphabet.path,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/person-off.png',
              height: 36,
            ),
            activeIcon: Image.asset(
              'assets/images/person-on.png',
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/shield-off.png',
              color: Colors.grey,
              height: 36,
            ),
            activeIcon: Image.asset(
              'assets/images/shield-on.png',
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/shop-off.png',
              height: 36,
            ),
            activeIcon: Image.asset(
              'assets/images/shop-on.png',
              height: 36,
            ),
            label: '',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF1F727E),
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: onPress,
      ),
    );
  }
}
