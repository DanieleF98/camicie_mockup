import 'package:camicie_mockup/core/size_model/models/size_model.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SizeModelRepository {
  final CollectionReference<dynamic> sizeModelCollection =
      FirebaseFirestore.instance.collection(sizeModelCollectionLabel);

  Future<QuerySnapshot<dynamic>> getAllSizeModels() {
    return sizeModelCollection.get();
  }

  Future<DocumentReference<dynamic>> addSizeModel(
    SizeModel sizeModel,
  ) {
    return sizeModelCollection.add(sizeModel.toJson());
  }

  Future<void> updateSizeModel(SizeModel sizeModel) async {
    await sizeModelCollection.doc(sizeModel.id).update(sizeModel.toJson());
  }

  Future<void> deleteSizeModel(SizeModel sizeModel) async {
    await sizeModelCollection.doc(sizeModel.id).delete();
  }

  Future<void> removeAllSizeModels() async {
    getAllSizeModels().then((QuerySnapshot<dynamic> snapshot) {
      for (final DocumentSnapshot<dynamic> ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
