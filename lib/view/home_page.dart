import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screl_test/constants/colors.dart';
import 'package:screl_test/controller/provider_class.dart';
import 'package:screl_test/model/model.dart';
import 'package:screl_test/service/api_service.dart';
import 'package:screl_test/view/details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  List<bool> isStarred = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: const Text(
          'Users List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  placeholder: 'Search Users',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<UserModel>>(
                    future: ApiService().fetchUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No data available.'));
                      } else {
                        List<UserModel> allUsers = snapshot.data!;
                        return ListView.builder(
                          itemCount: allUsers.length,
                          itemBuilder: (context, index) {
                            UserModel userModel = allUsers[index];

                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: ListTile(
                                title: Text(
                                  userModel.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  userModel.email,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: Consumer<UserController>(
                                  builder: (context, starredModel, child) {
                                    bool isUserStarred =
                                        starredModel.isStarred[index];
                                    return IconButton(
                                      icon: isUserStarred
                                          ? Icon(Icons.star, color: starColor)
                                          : const Icon(Icons.star_border),
                                      onPressed: () {
                                        starredModel.toggleStar(index);
                                      },
                                    );
                                  },
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(model: userModel),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
