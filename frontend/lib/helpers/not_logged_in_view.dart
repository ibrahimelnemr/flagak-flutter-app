import "package:flutter/material.dart";
import "package:frontend/services/api_service.dart";

class NotLoggedInView extends StatefulWidget {
  @override
  _NotLoggedInViewState createState() => _NotLoggedInViewState();
}

class _NotLoggedInViewState extends State<NotLoggedInView> {
  @override
  void initState() {
    super.initState();
    
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
                    "",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),

                  SizedBox(height: 24),
                  Text(
                    "You are currently not logged in.",
                    style: TextStyle(),
                  ),
                  SizedBox(height: 10),
                  
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Login',
                      
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
