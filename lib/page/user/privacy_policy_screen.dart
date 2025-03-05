import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
 
Last Updated: 04/03/25  

 1. Introduction  
Welcome to "Rider Spot!" Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our application.  

 2. Information We Collect  
We collect the following types of information:  
• Personal Information: Name, email, phone number, and profile details.  
• Location Data: To provide accurate ride suggestions and navigation services.  
• Payment Information: If applicable, for transactions and billing purposes.  
• Device & Usage Data: App interactions, preferences, and crash reports.  

3. How We Use Your Information  
We use the collected data to:  
• Provide and improve our services.  
• Facilitate ride bookings and payments.  
• Ensure safety and security.  
• Send service-related notifications and updates.  

 4. Data Sharing & Security  
• We do not sell or share your personal data with third parties except as required by law.  
• Your data is encrypted and securely stored.  

 5. User Rights  
You have the right to:  
• Access, update, or delete your personal data.  
• Disable location tracking (which may limit app functionality).  
• Contact us for any privacy-related concerns.  

 6. Changes to This Policy  
We may update this Privacy Policy periodically. We will notify users of any significant changes.  

For questions, contact adilcp8590@gmail.com.  
''',
            style: TextStyle(
                fontSize: 16, height: 2.0, color: customTextTheme(context)),
          ),
        ),
      ),
    );
  }
}
