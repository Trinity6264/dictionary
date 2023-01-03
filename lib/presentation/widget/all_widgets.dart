import 'package:dictionary/constant/custom_color.dart';
import 'package:flutter/material.dart';

class AllWidgets {
  void banner(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
          elevation: 10,
          backgroundColor: CustomColor.lineColor,
          content: Row(
            children: const [
              Icon(Icons.wifi_off, color: CustomColor.textLightGrey),
              SizedBox(width: 15.0),
              Text(
                'No internet connection found',
                style: TextStyle(
                  color: CustomColor.textLightGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: const [Text('')]),
    );
  }

  void closeBanner(BuildContext context) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }

  void snackBar(BuildContext context) {
    closeBanner(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Internet connection restored'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
