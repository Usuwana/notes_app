import 'package:notes_app/auth_gate.dart';
import 'package:notes_app/data/notes.dart';
import 'package:notes_app/screens/SomethingWentWrong.dart';
import 'package:notes_app/screens/note.dart';
import 'package:notes_app/screens/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final searchController = TextEditingController();
  Notes notes = Notes();
  late String new_title;
  late String new_note;
  late String new_time;

  Future<dynamic>? _notesFuture;

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    _notesFuture = notes.getNotes();
    new_title = '';
    new_note = '';
    new_time = '';
    //reloadData();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /*void reloadData() {
    // Simulate reloading data, fetching new data, or any other update
    setState(() {
      super.initState();
      _workerNamesFuture = employees.getWorkerNames();
    });
  }*/

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    //employees.workerNames.clear();
    titleController.dispose();
    noteController.dispose();
    searchController.dispose();

    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check if the app is resumed or inactive
    if (state == AppLifecycleState.resumed) {
      reloadData(); // Reload data when the page comes into focus
    }
  }*/

  Future<void> deleteUser(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      bool reAuthSuccess = false;

      while (!reAuthSuccess) {
        // Keep prompting until re-authentication succeeds or user cancels
        try {
          // Securely prompt the user for their password
          final password = await _getPasswordFromUser(context);

          if (password == null) {
            // User canceled the dialog, exit the loop
            break;
          }

          // Re-authenticate the user with the provided password
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: password,
          );

          await user.reauthenticateWithCredential(credential);
          reAuthSuccess =
              true; // Exit the loop if re-authentication is successful

          // Now delete the user
          await user.delete();
          print('User deleted successfully');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account deleted successfully')),
          );

          // Redirect to login page or exit the app
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthGate()),
          );
        } catch (e) {
          if (e is FirebaseAuthException && e.code == 'wrong-password') {
            // Inform the user that the password was incorrect and prompt again
            _showErrorDialog(context, 'Incorrect password. Please try again.');
          } else {
            print('Error during re-authentication: $e');
            _showErrorDialog(
                context, 'Failed to delete account. Try again later.');
            break; // Exit the loop if it's another type of error
          }
        }
      }
    }
  }

// Function to securely get the user's password and handle error feedback
  Future<String?> _getPasswordFromUser(BuildContext context) async {
    String? password;
    String? errorMessage;

    // Keep showing the dialog until a valid password is provided or user cancels
    while (password == null) {
      password = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController passwordController = TextEditingController();

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text('Re-enter Password'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(),
                        errorText: errorMessage, // Show error message if set
                      ),
                      obscureText: true, // Hide the password
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(null); // Close without returning a password
                    },
                  ),
                  TextButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      if (passwordController.text.isEmpty) {
                        setState(() {
                          errorMessage = 'Password cannot be empty';
                        });
                      } else {
                        Navigator.of(context).pop(passwordController
                            .text); // Return the entered password
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      );

      // If user canceled, break out of the loop
      if (password == null) break;
    }

    return password;
  }

// Show an error dialog with a custom message
  void _showErrorDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the error dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFF3D663), //change your color here
        ),
        /*centerTitle: true,
        title: SizedBox(
          height: 80,
          child: Image.asset(
            'assets/logotrans.png',
            fit: BoxFit.contain, // Adjust this to fit the image properly
          ),
        ),*/
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
              child: IconButton(
                  onPressed: () {
                    // FirebaseAuth.instance.currentUser!.delete();
                    // _signOut();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete your Account?'),
                          content: const Text(
                              '''If you select Delete we will delete your account on our server.

Your app data will also be deleted and you won't be able to retrieve it.

Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                // Call the delete account function
                                _getPasswordFromUser(context);
                                deleteUser(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ))),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                _signOut();
              },
              child: Text('Sign Out',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255))),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Search(searchTerm: searchController.text)),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 68, 68, 68),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  labelText: 'SEARCH NOTES...',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: _notesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        //_handleRefresh();
                        //(context as Element).reassemble();
                        setState(() {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                          //ModalRoute.withName('/'));
                        });
                      },
                      child: ListView.builder(
                          itemCount: notes.titles.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Dismissible(
                                  key: ObjectKey(notes.titles[index]),
                                  background: stackBehindDismiss(),
                                  onDismissed: (direction) {
                                    var item = notes.titles.elementAt(index);

                                    notes.removeNote(notes.titles[index]);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Note deleted!"),
                                    ));
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                        ModalRoute.withName('/'));
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      // List<QueryDocumentSnapshot> documents =
                                      //     snapshot.data!;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Note(
                                                    title: notes.titles[index]
                                                        .toString(),
                                                    note: notes.notes[index],
                                                    time: notes
                                                        .updates_times[index],

                                                    // documentID:
                                                    //     documents[index].id,
                                                  )));
                                      //print('Check me out:');
                                      //print(documents);
                                    },
                                    child: Card(
                                      color: Color(0xFF989898),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(children: [
                                              // Container(
                                              //   child: const CircleAvatar(
                                              //       radius: 28,
                                              //       backgroundImage:
                                              //           AssetImage('assets/logo.png')),
                                              // ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                child: Text(
                                                  notes.titles[index]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  child: const Icon(
                                                      Icons.arrow_circle_right),
                                                ),
                                              )
                                            ]),
                                          ),
                                          const Text(
                                            '<<Swipe to delete note>>',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color.fromARGB(
                                                    255, 62, 62, 62)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(color: Colors.black)
                              ],
                            );
                          }),
                    );
                  } else if (snapshot.hasError) {
                    print("Checkout the error:");
                    print(snapshot.error);
                    return const SomethingWentWrong();
                  } else if (!snapshot.hasData) {
                    return const Text('No notes found');
                  }
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const ProfileShimmer(
                          hasBottomLines: true,
                        );
                      });
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 68, 68, 68),
        tooltip: 'Increment',
        onPressed: () {
          DateTime now = DateTime.now();
          notes.addNote(new_title, new_note, now.toString(), now.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Note(title: new_title, note: new_note, time: new_time
                          // documentID:
                          //     documents[index].id,
                          )));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
