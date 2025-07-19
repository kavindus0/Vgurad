import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';

class FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverEnter(PointerEvent details) {
    _controller.forward();
  }

  void _onHoverExit(PointerEvent details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onHoverEnter,
      onExit: _onHoverExit,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Card(
              elevation: AppSizes.cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.borderRadiusMedium,
                ),
                side: BorderSide(color: AppColors.grey300),
              ),
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingXLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingSmall + 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        color: AppColors.primaryGreen,
                        size: AppSizes.iconSizeXLarge,
                      ),
                    ),
                    Text(widget.title, style: AppTextStyles.featureCardTitle),
                    const SizedBox(height: AppSizes.paddingSmall),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 15, color: AppColors.grey700),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onButtonPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.paddingMedium,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusMedium,
                            ),
                          ),
                          elevation: AppSizes.cardElevation,
                        ),
                        child: Text(
                          widget.buttonText,
                          style: const TextStyle(
                            fontSize: AppSizes.paddingMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
