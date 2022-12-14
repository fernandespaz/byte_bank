import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';
import '../app_database.dart';

class ContactDao{

  static const String tableSql = 'CREATE TABLE contacts('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)';


Future<int> save(Contact contact) async{
  final Database db = await getDatabase();
  final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {

  final Database db = await getDatabase();
  final List<Contact> contacts = [];
  for (Map<String, dynamic> row in await db.query('contacts')) {
    final Contact contact = Contact(
      row['id'],
      row['name'],
      row['account_number'],
    );
    contacts.add(contact);
  }
    return contacts; 
}


}