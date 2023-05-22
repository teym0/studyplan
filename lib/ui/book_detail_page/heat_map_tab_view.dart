import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/model/heatcell_model.dart';
import 'package:leadstudy/model/record_model.dart';
import 'package:leadstudy/model/section_model.dart';

import './heatmap.dart';
import '../../utils/heatmapprocess.dart';

Widget heatMapTabView(BuildContext context, WidgetRef ref, Book book,
    AsyncValue<List<Record>> records, AsyncValue<List<Section>> sections) {
  return records.when(
    data: ((recordData) {
      return sections.when(
        data: (sectionData) {
          print(sectionData);
          final List<HeatCellData> heatMapData =
              generateHeatMapDataFromRecords(book.amount, recordData);
          final List<HeatCellColor> heatMapColorData =
              generateHeatMapColorData(heatMapData);
          if (sectionData.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: HeatMap(
                  single: true,
                  heatMapData: heatMapData,
                  heatMapColorData: heatMapColorData),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}. ${sectionData[index].name}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    HeatMap(
                        single: false,
                        heatMapData: heatMapData.sublist(
                            sectionData[index].start - 1,
                            sectionData[index].last),
                        heatMapColorData: heatMapColorData.sublist(
                            sectionData[index].start - 1,
                            sectionData[index].last)),
                  ],
                ),
              );
            },
            itemCount: sectionData.length,
          );
          // return HeatMap(
          //   heatMapData: heatMapData,
          //   heatMapColorData: heatMapColorData,
          // );
        },
        error: (error, stackTrace) => const Text("Error"),
        loading: () => const Text("Loading"),
      );
    }),
    error: ((error, stackTrace) => const Text("Error")),
    loading: (() => const Center(child: CircularProgressIndicator())),
  );
}
