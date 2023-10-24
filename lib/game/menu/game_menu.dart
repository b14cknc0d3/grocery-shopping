// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../../main.dart';

class GameOverMenu extends StatelessWidget {
  final bool gameOver;
  final FruitCatcher game;
  const GameOverMenu({
    required this.gameOver,
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (gameOver) ...[
            Text('Game Over', style: Theme.of(context).textTheme.titleLarge),
            Text('Your  Best Score : ${game.lastScore.score} '),
          ],
          ElevatedButton.icon(
            onPressed: () {
              gameOver ? game.playAgain() : game.play();
            },
            icon: const Icon(Icons.play_arrow),
            label: Text(gameOver ? 'Play Again' : 'Play'),
          ),
        ],
      ),
    );
  }
}
