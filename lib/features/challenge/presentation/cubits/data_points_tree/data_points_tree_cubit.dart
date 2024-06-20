import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hymate_test/core/beans/enums/state_status_enum.dart';
import 'package:hymate_test/features/challenge/data/repositories/data_points_repository.dart';
import 'package:hymate_test/features/challenge/domain/data_point.dart';
import 'package:hymate_test/features/challenge/domain/domain.dart';

part 'data_points_tree_state.dart';

class DataPointsTreeCubit extends Cubit<DataPointsTreeState> {
  DataPointsTreeCubit() : super(DataPointsTreeState.initial());

  void toggleNodeSelection(HierarchyNode node) {
    if (state.hierarchyRoot == null) {
      return;
    }
    final updatedNode = node.copyWith(isSelected: !node.isSelected);
    final updatedTree = state.hierarchyRoot!.updateNode(updatedNode);
    emit(
      state.copyWith(
        hierarchyRoot: updatedTree,
      ),
    );

    createPlot();
  }

  void toggleNodeExpanded(HierarchyNode node) {
    if (state.hierarchyRoot == null || node is! HierarchyCategoryNode) {
      return;
    }
    final updatedNode = node.copyWith(isExpanded: !node.isExpanded);
    emit(
      state.copyWith(
        hierarchyRoot: state.hierarchyRoot!.updateNode(updatedNode),
      ),
    );
  }

  void load() async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      final hierarchyRoot =
          (await DataPointsRepository.getHierarchy()).generateColors();

      hierarchyRoot.printTree();

      emit(
        state.copyWith(
          status: StateStatus.success,
          hierarchyRoot: hierarchyRoot,
        ),
      );
    } catch (e, st) {
      emit(state.copyWith(status: StateStatus.error));
      log(
        'Failed to load data points: $e\n$st',
      );
    }
  }

  void createPlot() {
    final hierarchy = state.hierarchyRoot;
    if (hierarchy == null) {
      return;
    }

    final plot = Plot(
      id: 0,
      name: 'Test plot',
      primaryYAxisDataGraphs: hierarchy.getSelectedNodes().map((node) {
        if (node is HierarchyCategoryNode) {
          return Graph(
            id: node.id,
            name: node.label,
            dataPoints: node.dataPoints
                .map((e) => DataPoint(
                      id: e.id,
                      label: e.label,
                    ))
                .toList(),
          );
        }
        final dataNode = node as HierarchyDataPoint;
        return Graph(
          id: node.id,
          name: node.label,
          dataPoints: [
            DataPoint(
              id: dataNode.id,
              label: dataNode.label,
            ),
          ],
        );
      }).toList(),
    );

    final jsonApiMap = plot.toJsonApiMap();

    void printJson(Map<String, dynamic> json, [int depth = 0]) {
      final indent = '  ' * depth;
      for (final key in json.keys) {
        if (json[key] is Map<String, dynamic>) {
          log('$indent$key:');
          printJson(json[key], depth + 1);
        } else if (json[key] is List) {
          log('$indent$key:');
          for (final item in json[key]) {
            if (item is Map<String, dynamic>) {
              printJson(item, depth + 1);
              log('${'  ' * (depth + 1)}+++++++++');
            } else {
              log('${'  ' * (depth + 1)}$item');
            }
          }
        } else {
          log('$indent$key: ${json[key]}');
        }
      }
    }

    log('----------- Plot JSON -----------');
    printJson(jsonApiMap);
  }
}
