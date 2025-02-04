import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Reference to the user's wishlist collection
  CollectionReference<Map<String, dynamic>> get _wishlistCollection {
    final uid = currentUserId;
    if (uid == null) {
      print('DEBUG: User ID is null. Auth state: ${_auth.currentUser}');
      throw Exception('Must be logged in to access wishlist');
    }
    print('DEBUG: Creating collection reference for user: $uid');
    return _firestore.collection('users').doc(uid).collection('wishlist');
  }

  // Add a new wishlist item
  Future<void> addWishlistItem({
    required String title,
    required double amount,
    required String icon,
    required String iconColor,
    required DateTime date,
    String? message,
  }) async {
    print('DEBUG: Starting addWishlistItem');
    print('DEBUG: Current user: ${_auth.currentUser?.email}');
    
    if (_auth.currentUser == null) {
      print('DEBUG: No user logged in');
      throw Exception('You must be logged in to add wishlist items');
    }

    try {
      print('DEBUG: Attempting to add item to collection');
      final docRef = await _wishlistCollection.add({
        'title': title,
        'amount': amount,
        'icon': icon,
        'iconColor': iconColor,
        'date': date,
        'message': message,
        'createdAt': FieldValue.serverTimestamp(),
        'progress': 0.0,
      });
      print('DEBUG: Successfully added item with ID: ${docRef.id}');
    } catch (e) {
      print('DEBUG: Error adding item: $e');
      throw Exception('Failed to add wishlist item: ${e.toString()}');
    }
  }

  // Get all wishlist items
  Stream<QuerySnapshot<Map<String, dynamic>>> getWishlistItems() {
    print('DEBUG: Starting getWishlistItems');
    print('DEBUG: Current user: ${_auth.currentUser?.email}');
    
    if (_auth.currentUser == null) {
      print('DEBUG: No user logged in');
      throw Exception('You must be logged in to view wishlist items');
    }

    try {
      print('DEBUG: Attempting to retrieve wishlist items');
      return _wishlistCollection
          .orderBy('date', descending: true)
          .snapshots();
    } catch (e) {
      print('DEBUG: Error retrieving wishlist items: $e');
      throw Exception('Failed to retrieve wishlist items: ${e.toString()}');
    }
  }

  // Update wishlist item progress
  Future<void> updateItemProgress(String itemId, double progress) async {
    print('DEBUG: Starting updateItemProgress');
    print('DEBUG: Current user: ${_auth.currentUser?.email}');
    
    if (_auth.currentUser == null) {
      print('DEBUG: No user logged in');
      throw Exception('You must be logged in to update wishlist items');
    }

    try {
      print('DEBUG: Attempting to update item progress');
      await _wishlistCollection.doc(itemId).update({
        'progress': progress,
      });
      print('DEBUG: Successfully updated item progress');
    } catch (e) {
      print('DEBUG: Error updating item progress: $e');
      throw Exception('Failed to update wishlist item progress: ${e.toString()}');
    }
  }

  // Delete wishlist item
  Future<void> deleteWishlistItem(String itemId) async {
    print('DEBUG: Starting deleteWishlistItem');
    print('DEBUG: Current user: ${_auth.currentUser?.email}');
    
    if (_auth.currentUser == null) {
      print('DEBUG: No user logged in');
      throw Exception('You must be logged in to delete wishlist items');
    }

    try {
      print('DEBUG: Attempting to delete item');
      await _wishlistCollection.doc(itemId).delete();
      print('DEBUG: Successfully deleted item');
    } catch (e) {
      print('DEBUG: Error deleting item: $e');
      throw Exception('Failed to delete wishlist item: ${e.toString()}');
    }
  }

  // Get total savings goal
  Future<double> getTotalSavingsGoal() async {
    print('DEBUG: Starting getTotalSavingsGoal');
    print('DEBUG: Current user: ${_auth.currentUser?.email}');
    
    if (_auth.currentUser == null) {
      print('DEBUG: No user logged in');
      throw Exception('You must be logged in to view total savings goal');
    }

    try {
      print('DEBUG: Attempting to retrieve total savings goal');
      final QuerySnapshot<Map<String, dynamic>> snapshot = 
          await _wishlistCollection.get();
      
      double total = 0;
      for (var doc in snapshot.docs) {
        total += (doc.data()['amount'] as num).toDouble();
      }
      print('DEBUG: Successfully retrieved total savings goal: $total');
      return total;
    } catch (e) {
      print('DEBUG: Error retrieving total savings goal: $e');
      throw Exception('Failed to retrieve total savings goal: ${e.toString()}');
    }
  }

  // Group wishlist items by month
  Future<Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      getWishlistItemsByMonth() async {
    print('DEBUG: Starting getWishlistItemsByMonth');
    print('DEBUG: Current user: ${_auth.currentUser?.email}');
    
    if (_auth.currentUser == null) {
      print('DEBUG: No user logged in');
      throw Exception('You must be logged in to view wishlist items by month');
    }

    try {
      print('DEBUG: Attempting to retrieve wishlist items by month');
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _wishlistCollection.orderBy('date', descending: true).get();

      final Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>> grouped = {};

      for (var doc in snapshot.docs) {
        final date = (doc.data()['date'] as Timestamp).toDate();
        final monthYear = '${date.month}-${date.year}';
        grouped.putIfAbsent(monthYear, () => []).add(doc);
      }
      print('DEBUG: Successfully retrieved wishlist items by month');
      return grouped;
    } catch (e) {
      print('DEBUG: Error retrieving wishlist items by month: $e');
      throw Exception('Failed to retrieve wishlist items by month: ${e.toString()}');
    }
  }
}
