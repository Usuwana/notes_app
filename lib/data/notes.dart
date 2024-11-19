import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notes {
  late String note_title;
  late String note;
  late String last_edit;

  //late List<dynamic> schedules;
  //List<dynamic> names = [];
  List<dynamic> titles = [];
  List<dynamic> notes = [];
  List<dynamic> updates_times = [];

  List<dynamic> searchTitles = [];
  List<dynamic> searchNotes = [];
  List<dynamic> searchTimes = [];
  final firestoreInstance = FirebaseFirestore.instance;

  void removeNote(String title) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("notes")
            .where("title", isEqualTo: title)
            .get()
            .then((value) {
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("notes")
                .doc(element.id)
                .delete()
                .then((value) {
              print("Success!");
            });
          });
        });
      }
    });
  }

  Future<void> addNote(String title, String note, String creation_time,
      String update_time) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("notes")
            .add({
          'title': title,
          'note': note,
          'creation_time': creation_time,
          'update_time': update_time
        }).then((value) {
          print(value.id);
        });
      }
    });
  }

  Future<void> editnoteTitle(String current, String future) async {
    print(current);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("notes")
            .where("title", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("notes")
                .doc(element.id)
                .update({"title": future})
                //.delete()
                .then((value) {
              print("Success!");
            });
          });
        });
      }
    });
    //editClient('Tatenda');
  }

  Future<void> editNoteContent(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("notes")
            .where("note", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("notes")
                .doc(element.id)
                .update({"note": future})
                //.delete()
                .then((value) {
              print("Success!");
            });
          });
        });
      }
    });
    //editClient('Tatenda');
  }

  Future<void> editUpdateTime(String current, String future) async {
    print(current);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("notes")
            .where("update_time", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("notes")
                .doc(element.id)
                .update({"update_time": future})
                //.delete()
                .then((value) {
              print("Success!");
            });
          });
        });
      }
    });
    //editClient('Tatenda');
  }

  Future<void> deleteUserAccount() async {
    try {
      //await FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        await user?.delete();
      });
    } catch (e) {
      //log.e(e);
      print(e);
      // Handle general exception
    }
  }

  Future<dynamic> searchNote(String note) async {
    // Wait for the auth state to return a user.
    User? user = await FirebaseAuth.instance
        .authStateChanges()
        .firstWhere((user) => user != null);

    if (user != null) {
      // Now perform the asynchronous query on Firestore.
      final querySnapshot = await firestoreInstance
          .collection("allow-users")
          .doc(user.uid)
          .collection("notes")
          //.where("name", isEqualTo: client)
          .where("title", isGreaterThanOrEqualTo: note)
          .where("title", isLessThanOrEqualTo: note + '\uf8ff')
          .where("note", isGreaterThanOrEqualTo: note)
          .where("note", isLessThanOrEqualTo: note + '\uf8ff')
          .get();

      print("Documents found: ${querySnapshot.docs.length}");
      searchTitles = querySnapshot.docs.map((doc) => doc["title"]).toList();

      print('As we go:');
      print(searchTitles);

      searchNotes.addAll(querySnapshot.docs.map((doc) => doc["note"]).toList());
    }

    print('At the end');
    print(searchTitles);
    return searchTitles;
  }

  Future<dynamic> getNotes() async {
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection("allow-users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("notes");
    QuerySnapshot querySnapshot = await _collectionRef.get();

    titles.addAll(querySnapshot.docs.map((doc) => doc["title"]).toList());
    notes.addAll(querySnapshot.docs.map((doc) => doc["note"]).toList());
    updates_times.addAll(querySnapshot.docs.map((doc) => doc["note"]).toList());
    print(titles);
    return titles;
  }
}
