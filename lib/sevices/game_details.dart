import 'package:black_pearl/pages/squad_builder/squad_builder_game.dart';
import 'package:black_pearl/pages/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:black_pearl/models/game_model.dart';
import 'package:black_pearl/pages/home/home_screen.dart';

class GameDetails extends StatelessWidget {
  final Game game;

  GameDetails({Key? key, required this.game}) : super(key: key);
  CollectionReference gamesTable =
      FirebaseFirestore.instance.collection('games');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(game.opponentName.toString()),
      subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy").format(game.gameDate)),
      onTap: () => showDialog(
          context: context,
          builder: (contexxt) => Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          './todo', //edit
                          arguments: game,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        final confirm = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Warinig!"),
                                content:
                                    Text("Are you sure you want to delete?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: Text("Delete")),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                ],
                              ),
                            ) ??
                            false;
                        if (confirm) {
                          gamesTable.doc(game.documentId).delete();
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
                body: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    Text("Idk what was here"),
                    ListTile(
                      leading: Icon(Icons.event),
                      title: Text(
                        game.opponentName,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy")
                          .format(game.gameDate)),
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              './squad_builder_game',
                              arguments: game);
                        },
                        child: Text("Update Squad")),
                  ],
                ),
              )),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => Navigator.pushNamed(
          context,
          './todo', //edit event
          arguments: game,
        ),
      ),
    );
  }
}
