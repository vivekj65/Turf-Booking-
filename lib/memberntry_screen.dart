import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turf_booking/booking_screen.dart';
import 'package:turf_booking/model/slot_model.dart';
import 'package:turf_booking/payment_screen.dart';
import 'package:turf_booking/themes/theme_colors.dart';

class MemberEntryScreen extends StatefulWidget {
  const MemberEntryScreen({super.key, required this.slot});
  final Slot slot;

  @override
  State<MemberEntryScreen> createState() => _MemberEntryScreenState();
}

class _MemberEntryScreenState extends State<MemberEntryScreen> {
  List<String> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HashColorCodes.green,
        title: const Text(
          "Add Members",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: members.length + 1,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index < members.length) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: HashColorCodes.borderGrey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: HashColorCodes.borderGrey,
                            ),
                          ),
                          hintText: 'Member Name',
                        ),
                        initialValue: members[index],
                        onChanged: (value) {
                          members[index] = value;
                        },
                      ),
                    );
                  } else {
                    return Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async {
                            final existingMemberCount =
                                await getExistingMemberCount(
                                    widget.slot.slotNum);
                            if (members.length + existingMemberCount < 25) {
                              setState(() {
                                members.add('');
                              });
                            } else {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Limit Reached"),
                                    content: const Text(
                                        "You've reached the maximum limit of 25 members."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            "Add Member",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            log("Saved Members: $members");
                            final date = DateTime.now();
                            await saveMembersToFirestore(
                                members, widget.slot.slotNum, date);

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Proceed To Pay",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BookingScreen(slot: widget.slot)));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "See Bookings",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get the count of existing members for the slot from Firebase
  Future<int> getExistingMemberCount(int selectedSlot) async {
    final date = DateTime.now();
    final formattedDate = "${date.month} ${date.day}, ${date.year}";
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Members')
        .where('selectedSlot', isEqualTo: selectedSlot)
        .where('date', isEqualTo: formattedDate)
        .get();

    return querySnapshot.docs.length;
  }

  // Function to save members to Firestore with a custom date format
  Future<void> saveMembersToFirestore(
      List<String> members, int selectedSlot, DateTime date) async {
    final CollectionReference membersCollection =
        FirebaseFirestore.instance.collection('Members');

    String formattedDate = "${date.month} ${date.day}, ${date.year}";

    for (int i = 0; i < members.length; i++) {
      await membersCollection.add({
        'name': members[i],
        'selectedSlot': selectedSlot,
        'date': formattedDate,
      });
    }
  }
}
