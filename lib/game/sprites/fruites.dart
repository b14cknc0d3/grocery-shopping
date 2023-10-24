part of '../../../main.dart';

class Fruit extends SpriteComponent
    with HasGameRef<FruitCatcher>, CollisionCallbacks {
  static const List<String> _fruitPaths = [
    'apple.png',
    'donut.png',
    'grape.png',
    'ice-cream.png',
    'organe.png',
  ];
  bool _isHealthyFood = false;
  bool get isHealthyFood => _isHealthyFood;

  Vector2 velocity = Vector2(0, 0);
  @override
  Future<void> onLoad() async {
    int fruitIndex = Random().nextInt(_fruitPaths.length);
    _isHealthyFood = fruitIndex != 3 && fruitIndex != 1;
    String randomPath = _fruitPaths[fruitIndex];
    sprite = await gameRef.loadSprite(randomPath);
    size = Vector2.all(42);
    add(RectangleHitbox());
    double random = Random().nextInt(gameRef.size.x.toInt() - 20).toDouble();
    position =
        Vector2(random < size.x ? size.x : random, gameRef.size.y * 0.03);
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.y += gameRef.gravity;
    position.y += velocity.y * dt;
    if (position.y > gameRef.size.y - 100) {
      gameRef.remove(this);
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Shopper) {
      removeFromParent();
    }
  }
}
