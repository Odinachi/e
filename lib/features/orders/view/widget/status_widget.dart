import 'package:flutter/cupertino.dart';

import '../../../../app/app_assets.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/app_constant.dart';
import '../../data/domain/models/order_status_model.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.model,
    this.status = Status.future,
  });

  final OrderStatusModel model;
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: status == Status.passed ? 0.3 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryColor,
            ),
            color: status == Status.current ? AppColors.primaryColor : null,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            AppImageBuilder(
              path: model.image ?? "",
              fit: BoxFit.cover,
              color: status == Status.current
                  ? AppColors.white
                  : AppColors.primaryColor,
              height: 30,
              width: 30,
            ),
            const AppSpace(
              axis: Axis.horizontal,
              percentage: .04,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: model.title,
                      children: [
                        TextSpan(
                          text:
                              " (${DateTime.now().difference(model.time ?? DateTime.now()).inMinutes} mins ago)",
                          style: appStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: status == Status.current
                                ? AppColors.white.withOpacity(.8)
                                : AppColors.hintGrey,
                          ),
                        ),
                      ],
                      style: appStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color:
                            status == Status.current ? AppColors.white : null,
                      ),
                    ),
                  ),
                  if (model.desc?.isNotEmpty ?? false)
                    Text(
                      model.desc ?? "",
                      style: appStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: status == Status.current
                            ? AppColors.white.withOpacity(.8)
                            : AppColors.hintGrey,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Status { passed, current, future }
