import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_game/game/utils/utils.dart';
import 'package:flutter/material.dart' hide Draggable;

part './game/fruit_catcher.dart';
part './game/menu/game_menu.dart';
part './game/sprites/fruites.dart';
part './game/sprites/shopper.dart';
part './game/sprites/texts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final game = FruitCatcher();
  final menu = {
    'menu': (context, game) =>
        GameOverMenu(game: game as FruitCatcher, gameOver: false),
    'gameover': (context, game) =>
        GameOverMenu(game: game as FruitCatcher, gameOver: true),
  };

  runApp(
    SafeArea(
      child: GameWidget<FruitCatcher>(
        game: game,
        initialActiveOverlays: const ['menu'],
        overlayBuilderMap: {
          ...menu,
        },
      ),
    ),
  );
}
