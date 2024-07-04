import 'dart:io';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider= NotifierProvider<LocaleNotiafier, Locale>(
    () => LocaleNotiafier(),
);

class LocaleNotiafier extends Notifier<Locale>{
  @override
  build() {
    final languageCode = Platform.localeName.split('_')[0];
    return Locale(languageCode);
  }

  void changeLocale({
    required Locale locale
}) {
    state = locale;
  }
}