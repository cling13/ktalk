import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ktalk/chat/providers/chat_provider.dart';
import 'package:ktalk/common/utils/global_navigator.dart';
import 'package:ktalk/friend/providers/friend_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../common/utils/logger.dart';

class FriendListScreen extends ConsumerWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ref.watch(getFriendListProvider).when(
        data: (data) {
          context.loaderOverlay.hide();
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final contact = data[index];
              return ListTile(
                onTap: () async {
                  await ref
                      .read(chatProvider.notifier)
                      .enterChatFromFriendList(selectedContact: contact);
                },
                title: Text(contact.displayName),
                leading: CircleAvatar(
                  backgroundImage: contact.photo == null
                      ? const ExtendedAssetImageProvider(
                          'assets/images/profile.png')
                      : ExtendedMemoryImageProvider(contact.photo!),
                  radius: 30,
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          context.loaderOverlay.hide();
          logger.e(error);
          logger.e(stackTrace);
          GlobalNavigator.showAlertDialog(text: error.toString());
          return null;
        },
        loading: () {
          context.loaderOverlay.show();
          return null;
        },
      ),
    );
  }
}
