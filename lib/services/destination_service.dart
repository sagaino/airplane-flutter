import 'package:airplane/models/destination_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DestinationService {
  final CollectionReference _destinationReference =
      FirebaseFirestore.instance.collection("destinations");

  Future<List<DestinationModel>> fetchDestination() async {
    try {
      QuerySnapshot result = await _destinationReference.get();

      List<DestinationModel> destinations = result.docs.map((item) {
        return DestinationModel.fromJson(
          item.id,
          item.data() as Map<String, dynamic>,
        );
      }).toList();
      return destinations;
    } catch (e) {
      rethrow;
    }
  }
}
