// ignore_for_file: avoid_print
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:trinity_wizards_test/model/contact_model.dart';
import 'dart:math';

class ContacEditor extends StatefulWidget {
  const ContacEditor({Key? key, this.data}) : super(key: key);

  final Contactmodel? data;

  @override
  // ignore: library_private_types_in_public_api
  _ContacEditorState createState() => _ContacEditorState();
}

class _ContacEditorState extends State<ContacEditor> {
  TextEditingController controllerFName = TextEditingController();
  TextEditingController controllerLName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerDOB = TextEditingController();

  final focusFN = FocusNode();
  final focusLN = FocusNode();
  final focusE = FocusNode();
  final focusD = FocusNode();
  @override
  void initState() {
    super.initState();
    // getdata();
    setData();
  }

  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void setData() {
    controllerFName.text = widget.data?.firstName ?? '';
    controllerLName.text = widget.data?.lastName ?? '';
    controllerEmail.text = widget.data?.email ?? '';
    controllerDOB.text = widget.data?.dob ?? '';
  }

  Future<void> setDate() async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateFormat dateFormat = DateFormat("d/M/yyyy");
    DateTime now = dateFormat.parse(dateFormat.format(DateTime.now()));
    DateTime datepick = now.subtract(Duration(days: 1));

    if (controllerDOB.text != '') {
      datepick = DateFormat("d/M/yyyy").parse(controllerDOB.text);
    }
    final times = await showDatePicker(
        context: context,
        initialDate: datepick,
        lastDate: now,
        firstDate: now.subtract(Duration(days: 365 * 100)));
    if (times != null) {
      controllerDOB.text = DateFormat('d/M/yyyy').format(times);
      ;
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double sizeContainer = ((screen.width - 20) * 0.3);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data == null ? 'New Contact' : 'Edit Contact',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFFff8c00),
            ),
          ),
        ),
        leadingWidth: 75,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Contactmodel result = Contactmodel(
                  id: widget.data?.id ?? getRandomString(16),
                  firstName: controllerFName.text,
                  lastName: controllerLName.text,
                  email: controllerEmail.text,
                  dob: controllerDOB.text,
                );

                Navigator.pop(context, result.toJson());
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFFff8c00),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: sizeContainer,
                  height: sizeContainer,
                  decoration: BoxDecoration(
                    color: const Color(0xFFff8c00),
                    borderRadius: BorderRadius.all(
                      Radius.circular(sizeContainer),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.grey[100],
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  'Main Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'First Name',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controllerFName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text on First Name';
                          }
                          return null;
                        },
                        focusNode: focusFN,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          _fieldFocusChange(context, focusFN, focusLN);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Last Name',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controllerLName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text on Last Name';
                          }
                          return null;
                        },
                        focusNode: focusLN,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          _fieldFocusChange(context, focusLN, focusE);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.grey[100],
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  'Sub Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controllerEmail,
                        focusNode: focusE,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (v) {
                          setDate();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'DOB',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setDate();
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: controllerDOB,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
