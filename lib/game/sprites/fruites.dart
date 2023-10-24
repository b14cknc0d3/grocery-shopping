part of '../../../main.dart';

class Fruit extends SpriteComponent
    with HasGameRef<FruitCatcher>, CollisionCallbacks {
  static const _fruitPaths = [
    'apple.png',
    'donut.png',
    'grape.png',
    'ice-cream.png',
    'organe.png',
  ];
  bool isHealthyFood = false;
  Vector2 velocity = Vector2(0, 0);
  @override
  Future<void> onLoad() async {
    final fruitIndex = Random().nextInt(_fruitPaths.length);
    isHealthyFood = fruitIndex != 3 && fruitIndex != 1;
    final randomPath = _fruitPaths[fruitIndex];
    sprite = await gameRef.loadSprite(randomPath);
    size = Vector2.all(42);
    add(RectangleHitbox());
    final random = Random().nextInt(gameRef.size.x.toInt() - 20).toDouble();
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
