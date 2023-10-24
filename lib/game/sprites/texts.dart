part of '../../../main.dart';

class ScoreText extends TextComponent with HasGameRef<FruitCatcher> {
  @override
  Future<void> onLoad() async {
    text = "Score: ${gameRef.score}";
    positionType = PositionType.viewport;
    TextPaint textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 8.0,
        color: Colors.black,
        // fontFamily: 'Awesome Font',
      ),
    );
    textRenderer = textPaint;
    anchor = Anchor.topLeft;
    position = Vector2(10, 1);
    scale = Vector2(2.1, 2.1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    text = "Score: ${gameRef.score} Time: ${gameRef.playingTimeString}";
  }
}

// class TimmerText extends TextComponent with HasGameRef<FruitCatcher> {
//   @override
//   Future<void> onLoad() async {
//     text = "Time: ${gameRef.playingTimeString}";
//     positionType = PositionType.viewport;
//     TextPaint textPaint = TextPaint(
//       style: const TextStyle(
//         fontSize: 8.0,
//         color: Colors.black,
//       ),
//     );
//     textRenderer = textPaint;

//     anchor = Anchor.topRight;
//     position = Vector2(gameRef.size.x - 10, 1);
//     scale = Vector2(2.1, 2.1);
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     text = "Time: ${gameRef.playingTimeString}";
//   }
// }

class PlusOneText extends TextComponent with HasGameRef<FruitCatcher> {
  @override
  Future<void> onLoad() async {
    text = "+1";
    positionType = PositionType.viewport;
    TextPaint textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 12.0,
        color: Colors.black,
      ),
    );

    textRenderer = textPaint;
    scale = Vector2(2.1, 2.1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    text = "+1";
  }
}
