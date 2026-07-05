import 'package:flutter/material.dart';

/// A shimmering skeleton placeholder using Flutter primitives.
class LcSkeleton extends StatefulWidget {
  /// Creates an [LcSkeleton].
  const LcSkeleton({
    required this.child,
    super.key,
  });

  /// The child widget, typically composed of [LcSkeletonBox] and
  /// [LcSkeletonCircle].
  final Widget child;

  @override
  State<LcSkeleton> createState() => _LcSkeletonState();
}

class _LcSkeletonState extends State<LcSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final gradient = LinearGradient(
              colors: [
                Colors.grey.withValues(alpha: 0.1),
                Colors.grey.withValues(alpha: 0.3),
                Colors.grey.withValues(alpha: 0.1),
              ],
              stops: const [0, 0.5, 1],
              begin: const Alignment(-1, -0.3),
              end: const Alignment(1, 0.3),
              transform: _SlidingGradientTransform(_controller.value),
            );
            return gradient.createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.slidePercent);

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * (slidePercent * 2 - 1),
      0,
      0,
    );
  }
}

/// A rectangular skeleton box.
class LcSkeletonBox extends StatelessWidget {
  /// Creates an [LcSkeletonBox].
  const LcSkeletonBox({
    this.width,
    this.height,
    this.borderRadius = 8,
    super.key,
  });

  /// The width of the box.
  final double? width;

  /// The height of the box.
  final double? height;

  /// The border radius.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// A circular skeleton shape, typical for avatars.
class LcSkeletonCircle extends StatelessWidget {
  /// Creates an [LcSkeletonCircle].
  const LcSkeletonCircle({
    this.size = 48,
    super.key,
  });

  /// The size of the circle (width and height).
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// A list of skeleton tiles.
class LcSkeletonList extends StatelessWidget {
  /// Creates an [LcSkeletonList].
  const LcSkeletonList({
    this.itemCount = 3,
    super.key,
  });

  /// Number of tiles to generate.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => const LcSkeletonListTile(),
    );
  }
}

/// A standard card skeleton.
class LcSkeletonCard extends StatelessWidget {
  /// Creates an [LcSkeletonCard].
  const LcSkeletonCard({
    this.height = 150,
    super.key,
  });

  /// The height of the card.
  final double height;

  @override
  Widget build(BuildContext context) {
    return LcSkeleton(
      child: LcSkeletonBox(
        height: height,
        width: double.infinity,
        borderRadius: 16,
      ),
    );
  }
}

/// A standard avatar skeleton.
class LcSkeletonAvatar extends StatelessWidget {
  /// Creates an [LcSkeletonAvatar].
  const LcSkeletonAvatar({
    this.size = 48,
    super.key,
  });

  /// The size of the avatar.
  final double size;

  @override
  Widget build(BuildContext context) {
    return LcSkeleton(
      child: LcSkeletonCircle(size: size),
    );
  }
}

/// A standard list tile skeleton.
class LcSkeletonListTile extends StatelessWidget {
  /// Creates an [LcSkeletonListTile].
  const LcSkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const LcSkeleton(
      child: Row(
        children: [
          LcSkeletonCircle(size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LcSkeletonBox(height: 16, width: double.infinity),
                SizedBox(height: 8),
                LcSkeletonBox(height: 14, width: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
