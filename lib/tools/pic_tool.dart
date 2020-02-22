/// 图片路径
/// [name] : 图片名称 |  [format] : 自定义格式
String picX(String name, {String format = 'png'}) {
  return 'asset/image/$name.$format';
}

/// 图标路径
String iconX(String name) => 'asset/svg/$name.svg';

/// 动画
///
