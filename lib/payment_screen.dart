import 'package:flutter/material.dart';
import 'package:quantupi/quantupi.dart';
import 'package:turf_booking/themes/theme_colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.title});

  final String title;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var amount = TextEditingController();

  var descrip = TextEditingController();
  var name = TextEditingController();
  var upiID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HashColorCodes.green,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: upiID,
              decoration: InputDecoration(
                  hintText: "Upi Id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descrip,
              decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: amount,
              decoration: InputDecoration(
                  hintText: "Amount",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!))),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      paymentStart();
                    },
                    child: const Text(
                      "Pay",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )))
          ],
        ),
      ),
    );
  }

  void paymentStart() async {
    Quantupi upi = Quantupi(
      receiverUpiId: upiID.text,
      receiverName: name.text,
      transactionRefId: 'kdskd',
      transactionNote: descrip.text,
      amount: double.parse(amount.text),
    );
    final response = await upi.startTransaction();
    print(response);

    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("${response}"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("ok"))
            ],
          );
        });
  }
}
