import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/admin/admin.dart';
import 'package:streamster_app/admin/view/admin_common_widgets.dart';
import 'package:streamster_app/common/model/user.dart';

class AdminFormAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminFormAndroidState();
}

class _AdminFormAndroidState extends State<AdminFormAndroid> {
  final _searchController = TextEditingController();

  List<User> searchResult = [];
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        handleState(state);
      },
      child: BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
        return Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Text("User List",
                    style: TextStyle(
                        fontFamily: 'BalooTammuduBold',
                        color: Colors.brown,
                        fontSize: 25.0)),
              ),
              Container(
                width: 250,
                child: TextField(
                    onChanged: onSearchTextChanged,
                    controller: _searchController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: 'BalooTammudu',
                        ),
                        contentPadding: EdgeInsets.only(top: 20),
                        hintText: 'Search')),
              ),
              Expanded(
                  child: searchResult.length != 0 ||
                          _searchController.text.isNotEmpty
                      ? userListAndroid(searchResult)
                      : userListAndroid(users))
            ],
          ),
        );
      }),
    );
  }

  Widget userListAndroid(List<User> userList) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Container(
          height: 150.0,
          child: Card(
            child: ListTile(
              title: Row(
                children: [
                  Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AdminCommonWidgets.defaultImage(),
                        Text(userList[index].systemRole.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'BalooTammuduBold',
                                color: Colors.brown)),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          userList[index].firstName +
                              ' ' +
                              userList[index].lastName,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'BalooTammudu',
                              color: Colors.brown)),
                      Container(
                        child: ButtonTheme(
                          minWidth: 80,
                          height: 35,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.brown),
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Colors.white,
                            onPressed: () {
                              onUserUpdated(userList[index].id,
                                  userList[index].systemRole);
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(top: 9.0),
                                child:
                                    userList[index].systemRole.name == 'teacher'
                                        ? Text('update to student',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'BalooTammudu',
                                                color: Colors.brown))
                                        : Text('update to teacher',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'BalooTammudu',
                                                color: Colors.brown))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  onUserUpdated(String id, SystemRole systemRole) {
    if (systemRole == SystemRole.teacher) {
      BlocProvider.of<AdminBloc>(context)
          .add(UpdateSystemRole(userId: id, systemRole: SystemRole.student));
    } else {
      BlocProvider.of<AdminBloc>(context)
          .add(UpdateSystemRole(userId: id, systemRole: SystemRole.teacher));
    }
  }

  getUsers() {
    BlocProvider.of<AdminBloc>(context).add(GetUsers());
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    users.forEach((userDetail) {
      if (userDetail.firstName.contains(text) ||
          userDetail.lastName.contains(text)) searchResult.add(userDetail);
    });
    setState(() {});
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  // TODO - handle all states
  void handleState(AdminState state) {
    switch (state.status) {
      case AdminStatus.success:
        setState(() {
          users = state.users;
        });
        print("state set in form web");
        break;
      case AdminStatus.error:
        // TODO: Handle this case.
        break;
      case AdminStatus.loading:
        // TODO: Handle this case.
        break;
      case AdminStatus.updateSuccessful:
        print('update successful');
        break;
      default:
        break;
    }
  }
}
