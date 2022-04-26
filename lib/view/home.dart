import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:plaid_link/values/colors.dart';
import 'package:plaid_link/view/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? bankName;

  @override
  void initState() {
    PlaidLink.onEvent((eventName, metadata) {
      if(metadata.errorCode.isNotEmpty){
        if (kDebugMode) {
          print(metadata.errorMesssage);
        }
        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong. Please try again")));
        setState(() {
          bankName = null;
        });
      } else {
        setState(() {
          bankName = metadata.institutionName.isNotEmpty?metadata.institutionName:null;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      body: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Button(),
            const SizedBox(height: 40,),
            Text(bankName!=null?"Bank Account Linked: $bankName":"", style: const TextStyle(color: Colours.fontColor),)
          ]
      )
    ));
  }
}
