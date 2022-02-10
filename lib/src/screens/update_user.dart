import 'package:flutter/material.dart';
import 'package:flutter_mutation/src/screens/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser(
      {Key? key, required this.name, required this.email, required this.id})
      : super(key: key);

  final String name;
  final String email;
  final int id;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql(User.mutationUpdate),
        ),
        builder: (RunMutation runMutationUpdate, QueryResult? resultUpdate) {
          return Mutation(
            options: MutationOptions(
              document: gql(User.mutationDelete),
            ),
            builder:
                (RunMutation runMutationDelete, QueryResult? resultDelete) {
              return Center(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        helperText: "Update Name",
                        hintText: widget.name,
                      ),
                      controller: _nameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        helperText: "Update Email",
                        hintText: widget.email,
                      ),
                      controller: _emailController,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () => runMutationUpdate({
                        'id': widget.id,
                        'name': _nameController.text,
                        'email': _emailController.text
                      }),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () => runMutationDelete({'id': widget.id}),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            },
            // update: (GraphqlCache cache, QueryResult result) {
            //   return cache;
            // },
            // onCompleted: (dynamic resultData) {
            //   Navigator.pop(context);
            // },
          );
        },
        // update: (Cache, cacheUpdate, QueryResult result) {
        //   return cacheUpdate;
        // },
        // onCompleted: (dynamic resultData) {
        //   Navigator.pop(context);
        // },
      ),
    );
  }
}
