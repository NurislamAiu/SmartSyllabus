import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_app/src/core/router/route_names.dart';

class KpiCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final String illustrationAsset;

  const KpiCard({
    super.key,
    required this.label,
    required this.count,
    required this.color,
    required this.illustrationAsset,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: const Color(0x1AD9D9D9),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color)),
                      ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).pushNamed(RouteNames.syllabus);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          elevation: 0,
                        ),
                        child: const Text('Перейти'),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Positioned(
              left: 80,
              top: 60,
              child: Text('$count',
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(illustrationAsset,
                  height: 90, fit: BoxFit.contain),
            ),
          ]),
        ),
      ),
    );
  }
}