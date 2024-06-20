import 'package:equatable/equatable.dart';
import 'package:hymate_test/core/mixins/entity_convertible_mixin.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy_node.dart';

abstract class HierarchyNodeModel extends Equatable
    with EntityConvertible<HierarchyNodeModel, HierarchyNode> {
  final String id;

  const HierarchyNodeModel({
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
