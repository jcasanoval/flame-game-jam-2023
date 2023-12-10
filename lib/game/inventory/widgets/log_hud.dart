import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_jam_2024/game/game.dart';

class LogHud extends StatelessWidget {
  const LogHud({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            final logs = state.logs;
            final isFull = state.isFull;

            return Text(
              '$logs',
              style: TextStyle(
                color: isFull ? Colors.red : Colors.white,
                fontSize: 24,
              ),
            );
          },
        ),
      ),
    );
  }
}
