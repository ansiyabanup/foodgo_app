import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddTap;

  CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddTap,
  });
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CurvedNavigationBar(
            key: _bottomNavigationKey,
            items: [
              Image.asset('assets/images/home.png', width: 30, height: 30),
              Image.asset('assets/images/user.png', width: 30, height: 30),
              Image.asset('assets/images/add.png', width: 30, height: 30),
              Image.asset('assets/images/comment.png', width: 30, height: 30),
              Image.asset('assets/images/favourite.png', width: 30, height: 30),
            ],
            onTap: (index) {
              onTap(index);
            },
            height: 60,
            color: const Color(0xFFFFC529),
            buttonBackgroundColor: const Color(0xFFFFC529),
            backgroundColor: const Color.fromARGB(0, 10, 1, 1),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
          ),

          Positioned(
            top: -18, 
            left: MediaQuery.of(context).size.width / 2 - 30, // centered
            child: IgnorePointer(
          
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
