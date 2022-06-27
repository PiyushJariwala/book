
import 'package:firebase_database/firebase_database.dart';

class RealTimeDatabase
{
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;

  void addBook(String name,String image,String author,String about_author,String about_book,String rating,String date)
  {
    databaseReference = firebaseDatabase.ref();
    databaseReference!.child("Book").push().set({"name":"$name","image":"$image","author":"$author","about author": "$about_author","about book":"$about_book","rating":"$rating","date":"$date"});

  }

  Stream<DatabaseEvent> readData()
  {
    databaseReference = firebaseDatabase.ref();
    return databaseReference!.child("Book").onValue;
  }

}