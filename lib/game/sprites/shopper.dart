part of '../../../main.dart';

class Shopper extends SpriteComponent
    with HasGameRef<FruitCatcher>, Draggable, CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('shopper.png');
    size = Vector2.all(156);
    add(RectangleHitbox(
      size: Vector2(size.x / 2, size.y / 2),
      position: position + Vector2(size.x / 10, size.y / 2),
    ));
    position = Vector2(gameRef.size.x / 2 - 156 / 2, gameRef.size.y - 200);
  }

  @override
  bool onDragStart(info) => false;

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    position.x += info.delta.game.x;
    return false;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Fruit) {
      if (other.isHealthyFood) {
        gameRef.onCollide();
      } else {
        gameRef.gameOverF();
      }
      gameRef.remove(other);
    }
  }
}
