// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';

@CustomTag('localized-element')
class Localized extends PolymerElement {
  
  @published String locale = 'en';
  /*@published Map labels;*/
  
  @PublishedProperty(reflect: true) Map labels;
  
  Localized.created() : super.created();
  
  ready() {
    super.ready();
    _loadTranslations();
  }
  
  update() {
    if (!_l10n.containsKey(locale)) return;
    
    var l10n = _l10n[locale];

    labels['hello'] = l10n['hello'];
  }
  
  List locales = ['en', 'fr'];
  _loadTranslations() {
    locales.forEach((l10n)=> _loadLocale(l10n));
  }

  Map _l10n = {};
  _loadLocale(_l) {
    HttpRequest.getString('i18n/translation_${_l}.json')
      .then((res) {
        _l10n[_l] = JSON.decode(res);
        update();
      })
      .catchError((Error error) {
        print(error.toString());
      });
  }

}