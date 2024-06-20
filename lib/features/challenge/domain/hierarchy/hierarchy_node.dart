import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class HierarchyNode extends Equatable {
  final String id;
  final bool isSelected;
  final Color color;

  const HierarchyNode({
    required this.id,
    this.color = const Color(0xFF000000),
    this.isSelected = false,
  });

  HierarchyNode copyWith({
    bool? isSelected,
  });

  @override
  List<Object?> get props => [
        id,
        isSelected,
        color,
      ];
}
