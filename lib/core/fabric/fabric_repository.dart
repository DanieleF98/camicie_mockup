import 'package:camicie_mockup/core/fabric/models/fabric.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FabricRepository {
  final CollectionReference<dynamic> fabricCollection =
      FirebaseFirestore.instance.collection(fabricCollectionLabel);

  Future<QuerySnapshot<dynamic>> getAllFabrics() {
    return fabricCollection.get();
  }

  Future<DocumentReference<dynamic>> addFabric(
    Fabric fabric,
  ) {
    return fabricCollection.add(fabric.toJson());
  }

  Future<void> updateFabric(Fabric fabric) async {
    await fabricCollection.doc(fabric.id).update(fabric.toJson());
  }

  Future<void> deleteFabric(Fabric fabric) async {
    await fabricCollection.doc(fabric.id).delete();
    await FirebaseStorage.instance.refFromURL(fabric.imageUrl).delete();
  }

  Future<void> removeAllFabrics() async {
    getAllFabrics().then((QuerySnapshot<dynamic> snapshot) {
      for (final DocumentSnapshot<dynamic> ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
