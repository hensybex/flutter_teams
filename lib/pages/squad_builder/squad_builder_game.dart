import 'dart:async';

import 'package:black_pearl/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/sevices/sidebar.dart';
import 'package:black_pearl/pages/squad_builder/movable_object.dart';
import 'package:flutter/rendering.dart';
import 'package:black_pearl/models/game_model.dart';

class SquadBuilderGame extends StatefulWidget {
  final Game game;

  const SquadBuilderGame({Key? key, required this.game}) : super(key: key);

  @override
  _SquadBuilderGameState createState() => _SquadBuilderGameState();
}

class _SquadBuilderGameState extends State<SquadBuilderGame> {
  late Stream<QuerySnapshot> _playersStream;
  UserModel emptyPlayer = UserModel(firstName: "Empty", secondName: "Empty");
  List players = [];
  List playersList = [];
  late List<dynamic> startingSquad;
  late List<dynamic> startingList;
  late List<dynamic> playersNames;
  late List<dynamic> playersIds;
  late Map<String, String> namesMap;
  var firstNamesMap = {};
  var secondNamesMap = {};
  Color activeColor = Colors.white;
  static List<bool> activePlayers = List<bool>.filled(36, true, growable: true);
  static List<dynamic> activeTargets =
      List<String>.filled(36, '0', growable: true);
  static Map<dynamic, dynamic> firstNameState = Map();
  static Map<dynamic, dynamic> secondNameState = Map();

