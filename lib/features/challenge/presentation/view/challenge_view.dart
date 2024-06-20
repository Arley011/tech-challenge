import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hymate_test/common_widgets/loading_widget.dart';
import 'package:hymate_test/features/challenge/presentation/_widgets/widgets.dart';
import 'package:hymate_test/features/challenge/presentation/cubits/data_points_tree/data_points_tree_cubit.dart';

class ChallengeView extends StatelessWidget {
  const ChallengeView({super.key});

  static const String routeName = '/challenge';

  static PageRoute<T> route<T>() {
    return MaterialPageRoute<T>(
      builder: (_) => BlocProvider(
        create: (_) => DataPointsTreeCubit(),
        child: const ChallengeView(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Challenge',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: BlocBuilder<DataPointsTreeCubit, DataPointsTreeState>(
            builder: (context, state) {
              if (state.status.isInitial) {
                return ElevatedButton(
                  onPressed: context.read<DataPointsTreeCubit>().load,
                  child: const Text('Load Challenge Data'),
                );
              } else if (state.status.isError) {
                return ElevatedButton(
                  onPressed: context.read<DataPointsTreeCubit>().load,
                  child: const Text('Retry'),
                );
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 300,
                  maxWidth: 600,
                ),
                child: LoadingWidget(
                  isLoading: state.status.isLoading,
                  isError: state.status.isError,
                  onRetry: context.read<DataPointsTreeCubit>().load,
                  child: HierarchyWidget(
                    hierarchyRoot: state.hierarchyRoot,
                    onNodeSelectionToggle: (node) {
                      context
                          .read<DataPointsTreeCubit>()
                          .toggleNodeSelection(node);
                    },
                    onNodeExpandedToggle: (node) {
                      context
                          .read<DataPointsTreeCubit>()
                          .toggleNodeExpanded(node);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
