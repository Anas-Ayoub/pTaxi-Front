import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';

class RideRequestsPage extends StatefulWidget {
  const RideRequestsPage({super.key});

  @override
  _RideRequestsPageState createState() => _RideRequestsPageState();
}

class _RideRequestsPageState extends State<RideRequestsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late Stream<QuerySnapshot> rideRequestsStream;

  @override
  void initState() {
    if (currentUser != null) {
      rideRequestsStream = _firestore
          .collection('rideRequests')
          .where('receiverId', isEqualTo: currentUser!.uid)
          .snapshots();
    }
    super.initState();
  }

  void sendRideRequest(String receiverId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && receiverId.isNotEmpty) {
      final requestRef = await _firestore.collection('rideRequests').add({
        'senderId': currentUser.uid,
        'receiverId': receiverId,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      print("strated timer");
      Future.delayed(const Duration(seconds: 5), () async {
        final docSnapshot = await requestRef.get();
        if (docSnapshot.exists && docSnapshot.data()?['status'] == 'pending') {
          print("UPDATED!");

          await requestRef.update({'status': 'expired'});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
              onTap: () => log(currentUser!.uid),
              child: Text('Ride Requests'))),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "User id"),
          ),
          TextButton(
            onPressed: () => sendRideRequest(_controller.text),
            child: const Text("Send To Other User"),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: rideRequestsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final requests = snapshot.data!.docs
                    .where((doc) => doc['status'] == 'pending')
                    .toList();
                return Column(
                  children: requests.map(
                    (e) {
                      return ListTile(
                        key: ValueKey(e.id),
                        title: Text('Request from: ${e['senderId']}'),
                        subtitle: LinearTimer(
                          duration: Duration(seconds: 5),
                          forward: false,
                          color: Colors.amber,
                        ),
                      );
                    },
                  ).toList(),
                );
                // return ListView.builder(

                //   itemCount: requests.length,
                //   itemBuilder: (context, index) {
                //     final request = requests[index];

                //     Column(
                //       key: ValueKey(request['senderId']),
                //       children: [
                //         ListTile(
                //           title: Text('Request from: ${request['senderId']}'),
                //           subtitle: Text('Status: ${request['status']}'),
                //           onTap: () {
                //             // Handle request tap, e.g., accept or reject
                //           },
                //         ),
                //         LinearTimer(

                //           duration: Duration(seconds: 5),
                //           forward: false,
                //           color: Colors.amber,
                //         ),
                //       ],
                //     );
                //   },
                // );
              },
            ),
          )
        ],
      ),
    );
  }
}
