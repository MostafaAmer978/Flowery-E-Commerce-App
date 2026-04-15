import 'package:url_launcher/url_launcher.dart';

Future<void> callNumber(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

Future<void> openWhatsApp(String phoneNumber, {String message = ''}) async {
  final Uri whatsappUri = Uri.parse(
    "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
  );
  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open WhatsApp';
  }
}
