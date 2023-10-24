part of '../../../main.dart';

class ScoreText extends TextComponent with HasGameRef<FruitCatcher> {
  @override
  Future<void> onLoad() async {
    positionType = PositionType.viewport;
    textRenderer = TextPaint().copyWith((p0) => p0.copyWith(fontSize: 8));
    position = Vector2(10, 1);
    scale = Vector2(2.1, 2.1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    text =
        '''Score: ${gameRef.lastScore.score} ${' ' * (gameRef.size.x - 380).toInt()} Time: ${gameRef.playingTimeString}''';
  }
}

class PlusOneText extends TextComponent with HasGameRef<FruitCatcher> {
  @override
  Future<void> onLoad() async {
    text = '+1';
    positionType = PositionType.viewport;
    textRenderer = TextPaint().copyWith((p0) => p0.copyWith(fontSize: 10));
    scale = Vector2(2.1, 2.1);
  }
}
