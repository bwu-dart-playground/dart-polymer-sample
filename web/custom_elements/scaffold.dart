// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:polymer/polymer.dart';

/*http://blog.sethladd.com/2012/03/using-futures-in-dart-for-better-async.html*/
/*https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/intl*/

@CustomTag('scaffold-toolbar-element')
class Scaffold extends PolymerElement{

  void click_menu_item(String label) {
    shadowRoot.querySelector('#page_name').text = label;
  }

  Scaffold.created() : super.created();
    
  @override
  void attached() {
    super.attached();

    var menu_list;
    MenuList.create('menu_items.json').then((ml) {
      menu_list = ml;
      addElementToMenu(list_value){
        var newElement = new Element.tag('core-item');
        newElement
          ..setAttribute("icon", list_value["icon"])
          ..setAttribute("label", list_value["label"])
          ..onClick.listen((e) => click_menu_item(list_value["label"]));
        shadowRoot.querySelector('#core_menu_item').children.add(newElement);
      };
      menu_list.my_json.forEach(addElementToMenu);
    });
  }
}


class MenuList {
  String path;
  List my_json;

  static Future<MenuList> create(String path) {
    return new MenuList()._load(path);
  }

  Future<MenuList> _load(String path) {
    Completer completer = new Completer();
    
    this.path = path;
    
    var httpRequest = new HttpRequest();
    httpRequest
      ..open('GET', path)
      ..onLoadEnd.listen((e) {
        requestComplete(httpRequest);
        completer.complete(this);
      })
      ..send('');
    return completer.future;
  }

  requestComplete(HttpRequest request) {
    if (request.status == 200) {
      this.my_json = JSON.decode(request.responseText);
    }else{
      this.my_json = null;
    }
  }
}