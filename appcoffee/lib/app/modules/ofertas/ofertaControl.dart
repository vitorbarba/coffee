import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './ofertaModel.dart';

part 'ofertaControl.g.dart';

final Firestore _ofertaControl = Firestore.instance;

class MobxofertaControl = MobxofertaControlBase with _$MobxofertaControl;

abstract class MobxofertaControlBase implements Store {
  MobxofertaControlBase();

  @observable
  Oferta oferta;

  @observable
  ObservableFuture<List<Oferta>> ofertas =
      ObservableFuture<List<Oferta>>.value([]);

  @computed
  List<Oferta> get ofertasFromFirestore => ofertas.value;

  @action
  Future<bool> getOfertas() async {
    List<Oferta> ofertas = List();
    var query = _ofertaControl.collection('ofertas').getDocuments();
    await query.then((snap) {
      print('snap length: ${snap.documents.length}');

      if (snap.documents.length > 0) {
        for (var doc in snap.documents) {
          ofertas.add(Oferta.fromfirestoresnapshot(doc));
          // print('oferta docID: ${doc.documentID}');
        }

        //print('ofertas length: ${ofertas.length}');

        ofertas = ObservableFuture<List<Oferta>>.value(ofertas);
      }
    });

    return Future.value(true);
  }

  @action
  Future<bool> delOferta(Oferta oferta) async {
    if (oferta != null) {
      _ofertaControl.collection('ofertas').document(oferta.documentID).delete();
    }

    return Future.value(true);
  }

  @action
  Future<bool> pushOferta(Oferta oferta) async {
    if (oferta != null) {
      _ofertaControl.collection('ofertas').add(oferta.toJson());
    }
    return Future.value(true);
  }
}
