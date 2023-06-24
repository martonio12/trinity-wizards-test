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
  TextEditingController controllerSearch = TextEditingController();
  List<Contactmodel> data = [];
  List<Contactmodel> dataTemp = [];
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    Contactmodel.readJson().then((value) {
      setState(() {
        data = value;
        dataTemp = data;
      });
    });
  }

  void search(String keyword) {
    for (Contactmodel item in data) {
      if (item.firstName.toLowerCase().contains(keyword) ||
          item.lastName.toLowerCase().contains(keyword) ||
          item.email!.toLowerCase().contains(keyword)) {
        dataTemp.add(item);
      }
    }
    setState(() {});
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
          onPressed: () {
            setState(() {
              controllerSearch.text = '';
              isSearch = !isSearch;
            });
          },
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
                Visibility(
                  visible: isSearch,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: controllerSearch,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        //
                      },
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataTemp.length,
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
                        child: ContactWidget(data: dataTemp[index]));
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
