import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/model/section_model.dart';
import 'package:leadstudy/view_model/edit_section_view_model.dart';

class EditSectionPage extends ConsumerStatefulWidget {
  const EditSectionPage({Key? key}) : super(key: key);

  @override
  EditSectionState createState() => EditSectionState();
}

class EditSectionState extends ConsumerState<EditSectionPage> {
  final nameControllerProvider = TextEditingController();
  final startControllerProvider = TextEditingController();
  final lastControllerProvider = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Section> sectionList = ref.watch(editSectionProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("区切りを編集"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: nameControllerProvider,
                    decoration: const InputDecoration(hintText: "名前"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: startControllerProvider,
                    decoration: const InputDecoration(hintText: "はじめ"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: lastControllerProvider,
                    decoration: const InputDecoration(hintText: "おわり"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    final String? message = ref
                        .read(editSectionProvider.notifier)
                        .addSection(
                            nameControllerProvider.text,
                            int.parse(startControllerProvider.text),
                            int.parse(lastControllerProvider.text));
                    if (message != null) {
                      context.showErrorSnackBar(message: message);
                    }
                  },
                  icon: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        "${sectionList[index].start} - ${sectionList[index].last} (${sectionList[index].name})"),
                    trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(editSectionProvider.notifier)
                            .deleteSection(sectionList[index]);
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                );
              },
              itemCount: sectionList.length,
            ),
          ),
        ],
      ),
    );
  }
}
