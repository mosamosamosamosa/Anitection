import 'package:anitection/components/institution_title.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/constants.dart';
import 'package:anitection/providers/institution.dart';
import 'package:anitection/screens/chat/chat_screen.dart';
import 'package:anitection/screens/institution_detail/chat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/animal_pad_background.dart';

class InstitutionScreen extends ConsumerStatefulWidget {
  const InstitutionScreen({super.key, required this.institutionId});
  final int institutionId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InstitutionScreenState();
  }
}

class InstitutionScreenState extends ConsumerState<InstitutionScreen> {
  @override
  Widget build(BuildContext context) {
    final institutionFuture = ref.watch(institutionFutureProvider(widget.institutionId));
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        backgroundColor: const Color(0xFFC3EB89),
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: InstitutionTitle(title: institutionFuture.valueOrNull?.attributes.name ?? ""),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: NavUpButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          // ここに他のウィジェットを追加
          SingleChildScrollView(
            child: institutionFuture.when(data: (institution) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InstitutionImage(
                      url: AppConstants.mediaServerBaseUrl + (institution.attributes.image?.data.attributes.url ?? ''),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const InstitutionLabel(label: "所在地"),
                    const SizedBox(
                      height: 8,
                    ),
                    _Address(
                      address: institution.attributes.address ?? "",
                      onCopyToClipboard: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const InstitutionLabel(label: "電話番号"),
                    const SizedBox(
                      height: 8,
                    ),
                    _Tel(
                      tel: institution.attributes.phone ?? "",
                      onCopyToClipboard: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const InstitutionLabel(label: "Webサイト"),
                    const SizedBox(
                      height: 8,
                    ),
                    _WebSite(
                        url: institution.attributes.websiteUrl ?? "", onOpenWebSite: () {}),
                    const SizedBox(
                      height: 16,
                    ),
                    const InstitutionLabel(label: "取扱動物"),
                    const SizedBox(
                      height: 8,
                    ),
                    const _Text(text: "犬 23匹 / 猫 12匹 / 鳥 4匹 / "),
                    const SizedBox(
                      height: 16,
                    ),
                    const InstitutionLabel(label: "ほしい物リスト"),
                    const SizedBox(
                      height: 8,
                    ),
                    _Text(text: institution.attributes.needsUrl ?? ""),
                  ],
                ),
              );
            }, error: (e, st) {
              return Center(
                child: Text(e.toString()),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          )
        ],
      ),
      floatingActionButton: ChatButton(onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      },),
    );
  }
}

class InstitutionImage extends StatelessWidget {
  const InstitutionImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: const Color(0xFFC3EB89),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            url,
          ),
        ),
      ),
    );
  }
}

class InstitutionLabel extends StatelessWidget {
  const InstitutionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFC3EB89),
          borderRadius: BorderRadius.circular(6),
        ),
        child: StrokeText(
          text: label,
          textColor: const Color(0xFF444444),
          strokeColor: Colors.white,
          strokeWidth: 4,
        ),
      ),
    );
  }
}

class _Address extends StatelessWidget {
  const _Address({required this.address, required this.onCopyToClipboard});

  final String address;
  final VoidCallback onCopyToClipboard;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              address,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            GestureDetector(
              onTap: onCopyToClipboard,
              child: const Icon(
                Icons.copy,
                color: Color(0xFFC3EB89),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Tel extends StatelessWidget {
  const _Tel({required this.tel, required this.onCopyToClipboard});

  final String tel;
  final VoidCallback onCopyToClipboard;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: [
            Text(
              tel,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            GestureDetector(
              onTap: onCopyToClipboard,
              child: const Icon(
                Icons.copy,
                color: Color(0xFFC3EB89),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebSite extends StatelessWidget {
  const _WebSite({required this.url, required this.onOpenWebSite});

  final String url;
  final VoidCallback onOpenWebSite;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              url,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            GestureDetector(
              onTap: onOpenWebSite,
              child: const Icon(
                Icons.open_in_new,
                color: Color(0xFFC3EB89),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
