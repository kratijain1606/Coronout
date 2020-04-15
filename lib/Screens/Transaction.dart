import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:gocorona/Wrapper/ethWrapper.dart';
import 'package:gocorona/main.dart';

class MaticTransactions extends StatefulWidget {
  @override
  ReceiveUi createState() => new ReceiveUi();
}

class ReceiveUi extends State<MaticTransactions> {
  var sender = new TextEditingController();
  var amount = new TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: receiveUI(),
    );
  }

  receiveUI() {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/matic.png'),
      ),
    );
    return ListView(
      cacheExtent: 100,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: 9,
        top: 70,
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Send on Matic",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        logo,
        SizedBox(
          height: 25,
        ),
        Text(
          "sender",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            inherit: true,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: sender,
            validator: (val) =>
                val.length != 10 && val.length != 0 ? "Invalid address" : null,
            decoration: InputDecoration(
              hintText: 'Enter Sender Phone Number',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3.0)),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Center(
          child: TextFormField(
            controller: amount,
            validator: (val) =>
                val.length != 64 && val.length != 0 ? "Invalid address" : null,
            decoration: InputDecoration(
              hintText: 'Amount',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3.0)),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              _send(sender.text, double.parse(amount.text));
              setState(() {
                loading = false;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyStatefulWidget()));
              });
            },
            padding: EdgeInsets.all(12),
            color: Colors.blueAccent,
            child: loading
                ? SpinKitCircle(
                    size: 10,
                    color: Colors.black,
                  )
                : Text('Send', style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  _send(address, amount) async {
    EthWrapper wrapper = new EthWrapper();
    Toast.show("Transacting", context, duration: Toast.LENGTH_LONG);
    if (wrapper.transferToken(address, amount) != null)
      Toast.show(
          "Transaction Completed \nThank you for your contribution.", context,
          duration: Toast.LENGTH_LONG);
  }
}
