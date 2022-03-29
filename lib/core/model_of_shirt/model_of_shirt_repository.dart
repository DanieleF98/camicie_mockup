import 'package:camicie_mockup/core/model_of_shirt/models/model_of_shirt.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModelOfShirtRepository {
  final CollectionReference<dynamic> modelOfShirtCollection =
      FirebaseFirestore.instance.collection(modelOfShirtCollectionLabel);

  Future<QuerySnapshot<dynamic>> getAllModelsOfShirt() async {
    return modelOfShirtCollection.get();
  }

  Future<DocumentReference<dynamic>> addModelOfShirt(
    ModelOfShirt modelOfShirt,
  ) async {
    return modelOfShirtCollection.add(modelOfShirt.toJson());
  }

  Future<void> updateModelOfShirt(ModelOfShirt modelOfShirt) async {
    await modelOfShirtCollection
        .doc(modelOfShirt.id)
        .update(modelOfShirt.toJson());
  }

  Future<void> deleteModelOfShirt(ModelOfShirt modelOfShirt) async {
    await modelOfShirtCollection.doc(modelOfShirt.id).delete();
  }

  Future<void> removeAllModelsOfShirt() async {
    getAllModelsOfShirt().then((QuerySnapshot<dynamic> snapshot) {
      for (final DocumentSnapshot<dynamic> ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
