import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:plaid_link/values/colors.dart';
import 'package:plaid_link/values/string.dart';

class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with MaterialStateMixin, SingleTickerProviderStateMixin {

  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: kThemeAnimationDuration, vsync: this);
    _controller!.addListener(() {setState(() {});});
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(materialStates.contains(MaterialState.pressed)){
      _controller?.animateTo(1.0, curve: Curves.easeOutCubic);
    }else{
      _controller?.animateBack(0.0, curve: Curves.easeOutExpo);
    }

    return Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
            color: Colours.background,
            boxShadow: [
              BoxShadow(
                  color: Colours.shadow,
                  offset: Offset(
                      2 * (1 - _controller!.value),
                      2 * (1 - _controller!.value)),
                  blurRadius: 6 * (1 - _controller!.value),
                  spreadRadius: 2 * (1 - _controller!.value)),
              BoxShadow(
                color: Colours.light,
                offset: Offset(
                    -2 * (1 - _controller!.value),
                    -2 * (1 - _controller!.value)),
                blurRadius: 6 * (1 - _controller!.value),
              ),
              const BoxShadow(
                color: Colours.background,
                offset: Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 1
              )
            ],
            borderRadius: BorderRadius.circular(20)
        ),
        child: InkWell(
          onHighlightChanged: updateMaterialState(MaterialState.pressed),
          onTap: () async {
            final configuration = LinkTokenConfiguration(token: token);
            await PlaidLink.open(configuration: configuration);
          },
          customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Center(child: Text("Link Bank Account", style: TextStyle(color: Colours.fontColor),)),
        )
    );
  }
}
