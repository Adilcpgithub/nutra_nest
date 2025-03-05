import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: customTextTheme(context)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''

Effective Date: 04/03/29  

1. Acceptance of Terms  
By using " Rider Spot", you agree to these Terms & Conditions.  
If you do not agree, please refrain from using the app.  

 2. User Eligibility    
• Users must provide accurate personal information.  

 3. Booking & Payments  
• Users can book rides through the app.  
• Payments are processed securely, and refunds are subject to our policy.  

 4. User Responsibilities  
• Users must **respect drivers** and follow **local transportation laws**.  
• Misuse of the platform may result in **account suspension**.  

 5. Limitation of Liability  
• We do not guarantee ride availability at all times.  

6. Account Termination  
We reserve the right to **terminate or suspend accounts** that violate our policies.  

 7. Changes to Terms  
We may modify these Terms at any time.  
Continued use of the app implies acceptance of updates.  

For support, contact adilcp8590@gmail.com.  
''',
            style: TextStyle(
                fontSize: 16, height: 2.0, color: customTextTheme(context)),
          ),
        ),
      ),
    );
  }
}
