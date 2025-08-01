import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'app_colors.dart';

class CustomLogger {
  static logged(
      String message, {
        DateTime? time,
        int? sequenceNumber,
        int level = 0,
        String name = '',
        Zone? zone,
        Object? error,
        StackTrace? stackTrace,
      }) {
    // if (kDebugMode) {
    log(
      message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
    // }
  }
}
enum PreferenceHolders {
  authenticated,
  noMultiLogin,
  forceLogOut,
  password,
  pictorialFailureCount,
  failurePageCount,  complaintPageCount,
  otherDeviceLoggedIn,
  userLoggedIn,
  firstTimeLogin,
  countryId,
  userId,
  userName,
  mobileNumber,
  accessToken,
  email,
  refreshToken,
  jwt,
  mobileUniqueId,
  selectedCode,
  isFullFCR,
  employeeId,
  logDate,
  blobContainer,
  blobConnectionString,
  countryFree,
  brandFree,
  selectedLanguageId,
  selectedLanguage,
  secondLanguage,
  secondLanguageId,
  secondLanguageCode,
  defaultLanguage,
  defaultLanguageId,
  complaintsLastSynced,
  failureLastSynced,
  defaultChannelName,
  defaultDistributor,
  defaultRegionName,
  defaultChannelType,
  defaultChannelTypeId,
  defaultProvinceId,
  fcrOrPictorial,
  isCountryLocalVin,
  isCountryFuelType,
  defaultImageSize,
  defaultVideoSize,
}
customErrorToast(String errorString, BuildContext ctx) {
  try {
    showTopSnackBar(
      Overlay.of(ctx),
      Center(
        child: Container(
          height: 60,
          constraints: const BoxConstraints(maxWidth: 400),
          child: CustomSnackBar.error(
            icon: const SizedBox(),
            backgroundColor: AppColors.errorColor,
            message: errorString,
            maxLines: 3,
            textStyle: Theme.of(ctx)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColors.lightColor),
          ),
        ),
      ),
      snackBarPosition: SnackBarPosition.bottom,
    );
  } on Exception catch (e) {
    CustomLogger.logged(e.toString());
  }
}
