import 'package:notes_app/data/notes.dart';
import 'package:notes_app/screens/home.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  const Note(
      {super.key, required this.title, required this.note, required this.time
      //required this.documentID
      });

  final String? title;
  final String? note;
  final String? time;

  //final dynamic documentID;

  @override
  State<StatefulWidget> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  Notes notes = Notes();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title!;
    noteController.text = widget.note!;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    //employees.workerNames.clear();
    titleController.dispose();
    noteController.dispose();
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: ,

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
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context)
                                .viewInsets
                                .bottom, // Adjusts padding when the keyboard appears
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                ),
                                controller: titleController,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Note',
                                ),
                                controller: noteController,
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  /*if (widget.clientName !=
                                      nameController.text) {
                                    clients.editClientName(widget.clientName!,
                                        nameController.text);
                                  }
                                  if (widget.clientAddress !=
                                      addressController.text) {
                                    clients.editClientAddress(
                                        widget.clientAddress!,
                                        addressController.text);
                                  }
                                  if (widget.clientDetails !=
                                      detailsController.text) {
                                    clients.editClientDetails(
                                        widget.clientDetails!,
                                        detailsController.text);
                                  }
                                  if (widget.clientDiagnosis !=
                                      diagnosisController.text) {
                                    clients.editClientDiagnosis(
                                        widget.clientDiagnosis!,
                                        diagnosisController.text);
                                  }
                                  if (widget.clientEmail !=
                                      emailController.text) {
                                    clients.editClientEmail(widget.clientEmail!,
                                        emailController.text);
                                  }
                                  if (widget.clientID != idController.text) {
                                    clients.editClientID(
                                        widget.clientID!, idController.text);
                                  }
                                  if (widget.clientPhone !=
                                      phoneController.text) {
                                    clients.editClientPhone(widget.clientPhone!,
                                        phoneController.text);
                                  }*/

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      "Client details updated",
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Color(0xFFF3D663),
                                  ));
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Home() /*Note(
                                                clientName: widget.clientName,
                                                clientID: widget.clientID,
                                                clientEmail: widget.clientEmail,
                                                clientPhone: widget.clientPhone,
                                                clientDetails:
                                                    widget.clientDetails,
                                                clientAddress:
                                                    widget.clientAddress,
                                                clientDiagnosis:
                                                    widget.clientDiagnosis,
                                              )*/
                                          ),
                                      ModalRoute.withName('/Note'));
                                },
                                child: const Text('Save Changes'),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0xFFF3D663)),
                ),
              ),
            ),
          ]),
      backgroundColor: const Color(0xFF989898),
      body: RefreshIndicator(
        onRefresh: () async {
          //_handleRefresh();
          //(context as Element).reassemble();
          setState(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home() /*Note(
                          clientName: widget.clientName,
                          clientID: widget.clientID,
                          clientEmail: widget.clientEmail,
                          clientPhone: widget.clientPhone,
                          clientDetails: widget.clientDetails,
                          clientAddress: widget.clientAddress,
                          clientDiagnosis: widget.clientDiagnosis,
                        )*/
                    ),
                ModalRoute.withName('/Note'));
          });
        },
        child: Column(
          children: [
            Center(
              child: Text(
                widget.title.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24.0),
                //textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          //text: 'Extra Details/ Notes: ',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: widget.note.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
