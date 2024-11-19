import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientNotes {
  late String note_title;
  late String note;
  late String last_edit;

  //late List<dynamic> schedules;
  //List<dynamic> names = [];
  List<dynamic> titles = [];
  List<dynamic> notes = [];
  List<dynamic> updates_times = [];
  final firestoreInstance = FirebaseFirestore.instance;

  void removeClient(String title) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("name", isEqualTo: title)
            .get()
            .then((value) {
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
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

  Future<void> addClient(String name, String email, String id, String phone,
      String details, String address, String diagnosis
      /*List<dynamic> schedules*/
      ) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .add({
          'details': details,
          'email': email,
          'name': name,
          'phone': phone,
          'id': id,
          'address': address,
          'diagnosis': diagnosis
        }).then((value) {
          print(value.id);
        });
      }
    });
  }

  Future<void> editClientName(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("name", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
                .doc(element.id)
                .update({"name": future})
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

  Future<void> editClientDetails(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("details", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
                .doc(element.id)
                .update({"details": future})
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

  Future<void> editClientDiagnosis(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("diagnosis", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
                .doc(element.id)
                .update({"diagnosis": future})
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

  Future<void> editClientEmail(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("email", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
                .doc(element.id)
                .update({"email": future})
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

  Future<void> addSearchClient(String name, String email, String id,
      String phone, String details, String address, String diagnosis
      /*List<dynamic> schedules*/
      ) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("search_clients")
            .add({
          'details': details,
          'email': email,
          'name': name,
          'phone': phone,
          'id': id,
          'address': address,
          'diagnosis': diagnosis
        }).then((value) {
          print(value.id);
        });
      }
    });
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

  Future<dynamic> searchClient(String client) async {
    /*await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("name", isEqualTo: client)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            searchNames.add(value.docs.map((doc) => doc["name"]).toList());
            print('As we go:');
            print(value.docs.map((doc) => doc["name"]).toList());
            searchIDs.add(value.docs.map((doc) => doc["id"]).toList());
            searchEmails.add(value.docs.map((doc) => doc["email"]).toList());
            searchPhones.add(value.docs.map((doc) => doc["phone"]).toList());
            searchDetails.add(value.docs.map((doc) => doc["details"]).toList());
            searchAddresses
                .add(value.docs.map((doc) => doc["address"]).toList());
            searchDiagnoses
                .add(value.docs.map((doc) => doc["diagnosis"]).toList());
          });
        });
      }
    });
    print('At the end');
    print(searchNames);
    return searchNames;*/

    // Wait for the auth state to return a user.
    User? user = await FirebaseAuth.instance
        .authStateChanges()
        .firstWhere((user) => user != null);

    if (user != null) {
      // Now perform the asynchronous query on Firestore.
      final querySnapshot = await firestoreInstance
          .collection("allow-users")
          .doc(user.uid)
          .collection("clients")
          //.where("name", isEqualTo: client)
          .where("name", isGreaterThanOrEqualTo: client)
          .where("name", isLessThanOrEqualTo: client + '\uf8ff')
          .get();

      print("Documents found: ${querySnapshot.docs.length}");
      searchNames = querySnapshot.docs.map((doc) => doc["name"]).toList();

      print('As we go:');
      print(searchNames);

      searchIDs.addAll(querySnapshot.docs.map((doc) => doc["id"]).toList());
      searchEmails
          .addAll(querySnapshot.docs.map((doc) => doc["email"]).toList());
      searchPhones
          .addAll(querySnapshot.docs.map((doc) => doc["phone"]).toList());
      searchDetails
          .addAll(querySnapshot.docs.map((doc) => doc["details"]).toList());
      searchAddresses
          .addAll(querySnapshot.docs.map((doc) => doc["address"]).toList());
      searchDiagnoses
          .addAll(querySnapshot.docs.map((doc) => doc["diagnosis"]).toList());
    }

    print('At the end');
    print(searchNames);
    return searchNames;
  }

  Future<void> editClientAddress(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("address", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
                .doc(element.id)
                .update({"address": future})
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

  Future<void> editClientID(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("id", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
                .doc(element.id)
                .update({"id": future})
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

  Future<void> editClientPhone(String current, String future) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //print(user.uid);
        firestoreInstance
            .collection("allow-users")
            .doc(user.uid)
            .collection("clients")
            .where("phone", isEqualTo: current)
            .get()
            .then((value) {
          print("Documents found: ${value.docs.length}");
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("allow-users")
                .doc(user.uid)
                .collection("clients")
                .doc(element.id)
                .update({"phone": future})
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

  Future<dynamic> getClients() async {
    // CollectionReference collectionRef =
    //     FirebaseFirestore.instance.collection("clients");
    // // .doc(FirebaseAuth.instance.currentUser?.uid)
    // // .collection("likedMovies");
    // QuerySnapshot querySnapshot = await collectionRef.get();

    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection("allow-users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("clients");
    QuerySnapshot querySnapshot = await _collectionRef.get();

    clientNames.addAll(querySnapshot.docs.map((doc) => doc["name"]).toList());
    IDs.addAll(querySnapshot.docs.map((doc) => doc["id"]).toList());
    emails.addAll(querySnapshot.docs.map((doc) => doc["email"]).toList());
    phones.addAll(querySnapshot.docs.map((doc) => doc["phone"]).toList());
    all_details
        .addAll(querySnapshot.docs.map((doc) => doc["details"]).toList());
    addresses.addAll(querySnapshot.docs.map((doc) => doc["address"]).toList());
    all_diagnoses
        .addAll(querySnapshot.docs.map((doc) => doc["diagnosis"]).toList());
    print(clientNames);
    return clientNames;
  }
}
