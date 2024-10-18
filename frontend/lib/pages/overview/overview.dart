import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import '../../constants/style.dart';
import '../../theme_provider.dart';// Import style for colors
import 'dashboard.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Overview'),
            backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
            iconTheme: IconThemeData(
              color: themeProvider.isDarkMode ? light(context) : dark(context), // Change arrow color based on theme
            ),
            titleTextStyle: TextStyle(
              color: themeProvider.isDarkMode ? light(context) : dark(context), // Change title text color based on theme
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: const Column(
                children: [
                  DashboardWidget(),
                  //GreetingSection(),
                  // ActionStepsSection(),
                  // RegisterSection(),
                  // FeedbackSection(),
                  // StatisticsSection(),
                  // AchievementsSection(),
                  // OtherLinksSection(),
                  // WhyThisMattersSection(),
                ],
              ),
            ),
          ),
          backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context), // Adjust background color based on theme
        );
      },
    );
  }
}

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Hello, Hero',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ActionStepsSection extends StatelessWidget {
  const ActionStepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.check_circle_outline),
        title: Text('Try these steps next!'),
        subtitle: Text('1. Mark Actions you already do\n2. Refine emissions inputs\n3. Add an Action to your goals'),
      ),
    );
  }
}

class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.person_add),
        title: Text('Register'),
        subtitle: Text('Sign up and personalize it to see your full Earth Hero features.'),
      ),
    );
  }
}

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.feedback),
        title: Text('Would you help us improve Earth Hero?'),
        subtitle: Text('We would like feedback on the Actions interface. If interested, please complete this 10-minute survey.'),
      ),
    );
  }
}

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.bar_chart),
        title: Text('Total Earth Heroes: 128,830'),
        subtitle: Text('Actions achieved: 745,159\nEmissions saved: 142,914t'),
      ),
    );
  }
}

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.star),
        title: Text('My Achievements'),
        subtitle: Text('Set a Target to reduce emission and we will help you get there.'),
      ),
    );
  }
}

class OtherLinksSection extends StatelessWidget {
  const OtherLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.link),
        title: Text('Other Links'),
        subtitle: Text('Newsletter, Contact Us, Sources and Recognition'),
      ),
    );
  }
}

class WhyThisMattersSection extends StatelessWidget {
  const WhyThisMattersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Why This Matters: The Story of Climate Change. A Comic of Worldly Proportions. We can make a difference together.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
