import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:math' as math;

class AddUser extends StatefulWidget {
  AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String mutationAdd = '''
      mutation Insert_user(\$email:String!,\$id:Int!,\$name:String!) {
        insert_User(objects:
          {email: \$email, 
            id: \$id, 
            name: \$name}) {
          affected_rows
        }
      }
    '''
      .replaceAll('\n', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql(mutationAdd),
          update: (cache, QueryResult? result) {
            return cache;
          },
          // onCompleted: (dynamic resultData) {
          //   Navigator.pop(context);
          //   print(resultData);
          // },
        ),
        builder: (RunMutation runMutation, QueryResult? result) {
          return Column(
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
                onPressed: () {
                  runMutation(
                    {
                      'email': _emailController.text,
                      'id': math.Random().nextInt(100),
                      'name': _nameController.text
                    },
                  );
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      ),
    );
  }
}
