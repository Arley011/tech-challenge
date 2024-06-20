part of 'data_points_tree_cubit.dart';

class DataPointsTreeState extends Equatable {
  const DataPointsTreeState({
    this.status = StateStatus.initial,
    this.hierarchyRoot,
  });

  factory DataPointsTreeState.initial() {
    return const DataPointsTreeState();
  }

  final StateStatus status;
  final HierarchyRoot? hierarchyRoot;

  DataPointsTreeState copyWith({
    StateStatus? status,
    HierarchyRoot? hierarchyRoot,
  }) {
    return DataPointsTreeState(
      status: status ?? this.status,
      hierarchyRoot: hierarchyRoot ?? this.hierarchyRoot,
    );
  }

  @override
  List<Object?> get props => [
        status,
        hierarchyRoot,
      ];
}
