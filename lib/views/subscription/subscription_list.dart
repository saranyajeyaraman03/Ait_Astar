class FanSubscriptionList {
  final int id;
  final int userId;
  final int status;
  final String startDate;
  final String endDate;
  final String unsubscribeDate;
  final bool isAutoDebit;
  final String planType;
  final String userType;
  final double planPrice;
  final int numberOfMonth;
  final String currency;
  final String stripeSubscriptionId;
  final String? stripeSubscriptionId2;
  final String? subscribedUser;
  final String? subscribedType;

  FanSubscriptionList({
    required this.id,
    required this.userId,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.unsubscribeDate,
    required this.isAutoDebit,
    required this.planType,
    required this.userType,
    required this.planPrice,
    required this.numberOfMonth,
    required this.currency,
    required this.stripeSubscriptionId,
    this.stripeSubscriptionId2,
    this.subscribedUser,
    this.subscribedType,
  });

  factory FanSubscriptionList.fromJson(Map<String, dynamic> json) {
    return FanSubscriptionList(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? 0,
      startDate: json['start_date'] ?? "",
      endDate: json['end_date'] ?? "",
      unsubscribeDate: json['unsubscribe_date'] ?? "",
      isAutoDebit: json['is_auto_debit'] ?? false,
      planType: json['plan_type'] ?? "",
      userType: json['user_type'] ?? "",
      planPrice: (json['plan_price'] as num?)?.toDouble() ?? 0.0,
      numberOfMonth: json['number_of_month'] ?? 0,
      currency: json['currency'] ?? "",
      stripeSubscriptionId: json['stripe_subscription_id'] ?? "",
      stripeSubscriptionId2: json['stripe_subscription_id_2'] ?? "",
      subscribedUser: json['subscribed_user'] ?? "None",
      subscribedType: json['subscribed_type'] ?? "",
    );
  }
}
