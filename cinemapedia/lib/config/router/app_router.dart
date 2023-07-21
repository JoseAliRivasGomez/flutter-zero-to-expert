import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  // initialLocation: '/home/0', //solo para Rutas padre/hijo stateful
  routes: [
    //StatefulShellRoute
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(childView: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/',
              builder: (context, state) {
                return const HomeView();
              },
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';
                    return MovieScreen(movieId: movieId);
                  },
                ),
              ]),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/favorites',
            builder: (context, state) {
              return const FavoritesView();
            },
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/popular',
            builder: (context, state) {
              return const PopularView();
            },
          ),
        ]),
      ],
    ),

    //ShellRoute stateless
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return HomeScreen(childView: child);
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       builder: (context, state) {
    //         return const HomeView();
    //       },
    //       routes: [
    //         GoRoute(
    //           path: 'movie/:id',
    //           name: MovieScreen.name,
    //           builder: (context, state) {
    //             final movieId = state.pathParameters['id'] ?? 'no-id';
    //             return MovieScreen(movieId: movieId);
    //           },
    //         ),
    //       ]
    //     ),
    //     GoRoute(
    //       path: '/favorites',
    //       builder: (context, state) {
    //         return const FavoritesView();
    //       },
    //     ),
    //     GoRoute(
    //       path: '/categories',
    //       builder: (context, state) {
    //         return const CategoriesView();
    //       },
    //     ),
    //   ],
    // ),

    //Rutas padre/hijo stateful
    // GoRoute(
    //   path: '/home/:page',
    //   name: HomeScreen.name,
    //   builder: (context, state) {
    //     final pageIndex = state.pathParameters['page'] ?? '0';
    //     return HomeScreen(pageIndex: int.parse(pageIndex));
    //   },
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //   ],
    // ),
    // GoRoute(path: '/', redirect: (_, __) => '/home/0'),
  ],
);
