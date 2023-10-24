part of '../../../main.dart';

class GameOverMenu extends StatelessWidget {
  final bool gameOver;
  final FruitCatcher game;
  const GameOverMenu({super.key, required this.game, required this.gameOver});
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black.withAlpha(100),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (gameOver) ...[
                Text("Game Over",
                    style: Theme.of(context).textTheme.titleLarge),
                Text("Your  Best Score : ${game.score} "),
              ],
              ElevatedButton.icon(
                  onPressed: () {
                    gameOver ? game.playAgain() : game.play();
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: Text(gameOver ? "Play Again" : "Play")),
            ],
          ),
        ));
  }
}
