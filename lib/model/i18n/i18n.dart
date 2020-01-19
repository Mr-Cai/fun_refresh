import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'lang_kv.dart';

final i18nKey = GlobalKey<_I18nContainerState>();

class I18nDelegate extends LocalizationsDelegate<I18n> {
  static final i18nDelegate = I18nDelegate();
  @override
  isSupported(locale) => langCodes.contains(locale.languageCode);
  @override
  load(locale) => SynchronousFuture<I18n>(I18n(locale));
  @override
  shouldReload(old) => false;
}

class I18n {
  I18n(this.locale);
  final Locale locale;
  get appName => $TxTKV[locale.languageCode]['app_name'];
  get desc => $TxTKV[locale.languageCode]['desc'];
  get game => $TxTKV[locale.languageCode]['game'];
  get video => $TxTKV[locale.languageCode]['video'];
  get more => $TxTKV[locale.languageCode]['more'];
  get msg => $TxTKV[locale.languageCode]['msg'];
  get userName => $TxTKV[locale.languageCode]['user_name'];
  get social => $TxTKV[locale.languageCode]['social'];
  get mind => $TxTKV[locale.languageCode]['mind'];
  get reward => $TxTKV[locale.languageCode]['reward'];
  get setting => $TxTKV[locale.languageCode]['setting'];
  get zh => $TxTKV[locale.languageCode]['zh'];
  get en => $TxTKV[locale.languageCode]['en'];
  get ja => $TxTKV[locale.languageCode]['ja'];
  get searchHint => $TxTKV[locale.languageCode]['search_hint'];
  get tryHint => $TxTKV[locale.languageCode]['try'];
  factory I18n.of(BuildContext context) => Localizations.of(context, I18n);
}

class I18nContainer extends StatefulWidget {
  I18nContainer({@required Key key, @required this.child}) : super(key: key);
  final Widget child;
  @override
  createState() => _I18nContainerState();
}

class _I18nContainerState extends State<I18nContainer> {
  var _locale = Locale('zh', 'CH');
  toggleLanguage(Locale locale) => setState(() => _locale = locale);
  @override
  Widget build(BuildContext context) => Localizations.override(
      context: context, locale: _locale, child: widget.child);
}
