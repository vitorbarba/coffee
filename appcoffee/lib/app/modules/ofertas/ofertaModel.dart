import 'package:cloud_firestore/cloud_firestore.dart';

class Oferta {
  String firstName;
  String lastName;
  String documentID;

  Oferta(this.firstName, this.lastName);

  Oferta.fromfirestoresnapshot(DocumentSnapshot snap)
      : documentID = snap.documentID,
        firstName = snap.data['firstName'],
        lastName = snap.data['lastName'];

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
