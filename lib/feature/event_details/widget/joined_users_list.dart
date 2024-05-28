import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/profile/profile_view.dart';
import 'package:etkinlik/model/my_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinedUsersList extends ConsumerWidget {
  const JoinedUsersList({
    super.key,
    required this.joinedUsers,
  });

  final List<MyUser> joinedUsers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNum.medium,
      ),
      child: CustomCard(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: joinedUsers.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppNum.xSmall),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(joinedUsers[index].name),
                    ),
                    body: ProfileView(
                      isViewOnly: true,
                      user: joinedUsers[index],
                    ),
                  ),
                ));
              },
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppNum.xxSmall,
                horizontal: AppNum.small,
              ),
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  joinedUsers[index].photoURL,
                ),
              ),
              title: Text(
                joinedUsers[index].name,
              ),
            );
          },
        ),
      ),
    );
  }
}
