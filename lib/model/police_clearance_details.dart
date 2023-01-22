import 'package:policesystem/cashier/cashier_model/cashier_model.dart';
import 'package:policesystem/model/applicant.dart';
import 'package:policesystem/model/barangay.dart';
import 'package:policesystem/model/ctc.dart';
import 'package:policesystem/model/police_clearance.dart';
import 'package:policesystem/model/police_model.dart';
import 'package:policesystem/model/pur_model.dart';
import 'package:policesystem/model/zone_model.dart';

class PoliceClearanceDetails {
  final int id;
  final int pccId;
  final int applicantId;
  final int purposeId;
  final int ctcId;
  final int policeId;
  final int oicId;
  final int paymentId;
  final String status;
  final String createdAt;
  final PoliceClearance pcc;
  final Applicant applicant;
  final Purpose purpose;
  //barangay added
  // final Barangay barangay;
  // Zone added
  // final Zone zone;
  final CommunityTaxCertificate ctc;
  final Police police;
  final Payment payment;

  PoliceClearanceDetails({
    required this.id,
    required this.pccId,
    required this.applicantId,
    required this.purposeId,
    required this.ctcId,
    required this.policeId,
    required this.oicId,
    required this.paymentId,
    required this.status,
    required this.createdAt,
    required this.pcc,
    required this.applicant,
    required this.purpose,
    required this.ctc,
    required this.police,
    required this.payment,
    //barangay added
    // required this.barangay,
    //zone added
    // required this.zone,
  });

  factory PoliceClearanceDetails.fromJson(Map<String, dynamic> json) =>
      PoliceClearanceDetails(
        id: json['id'],
        pccId: json['pcc_id'],
        applicantId: json['applicant_id'],
        purposeId: json['purpose_id'],
        ctcId: json['ctc_id'],
        policeId: json['police_id'],
        oicId: json['oic_id'],
        paymentId: json['payment_id'],
        status: json['status'],
        createdAt: json['created_at'],
        pcc: PoliceClearance.fromJson(json['pcc']),
        applicant: Applicant.fromJson(json['applicant']),
        //barangay added
        // barangay: Barangay.fromJson(json['barangay']),
        //zone added
        // zone: Zone.fromJson(json['zone']),
        purpose: Purpose.fromJson(json['purpose']),
        ctc: CommunityTaxCertificate.fromJson(json['ctc']),
        police: Police.fromJson(json['police']),
        payment: Payment.fromJson(json['payment']),
      );
}
