import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/admin/admin.dart';

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  final _searchController = TextEditingController();

  List<User> searchResult = [];
  List<User> users = [];

  _UserListState() {

    /* TEST DATA */
    var user = new User("1", "Matej", "Michalek", "matej@mail.com", "password",
        null, SystemRole.student);
    var user1 = new User("2", "Michaela", "Golhova", "miska@mail.com",
        "password", null, SystemRole.teacher);
    var user2 = new User("3", "Michal", "Pompa", "michal@mail.com", "password",
        null, SystemRole.teacher);
    var user3 = new User("4", "Karol", "Karol", "michal@mail.com", "password",
        null, SystemRole.teacher);
    var user4 = new User("5", "Izidor", "Pompa", "michal@mail.com", "password",
        null, SystemRole.teacher);

    users.add(user);
    users.add(user1);
    users.add(user2);
    users.add(user3);
    users.add(user4);
  }

  onUserUpdated(String id, String systemRole) {
    BlocProvider.of<AdminBloc>(context)
        .add(UpdateSystemRole(userId: id, systemRole: systemRole));
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

  /*  --------------------------------------------------------- COMMON WIDGETS ----------------------------------------------------------------------- */

  Widget defaultImage() {
    return Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQhOaaBAY_yOcJXbL4jW0I_Y5sePbzagqN2aA&usqp=CAU"))));
  }

  /*  --------------------------------------------------------- ANDROID LAYOUT ----------------------------------------------------------------------- */

  Widget androidLayout(AdminState state) {
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
          Expanded(child: searchResult.length != 0 || _searchController.text.isNotEmpty
          ? userListAndroid(searchResult)
        : userListAndroid(users))
        ],
      ),
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
                        defaultImage(),
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
                      Text(userList[index].firstName + ' ' + userList[index].lastName,
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
                      onUserUpdated(userList[index].id, userList[index].systemRole.name);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: userList[index].systemRole.name == 'teacher'
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

  /*  --------------------------------------------------------- WEB LAYOUT ----------------------------------------------------------------------- */

  Widget webLayout(AdminState state) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Card(
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
                margin: EdgeInsets.only(bottom: 20.0),
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
              Expanded(child: searchResult.length != 0 || _searchController.text.isNotEmpty
                  ? userListWeb(searchResult)
                  : userListWeb(users))
            ],
          ),
        ),
      ),
    );
  }

  Widget userListWeb(List<User> userList) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Container(
          height: 150.0,
          child: Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultImage(),
                      Text(userList[index].systemRole.name,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'BalooTammuduBold',
                              color: Colors.brown)),
                    ],
                  ),
                  Text(userList[index].firstName + ' ' + userList[index].lastName,
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'BalooTammudu',
                          color: Colors.brown)),
                  Container(
                    child: ButtonTheme(
                      minWidth: 90,
                      height: 50,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Colors.white,
                        onPressed: () {
                          onUserUpdated(userList[index].id, userList[index].systemRole.name);
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(top: 9.0),
                            child: userList[index].systemRole.name == 'teacher'
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
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {},
      child: BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return webLayout(state);
          } else {
            return androidLayout(state);
          }
        });
      }),
    );
  }

  // TODO - handle all states
  void handleState(AdminState state) {
  }
}
