import 'package:flutter/widgets.dart';

extension FocusScopeNodeExt on FocusScopeNode {
  void requestFocusOnChild() {
    if (focusedChild != null) {
      requestFocus();
      return;
    }

    _firstLeaf().requestFocus();
  }
}

extension _FirstNode on FocusNode {
  FocusNode _firstLeaf() {
    if (children.isEmpty) {
      return this;
    }

    return children.first._firstLeaf();
  }
}
