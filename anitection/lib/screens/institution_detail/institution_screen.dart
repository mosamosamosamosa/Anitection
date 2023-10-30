import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/animal_pad_background.dart';

class InstitutionScreen extends ConsumerStatefulWidget {
  const InstitutionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InstitutionScreenState();
  }
}

class InstitutionScreenState extends ConsumerState<InstitutionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFC3EB89),
        title: const Padding(
          padding: EdgeInsets.all(16),
          child: StrokeText(
            text: "あにまる保護施設",
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            strokeWidth: 4,
            strokeColor: Colors.white,
            textColor: Color(0xFF573F1B),
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset(2, 2),
              ),
            ],
          ),
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InstitutionImage(
                    url:
                        "https://img.furusato-tax.jp/img/x/original/feature/form/details/20211129/gpfd_107bfa9e0ad3c76c4afea5461d79acf480140bda.jpg",
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const InstitutionLabel(label: "所在地"),
                  const SizedBox(
                    height: 8,
                  ),
                  _Address(
                    address: "大阪府大阪市旭区高殿2-21-11-5",
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
                    tel: "222-2222-2222",
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
                      url: "http://www/nyannyan.com", onOpenWebSite: () {}),
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
                  const _Text(text: "Amazon"),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: _ChatButton(),
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

class _ChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            bottom: -8,
            child: Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD9D9D9),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            )),
        Container(
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFDF90),
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  "assets/svg/ic_chat_and_shadow.svg",
                  width: 40,
                  height: 32,
                ),
              ),
              const Positioned(
                  top: 32,
                  child: StrokeText(
                    text: "チャット",
                    textColor: Color(0xFFC39248),
                    strokeColor: Colors.white,
                    strokeWidth: 2,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
