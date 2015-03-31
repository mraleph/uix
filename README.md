# uix

Library to build Web User Interfaces in [Dart](https://dartlang.org)
inspired by [React](http://facebook.github.io/react/).

- **Virtual DOM** Virtual DOM simplifies the way to manage DOM
  mutations, just describe how your Component should look at any point
  in time. uix library has a highly optimized virtual dom
  implementation, see benchmarks below.
- **Scheduler** Proper read/write DOM batching, revisioned nodes for
  fast "dirty checking" using mutable data structures.
- **Sideways Data Dependencies** Automatic management of data
  dependencies using Dart
  [streams](https://www.dartlang.org/docs/tutorials/streams/):
  `addSubscription(StreamSubscription s)`,
  `addTransientSubscription(StreamSubscription s)`.

## Quick Start

Requirements:

 - Dart SDK 1.9.1 or greater

#### 1. Create a new Dart Web Project
#### 2. Add uix library in `pubspec.yaml` file:

```yaml
dependencies:
  uix: any
```

#### 3. Install dependencies

```sh
$ pub get
```

#### 4. Add `build.dart` file:

```dart
library build_file;

import 'package:source_gen/source_gen.dart';
import 'package:uix/generator.dart';

void main(List<String> args) {
  build(args, const [
    const ComponentGenerator()
  ], librarySearchPaths: ['web']).then((msg) {
    print(msg);
  });
}
```

Dart Editor will automatically run `build.dart` file. To configure
auto-build in [WebStorm](https://www.jetbrains.com/webstorm/), just
[add File Watcher](http://stackoverflow.com/questions/17266106/how-to-run-build-dart-in-webstorm).

#### 5. Create `web/index.html` file:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello uix</title>
  </head>
  <body>
    <script type="application/dart" src="main.dart"></script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
```

#### 6. Create `web/main.dart` file:

```dart
library main;

import 'dart:html' as html;
import 'package:uix/uix.dart';

// Part file will be automatically generated by source_gen.
part 'main.g.dart';

// Each Component should have @ComponentMeta() annotation, it is used
// by source_gen to generate additional code for Components:
//
// - create${className}([data, children, parent]) - create Component
// - v${className}(...) - create virtual dom node representing Component
//
// Type parameter in Component is used to specify type of the input
// data (props in React terms).
@ComponentMeta()
class Main extends Component<String> {
  // Tag name of the root element for this Component.
  final String tag = 'p';

  // Each time when Component is invalidated (new data is passed,
  // or invalidate() method is called), it will be updated during
  // writeDom phase.
  //
  // API is designed this way intentionally to improve developer
  // experience and get better stack traces when something is
  // failing, that is why there is no method like render() in
  // React.
  updateView() {
    // updateRoot method is used to update internal representation
    // using Virtual DOM API.
    //
    // vRoot node is used to represent root element.
    updateRoot(vRoot()([
      vElement('span')('Hello '),
      vElement('span')(data)
    ]);
  }
}

main() {
  // Initialize uix library.
  initUix();

  // createMain function is automatically generated by source_gen.
  final component = createMain('uix');

  // Inject component into document body.
  injectComponent(component, html.document.body);
}
```

## Examples

- [Hello](https://github.com/localvoid/uix/tree/master/example/hello)
- [Timer](https://github.com/localvoid/uix/tree/master/example/timer)
- [Collapsable](https://github.com/localvoid/uix/tree/master/example/collapsable)
- [Form](https://github.com/localvoid/uix/tree/master/example/form)
- [State Diff](https://github.com/localvoid/uix/tree/master/example/state_diff)
- [Read/Write DOM Batching](https://github.com/localvoid/uix/tree/master/example/read_write_batching)
- [Component Inheritance](https://github.com/localvoid/uix/tree/master/example/inheritance)
- [SVG](https://github.com/localvoid/uix/tree/master/example/svg)
- [TodoMVC (observable)](https://github.com/localvoid/uix_todomvc/)
- [TodoMVC (persistent)](https://github.com/localvoid/uix_todomvc_persistent/)
- [MineSweeper Game](https://github.com/localvoid/uix_minesweeper/)
- [Snake Game](https://github.com/localvoid/uix_snake/)
- [Dual N-Back Game](https://github.com/localvoid/dual_nback/)

## VDom Benchmark

- [Run](http://vdom-benchmark.github.io/vdom-benchmark/?cfg=http://localvoid.github.io/vdom-benchmark-uix/config.js)

## DBMonster Benchmark

- [Run](http://localvoid.github.io/uix_dbmon/)
- [Run](http://localvoid.github.io/uix_dbmon/classlist2) (compiled with [patched dart-sdk](https://code.google.com/p/dart/issues/detail?id=23012))

## Server-Side rendering

uix library with
[simple tweaks](https://github.com/localvoid/uix_standalone) is fully
capable to render components on the server and mounting on top of the
existing html tree. Unfortunately Dart doesn't support any usable way
to build uix Components this way. There are several proposals for
Configured Imports [1](https://github.com/lrhn/dep-configured-imports)
[2](https://github.com/eernstg/dep-configured-imports)
[3](https://github.com/munificent/dep-external-libraries/blob/master/Proposal.md)
that will solve some problems, but all this proposals will be really
bad in terms of developer experience for building isomorphic uix
components compared to simple conditional compilation.
