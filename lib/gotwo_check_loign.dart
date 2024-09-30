import 'package:flutter/material.dart';
import 'package:gotwo_app/gotwo_user.dart';


class check_login extends StatefulWidget {
  const check_login({super.key});
  @override
  State<check_login> createState() => _check_loginState();
}

class _check_loginState extends State<check_login> {
  Future checkloin() async {
    bool? signin = await User.getsignin();
    if (signin == false) {
      Navigator.pushNamed(context, 'login');
    } else {
      Navigator.pushNamed(context, 'join');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
