import "package:flutter/material.dart";
import "package:frontend/helpers/not_logged_in_view.dart";
import "package:frontend/services/api_service.dart";
import "package:frontend/utils/styles.dart";
import "package:frontend/widgets/custom_button.dart";
import "package:frontend/widgets/custom_text_button.dart";

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

  void _logout() async {
    try {
      await ApiService.logoutUser();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Logout successful!',
            style: TextStyle(color: Colors.green),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      ApiService.onProductUpdate = null;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      print("Error logging out: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error logging out: $error',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
                      SizedBox(height: 24),

                      TextButton(
                        onPressed: _logout,
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.red),
                        child: Text("Logout"),
                      ),

                      // CustomTextButton(buttonText: "Logout", onPressed: _logout, ),

                      // CustomButton(
                      //   buttonText: "Go to Main Page",
                      //   onPressed: () {
                      //     Navigator.pushReplacementNamed(context, '/main');
                      //   },
                      // ),
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