  @override
  void initState() {
    super.initState();
    _playersStream = FirebaseFirestore.instance
        .collection('users')
        .where('wrole', isEqualTo: 'Player')
        .where('subscripted', arrayContains: widget.game.documentId)
        .where('onBench', isEqualTo: true)
        .snapshots();

    FirebaseFirestore.instance
        .collection('users')
        .where('wrole', isEqualTo: 'Player')
        .where('subscripted', arrayContains: widget.game.documentId)
        .where('onBench', isEqualTo: true)
        .get()
        .then((value) {
      startingList = value.docs.toList();
      for (var i = 0; i < startingList.length; i++) {
        firstNamesMap[startingList[i].data()['uid']] =
            startingList[i].data()['firstName'];
        secondNamesMap[startingList[i].data()['uid']] =
            startingList[i].data()['secondName'];
      }
    }).whenComplete(() {
      setState(() {
        firstNameState = firstNamesMap;
        secondNameState = secondNamesMap;
      });
    });

    FirebaseFirestore.instance
        .collection("games")
        .doc(widget.game.id)
        .get()
        .then((value) {
      startingSquad = value.get('startingSquad');
    }).whenComplete(() {
      setState(() {
        if (startingSquad == null) {
          activeTargets = List<String>.filled(36, '0', growable: true);
        } else {
          activeTargets = startingSquad;
        }
      });
      print("ERROR1");
      print(activeTargets);
      print("ERROR2");
    });

    //print(activeTargets);

    /* FirebaseFirestore.instance
        .collection("games")
        .doc(widget.game.id)
        .snapshots()
        .listen((event) {
      startingSquad = event.get("startingSquad").whenComplete(() {
        setState(() {
          activeTargets = startingSquad;
        });
      }); */
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color mainColor = Colors.grey.withOpacity(0.5);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(widget.game.isHome == true
            ? ('Чёрная Жемчужина - ' + widget.game.opponentName)
            : (widget.game.opponentName + ' - Чёрная Жемчужина')),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                commitChanges(activeTargets);
              },
              child: const Text('Save Formation')),
        ],
      ),
      drawer: SideBarWidget(),
      body: Column(
        children: [
          Expanded(
            flex: 85,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Football_field.svg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: null /* add child content here */,
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleRow(
                        secondNameState: secondNameState,
                        rowNum: 0,
                        firstNameState: firstNameState,
                        activeTargets: activeTargets,
                        activePlayer: emptyPlayer,
                        activeTarget: '0',
                        activeColor: activeColor,
                      ),
                    ),
                    Expanded(
                      child: SingleRow(
                        secondNameState: secondNameState,
                        rowNum: 1,
                        firstNameState: firstNameState,
                        activeTargets: activeTargets,
                        activePlayer: emptyPlayer,
                        activeTarget: '0',
                        activeColor: activeColor,
                      ),
                    ),
                    Expanded(
                      child: SingleRow(
                        secondNameState: secondNameState,
                        rowNum: 2,
                        firstNameState: firstNameState,
                        activeTargets: activeTargets,
                        activePlayer: emptyPlayer,
                        activeTarget: '0',
                        activeColor: activeColor,
                      ),
                    ),
                    Expanded(
                      child: SingleRow(
                        secondNameState: secondNameState,
                        rowNum: 3,
                        firstNameState: firstNameState,
                        activeTargets: activeTargets,
                        activePlayer: emptyPlayer,
                        activeTarget: '0',
                        activeColor: activeColor,
                      ),
                    ),
                    Expanded(
                      child: SingleRow(
                        secondNameState: secondNameState,
                        rowNum: 4,
                        firstNameState: firstNameState,
                        activeTargets: activeTargets,
                        activePlayer: emptyPlayer,
                        activeTarget: '0',
                        activeColor: activeColor,
                      ),
                    ),
                    Expanded(
                      child: SingleRow(
                        secondNameState: secondNameState,
                        rowNum: 5,
                        firstNameState: firstNameState,
                        activeTargets: activeTargets,
                        activePlayer: emptyPlayer,
                        activeTarget: '0',
                        activeColor: activeColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 15,
            child: StreamBuilder(
              stream: _playersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LinearProgressIndicator();
                }
                playersList = snapshot.data!.docs;
                return Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    itemCount: playersList.length,
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return Center(
                        child: PlayerCard(
                          activePlayer:
                              UserModel.fromSnapshot(playersList[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void commitChanges(List<dynamic> activeTargets) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var playerInfo = Map<String, Object?>();
    var gameInfo = Map<String, Object?>();
    var tmp = List<String>.from(activeTargets);

    tmp.removeWhere((element) => element == '0');
    playerInfo['onBench'] = true;
    for (var i = 0; i < tmp.length; i++) {
      firebaseFirestore.collection("users").doc(tmp[i]).update(playerInfo);
    }
    gameInfo['startingSquad'] = activeTargets;
    firebaseFirestore.collection("games").doc(widget.game.id).update(gameInfo);
  }
}

class SingleCard extends StatefulWidget {
  UserModel emptyPlayer = UserModel(firstName: "Empty", secondName: "Empty");
  UserModel activePlayer;
  String activeTarget;
  Color activeColor;
  int arrayNum;
  List<dynamic> activeTargets;
  Map<dynamic, dynamic> firstNameState;
  Map<dynamic, dynamic> secondNameState;

  SingleCard({
    Key? key,
    required this.secondNameState,
    required this.firstNameState,
    required this.activeTargets,
    required this.activePlayer,
    required this.activeTarget,
    required this.activeColor,
    required this.arrayNum,
  }) : super(key: key);

  @override
  _SingleCardState createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var info = Map<String, Object?>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: PlayerTarget(
          arrayNum: widget.arrayNum,
          activeTarget: widget.activeTargets[widget.arrayNum] != '0'
              ? widget.activeTargets[widget.arrayNum]
              : widget.activeTarget,
          activePlayer: widget.activeTargets[widget.arrayNum] != '0'
              ? UserModel(
                  firstName: widget
                      .firstNameState[widget.activeTargets[widget.arrayNum]],
                  secondName: widget
                      .secondNameState[widget.activeTargets[widget.arrayNum]],
                )
              : widget.emptyPlayer,
          activeColor: widget.activeColor,
        ),
      ),
    );
  }
}

class SingleRow extends StatefulWidget {
  UserModel emptyPlayer = UserModel(firstName: "Empty", secondName: "Empty");
  UserModel activePlayer;
  String activeTarget;
  Color activeColor;
  int rowNum;
  List<dynamic> activeTargets;
  Map<dynamic, dynamic> firstNameState;
  Map<dynamic, dynamic> secondNameState;

  SingleRow({
    Key? key,
    required this.firstNameState,
    required this.secondNameState,
    required this.rowNum,
    required this.activeTargets,
    required this.activePlayer,
    required this.activeTarget,
    required this.activeColor,
  }) : super(key: key);

  @override
  _SingleRowState createState() => _SingleRowState();
}

class _SingleRowState extends State<SingleRow> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SingleCard(
          firstNameState: widget.firstNameState,
          secondNameState: widget.secondNameState,
          arrayNum: widget.rowNum * 5,
          activeTarget: '0',
          activePlayer: widget.emptyPlayer,
          activeColor: Colors.white,
          activeTargets: widget.activeTargets,
        ),
        /* Expanded(
            child: Center(
              child: PlayerTarget(
                arrayNum: 0,
                activeTarget: false,
                activePlayer: emptyPlayer,
                activeColor: Colors.white,
              ),
            ),
          ), */
        SingleCard(
          firstNameState: widget.firstNameState,
          secondNameState: widget.secondNameState,
          arrayNum: widget.rowNum * 5 + 1,
          activeTarget: '0',
          activePlayer: widget.emptyPlayer,
          activeColor: Colors.white,
          activeTargets: widget.activeTargets,
        ),
        SingleCard(
          firstNameState: widget.firstNameState,
          secondNameState: widget.secondNameState,
          arrayNum: widget.rowNum * 5 + 2,
          activeTarget: '0',
          activePlayer: widget.emptyPlayer,
          activeColor: Colors.white,
          activeTargets: widget.activeTargets,
        ),
        SingleCard(
          firstNameState: widget.firstNameState,
          secondNameState: widget.secondNameState,
          arrayNum: widget.rowNum * 5 + 3,
          activeTarget: '0',
          activePlayer: widget.emptyPlayer,
          activeColor: Colors.white,
          activeTargets: widget.activeTargets,
        ),
        SingleCard(
          firstNameState: widget.firstNameState,
          secondNameState: widget.secondNameState,
          arrayNum: widget.rowNum * 5 + 4,
          activeTarget: '0',
          activePlayer: widget.emptyPlayer,
          activeColor: Colors.white,
          activeTargets: widget.activeTargets,
        ),
        /* Expanded(
            child: Center(
              child: PlayerTarget(
                arrayNum: 2,
                activeTarget: false,
                activePlayer: emptyPlayer,
                activeColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: PlayerTarget(
                arrayNum: 3,
                activeTarget: false,
                activePlayer: emptyPlayer,
                activeColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: PlayerTarget(
                arrayNum: 4,
                activeTarget: false,
                activePlayer: emptyPlayer,
                activeColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: PlayerTarget(
                arrayNum: 5,
                activeTarget: false,
                activePlayer: emptyPlayer,
                activeColor: Colors.white,
              ),
            ),
          ), */
      ],
    );
  }
}

