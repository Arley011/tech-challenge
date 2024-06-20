import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hymate_test/features/challenge/data/models/hierarchy/hierarchy.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy.dart';

class DataPointsRepository {
  static Future<HierarchyRoot> getHierarchy() async {
    final rawHierarchyData =
        await loadRawDataPointsHierarchy('test_data/hymate_hierarchy.json');
    if (rawHierarchyData == null) {
      throw Exception('Failed to fetch hierarchy data');
    }

    HierarchyRootModel rootModel = const HierarchyRootModel();
    int dynamicCategoryId = 0;

    void parseData(Map<String, dynamic> data, String? parentId) {
      data.forEach((key, value) {
        try {
          final category = HierarchyCategoryNodeModel(
            id: (dynamicCategoryId++).toString(),
            label: key,
            parentId: parentId,
          );
          rootModel = rootModel.addNode(category, parentId);

          if (value is List) {
            for (final item in value) {
              final label = item['label'] as String;
              final id = item['id'] as String;
              rootModel = rootModel.addNode(
                HierarchyDataPointModel(
                  id: id,
                  label: label,
                  categoryId: category.id,
                ),
                category.id,
              );
            }
          } else if (value is Map) {
            final valueMap = Map<String, dynamic>.from(value);

            parseData(valueMap, category.id);
          }
        } catch (e, st) {
          log(
            'Cannot parse data for key: $key, value: $value\n$e\n$st',
          );
        }
      });
    }

    parseData(rawHierarchyData, null);

    return rootModel.toEntity();
  }

  static Future<Map<String, dynamic>?> loadRawDataPointsHierarchy(
      String path) async {
    try {
      final jsonData = await rootBundle.loadString(path);
      return jsonDecode(jsonData) as Map<String, dynamic>;
    } catch (e) {
      log('Error while fetching hierarchy data: $e');
      return null;
    }
  }
}
