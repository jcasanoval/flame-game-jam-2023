import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class LogHud extends StatelessWidget {
  const LogHud({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < InventoryState.inventorySize; i++)
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                      Assets.images.log.path,
                      width: 32,
                      height: 32,
                      color:
                          i < state.logs ? null : Colors.white.withOpacity(0.5),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
