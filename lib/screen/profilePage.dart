import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserProfile> _getUserProfileStream() {
    User? user = _auth.currentUser;

    if (user != null) {
      return _firestore
          .collection('user_collection')
          .doc(user.uid)
          .snapshots()
          .map((documentSnapshot) {
        Map<String, dynamic>? userData = documentSnapshot.data();

        return UserProfile(
          name: userData?['name'] ?? '',
          address: userData?['address'] ?? '',
          phone: userData?['phone'] ?? '',
          email: userData?['email'] ?? '',
          imageUrl: userData?['image_url'] ?? '',
          detail: userData?['detail'] ?? '',
        );
      });
    } else {
      // Return an empty stream if the user is not logged in
      return Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<UserProfile>(
        stream: _getUserProfileStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No data available'),
            );
          }

          UserProfile userProfile = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              userProfile.imageUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userProfile.imageUrl),
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 100,
                    ),
              SizedBox(height: 20),
              Text('Name: ${userProfile.name}'),
              Text('Address: ${userProfile.address}'),
              Text('Phone: ${userProfile.phone}'),
              Text('Email: ${userProfile.email}'),
              Text('Abouts ${userProfile.detail}')
            ],
          );
        },
      ),
    );
  }
}


class UserProfile {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String imageUrl;
  final String detail;

  UserProfile({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.detail,
  });
}
