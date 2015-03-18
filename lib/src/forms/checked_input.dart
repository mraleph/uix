// Copyright (c) 2015, the uix project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library uix.src.forms.check_box;

import 'dart:html' as html;
import '../../uix.dart';

part 'checked_input.g.dart';

@ComponentMeta(dirtyCheck: false)
class CheckedInput extends Component<bool> {
  String get tag => 'input';

  void update() {
    if ((flags & (Component.dirtyFlag | Component.attachedFlag)) ==
        (Component.dirtyFlag | Component.attachedFlag)) {
      final html.CheckboxInputElement e = element;
      if (e.checked != data) {
        e.checked = data;
      }
      flags &= ~Component.dirtyFlag;
    }
  }
}