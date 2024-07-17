import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/ride_request_card.dart';

class RideRequests extends StatefulWidget {
  const RideRequests({super.key});

  @override
  RideRequestsState createState() => RideRequestsState();
}

class RideRequestsState extends State<RideRequests> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late Stream<QuerySnapshot> rideRequestsStream;

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      rideRequestsStream = _firestore
          .collection('rideRequests')
          .where('receiverId', isEqualTo: currentUser!.uid)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: StreamBuilder<QuerySnapshot>(
            stream: rideRequestsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              final requests = snapshot.data!.docs
                  .where((doc) => doc['status'] == 'pending')
                  .toList();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _appProvider.setCards(requests);
              });
              return Column(
                children: requests.map((doc) {
                  return Animate(
                    key: ValueKey(doc.id),
                    effects: [
                      SlideEffect(begin: Offset(-0.5, 0), duration: 150.ms)
                    ],
                    child: RideRequestCard(
                      name: doc['name'],
                      onCancelCallBack: () async {
                        await _firestore
                            .collection('rideRequests')
                            .doc(doc.id)
                            .update({'status': 'expired'});
                      },
                      onAcceptCallBack: () async {
                        await _firestore
                            .collection('rideRequests')
                            .doc(doc.id)
                            .update({'status': 'accepted'});
                      },
                    ),
                  );
                }).toList(),
              );
            },
          )),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text('Dynamic Cards'),
    //   ),
    //   body: Stack(
    //     children: [
    //       Placeholder(),

    //     ],
    //   ),
    //         floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Provider.of<AppProvider>(context, listen: false).addCardItem();
    //     },
    //     tooltip: 'Add Card',
    //     child: Icon(Icons.add),
    //   ),

    // );
  }
}
