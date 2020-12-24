import 'package:flutter/material.dart';
//import 'package:mynote/ui/views/note/user_model.dart';
import 'package:mynote/ui/views/note/user_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UserViewItem extends ViewModelWidget<UserViewModel> {
  @override
  Widget build(BuildContext context, model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết ${model.editingItem.id}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => model.state = UserViewState.listView,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit), onPressed: () => model.updateItem())
        ],
      ),
      body: Center(
        child: ListTile(
          title: Text(model.editingItem.username),
          subtitle: Text(model.editingItem.password),
        ),
      ),
    );
  }
}
