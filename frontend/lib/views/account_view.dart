import "package:flutter/material.dart";
import "package:frontend/helpers/not_logged_in_view.dart";
import "package:frontend/services/api_service.dart";
import "package:frontend/utils/styles.dart";

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late Future<String> userIdFuture;
  late Future<String> userNameFuture;
  late Future<String> userEmailFuture;
  late Future<bool> isLoggedInFuture;
  @override
  void initState() {
    super.initState();
    userIdFuture = ApiService.getUserId();
    userNameFuture = ApiService.getUserName();
    userEmailFuture = ApiService.getUserEmail();
    isLoggedInFuture = ApiService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<bool>(
            future: isLoggedInFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data == false) {
                return NotLoggedInView();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 32),
                      Text("Account Details", style: AppStyles.titleTextStyle),
                      SizedBox(height: 24),
                      Text("Name", style: AppStyles.bodyTextStyle),
                      SizedBox(height: 10),
                      FutureBuilder<String>(
                        future: userNameFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String userName = snapshot.data!;
                            return Text(
                              userName,
                              style: AppStyles.bodyTextStyle,
                            );
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
                        style: AppStyles.bodyTextStyle,
                      ),
                      SizedBox(height: 10),
                      FutureBuilder<String>(
                        future: userEmailFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String userId = snapshot.data!;
                            return Text(
                              userId,
                              style: AppStyles.bodyTextStyle,
                            );
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
                        style: AppStyles.defaultButtonStyle,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
