import 'package:book/firebase/realtimeDatabase.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController name = TextEditingController();
  TextEditingController image_link = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController about_author = TextEditingController();
  TextEditingController about_book = TextEditingController();
  TextEditingController rates = TextEditingController();
  TextEditingController date = TextEditingController();

  final finalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: finalKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Add Book",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            // backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Something";
                      }
                      return null;
                    },
                    controller: name,
                    decoration: const InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.menu_book),
                        border: OutlineInputBorder()),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Something";
                            }
                            return null;
                          },
                          controller: image_link,
                          decoration: const InputDecoration(
                              labelText: "Image Link",
                              prefixIcon: Icon(Icons.image),
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Something";
                      }
                      return null;
                    },
                    controller: author,
                    decoration: const InputDecoration(
                        labelText: "Aouther Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Something";
                      }
                      return null;
                    },
                    controller: about_author,
                    decoration: const InputDecoration(
                        labelText: "About Author",
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder()),
                    maxLines: 3,
                  ), //
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Something";
                      }
                      return null;
                    },
                    controller: about_book,
                    decoration: const InputDecoration(
                      labelText: "About Book",
                      prefixIcon: Icon(Icons.auto_stories),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ), //
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Something";
                      }
                      return null;
                    },
                    controller: rates,
                    decoration: const InputDecoration(
                      labelText: "Ratings",
                      prefixIcon: Icon(Icons.star),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ), //

                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Something";
                      }
                      return null;
                    },
                    controller: date,
                    decoration: const InputDecoration(
                      labelText: "Publish Year",
                      prefixIcon: Icon(Icons.star),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ), //

                  const SizedBox(
                    height: 10,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (finalKey.currentState!.validate())
                      {
                        RealTimeDatabase().addBook(name.text, image_link.text, author.text, about_author.text, about_book.text, rates.text, date.text);
                        finalKey.currentState!.reset();
                      }
                    },
                    child: const Text("Finish"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
