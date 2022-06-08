

import 'package:flutter/material.dart';

enum TodoPageType {
  all,
  complete,
  incomplete
}

extension TodoPageTypeExts on TodoPageType {
  String get stringValue {
    switch (this) {
      case TodoPageType.all:
        return 'All';
      case TodoPageType.complete:
        return 'Complete';
      case TodoPageType.incomplete:
        return 'Incomplete';
    }
  }

  IconData get icon {
    switch (this) {
      case TodoPageType.all:
        return Icons.dashboard;
      case TodoPageType.complete:
        return Icons.check_box;
      case TodoPageType.incomplete:
        return Icons.pending;
    }
  }
}