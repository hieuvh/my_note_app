import 'package:flutter/material.dart';
//import 'package:mynote/ui/views/note/note_model.dart';
import 'package:mynote/ui/views/note/user_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UserViewItemEdit extends ViewModelWidget<UserViewModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật ${model.editingItem.id}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => model.state = UserViewState.listView,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => model.saveItem(),
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nhập Email',
                  ),
                  controller: model.editingControllerEmail),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nhập tài khoản',
                ),
                controller: model.editingControllerUser,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nhập mật khẩu',
                ),
                controller: model.editingControllerPass,
              )
            ],
          )),
    );
  }
}
