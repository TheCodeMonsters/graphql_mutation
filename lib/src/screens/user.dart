class User {
  static String query = '''
    query{
      User {
        email
        id
        name
      }
   } 
  ''';

  static String mutationUpdate = '''
      mutation Update_User(\$id:Int!,\$email:String!,\$name:String!){
        update_User(where: 
          {id: {_eq: \$id}}, 
            _set: {email: \$email, name: \$name}) {
              affected_rows
            }
      } 
  ''';

  static String mutationDelete = '''
    mutation delete_User(\$id:Int!){
      delete_User(where: {id: {_eq: \$id}}) {
        affected_rows
      }
    } 
  ''';

  static String mutationAdd = '''
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
}
