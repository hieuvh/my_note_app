import 'package:flutter/material.dart';
import 'package:mynote/ui/views/note/user_view.dart';
import 'package:quiver/strings.dart';
//import 'ui/views/note/user_viewmodel.dart';
import 'package:mynote/ui/views/note/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:mynote/ui/views/note/widgets/user_view_item.dart';
import 'package:mynote/ui/views/note/widgets/user_view_edit.dart';
import 'package:mynote/ui/views/note/user_view_add.dart';
import 'user_viewmodel.dart';
import 'user_model.dart';

// void main() => runApp(NewApp());

// class NewApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Simple Form',
//       theme: new ThemeData(primarySwatch: Colors.blue),
//       home: new SignUpForm(),
//     );
//   }
// }

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() => new SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  var repo = UserRepository();

  String _username = '';
  String _email = '';
  String _password = '';

  void onPressedSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("Name " + _username);
      print("Email " + _email);
      print("Password " + _password);

      UserViewModel().addItem(_email, _username, _password);

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Thêm thành công.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Thêm người dùng'),
      ),
      body: Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ),
      ),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new TextFormField(
        decoration: InputDecoration(
            labelText: 'Tên tài khoản', hintText: 'Nhập tên tài khoản'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Nhập tên tài khoản';
          }
        },
        onSaved: (value) {
          setState(() {
            _username = value;
          });
        }));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(labelText: 'Email', hintText: 'Nhập email'),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
        onSaved: (value) {
          setState(() {
            _email = value;
          });
        }));

    // formWidget.add(new TextFormField(
    //     decoration: InputDecoration(labelText: 'Enter Age', hintText: 'Age'),
    //     keyboardType: TextInputType.number,
    //     validator: (value) {
    //       if (value.isEmpty) {
    //         return 'Enter Age';
    //       }
    //     },
    //     onSaved: (value) {
    //       setState(() {
    //         _age = int.tryParse(value);
    //       });
    //     }));

    formWidget.add(new TextFormField(
        key: _passKey,
        obscureText: true,
        decoration:
            InputDecoration(labelText: 'Nhập mật khẩu', hintText: 'Mật khẩu'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Nhập mật khẩu';
          }
          if (value.length < 4) {
            return 'Mật khẩu có ít nhất 4 kí tự';
          }
        }));

    formWidget.add(
      new TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Xác nhận mật khẩu', labelText: 'Nhập lại mật khẩu'),
          validator: (confirmPassword) {
            if (confirmPassword.isEmpty) return 'Nhập lại mật khẩu';
            var password = _passKey.currentState.value;
            if (!equalsIgnoreCase(confirmPassword, password)) {
              return 'Mật khẩu không trùng khớp';
            } else {}
          },
          onSaved: (value) {
            setState(() {
              _password = value;
            });
          }),
    );

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('Thêm'),
        onPressed: onPressedSubmit));

    return formWidget;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập email';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
