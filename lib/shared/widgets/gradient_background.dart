import 'package:flutter/material.dart';
import 'package:mobile_bursar_android/shared/shared.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class GradientBackground extends StatelessWidget {
  /// 是否需要水波浪
  final bool needWave;
  final Widget? child;
  final bool needTopSafeArea;
  final bool needTopRadius;

  const GradientBackground({
    super.key,
    this.needWave = true,
    this.needTopSafeArea = true,
    this.needTopRadius = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return needTopSafeArea
        ? Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: SafeArea(
              child: _buildBackground(context),
            ),
          )
        : _buildBackground(context);
  }

  Widget _buildBackground(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: needTopRadius
                ? const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  )
                : null,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.9],
              colors: [
                hexToColor('#405FA3'),
                hexToColor('#1ED69D'),
              ],
            ),
          ),
          child: child,
        ),
        if (needWave)
          Positioned(
            bottom: 0,
            left: 0,
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [hexToColor('#2BA99F'), hexToColor('#22CC9E')],
                  [hexToColor('#2BA99F'), hexToColor('#3BCDAD')],
                  [hexToColor('#3CC8AE'), hexToColor('#22C69E')],
                  [hexToColor('#55D5B1'), hexToColor('#54D9B1')]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.20, 0.23, 0.25, 0.30],
                blur: const MaskFilter.blur(BlurStyle.solid, 1),
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
              waveAmplitude: 20,
              size: Size(
                MediaQuery.of(context).size.width,
                60.0,
              ),
            ),
          ),
      ],
    );
  }
}