UserModel getPlayer(String playerId, List<dynamic> activeTargets) {
  UserModel player = UserModel(firstName: "Empty", secondName: "Empty");
  FirebaseFirestore.instance
      .collection("users")
      .doc(playerId)
      .get()
      .then((value) {
    player = UserModel.fromMap(value.data());
  });
  return player;
}

class PlayerCard extends StatelessWidget {
  @override
  UserModel activePlayer;

  PlayerCard({
    Key? key,
    required this.activePlayer,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height,
        child: Draggable(
          data: activePlayer,
          child: Card(
            child: Column(
              children: [
                Text(activePlayer.firstName!),
                Text(activePlayer.secondName!),
              ],
            ),
          ),
          feedback: Card(
            child: Column(
              children: [
                Text("Player Photo"),
                Text("Player Name"),
              ],
            ),
          ),
          childWhenDragging: Card(
            child: Column(
              children: [
                Text("Player Photo"),
                Text("Player Name"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerTarget extends StatefulWidget {
  String activeTarget;
  int arrayNum;
  Color activeColor;
  UserModel activePlayer;

  PlayerTarget({
    Key? key,
    required this.arrayNum,
    required this.activeTarget,
    required this.activeColor,
    required this.activePlayer,
  }) : super(key: key);

  @override
  _PlayerTargetState createState() => _PlayerTargetState();
}

class _PlayerTargetState extends State<PlayerTarget> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var info = Map<String, Object?>();

  @override
  Widget build(BuildContext context) {
    return DragTarget<UserModel>(
      builder: (context, data, rejected) {
        return Container(
          width: 100,
          height: 100,
          color: Colors.blue.withOpacity(0.1),
          child: widget.activeTarget == '0'
              ? Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                )
              : PlayerCard(
                  activePlayer: widget.activePlayer,
                ),
        );
      },
      onLeave: (data) {
        if (widget.activePlayer.uid == data?.uid) {
          setState(
            () {
              widget.activeTarget = '0';
              _SquadBuilderGameState.activeTargets[widget.arrayNum] = '0';
              _SquadBuilderGameState.activePlayers[widget.arrayNum] = true;
              info['onBench'] = true;
              firebaseFirestore
                  .collection("users")
                  .doc(widget.activePlayer.uid)
                  .update(info);
            },
          );
        }
      },
      onAccept: (data) {
        setState(() {
          widget.activeTarget = '1';
          widget.activePlayer = data;
          _SquadBuilderGameState.activeTargets[widget.arrayNum] =
              widget.activePlayer.uid!;
          info['onBench'] = false;
          firebaseFirestore
              .collection("users")
              .doc(widget.activePlayer.uid)
              .update(info);
        });
      },
    );
  }
}
