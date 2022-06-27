import 'package:book/firebase/realtimeDatabase.dart';
import 'package:book/model/FireModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FireModel> book_list = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RealTimeDatabase().readData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.hasData) {
          book_list.clear();
          DataSnapshot res = snapshot.data.snapshot;
          for (var datasnapshot in res.children) {
            FireModel fireModel = FireModel(
              name: "${datasnapshot.child("name").value}",
              image_link: "${datasnapshot.child("image").value}",
              author: "${datasnapshot.child("author").value}",
              about_author: "${datasnapshot.child("about author").value}",
              about_book: "${datasnapshot.child("about book").value}",
              rating: "${datasnapshot.child("rating").value}",
              date: "${datasnapshot.child("date").value}",
            );

            book_list.add(fireModel);
          }

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Browser",
                  style: TextStyle(color: Colors.black),
                ),
                //backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'second');
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: book_list.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 70, right: 20, top: 10, bottom: 10),
                          padding:
                              EdgeInsets.only(left: 100, top: 15, bottom: 20,right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${book_list[index].name}",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,size: 15,color: Colors.amber,),
                                  Icon(Icons.star,size: 15,color: Colors.amber,),
                                  Icon(Icons.star,size: 15,color: Colors.amber,),
                                  Icon(Icons.star,size: 15,color: Colors.amber,),
                                  Icon(Icons.star,size: 15,color: Colors.grey,),
                                ],
                              ),
                              Container(
                                  height: 20,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${book_list[index].author}",
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Divider(),
                              Expanded(
                                  child: Text(
                                "${book_list[index].about_book}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: 140,
                          margin:
                              EdgeInsets.only(left: 20, top: 35, bottom: 35),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Card(
                            child: CachedNetworkImage(
                              imageUrl: "${book_list[index].image_link}",
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

// PageRouteBuilder _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const AddBook(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//
//       var tween =
//           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

}
