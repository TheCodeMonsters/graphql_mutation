import 'package:flutter/material.dart';
import 'package:flutter_mutation/src/screens/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:math' as math;

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql(User.mutation),
        ),
        builder: (RunMutation runMutation, QueryResult? result) {
          return Center(
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(15)),
                TextField(
                  decoration: const InputDecoration(helperText: "Enter name"),
                  controller: _nameController,
                ),
                const Padding(padding: EdgeInsets.all(15)),
                TextField(
                  decoration: const InputDecoration(helperText: "Enter email"),
                  controller: _emailController,
                ),
                const Padding(padding: EdgeInsets.all(15)),
                MaterialButton(
                  child: const Text(
                    "Add User",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () => runMutation({
                    'email': _emailController.text,
                    'id': math.Random().nextInt(100),
                    'name': _nameController.text
                  }),
                )
              ],
            ),
          );
        },
        update: (Cache cache, QueryResult result) {
          return cache;
        },
        onCompleted: (dynamic resultdata) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
