import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar';
  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(
      content: const Text('Hola'),
      action: SnackBarAction(label: 'Ok', onPressed: () {}),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Estas seguro?'),
        content: const Text(
            'Ex cupidatat anim incididunt consectetur do laborum tempor sint. Pariatur anim irure fugiat reprehenderit non cillum quis qui ex irure sit. Mollit sunt voluptate voluptate nulla dolore non amet ipsum.'),
        actions: [
          TextButton(
              onPressed: () => context.pop(), child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => context.pop(), child: const Text('Aceptar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Dialogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () {
                  showAboutDialog(context: context, children: [
                    const Text(
                        'Commodo aute incididunt ea officia tempor ut culpa exercitation. Labore irure mollit consectetur irure deserunt mollit. In ipsum proident do laborum. Velit non eu veniam incididunt ut. Dolor laboris id veniam commodo et qui in ad adipisicing do proident eu tempor. Reprehenderit eiusmod veniam ipsum proident cillum quis. Non adipisicing anim veniam proident ex ullamco exercitation.')
                  ]);
                },
                child: const Text('Licencias usadas')),
            FilledButton(
                onPressed: () => openDialog(context),
                child: const Text('Mostrar dialogo'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showCustomSnackbar(context),
          icon: const Icon(Icons.remove_red_eye_outlined),
          label: const Text('Mostrar Snackbar')),
    );
  }
}
