part of '../../../main.dart';

class FruitCatcher extends FlameGame with HasCollisionDetection, HasDraggables {
  Shopper shopper = Shopper();
  int get level => (_score ~/ 15).round();
  int get spawnSec =>
      (2000 - (level * 100)) < 200 ? 200 : (2000 - (level * 100));
  double get gravity => level == 0 ? 1.5 : (1.5 + level / 100);
  int _score = 0;
  onCollide() {
    _score++;
    FlameAudio.play('beep.mp3');
    createPlusOnetext(shopper.position.x, shopper.position.y);
  }

  Score _lastScore = Score.empty();
  Score get lastScore => _lastScore;
  double _playingTimeInSec = 0;
  String get playingTimeString => secToMs(_playingTimeInSec.toInt());
  int get score => _score;
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  bool gameOver = false;

  void startBgmMusic() {
    if (!kIsWeb) {
      FlameAudio.bgm.initialize();
      FlameAudio.bgm.play('game_loop.mp3');
    }
  }

  play() {
    FlameAudio.bgm.stop();
    overlays.remove('menu');
    isPlaying.value = true;
    gameOver = false;
  }

  reset() {
    _lastScore = Score(
        timePassed: _playingTimeInSec.toInt(), level: level, score: score);
    _score = 0;
    gameOver = true;
  }

  playAgain() {
    overlays.remove('gameover');
    _score = 0;
    _playingTimeInSec = 0;
    gameOver = false;
    isPlaying.value = true;
  }

  gameOverF() {
    FlameAudio.play('game_over.mp3');
    gameOver = true;
    isPlaying.value = false;
    for (var element in children) {
      if (element is Fruit) remove(element);
    }
    overlays.add('gameover');
    startBgmMusic();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(shopper);
    isPlaying.addListener(() => spawnItems());
    addAll([ScoreText()]);
    startBgmMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameOver && isPlaying.value) {
      _playingTimeInSec += dt;
    }
  }

  void createPlusOnetext(x, y) {
    var text = PlusOneText()..position = Vector2(x, y);
    add(text);
    Future.delayed(const Duration(seconds: 1), () => remove(text));
  }

  void spawnItems() async {
    while (isPlaying.value && !gameOver) {
      add(Fruit());
      await Future.delayed(Duration(milliseconds: spawnSec));
    }
  }

  @override
  backgroundColor() => const Color(0xffF5EADE);
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
