// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/waste_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWasteToUserInFirestore(String userId, Waste waste) async {
    try {
      DocumentReference userDocRef = _firestore.collection('users').doc(userId);

      await userDocRef.update({
        'waste list': FieldValue.arrayUnion([
          {
            'wasteId': waste.wasteId,
            'wasteClass': waste.wasteClass,
            'wasteTypes': waste.wasteTypes,
            'status': waste.status,
            'date': waste.date,
            'time': waste.time,
            'location': waste.location,
            'points': waste.points,
          }
        ])
      });

      print('Waste added to user in Firestore.');
    } catch (e) {
      print('Error adding waste to user in Firestore: $e');
    }
  }

  Future<List<Waste>> getWasteListForUser(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      List<Waste> wasteList = [];

      if (userData.isNotEmpty && userData['waste list'] != null) {
        wasteList = (userData['waste list'] as List)
            .map((wasteData) => Waste(
                  wasteId: wasteData['wasteId'],
                  wasteClass: wasteData['wasteClass'],
                  wasteTypes: List<String>.from(wasteData['wasteTypes']),
                  status: wasteData['status'],
                  date: (wasteData['date'] as Timestamp).toDate(),
                  time: wasteData['time'],
                  location: wasteData['location'],
                  points: wasteData['points'],
                ))
            .toList();
      }

      return wasteList;
    } catch (e) {
      print('Error retrieving waste list from Firestore: $e');
      return [];
    }
  }
}
