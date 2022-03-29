import 'package:camicie_mockup/core/stats/models/stat.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatsRepository {
  final CollectionReference<dynamic> statsCollection =
      FirebaseFirestore.instance.collection(statsCollectionLabel);

  Future<QuerySnapshot<dynamic>> getAllStats() {
    return statsCollection.get();
  }

  Future<DocumentReference<dynamic>> addStat(
    Stat stat,
  ) {
    return statsCollection.add(stat.toJson());
  }

  Future<void> updateStat(Stat stat) async {
    await statsCollection.doc(stat.id).update(stat.toJson());
  }

  Future<void> deleteStat(Stat stat) async {
    await statsCollection.doc(stat.id).delete();
  }

  Future<void> removeAllStats() async {
    getAllStats().then((QuerySnapshot<dynamic> snapshot) {
      for (final DocumentSnapshot<dynamic> ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
