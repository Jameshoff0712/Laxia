import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_four.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../generated/l10n.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../common/helper.dart';

// import '../common/app_config.dart' as config;
class PassRest_Three extends StatefulWidget {
  const PassRest_Three({Key? key}) : super(key: key);

  @override
  _PassRest_ThreeState createState() => _PassRest_ThreeState();
}

class _PassRest_ThreeState extends StateMVC<PassRest_Three> {
  late AuthController _con;
  _PassRest_ThreeState() : super(AuthController()) {
    _con = controller as AuthController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding:
              const EdgeInsets.only(top: 57.0, left: 16, right: 16, bottom: 65),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () => SystemNavigator.pop(),
                            padding: EdgeInsets.only(left: 7),
                            icon: const Icon(Icons.clear, color: Colors.black),
                            iconSize: 16,
                          ))),
                  Expanded(
                      flex: 6,
                      child: Center(
                          child: Text(Trans.of(context).reset_password_res,
                              style: defaultTextStyle(
                                  Colors.black, FontWeight.w700,
                                  size: 16)))),
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                      )),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(Trans.of(context).input_new_password,
                      style: TextStyle(
                          color: Color.fromARGB(250, 102, 110, 110),
                          fontWeight: FontWeight.w400,
                          fontSize: 14))),
              const SizedBox(
                height: 45,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                onSaved: (input) => _con.user.password = input,
                validator: (input) => input!.length < 3 ? null : null,
                obscureText: _con.hidePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  labelText: Trans.of(context).password,
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 210, 212), fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  // hintText: '••••••••••••',
                  // errorStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  // errorBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                  // hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  // prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _con.hidePassword = !_con.hidePassword;
                      });
                    },
                    color: Color.fromARGB(255, 210, 210, 212),
                    icon: Icon(_con.hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(1, 210, 210, 212)),
                  ),
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                  // focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
                  // enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Trans.of(context).required_password,
                        style: defaultTextStyle(
                            Color.fromARGB(255, 51, 51, 51), FontWeight.w400,
                            size: 12))),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 61, right: 61),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 110, 198, 210),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 14),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Trans.of(context).update_password,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PassRest_Four()));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
