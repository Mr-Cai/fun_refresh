import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'lang_kv.dart';

final i18nKey = GlobalKey<_I18nContainerState>();

class I18nDelegate extends LocalizationsDelegate<I18n> {
  static final i18nDelegate = I18nDelegate();

  @override
  bool isSupported(Locale locale) => langCodes.contains(locale.languageCode);

  @override
  Future<I18n> load(Locale locale) => SynchronousFuture<I18n>(I18n(locale));

  @override
  bool shouldReload(LocalizationsDelegate<I18n> old) => false;
}

class I18n {
  I18n(this.locale);

  factory I18n.of(BuildContext context) => Localizations.of(context, I18n);

  final Locale locale;

  String get appName => $TxTKV[locale.languageCode]['app_name'];
  String get desc => $TxTKV[locale.languageCode]['desc'];
  String get game => $TxTKV[locale.languageCode]['game'];
  String get video => $TxTKV[locale.languageCode]['video'];
  String get more => $TxTKV[locale.languageCode]['more'];
  String get msg => $TxTKV[locale.languageCode]['msg'];
  String get userName => $TxTKV[locale.languageCode]['user_name'];
  String get social => $TxTKV[locale.languageCode]['social'];
  String get mind => $TxTKV[locale.languageCode]['mind'];
  String get reward => $TxTKV[locale.languageCode]['reward'];
  String get setting => $TxTKV[locale.languageCode]['setting'];
  String get zh => $TxTKV[locale.languageCode]['zh'];
  String get en => $TxTKV[locale.languageCode]['en'];
  String get ja => $TxTKV[locale.languageCode]['ja'];
  String get searchHint => $TxTKV[locale.languageCode]['search_hint'];
  String get tryHint => $TxTKV[locale.languageCode]['try'];
  String get profile => $TxTKV[locale.languageCode]['profile'];
  String get error => $TxTKV[locale.languageCode]['error'];
}

class I18nContainer extends StatefulWidget {
  I18nContainer({
    @required Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _I18nContainerState();
}

class _I18nContainerState extends State<I18nContainer> {
  var _locale = Locale('zh', 'CH');

  void toggleLanguage(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) => Localizations.override(
      context: context, locale: _locale, child: widget.child);
}
