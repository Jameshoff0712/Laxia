import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../../controllers/auth_controller.dart';
import '../../../common/helper.dart';
// import '../common/app_config.dart' as config;
import './passrest_three.dart';
class PassRest_One extends StatefulWidget {
  const PassRest_One({ Key? key }) : super(key: key);

  @override
  _PassRest_OneState createState() => _PassRest_OneState();
}

class _PassRest_OneState extends StateMVC<PassRest_One> {
  late AuthController _con;
  _PassRest_OneState() : super(AuthController()) {
    _con = controller as AuthController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 57.0,left: 16,right: 16,bottom: 65),
        child:Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(flex:2,child: Align(alignment: Alignment.topLeft ,child: IconButton(onPressed: ()=>Navigator.pop(context),padding: EdgeInsets.only(left: 7), icon: const Icon(Icons.arrow_back_ios,color: Colors.black),iconSize: 16,))),
                Expanded(flex:6,child: Center(child: Text(Trans.of(context).reset_password,style: defaultTextStyle(Colors.black, FontWeight.w700,size:20) ))),
                Expanded(flex:2,child: SizedBox(width: double.infinity,)),
              ],
            ),    
            const SizedBox(height: 27,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: Trans.of(context).input_email_then_help,style:TextStyle(color:Color.fromARGB(250, 102, 110, 110),fontWeight:FontWeight.w400,fontSize: 14)),
              ]),
            ),
            const SizedBox(height: 27,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (input) => _con.user.email = input,
              validator: (input) {
                if (input!.contains(new RegExp(r'^[0-9]+$'))) {
                  if (input.length < 10) {
                    return null;
                  }
                  return null;
                }
                if (!input.contains(RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
                  return null;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: Trans.of(context).input_email,
                labelStyle: TextStyle(color:Color.fromARGB(255,210, 210, 212),fontSize: 14),
                // filled: true,
                // fillColor: Colors.white.withOpacity(0.2),
                contentPadding: EdgeInsets.only(left: 16,top: 16,bottom: 16),
                // hintText: 'john@doe.com',
                // errorStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                // errorBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                // hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                // // prefixIcon: Icon(Icons.alternate_email, color: Colors.white),
                // border: OutlineInputBorder(
                //   // borderRadius: BorderRadius.all(Radius.circular(100)),
                //   borderSide: BorderSide(color: Color.fromARGB(1,210, 210, 212)),
                // ),
                // focusedBorder: UnderlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Color.fromARGB(1,210, 210, 212))),
                border: UnderlineInputBorder( borderSide: BorderSide(color: Color.fromARGB(1,210, 210, 212)),),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 61,right: 61),
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
                      padding: const EdgeInsets.only(top:14,bottom:14),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          Trans.of(context).send_url_for_reset,
                          style: TextStyle(color:Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PassRest_Three()));
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
