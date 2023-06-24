// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:trinity_wizards_test/contact_editor.dart';
import 'package:trinity_wizards_test/model/contact_model.dart';
import 'package:trinity_wizards_test/widget/contact_widget.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contactmodel> data = [];
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    Contactmodel.readJson().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contans',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContacEditor(),
                ),
              ).then((value) {
                if (value != null) {
                  try {
                    Contactmodel datas = value;

                    data.add(datas);
                  } catch (e) {}
                }
                setState(() {
                  //
                });
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // print('refresh');
          return getdata();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContacEditor(
                                data: data[index],
                              ),
                            ),
                          ).then((value) {
                            if (value != null) {
                              try {
                                Contactmodel datas = value;
                                var index = data.indexWhere(
                                    (element) => element.id == datas.id);

                                data[index] = datas;
                              } catch (e) {}
                            }
                            setState(() {
                              //
                            });
                          });
                        },
                        child: ContactWidget(name: data[index].firstName));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
