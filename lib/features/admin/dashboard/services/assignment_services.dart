import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/assignment_model.dart';

class AssignmentServices{
  static final CollectionReference<Map<String,dynamic>> assignments = FirebaseFirestore.instance.collection('assignments');


  static String getAssignmentId() {
    return assignments.doc().id;
  }

  static Future<bool> addAssignment(AssignmentModel assignment) async {
    try {
      await assignments.doc(assignment.id).set(assignment.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateAssignment(AssignmentModel assignment) async {
    try {
      await assignments.doc(assignment.id).update(assignment.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteAssignment(String id) async {
    try {
      await assignments.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }


  static Stream<List<AssignmentModel>> getAssignments() {
    return assignments.snapshots().map((snapshot) => snapshot.docs.map((doc) => AssignmentModel.fromMap(doc.data())).toList());
  }
}