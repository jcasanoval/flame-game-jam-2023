import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_jam_2024/game/game.dart';

class LogHud extends StatelessWidget {
  const LogHud({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: BlocSelector<InventoryBloc, InventoryState, int>(
          selector: (state) {
            return state.logs;
          },
          builder: (context, logs) {
            return Text(
              '$logs',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            );
          },
        ),
      ),
    );
  }
}
