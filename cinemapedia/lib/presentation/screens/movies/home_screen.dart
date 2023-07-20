import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final StatefulNavigationShell childView;
  //final Widget childView; //solo para ShellRoute stateless
  
  //final int pageIndex; //solo para Rutas padre/hijo stateful

  const HomeScreen({super.key, required this.childView});

  // final viewRoutes = const <Widget>[ //solo para Rutas padre/hijo stateful
  //   HomeView(),
  //   CategoriesView(),
  //   FavoritesView(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      // body: IndexedStack( //solo para Rutas padre/hijo stateful
      //   index: pageIndex,
      //   children: viewRoutes,
      // ),
      // bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: pageIndex),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
