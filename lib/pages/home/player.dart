import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/router.gr.dart';
import '../auth/login_page.dart';
import 'package:black_pearl/models/user_model.dart';

import 'package:black_pearl/sevices/sidebar.dart';
import 'package:intl/intl.dart';

class Player extends StatefulWidget {
  String id;
  Player({required this.id});
  @override
  _PlayerState createState() => _PlayerState(id: id);
}

class _PlayerState extends State<Player> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('games')
      .where('Game Date', isGreaterThan: DateTime.now())
      //.where('Opponent', isEqualTo: 'Lizok')
      .snapshots();
  List<DocumentSnapshot> gamesList = [];
  String id;
  var rooll;
  var emaill;
  var firstName;
  var secondName;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;

  _PlayerState({required this.id});
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(id)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      setState(() {
        emaill = loggedInUser.email.toString();
        firstName = loggedInUser.firstName.toString();
        secondName = loggedInUser.secondName.toString();
        rooll = loggedInUser.wrole.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, $firstName $secondName!",
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: SideBarWidget(),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          gamesList = snapshot.data!.docs;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: gamesList.length,
              itemBuilder: (_, index) {
                return Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: ListTile(
                          title: Text(
                            snapshot.data!.docChanges[index].doc['Opponent'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docChanges[index].doc['Opponent'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              DateFormat.yMMMd()
                                  .add_jm()
                                  .format(snapshot
                                      .data!.docChanges[index].doc['Game Date']
                                      .toDate())
                                  .toString(),
                              /*snapshot.data!.docChanges[index]
                                        .doc['Game Date']
                                        .toDate()
                                        .toString(),*/
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                TextButton(
                                  child: const Text('Will not attend'),
                                  onPressed: () {
                                    unsubscribeFromEvent(
                                      snapshot.data!.docChanges[index]
                                          .doc['documentId'],
                                      this.id,
                                    );
                                  },
                                ),
                                TextButton(
                                  child: const Text('Maybe'),
                                  onPressed: () {
                                    semiSubscribeToEvent(
                                      snapshot.data!.docChanges[index]
                                          .doc['documentId'],
                                      this.id,
                                    );
                                  },
                                ),
                                TextButton(
                                  child: const Text('Will attend'),
                                  onPressed: () {
                                    subscribeToEvent(
                                      snapshot.data!.docChanges[index]
                                          .doc['documentId'],
                                      this.id,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('Check Squad'),
                              onPressed: () {
                                context.pushRoute(SquadBuilderRoute(
                                    gameId: snapshot.data!.docChanges[index]
                                        .doc['documentId']));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['Opponent'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),*/
                );
              },
            ),
          );
        },
      ),
    );
  }

  void subscribeToEvent(String gameDocId, String playerId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user!.uid;

    List list = [gameDocId];
    List gameChanges = [user.uid];

    final userUpdates = <String, dynamic>{
      "subscripted": FieldValue.arrayUnion(list),
      "semiSubscripted": FieldValue.arrayRemove(list),
    };

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update(userUpdates);

    final gameUpdates = <String, dynamic>{
      "onBench": FieldValue.arrayUnion(gameChanges),
    };
    //await firebaseFirestore.collection("games").doc(gameId).update(updates2);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Статус обновлён!'),
      ),
    );
  }

  void semiSubscribeToEvent(String gameDocId, String playerId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user!.uid;

    List list = [gameDocId];
    List list2 = [user.uid];

    final updates = <String, dynamic>{
      "semiSubscripted": FieldValue.arrayUnion(list),
      "subscripted": FieldValue.arrayRemove(list),
    };
    final updates2 = <String, dynamic>{
      "onBench": FieldValue.arrayUnion(list2),
    };

    await firebaseFirestore.collection("users").doc(user.uid).update(updates);
    //await firebaseFirestore.collection("games").doc(gameId).update(updates2);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Статус обновлён!'),
      ),
    );
  }

  void unsubscribeFromEvent(String gameDocId, String playerId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user!.uid;

    List<dynamic> list = [gameDocId];
    List list2 = [user.uid];

    final updates = <String, dynamic>{
      "semiSubscripted": FieldValue.arrayRemove(list),
      "subscripted": FieldValue.arrayRemove(list),
    };
    await firebaseFirestore.collection("users").doc(user.uid).update(updates);
    //await firebaseFirestore.collection("games").doc(gameId).update(updates2);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Статус обновлён!'),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    LinearProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
