import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/model/section_model.dart';
import 'package:leadstudy/stream/provider.dart';
import 'package:leadstudy/view_model/edit_section_view_model.dart';

import '../view_model/section_view_model.dart';

class BookEditScreenArgument {
  Book? book;
  BookEditScreenArgument(this.book);
}

final pendingTitleImageProvider =
    StateProvider.autoDispose<String>((ref) => "");

class EditBookPage extends ConsumerStatefulWidget {
  const EditBookPage(this.args, {Key? key}) : super(key: key);
  final BookEditScreenArgument args;

  @override
  EditBookState createState() => EditBookState();
}

class EditBookState extends ConsumerState<EditBookPage> {
  final titleControllerState = TextEditingController();
  final amountControllerState = TextEditingController();
  final unitController = TextEditingController(text: "ページ");

  @override
  void initState() {
    super.initState();
    final Book? book = widget.args.book;
    if (book != null) {
      titleControllerState.text = book.title;
      amountControllerState.text = book.amount.toString();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unitController.text = book.unitName;
        if (book.imageUrl != null) {
          ref
              .read(pendingTitleImageProvider.notifier)
              .update((state) => book.imageUrl!);
        }
        Future(() async {
          final sections =
              await ref.read(sectionListProvider.notifier).getSections(book);
          ref.read(editSectionProvider.notifier).setSections(sections);
        });
      });
    }
  }

  Future pickImageAndUpload(WidgetRef ref) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    final imageUrl =
        await ref.read(booksServiceProvider).uploadImage(pickedFile);
    final pendingAvatar = ref.read(pendingTitleImageProvider.notifier);
    pendingAvatar.state = imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final pendingTitleImage = ref.watch(pendingTitleImageProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: (widget.args.book == null)
              ? const Text("教材を追加")
              : const Text("教材を編集"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (pendingTitleImage == "")
                        ? GestureDetector(
                            onTap: () {
                              pickImageAndUpload(ref);
                            },
                            child: Container(
                              width: screenSize.width * 0.25,
                              height: screenSize.width * 0.25 * 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              child: const Center(
                                child: Text(
                                  "未設定",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              pickImageAndUpload(ref);
                            },
                            child: SizedBox(
                              width: screenSize.width * 0.25,
                              height: screenSize.width * 0.25 * 1.3,
                              child: Image.network(
                                pendingTitleImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8, bottom: 4),
                            child: Text(
                              "本のカバー画像",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              pickImageAndUpload(ref);
                            },
                            label: const Text("画像をアップロード"),
                            icon: const Icon(Icons.upload_outlined),
                          ),
                          (pendingTitleImage == "")
                              ? Container()
                              : TextButton.icon(
                                  onPressed: () {
                                    ref
                                        .read(
                                            pendingTitleImageProvider.notifier)
                                        .state = "";
                                    ref
                                        .read(booksServiceProvider)
                                        .deleteImage(pendingTitleImage);
                                  },
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  label: const Text("画像を削除"),
                                  icon: const Icon(Icons.delete_rounded),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.book_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: titleControllerState,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '教材の名前',
                          labelText: '名前',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.numbers_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownMenu(
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                value: "page",
                                label: "ページ",
                              ),
                              DropdownMenuEntry(
                                value: "question",
                                label: "問",
                              ),
                              DropdownMenuEntry(
                                value: "question",
                                label: "章",
                              ),
                            ],
                            controller: unitController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: amountControllerState,
                            decoration: const InputDecoration(
                              hintText: 'ページ数や問題数など',
                              labelText: '単位の量',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("/edit_section");
                              },
                              child: const Text("区切りを設定")),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton.icon(
                      onPressed: () async {
                        late Book book;
                        if (widget.args.book == null) {
                          book = await ref.read(booksServiceProvider).addBook(
                                titleControllerState.text,
                                amountControllerState.text,
                                unitController.text,
                                pendingTitleImage,
                              );
                        } else {
                          book = await ref.read(booksServiceProvider).editBook(
                                widget.args.book!,
                                titleControllerState.text,
                                amountControllerState.text,
                                unitController.text,
                                pendingTitleImage,
                              );
                          await ref
                              .read(sectionListProvider.notifier)
                              .deleteAllItems(book.id!);
                        }
                        final List<Section> sections =
                            await ref.read(editSectionProvider);
                        await ref
                            .read(sectionListProvider.notifier)
                            .addMultipleItems(sections, book);
                        Navigator.of(context).pop();
                      },
                      label: (widget.args.book == null)
                          ? const Text("教材を追加")
                          : const Text("変更を保存"),
                      icon: (widget.args.book == null)
                          ? const Icon(Icons.add)
                          : const Icon(Icons.save_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
