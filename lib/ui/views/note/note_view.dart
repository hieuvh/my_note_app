import 'package:flutter/material.dart';
import 'package:mynote/ui/views/note/note_model.dart';
import 'package:mynote/repository/note_repository.dart';

class UpdateItem extends StatefulWidget {
  final int itemId;
  final String itemTitle;
  final String itemDesc;
  UpdateItem(this.itemId, this.itemTitle, this.itemDesc);
  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  TextEditingController newTitleTextController = new TextEditingController();
  TextEditingController newDescTextController = new TextEditingController();
  LocalRepository dbLocal = LocalRepository();

  @override
  void initState() {
    super.initState();
    setState(() {
      newTitleTextController.text = widget.itemTitle;
      newDescTextController.text = widget.itemDesc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sửa ghi chú"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text("Tiêu đề"),
              TextFormField(
                controller: newTitleTextController,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text("Nội dung"),
              TextFormField(
                controller: newDescTextController,
              ),
              Padding(padding: EdgeInsets.all(5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Hủy',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context, true);
                        //insertData();
                      });
                    },
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Lưu',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        updateItem(
                            context,
                            widget.itemId,
                            newTitleTextController.text,
                            newDescTextController.text);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void updateItem(BuildContext context, int itemId, String newTitleItem,
      String newDescItem) async {
    int result = await dbLocal
        .updateData(ListModel.withId(itemId, newTitleItem, newDescItem));
    Navigator.pop(context, true);
  }
}
