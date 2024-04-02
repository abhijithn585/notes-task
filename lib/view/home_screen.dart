import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controller/auth_provider.dart';
import 'package:task/controller/firebase_provider.dart';
import 'package:task/model/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final pro = Provider.of<FirestoreProvider>(context, listen: false);
    pro.fetchNotes();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AuthProviders>(context, listen: false);
    final pro2 = Provider.of<FirestoreProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SizedBox(
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Material(
                      child: TextField(
                        controller: detailsController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addNotes();
                      },
                      child: Text("Done"))
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "NOTES",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                pro.signOut();
              },
              icon: const Icon(
                Icons.login,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 80),
        child: Column(
          children: [
            Consumer<FirestoreProvider>(
                builder: (context, value, child) => Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: pro2.notesList.length,
                        itemBuilder: (context, index) {
                          final data = pro2.notesList[index];
                          return Container(
                            decoration: BoxDecoration(color: Colors.amber),
                            height: 200,
                            child: Column(
                              children: [
                                Text(
                                  '${data.title}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 40),
                                )
                              ],
                            ),
                          );
                        })))
          ],
        ),
      ),
    );
  }

  addNotes() {
    final pro = Provider.of<FirestoreProvider>(context, listen: false);
    final uid = pro.service.auth.currentUser!.uid;
    NotesModel notes = NotesModel(
        title: titleController.text, details: detailsController.text);
    pro.addNotes(notes, notes.title!, uid);
    Navigator.pop(context);
  }
}
