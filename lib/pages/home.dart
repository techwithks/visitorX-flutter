import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitorx/pages/visitor.dart';
import 'package:visitorx/service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController visitcontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  Stream? VisitorStream;

  getontheload() async {
    VisitorStream = await DatabaseMethods().getVisitorDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allVisitorDetails() {
    return StreamBuilder(
        stream: VisitorStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name : " + ds["Name"],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        namecontroller.text = ds["Name"];
                                        visitcontroller.text = ds["Visit for"];
                                        locationcontroller.text = ds["Address"];
                                        EditVisitorDetail(ds["Id"]);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      )),
                                  SizedBox(width: 10.0),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .deleteVisitorDetails(ds["Id"]);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Visit for : " + ds["Visit for"],
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Address : " + ds["Address"],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Visitor()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "Visitor",
            //   style: TextStyle(
            //       color: Colors.blue,
            //       fontSize: 20.0,
            //       fontWeight: FontWeight.bold),
            // ),
            Text(
              "Symbiosis Visitor",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20, right: 20.0),
        child: Column(
          children: [
            Expanded(child: allVisitorDetails()),
          ],
        ),
      ),
    );
  }

  Future EditVisitorDetail(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel)),
                SizedBox(
                  width: 60.0,
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Details",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ]),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Visit for",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: visitcontroller,
                  decoration: InputDecoration(
                    hintText: "Reason For Visit",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Address",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: locationcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Address",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfo = {
                          "Name": namecontroller.text,
                          "Visit for": visitcontroller.text,
                          "Id": id,
                          "Address": locationcontroller.text,
                        };
                        await DatabaseMethods()
                            .updateVisitorDetails(id, updateInfo)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Update")))
            ]),
          ));
}
