import "package:flutter/material.dart";
import "package:frontend/services/api_service.dart";

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late Future<String> userIdFuture;
  late Future<String> userNameFuture;
  late Future<String> userEmailFuture;
  @override
  void initState() {
    super.initState();
    userIdFuture = ApiService.getUserId();
    userNameFuture = ApiService.getUserName();
    userEmailFuture = ApiService.getUserEmail();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  Text(
                    "Account Details",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),

                  SizedBox(height: 24),
                  Text(
                    "User ID",
                    style: TextStyle(),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<String>(
                    future: userIdFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String userId = snapshot.data!;
                        return Text(userId);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error retrieving account details: ${snapshot.error}');
                      }
                      return Text("Error retrieving account details.");
                    },
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Name",
                    style: TextStyle(),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<String>(
                    future: userNameFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String userId = snapshot.data!;
                        return Text(userId);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error retrieving account details: ${snapshot.error}');
                      }
                      return Text("Error retrieving account details.");
                    },
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Registered Email",
                    style: TextStyle(),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<String>(
                    future: userEmailFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String userId = snapshot.data!;
                        return Text(userId);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error retrieving account details: ${snapshot.error}');
                      }
                      return Text("Error retrieving account details.");
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/main');
                    },
                    child: Text(
                      'Go to Main Page',
                      
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
