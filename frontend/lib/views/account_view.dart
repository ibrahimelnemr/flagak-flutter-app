import "package:flutter/material.dart";
import "package:frontend/services/api_service.dart";

class AccountView extends StatefulWidget {
@override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late Future<String> userId;
  @override
  void initState() {
    super.initState();
    userId = ApiService.getUserId();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Text(
              "Account Details",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16),
            Text(""),
            SizedBox(height: 16),
            SizedBox(height: 8),
            
          ],),
          Column(),
        ],)
        
        )
      ),

    );
  }

}