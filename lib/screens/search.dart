import 'package:notes_app/data/notes.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:notes_app/screens/SomethingWentWrong.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.searchTerm});

  final String? searchTerm;

  @override
  State<StatefulWidget> createState() => _SearchState();
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}

class _SearchState extends State<Search> {
  Notes notes = Notes();
  Future<dynamic>? _notesFuture;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    _clientsFuture = clients.searchClient(widget.searchTerm!);
    //reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFF3D663), //change your color here
        ),
        centerTitle: true,
        title: SizedBox(
          height: 80,
          child: Image.asset(
            'assets/logotrans.png',
            fit: BoxFit.contain, // Adjust this to fit the image properly
          ),
        ),
        backgroundColor: const Color(0xFF989898),
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
                      color: Color(0xFFF3D663))),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFF989898),
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
                      icon: const Icon(Icons.search)),
                  filled: true,
                  fillColor: Colors.grey,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  labelText: 'SEARCH CLIENTS...',
                  labelStyle: const TextStyle(color: Colors.black),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: _clientsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        //_handleRefresh();
                        //(context as Element).reassemble();
                        setState(() {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              ModalRoute.withName('/'));
                        });
                      },
                      child: ListView.builder(
                          itemCount: clients.searchNames.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // List<QueryDocumentSnapshot> documents =
                                    //     snapshot.data!;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Note(
                                                  clientName: clients
                                                      .searchNames[index]
                                                      .toString(),
                                                  clientID:
                                                      clients.searchIDs[index],
                                                  clientEmail: clients
                                                      .searchEmails[index],
                                                  clientPhone: clients
                                                      .searchPhones[index],
                                                  clientDetails: clients
                                                      .searchDetails[index]
                                                      .toString(),
                                                  clientAddress: clients
                                                      .searchAddresses[index],
                                                  clientDiagnosis: clients
                                                      .searchDiagnoses[index],
                                                )));
                                  },
                                  child: Container(
                                    child: Row(children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: Text(clients.searchNames[index]
                                            .toString()),
                                      ),
                                      const Spacer(),
                                      Container(
                                        child: const Icon(
                                            Icons.arrow_circle_right),
                                      )
                                    ]),
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
                    print(clients.searchNames.length);
                    return Container(
                      child: Text('No results for search term'),
                    );
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
    );
  }
}
