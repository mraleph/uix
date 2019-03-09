// Copyright (c) 2015, the uix project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

bool invariant(dynamic condition, [dynamic message]) {
  if (condition is Function){
    condition = condition();
  }
  if (!(condition as bool)) {
    if (message is Function) {
      message = message();
    }
    throw message;
  }
  return true;
}
