import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../dialog/policy_dialog.dart';

class TermOfUseWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RichText(
        textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 14.0, color: Colors.white),
                children:  <TextSpan> [
                  TextSpan(text: 'By signing up, you agree to our\n'),
                  TextSpan(
                    text: 'Terms ', 
                    style: TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //Open dialog box of Terms & conditions
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return PolicyDialog(
                            mdFileName: 'terms_and_conditions.md'
                          );
                        }
                      );
                    }
                    ),
                  TextSpan(text: 'and '),
                  TextSpan(
                    text: 'Privacy.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //Open dialog box of Privacy Policy
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return PolicyDialog(
                            mdFileName: 'privacy_policy.md'
                          );
                        }
                      );
                      
                    }
                  )
                ]
              ),
            ),
    );
  }
}