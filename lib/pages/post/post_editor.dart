import "dart:convert";
import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_quill/flutter_quill.dart" hide Text;
import "../../core/image_picker.dart";
import "code_colors.dart";
import "../../core/show_toast.dart";
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

  void addCode(String code, String language) {
    List<InlineSpan> spanList = [];
    // the most complex RegExp ever i made
    RegExp pattern = RegExp(
        r'''(?:\/\/[^\n]*)|(?:#[^\n]*)|(\b\w+\b|\s+|(['"])(?:(?!\2).|\\\2)*\2|[{}()\[\],.;?!`<>*^%$#@&"'+-=])''');
    Iterable<Match> matches = pattern.allMatches(code);
    for (Match match in matches) {
      String word = match.group(0)!;
      Color color = CodeColors().python(word);

      spanList.add(
        TextSpan(
          text: word,
          style: TextStyle(color: color),
        ),
      );
    }
    Widget colorsCode = Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.lightBlueAccent,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.copy_all,
                      color: MyColorsIcons.gradient2,
                    ),
                    label: const Text(
                      "Copy",
                      style: TextStyle(
                        color: MyColorsIcons.gradient2,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: MyColorsIcons.gradient2, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: code,
                        ),
                      );
                      showToast("Copied Successful!");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: SelectableText.rich(
                  TextSpan(
                      style: const TextStyle(fontFamily: "monospace"),
                      children: spanList),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    setState(() {
      contentPreView.add(colorsCode);
    });
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
                      onTap: () {
                        List<DropdownMenuItem<String>> items = [
                          const DropdownMenuItem(
                            value: 'language',
                            child: Text('Language'),
                          ),
                          const DropdownMenuItem(
                            value: 'python',
                            child: Text('Python'),
                          ),
                          const DropdownMenuItem(
                            value: 'java',
                            child: Text('Java'),
                          ),
                          const DropdownMenuItem(
                            value: 'javascript',
                            child: Text('Java Script'),
                          ),
                          const DropdownMenuItem(
                            value: 'c++',
                            child: Text('C++'),
                          ),
                          const DropdownMenuItem(
                            value: 'c',
                            child: Text('C'),
                          ),
                        ];
                        String language = 'language';

                        insertQuillData();
                        final codeController = TextEditingController();
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width > 1000
                                  ? MediaQuery.of(context).size.width * 0.70
                                  : MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height * 0.70,
                              child: Scaffold(
                                body: ListView(
                                  padding: const EdgeInsets.all(10),
                                  children: [
                                    TextFormField(
                                      controller: codeController,
                                      autocorrect: false,
                                      maxLines: 1000,
                                      minLines: 13,
                                      decoration: InputDecoration(
                                        errorStyle: const TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold),
                                        labelText: "Code",
                                        hintText: "Type your Code...",
                                        border: MyColorsIcons
                                            .outLinedBorderForTextFromFeild,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DropdownButton<String>(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          value: language,
                                          items: items,
                                          onChanged: (newValue) {
                                            setState(() {
                                              language = newValue!;
                                            });
                                          },
                                        ),
                                        const Spacer(),
                                        TextButton.icon(
                                          icon: const Icon(
                                            Icons.cancel_outlined,
                                            color: MyColorsIcons.gradient2,
                                          ),
                                          onPressed: () {
                                            if (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }
                                          },
                                          label: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: MyColorsIcons.gradient2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        TextButton.icon(
                                          icon: const Icon(
                                            Icons.done,
                                            color: MyColorsIcons.gradient2,
                                          ),
                                          onPressed: () {
                                            if (language != 'language') {
                                              if (codeController.text
                                                  .trim()
                                                  .isEmpty) {
                                                showToast("Code is empty");
                                                return;
                                              }
                                              addCode(codeController.text,
                                                  language);
                                              if (Navigator.canPop(context)) {
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              showToast(
                                                  "Pleage select a language");
                                            }
                                          },
                                          label: const Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: MyColorsIcons.gradient2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.black26,
                        padding: const EdgeInsets.all(3),
                        child: const Icon(Icons.code),
                      )),
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
                                await pickPhotoMobile("post/$timeEpoch")
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
                                await pickPhotoWeb("post/$timeEpoch")
                                    .then((value) {
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
                          // PopupMenuItem<String>(
                          //   child: const Row(
                          //     children: [
                          //       Icon(Icons.code),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       Text('Insert Code'),
                          //     ],
                          //   ),
                          //   onTap: () {
                          //   },
                          // ),
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
