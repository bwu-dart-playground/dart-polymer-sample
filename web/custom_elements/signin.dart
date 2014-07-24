// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

@CustomTag('signin-element')
class Signin extends PolymerElement {
  
  @published String locale = 'en';
  
  @observable Map labels = toObservable({
    'hello': 'Hello 1'
  });
  
  Signin.created() : super.created();
}