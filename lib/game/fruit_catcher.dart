part of '../../../main.dart';

class FruitCatcher extends FlameGame with HasCollisionDetection, HasDraggables {
  Shopper shopper = Shopper();
  int get level => lastScore.score ~/ 15;
  int get spawnSec =>
      (2000 - (level * 100)) < 200 ? 200 : (2000 - (level * 100));
  double get gravity => level == 0 ? 1.5 : (1.5 + level / 100);
  void onCollide() {
    lastScore.score++;
    FlameAudio.play('beep.mp3');
    createPlusOneText(shopper.position.x, shopper.position.y);
  }

  Score lastScore = Score.empty();
  double _playingTimeInSec = 0;
  String get playingTimeString => secToMs(_playingTimeInSec.toInt());
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  bool gameOver = false;
  void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('game_loop.mp3');
  }

  void play() {
    FlameAudio.bgm.stop();
    overlays.remove('menu');
    isPlaying.value = true;
    gameOver = false;
  }

  void reset() {
    lastScore = Score(
      timePassed: _playingTimeInSec.toInt(),
      level: level,
      score: 0,
    );
    gameOver = true;
  }

  void playAgain() {
    overlays.remove('gameover');

    _playingTimeInSec = 0;
    gameOver = false;
    isPlaying.value = true;
  }

  void gameOverF() {
    FlameAudio.play('game_over.mp3');
    gameOver = true;
    isPlaying.value = false;
    for (final element in children) {
      if (element is Fruit) {
        remove(element);
      }
    }
    overlays.add('gameover');
    startBgmMusic();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    addAll([shopper, ScoreText()]);
    isPlaying.addListener(() async {
      while (isPlaying.value && !gameOver) {
        add(Fruit());
        await Future.delayed(Duration(milliseconds: spawnSec));
      }
    });
    startBgmMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameOver && isPlaying.value) {
      _playingTimeInSec += dt;
    }
  }

  void createPlusOneText(double x, double y) {
    final text = PlusOneText()..position = Vector2(x, y);
    add(text);
    Future.delayed(const Duration(seconds: 1), () => remove(text));
  }

  @override
  Color backgroundColor() => const Color(0xffF5EADE);
}

class Score {
  late int timePassed;
  late int level;
  late int score;
  Score({
    required this.timePassed,
    required this.level,
    required this.score,
  });
  factory Score.empty() {
    return Score(timePassed: 0, level: 0, score: 0);
  }
}
