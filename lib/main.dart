import 'package:flutter/material.dart';
import 'package:mynote/repository/note_repository.dart';
import 'package:mynote/ui/views/note/note_view.dart';

import 'package:mynote/ui/views/note/note_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Ứng dụng Ghi chú';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: BuildBody(),
      ),
    );
  }
}

class BuildBody extends StatefulWidget {
  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  LocalRepository dbLocal = LocalRepository();

  Future<List<ListModel>> listItems;
  List<ListModel> noteListmain = List<ListModel>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshDataList();
  }

  refreshDataList() {
    setState(() {
      getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
        itemCount: noteListmain.length,
        itemBuilder: (BuildContext context, int position) {
          return InkWell(
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  this.noteListmain[position].title,
                ),
                subtitle: Text(this.noteListmain[position].desc),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    deleteData(this.noteListmain[position].id);
                  },
                ),
              ),
            ),
            onTap: () {
              updateData(
                  this.noteListmain[position].id,
                  this.noteListmain[position].title,
                  this.noteListmain[position].desc);
            },
          );
        });
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Column(
            children: <Widget>[
              Text("Tiêu đề"),
              TextFormField(
                decoration: InputDecoration(hintText: 'Nhập tiêu đề'),
                controller: titleController,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text("Nội dung"),
              TextFormField(
                decoration: InputDecoration(hintText: 'Nhập nội dung'),
                controller: descController,
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              RaisedButton(
                child: Text("Thêm ghi chú"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    insertData();
                    FocusScope.of(context).unfocus();
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text("Danh sách các ghi chú"),
            ],
          ),
          Flexible(
            child: ListView.builder(
                itemCount: noteListmain.length,
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    child: Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          this.noteListmain[position].title,
                        ),
                        subtitle: Text(this.noteListmain[position].desc),
                        trailing: GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () {
                            deleteData(this.noteListmain[position].id);
                          },
                        ),
                      ),
                    ),
                    onTap: () {
                      updateData(
                          this.noteListmain[position].id,
                          this.noteListmain[position].title,
                          this.noteListmain[position].desc);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  void insertData() async {
    int result;
    String title = titleController.text;
    String desc = descController.text;
    result = await dbLocal.insertData(ListModel(title, desc));
    print('inserted row id: $result');
    titleController.text = '';
    descController.text = '';
    refreshDataList();
  }

  void getAllData() async {
    final noteMapList = await dbLocal.getDbData();
    setState(() {
      noteListmain = noteMapList;
    });
  }

  void updateData(int id, String title, String desc) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateItem(id, title, desc);
    }));
    if (result == true) {
      refreshDataList();
    }
  }

  void deleteData(int itemId) async {
    int result = await dbLocal.deleteData(itemId);
    refreshDataList();
  }
}
