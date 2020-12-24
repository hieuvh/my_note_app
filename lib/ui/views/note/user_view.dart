import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:stacked/stacked.dart';
import 'package:mynote/ui/views/note/widgets/user_view_item.dart';
import 'package:mynote/ui/views/note/widgets/user_view_edit.dart';
import 'package:mynote/ui/views/note/user_view_add.dart';
import 'user_viewmodel.dart';
import 'user_model.dart';

class UserView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  var userAdd = SignUpForm();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text(model.title)),
        body: Stack(
          children: [
            model.state == UserViewState.listView
                ? ListView.builder(
                    itemCount: model.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      User item = model.items[index];
                      return ListTile(
                        title: Text(item.username),
                        subtitle: Text(item.password),
                        onTap: () {
                          model.editingItem = item;
                          model.state = UserViewState.itemView;
                        },
                      );
                    },
                  )
                : model.state == UserViewState.itemView
                    ? UserViewItem()
                    : model.state == UserViewState.updateView
                        ? UserViewItemEdit()
                        : SizedBox(),
          ],
        ),
        floatingActionButton: model.state == UserViewState.listView
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  return MaterialApp(
                    title: "Login",
                    home: SignUpForm(),
                  );
                },
              )
            : null,
      ),
      viewModelBuilder: () => UserViewModel(),
    );
  }
}
