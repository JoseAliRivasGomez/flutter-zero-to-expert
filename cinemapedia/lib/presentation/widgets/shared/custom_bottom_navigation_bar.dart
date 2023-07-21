import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  // final int currentIndex; //solo para Rutas padre/hijo stateful

  const CustomBottomNavigationBar({
    super.key,
    // required this.currentIndex //solo para Rutas padre/hijo stateful
  });

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    switch (location) {
      case '/':
        return 0;
      case '/popular':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        // context.go('/home/0'); //solo para Rutas padre/hijo stateful
        break;
      case 1:
        context.go('/popular');
        // context.go('/home/1'); //solo para Rutas padre/hijo stateful
        break;
      case 2:
        context.go('/favorites');
        // context.go('/home/2'); //solo para Rutas padre/hijo stateful
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      selectedItemColor: colors.primary,
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      // currentIndex: currentIndex, //solo para Rutas padre/hijo stateful
      onTap: (value) => onItemTapped(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumbs_up_down_outlined),
          label: 'Populares',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
