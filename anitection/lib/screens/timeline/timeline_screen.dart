import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/constants.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/timeline/timeline.dart';
import 'package:anitection/providers/institution.dart';
import 'package:anitection/providers/timeline_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineScreen extends ConsumerStatefulWidget {
  const TimelineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TimelineScreenState();
  }
}

class TimelineScreenState extends ConsumerState<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(timelineControllerProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          controller.when(data: (data) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: data.length,
              itemBuilder: (context, index) {
                return TimelineCard(
                  timeline: data[index],
                );
              },
            );
          }, error: (e, st) {
            return Center(
              child: Text(e.toString() + st.toString()),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          })
        ],
      ),
    );
  }
}

class TimelineCard extends ConsumerWidget {
  const TimelineCard({super.key, required this.timeline});
  final Model<TimelineAttributes> timeline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final institution = ref.watch(institutionFutureProvider(timeline.attributes.institution?.data.id ?? 0));
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      AppConstants.mediaServerBaseUrl + (institution.valueOrNull?.attributes.image?.data.attributes.url ?? "")),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text(
                  timeline.attributes.institution?.data.attributes.name ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF444444),
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Flexible(child: Text(timeline.attributes.content, textAlign: TextAlign.left,)),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            if (timeline.attributes.images != null)
              ...[
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    children: timeline.attributes.images?.data?.map((e) {
                      return Image.network(
                        AppConstants.mediaServerBaseUrl + (e.attributes.url ?? ""),
                        fit: BoxFit.cover,
                      );
                    }).toList() ?? [],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: 24,
                    )),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.chat,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
