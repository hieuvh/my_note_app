import 'package:flutter/cupertino.dart';
import 'package:mynote/ui/views/note/user_repository.dart';
import 'package:mynote/ui/views/note/user_model.dart';
import 'package:stacked/stacked.dart';

import 'user_model.dart';

/// Trạng thái của view
enum UserViewState { listView, itemView, insertView, updateView }

class UserViewModel extends BaseViewModel {
  final title = 'Thông tin đăng ký';

  /// Danh sách các bản ghi được load bất đồng bộ bên trong view model,
  /// khi load thành công thì thông báo đến view để cập nhật trạng thái
  var _items = <User>[];

  /// ### Danh sách các bản ghi dùng để hiển thị trên ListView
  /// Vì quá trình load items là bất đồng bộ nên phải tạo một getter
  /// `get items => _items` để tránh xung đột
  List<User> get items => _items;

  /// Trạng thái mặc định của view là listView, nó có thể thay đổi
  /// bên trong view model
  var _state = UserViewState.listView;

  /// Khi thay đổi trạng thái thì sẽ báo cho view biết để cập nhật
  /// nên cần tạo một setter để vừa nhận giá trị vừa thông báo đến view
  set state(value) {
    // Cập nhật giá trị cho biến _state
    _state = value;

    // Thông báo cho view biết để cập nhật trạng thái của widget
    notifyListeners();
  }

  /// Cần có một getter để lấy ra trạng thái view cục bộ cho view
  UserViewState get state => _state;
  User editingItem;

  var editingControllerEmail = TextEditingController();
  var editingControllerUser = TextEditingController();
  var editingControllerPass = TextEditingController();

  ///
  var repo = UserRepository();

  Future init() async {
    return reloadItems();
  }

  Future reloadItems() async {
    return repo.items().then((value) {
      _items = value;
      notifyListeners();
    });
  }

  void addItem(mail, usern, passwd) {
    var email = mail;
    var username = usern;
    var password = passwd;
    var item = User(email, username, password);
    repo.insert(item).then((value) {
      reloadItems();
    });
  }

  void updateItem() {
    editingControllerEmail.text = editingItem.email;
    editingControllerUser.text = editingItem.username;
    editingControllerPass.text = editingItem.password;
    state = UserViewState.updateView;
  }

  void saveItem() {
    // TODO lưu editingItem

    // TODO editingItem = null
    editingItem = null;
    notifyListeners();
  }

  void deleteItem(mail, usern, passwd) {
    var email = mail;
    var username = usern;
    var password = passwd;
    var item = User(email, username, password);
    repo.delete(item).then((value) {
      reloadItems();
    });
  }
}
