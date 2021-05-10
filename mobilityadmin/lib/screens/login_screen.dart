import 'package:country_code_picker/country_code_picker.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import '../services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _countryCode = '+91';
  var _phoneController = TextEditingController();

  PhoneAuthService _service = PhoneAuthService();

  bool _loading= false;

  @override
  void dispose() {
    setState(() {
      _loading=false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ProgressDialog progressDialog= ProgressDialog(
      context: context,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      loadingText: 'Please wait',
      progressIndicatorColor: Theme.of(context).primaryColor,
      backgroundOverlay: Colors.grey.shade300,

    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'PAYROLL',
              style: TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.grey.shade400,
                    ),
                  ],
                  color: Colors.blue.shade900,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome to Payroll',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue.shade700),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Enter your phone number')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: CountryCodePicker(

                        onChanged:(code){
                          setState(() {
                            _countryCode = code.toString();
                          });
                        },
                        initialSelection: 'IN',
                        favorite: ['+91', 'IN'],
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        showDropDownButton: true,
                        showFlag: false,
                        showFlagDialog: true,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.blue),
                            top: BorderSide(width: 1, color: Colors.blue),
                            right: BorderSide(width: 1, color: Colors.blue),
                            left: BorderSide(width: 1, color: Colors.blue)),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 32,
                          child: TextFormField(
                            onChanged: (value){
                              if(value.length>3){
                                setState(() {
                                  _loading=true;
                                });
                              }else{
                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: -10),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: _loading ? false : true,
                      child: TextButton(
                        onPressed: () {
                          if(_phoneController.text!=null){
                            progressDialog.show();
                            String number ='$_countryCode${_phoneController.text}';
                            _service.verifyPhoneNumber(context, number);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Continue',
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                          ),),
                          elevation: MaterialStateProperty.all(1),
                            backgroundColor: _loading ? MaterialStateProperty.all(Colors.blue):MaterialStateProperty.all(Colors.grey))  ,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
