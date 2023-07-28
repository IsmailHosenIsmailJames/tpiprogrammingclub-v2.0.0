import "dart:convert";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_quill/flutter_quill.dart" hide Text;
import "package:tpiprogrammingclub/core/image_picker.dart";
import "../../theme/change_button_theme.dart";
import "../../theme/my_colors_icons.dart";

class PostEditor extends StatefulWidget {
  const PostEditor({super.key});

  @override
  State<PostEditor> createState() => _PostEditorState();
}

class _PostEditorState extends State<PostEditor> {
  final QuillController quillControllerNew = QuillController(
      document: Document(),
      selection: const TextSelection(baseOffset: 0, extentOffset: 0));
  List<Widget> contentPreView = [];
  Map<String, Map<String, String>> contentData = {};
  int counter = 0;

  void insertQuillData() {
    String encodedJsonData =
        jsonEncode(quillControllerNew.document.toDelta().toJson());

    if (quillControllerNew.document
            .toDelta()
            .toJson()
            .toString()
            .replaceAll("\n", "") !=
        "[{insert: }]") {
      setState(() {
        contentData.addAll({
          "$counter": {
            "type": "quill",
            "data": encodedJsonData,
          }
        });
      });

      Widget quillWidgetPreWiew = QuillEditor(
        controller: QuillController(
            document: Document.fromJson(jsonDecode(encodedJsonData)),
            selection: const TextSelection(baseOffset: 0, extentOffset: 0)),
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: FocusNode(),
        autoFocus: false,
        readOnly: true,
        expands: false,
        padding: EdgeInsets.zero,
        customStyles: DefaultStyles(
          h1: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 32,
                color: Colors.black,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const VerticalSpacing(16, 0),
              const VerticalSpacing(0, 0),
              null),
          sizeSmall: const TextStyle(fontSize: 9),
        ),
      );
      setState(() {
        contentPreView.add(quillWidgetPreWiew);
        counter++;
        quillControllerNew.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(80, 100, 100, 100),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColorsIcons.gradient2, width: 2),
            ),
            padding: const EdgeInsets.all(4),
            child: Center(
              child: QuillToolbar.basic(
                controller: quillControllerNew,
                showClearFormat: false,
                showCodeBlock: false,
                iconTheme: const QuillIconTheme(
                  disabledIconColor: Colors.grey,
                  iconSelectedFillColor: MyColorsIcons.gradient2,
                ),
                customButtons: [
                  QuillCustomButton(
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      color: Colors.black26,
                      child: PopupMenuButton<String>(
                        child: const Icon(Icons.more_horiz),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            child: const Row(
                              children: [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Insert Image'),
                              ],
                            ),
                            onTap: () async {
                              insertQuillData();

                              int timeEpoch =
                                  DateTime.now().millisecondsSinceEpoch;
                              if (!kIsWeb) {
                                pickPhotoMobile("post/$timeEpoch")
                                    .then((value) {
                                  File? image = value.imageFile;
                                  String? url = value.url;
                                  if (image != null && url != null) {
                                    setState(() {
                                      contentData.addAll({
                                        "$counter": {
                                          "type": "image",
                                          "data": url,
                                        }
                                      });
                                    });
                                    Widget imageWidgetPreView = Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Shadow color
                                            spreadRadius: 2, // Spread radius
                                            blurRadius: 5, // Blur radius
                                            offset: const Offset(0,
                                                3), // Offset in x and y direction
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Optional: Match the container's border radius
                                        child: Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      contentPreView.add(imageWidgetPreView);
                                    });
                                  }
                                });
                              } else {
                                pickPhotoWeb("post/$timeEpoch").then((value) {
                                  Uint8List? image = value.imageFile;
                                  String? url = value.url;
                                  if (image != null && url != null) {
                                    setState(() {
                                      contentData.addAll({
                                        "$counter": {
                                          "type": "image",
                                          "data": url,
                                        }
                                      });
                                    });
                                    Widget imageWidgetPreView = Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Shadow color
                                            spreadRadius: 2, // Spread radius
                                            blurRadius: 5, // Blur radius
                                            offset: const Offset(0,
                                                3), // Offset in x and y direction
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Optional: Match the container's border radius
                                        child: Image.memory(
                                          image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      contentPreView.add(imageWidgetPreView);
                                    });
                                  }
                                });
                              }
                            },
                          ),
                          PopupMenuItem<String>(
                            child: const Row(
                              children: [
                                Icon(Icons.link),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Insert Linked Iamge'),
                              ],
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem<String>(
                            child: const Row(
                              children: [
                                Icon(Icons.code),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Insert Code'),
                              ],
                            ),
                            onTap: () {
                              insertQuillData();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColorsIcons.gradient2, width: 2),
            ),
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: contentPreView,
                ),
                QuillEditor(
                  controller: quillControllerNew,
                  scrollController: ScrollController(),
                  scrollable: true,
                  focusNode: FocusNode(),
                  autoFocus: true,
                  readOnly: false,
                  placeholder: 'Write your document...',
                  expands: false,
                  padding: EdgeInsets.zero,
                  customStyles: DefaultStyles(
                    h1: DefaultTextBlockStyle(
                        const TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          height: 1.15,
                          fontWeight: FontWeight.w300,
                        ),
                        const VerticalSpacing(16, 0),
                        const VerticalSpacing(0, 0),
                        null),
                    sizeSmall: const TextStyle(fontSize: 9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ChangeThemeButtonWidget(value: 1),
            ],
          ),
        ],
      ),
    );
  }
}
