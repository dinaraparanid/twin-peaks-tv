part of 'animation.dart';

final class AnimatedSelectionController extends ChangeNotifier {
  AnimatedSelectionController({
    required AnimationController animationController,
  }) : _animationController = animationController {
    borderAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  final AnimationController _animationController;
  late final Animation<double> borderAnimation;

  var _isSelected = false;

  bool get isSelected => _isSelected;

  Future<void> setSelected(bool isSelected) async {
    if (isSelected == _isSelected) {
      return;
    }

    _isSelected = isSelected;
    notifyListeners();

    if (isSelected) {
      await _animationController.forward();
    } else {
      await _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
