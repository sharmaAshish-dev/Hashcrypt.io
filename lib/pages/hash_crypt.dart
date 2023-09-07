import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashcrypt/hash_functions/string_extension.dart';
import 'package:hashcrypt/values/colors.dart';
import 'package:hashcrypt/widgets/app_logo.dart';
import 'package:layout/layout.dart';
import 'package:particles_fly/particles_fly.dart';

import '../hash_functions/hash_functions.dart';
import '../values/images.dart';
import '../widgets/dropdown.dart';
import '../widgets/footer.dart';

class Hashcrypt extends ConsumerStatefulWidget {
  const Hashcrypt({Key? key}) : super(key: key);

  @override
  ConsumerState<Hashcrypt> createState() => _HashcryptState();
}

class _HashcryptState extends ConsumerState<Hashcrypt> {
  final TextEditingController _text = TextEditingController();
  final _hashedText = StateProvider<String>((ref) => "");
  final List<HashType> _encryptionTypes = HashType.values;
  final _selectedEncryptionType = StateProvider<HashType>((ref) => HashType.md5);

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AppLogo(
            fontSize: context.layout.value(
          xs: 20,
          sm: 20,
          md: 30,
          lg: 30,
        )),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          ParticlesFly(
            height: context.layout.size.height,
            width: context.layout.size.width,
            connectDots: true,
            particleColor: AppColors.primaryColor,
            numberOfParticles: context.layout.value(
              xs: 50,
              sm: 80,
              md: 100,
              lg: 120,
            ),
            onTapAnimation: false,
            speedOfParticles: 4,
            enableHover: false,
            isRandSize: true,
          ),
          ListView(
            children: [
              const SizedBox(height: 50),
              Column(
                children: [
                  SizedBox(
                    width: context.layout.breakpoint >= LayoutBreakpoint.md ? context.layout.size.width * 0.25 : context.layout.size.width * 0.7,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Encryption: ",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.primaryColor),
                        ),
                        SizedBox(
                          width: context.layout.value(
                            xs: 10,
                            sm: 10,
                            md: 10,
                            lg: 20,
                          ),
                        ),
                        Expanded(
                          child: DropDownUtils<HashType>(items: _encryptionTypes, title: "Encryption", showSearchBar: false, selectedItem: ref.watch(_selectedEncryptionType)).dropDownMenu(
                            (value) {
                              ref.read(_selectedEncryptionType.notifier).state = value;
                              ref.read(_hashedText.notifier).state = _text.text.encode(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: context.layout.breakpoint >= LayoutBreakpoint.md ? context.layout.size.width * 0.5 : context.layout.size.width * 0.9,
                        child: TextField(
                          controller: _text,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              ref.read(_hashedText.notifier).state = value.encode(ref.read(_selectedEncryptionType));
                            } else {
                              ref.read(_hashedText.notifier).state = "";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter text to encrypt",
                            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(20),
                          ),
                          style: const TextStyle(color: Colors.black),
                          maxLines: context.layout.breakpoint < LayoutBreakpoint.lg ? 10 : 15,
                          minLines: context.layout.breakpoint < LayoutBreakpoint.lg ? 10 : 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (ref.watch(_hashedText).isNotEmpty)
                    Text(
                      "Hash:",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.primaryColor),
                    ),
                  if (ref.watch(_hashedText).isNotEmpty)
                    const SizedBox(
                      height: 8,
                    ),
                  if (ref.watch(_hashedText).isNotEmpty)
                    Text(
                      ref.watch(_hashedText),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor, fontSize: 20),
                    ),
                  if (ref.watch(_hashedText).isNotEmpty)
                    const SizedBox(
                      height: 16,
                    ),
                  if (ref.watch(_hashedText).isNotEmpty)
                    MaterialButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: ref.watch(_hashedText)));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Copied to clipboard"),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.content_copy,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Copy",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Footer(),
        ],
      ),
    );
  }

  Widget get logo => Align(
        alignment: Alignment.topLeft,
        child: Margin(
          margin: const EdgeInsets.only(top: 8, left: 8),
          child: AppLogo(
            fontSize: context.layout.value(
              xs: 20,
              sm: 20,
              md: 20,
              lg: 30,
            ),
          ),
        ),
      );
}
