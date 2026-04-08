import 'package:flutter/material.dart';

/// Un indicador de progreso sutil y animado para procesos sin tiempo límite.
/// En lugar de una barra continua, muestra una línea de puntos que se desplaza lentamente.
class InfiniteProgressIndicator extends StatefulWidget {
  final Color? color;
  final Color? backgroundColor;
  final double height;
  final BorderRadius? borderRadius;

  const InfiniteProgressIndicator({
    super.key,
    this.color,
    this.backgroundColor,
    this.height = 8.0,
    this.borderRadius,
  });

  @override
  State<InfiniteProgressIndicator> createState() => _InfiniteProgressIndicatorState();
}

class _InfiniteProgressIndicatorState extends State<InfiniteProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Animación lenta y fluida
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? Theme.of(context).colorScheme.primary;
    final effectiveBackgroundColor = widget.backgroundColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _DottedLinePainter(
              color: effectiveColor,
              phase: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double phase; // 0.0 to 1.0

  _DottedLinePainter({
    required this.color,
    required this.phase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const dotSpacing = 16.0;
    final dotRadius = size.height / 3;
    
    // El desplazamiento total de un ciclo es igual al espaciado entre puntos
    final offset = phase * dotSpacing;
    
    double startX = offset;
    
    // Dibujamos puntos hacia la derecha
    while (startX < size.width + dotRadius) {
      canvas.drawCircle(Offset(startX, size.height / 2), dotRadius, paint);
      startX += dotSpacing;
    }
    
    // Dibujamos un punto extra a la izquierda para cubrir el hueco al inicio del ciclo
    canvas.drawCircle(Offset(offset - dotSpacing, size.height / 2), dotRadius, paint);
  }

  @override
  bool shouldRepaint(covariant _DottedLinePainter oldDelegate) {
    return oldDelegate.phase != phase || oldDelegate.color != color;
  }
}
