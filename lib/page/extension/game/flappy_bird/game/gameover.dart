import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import '../game/config.dart';

class GameOver extends PositionComponent
    with HasGameRef, Tapable, Resizable, ComposedComponent {
  GameOverGround ground;

  GameOver(Image spriteImage, Size screenSize) {
    var sprite = Sprite.fromImage(
      spriteImage,
      width: SpriteDimensions.gameOverWidth,
      height: SpriteDimensions.gameOverHeight,
      y: SpritesPostions.gameOverY,
      x: SpritesPostions.gameOverX,
    );

    this.ground = GameOverGround(sprite);
    this.ground.x = (screenSize.width - ComponentDimensions.gameOverWidth) / 2;
    this.ground.y =
        (screenSize.height - ComponentDimensions.gameOverHeight) / 2;
    this..add(ground);
  }
}

class GameOverGround extends SpriteComponent with Resizable {
  GameOverGround(Sprite sprite)
      : super.fromSprite(ComponentDimensions.gameOverWidth,
            ComponentDimensions.gameOverHeight, sprite);
}
