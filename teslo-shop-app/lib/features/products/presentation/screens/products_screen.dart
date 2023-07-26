import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/products/presentation/widgets/widgets.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final authState = ref.watch(authProvider);

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Productos', key: Key('productsScreenTitle'),),
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        // ],
      ),
      body: const _ProductsView(),
      floatingActionButton: Visibility(
        visible: authState.user!.isAdmin,
        child: FloatingActionButton.extended(
          key: const Key('productsNewProductButton'),
          label: const Text('Nuevo producto'),
          icon: const Icon(Icons.add),
          onPressed: () {
            context.push('/product/new');
          },
        ),
      ),
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref.read(productsProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);
    final authState = ref.watch(authProvider);

    FlutterNativeSplash.remove();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
      child: MasonryGridView.count(
        key: const Key('ProductList'),
        padding: const EdgeInsets.only(bottom: 80),
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: productsState.products.length,
        itemBuilder: (context, index) {
          final product = productsState.products[index];
          return GestureDetector(
              onTap: () {
                if (authState.user!.isAdmin) {
                  context.push('/product/${product.id}');
                }
              },
              child: ProductCard(product: product));
        },
      ),
    );
  }
}
