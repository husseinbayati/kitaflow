import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/design_tokens.dart';
import '../theme/app_colors.dart';

/// Zentrierter Ladeindikator mit optionaler Nachricht.
class KfLoading extends StatelessWidget {
  const KfLoading({
    super.key,
    this.message,
  });

  /// Optionaler Text unter dem Ladeindikator.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
          if (message != null) ...[
            AppGaps.v16,
            Text(
              message!,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Shimmer-Platzhalter für ladende Listen.
///
/// Zeigt animierte Platzhalterzeilen, bis die echten Daten geladen sind.
class KfShimmerList extends StatelessWidget {
  const KfShimmerList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 72,
    this.padding,
  });

  /// Anzahl der Platzhalterzeilen.
  final int itemCount;

  /// Höhe jeder Platzhalterzeile in dp.
  final double itemHeight;

  /// Optionales Padding um die Liste.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariant,
      highlightColor: AppColors.surface,
      child: Padding(
        padding: padding ?? AppPadding.screen,
        child: Column(
          children: List.generate(
            itemCount,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
              child: _ShimmerItem(height: itemHeight),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      padding: AppPadding.card,
      child: Row(
        children: [
          // Avatar-Platzhalter
          Container(
            width: DesignTokens.avatarMd,
            height: DesignTokens.avatarMd,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
          ),
          AppGaps.h12,
          // Text-Platzhalter
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: DesignTokens.spacing12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusXs),
                  ),
                ),
                AppGaps.v8,
                Container(
                  height: DesignTokens.spacing12,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusXs),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
