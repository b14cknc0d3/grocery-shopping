import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Draggable;
import 'game/utils/utils.dart';
part './game/fruit_catcher.dart';
part './game/menu/game_menu.dart';
part './game/sprites/fruites.dart';
part './game/sprites/shopper.dart';
part './game/sprites/texts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final game = FruitCatcher();
    var menu = {
      'menu': ((context, game) => GameOverMenu(game: game, gameOver: false))
    };
    var gameOverMenu = {
      'gameover': (context, game) => GameOverMenu(game: game, gameOver: true)
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Shopping',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SafeArea(
        child: GameWidget<FruitCatcher>(
            loadingBuilder: (_) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            game: game,
            initialActiveOverlays: const ['menu'],
            overlayBuilderMap: {...menu, ...gameOverMenu}),
      ),
    );
  }
}
