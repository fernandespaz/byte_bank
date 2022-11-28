// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../database/dao/contact_dao.dart';
import '../models/contact.dart';
import 'contacts_form.dart';

class ContactsList extends StatelessWidget {

  final ContactDao _dao = ContactDao(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Contacts'),
      ),
      body: FutureBuilder(
          future:
              Future.delayed(Duration(seconds: 1)).then((value) => _dao.findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      Text('Loading'),
                    ],
                  ),
                );
              case ConnectionState.none:
                // ignore: todo
                // TODO: Handle this case.
                break;
              case ConnectionState.active:
                // ignore: todo
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                // ignore: todo
                // TODO: Handle this case.
                break;
            }
            final List<Contact>? contacts = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return _ContactItem(contact: contact);
              },
              itemCount: contacts!.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
