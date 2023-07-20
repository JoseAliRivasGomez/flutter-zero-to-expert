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
      case '/categories':
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
        context.go('/categories');
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
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
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
          icon: Icon(Icons.label_outline),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritas',
        ),
      ],
    );
  }
}
