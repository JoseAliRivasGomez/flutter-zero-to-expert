import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CounterBloc(),
        child: const _BlockCounterView());
  }
}

class _BlockCounterView extends StatelessWidget {
  const _BlockCounterView();

  void increaseCounterBy(BuildContext context, [int value = 1]) {
    //context.read<CounterBloc>().add(CounterIncreased(value)); //1 way
    context.read<CounterBloc>().increaseBy(value); //2 way
  }

  @override
  Widget build(BuildContext context) {
    //final counterState = context.watch<CounterBloc>().state; //1 way

    return Scaffold(
      appBar: AppBar(
        // title: Text('Bloc Counter ${counterState.transactionCount}'), //1 way
        title: context.select((CounterBloc counterBloc) =>
            Text('Bloc Counter ${counterBloc.state.transactionCount}')), //2 way
        actions: [
          IconButton(
            onPressed: () {
              // context.read<CounterBloc>().add(CounterReset()); //1 way
              context.read<CounterBloc>().reset(); //2way
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Center(
        child: context.select((CounterBloc counterBloc) =>
            Text('Counter value: ${counterBloc.state.counter}')),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => increaseCounterBy(context, 3),
            heroTag: '1',
            child: const Text('+3'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () => increaseCounterBy(context, 2),
            heroTag: '2',
            child: const Text('+2'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () => increaseCounterBy(context, 1),
            heroTag: '3',
            child: const Text('+1'),
          )
        ],
      ),
    );
  }
}
