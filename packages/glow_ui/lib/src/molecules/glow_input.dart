import 'package:flutter/material.dart';

import '../shaders/glow_stroke.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Input field with Glow styling
class GlowInput extends StatefulWidget {
  const GlowInput({
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.obscureText = false,
    this.dense = false,
    super.key,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool dense;

  @override
  State<GlowInput> createState() => _GlowInputState();
}

class _GlowInputState extends State<GlowInput> {
  late final FocusNode _focusNode;
  Offset? _haloOffset;
  bool _showHalo = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;
    final borderWidth = _isPressed ? 1.4 : (isFocused ? 1.3 : 1.1);
    final borderColor = isFocused
        ? GlowColors.primaryGlow.withValues(alpha: 0.9)
        : GlowColors.primaryGlow.withValues(alpha: 0.35);

    final contentPadding = widget.dense
        ? const EdgeInsets.symmetric(
            horizontal: GlowSpacing.md,
            vertical: GlowSpacing.sm,
          )
        : const EdgeInsets.symmetric(
            horizontal: GlowSpacing.md,
            vertical: GlowSpacing.md,
          );
    final iconConstraints = widget.dense
        ? const BoxConstraints(minWidth: 36, minHeight: 36)
        : const BoxConstraints(minWidth: 40, minHeight: 40);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GlowSpacing.md),
        boxShadow: isFocused
            ? GlowEffects.glowShadow(
                color: GlowColors.primaryGlow,
                blur: 18,
              )
            : const [],
      ),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          setState(() {
            _isPressed = true;
            _haloOffset = event.localPosition;
            _showHalo = true;
          });
        },
        onPointerUp: (_) => setState(() {
          _isPressed = false;
          _showHalo = false;
        }),
        onPointerCancel: (_) => setState(() {
          _isPressed = false;
          _showHalo = false;
        }),
        child: GlowStroke(
          radius: GlowSpacing.md,
          strokeWidth: borderWidth,
          color: GlowColors.primaryGlow,
          opacity: isFocused ? 0.55 : 0.35,
          child: Stack(
            children: [
              if (_haloOffset != null)
                Positioned(
                  left: _haloOffset!.dx - 30,
                  top: _haloOffset!.dy - 30,
                  child: IgnorePointer(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      width: _showHalo ? 60 : 0,
                      height: _showHalo ? 60 : 0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: _showHalo
                            ? GlowEffects.glowShadow(
                                color: GlowColors.primaryGlow,
                                blur: 24,
                              )
                            : const [],
                      ),
                    ),
                  ),
                ),
              TextField(
                focusNode: _focusNode,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
                onChanged: widget.onChanged,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: GlowColors.textPrimary),
                decoration: InputDecoration(
                  filled: false,
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  helperText: widget.helperText,
                  errorText: widget.errorText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
                  prefixIconConstraints: iconConstraints,
                  suffixIconConstraints: iconConstraints,
                  contentPadding: contentPadding,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(GlowSpacing.md),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(GlowSpacing.md),
                    borderSide: BorderSide(
                      color: GlowColors.primaryGlow.withValues(alpha: 0.95),
                      width: borderWidth,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(GlowSpacing.md),
                    borderSide: const BorderSide(color: GlowColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(GlowSpacing.md),
                    borderSide: const BorderSide(
                      color: GlowColors.error,
                      width: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
