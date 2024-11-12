import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turtle/LoginPage.dart';
import'package:turtle/AuthService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turtle Skatepark App"),
        backgroundColor: Colors.tealAccent[700],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),   
            onPressed: () {
                Provider.of<AuthService>(context, listen: false).logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage())
                  ); // Log out by navigating to LoginPage         onPressed: () {
            },
            
          ),
          // IconButton(
          //  icon: Icon(Icons.qr_code),
          //  onPressed: () {
              // Action for QR code
          //  },
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text("Login", style: TextStyle(color: Colors.white)),
          ),
        ],


      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.tealAccent[700],
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Statistics'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Tutorials'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TutorialsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Safety'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SafetyPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Shop Info'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SkateShopPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.brush),
              title: Text('Art Submissions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArtSubmissionsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to Turtle Skatepark App!",
          style: TextStyle(fontSize: 24, color: Colors.tealAccent[700]),
        ),
      ),
    );
  }
}

// Define all other pages here like StatisticsPage, TutorialsPage, etc., with their respective AppBars and styling

class StatisticsPage extends StatelessWidget {
  // Dummy user-specific data for a more personalized experience
  final String userName = "James Rider";
  final double averageSpeed = 12.5; // km/h
  final int totalTricks = 120;
  final int sessionsThisMonth = 15;
  final double highestSpeed = 24.3; // km/h
  final Duration totalTimeSpent = Duration(hours: 10, minutes: 45); // Total riding time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Rider Statistics"),
        backgroundColor: Colors.teal[600],
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.user),
            onPressed: () {
              // User profile button action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // User Greeting
            Text(
              "Welcome back, $userName!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent[400],
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Here's your latest ride report",
              style: TextStyle(
                fontSize: 16,
                color: Colors.tealAccent[100],
              ),
            ),
            SizedBox(height: 20),

            // Total Time Spent
            _buildStatisticCard(
              title: "Total Time Riding",
              value: "${totalTimeSpent.inHours} hrs ${totalTimeSpent.inMinutes % 60} mins",
              icon: FontAwesomeIcons.clock,
              color: Colors.purpleAccent,
            ),

            // Average Speed
            _buildStatisticCard(
              title: "Average Speed",
              value: "${averageSpeed.toStringAsFixed(1)} km/h",
              icon: FontAwesomeIcons.tachometerAlt,
              color: Colors.blueAccent,
            ),

            // Highest Speed
            _buildStatisticCard(
              title: "Top Speed",
              value: "${highestSpeed.toStringAsFixed(1)} km/h",
              icon: FontAwesomeIcons.bolt,
              color: Colors.redAccent,
            ),

            // Total Tricks Performed
            _buildStatisticCard(
              title: "Total Tricks Performed",
              value: "$totalTricks tricks",
              icon: FontAwesomeIcons.magic,
              color: Colors.greenAccent,
            ),

            // Sessions This Month
            _buildStatisticCard(
              title: "Sessions This Month",
              value: "$sessionsThisMonth",
              icon: FontAwesomeIcons.calendarAlt,
              color: Colors.amberAccent,
            ),

            SizedBox(height: 20),

            // Tricks Breakdown
            _buildDetailedTricksSection(),

            // Detailed Speed Analysis
            _buildSpeedAnalysisSection(),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual statistic cards
  Widget _buildStatisticCard({required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[850],
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
        subtitle: Text(value, style: TextStyle(color: Colors.tealAccent[100], fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Section for detailed tricks breakdown
  Widget _buildDetailedTricksSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[850],
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tricks Breakdown",
              style: TextStyle(color: Colors.tealAccent[400], fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildTrickStatRow("Ollies", 45),
            _buildTrickStatRow("Kickflips", 30),
            _buildTrickStatRow("Grinds", 25),
            _buildTrickStatRow("360 Spins", 20),
          ],
        ),
      ),
    );
  }

  // Helper method to build rows for each trick type
  Widget _buildTrickStatRow(String trickName, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(trickName, style: TextStyle(color: Colors.white, fontSize: 16)),
          Text("$count times", style: TextStyle(color: Colors.tealAccent[100], fontSize: 16)),
        ],
      ),
    );
  }

  // Section for speed analysis
  Widget _buildSpeedAnalysisSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[850],
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Speed Analysis",
              style: TextStyle(color: Colors.tealAccent[400], fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSpeedStat("Fastest Lap", "45 sec"),
                _buildSpeedStat("Avg Speed Per Lap", "${(averageSpeed - 1).toStringAsFixed(1)} km/h"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSpeedStat("Top Speed Zone", "Ramp Zone"),
                _buildSpeedStat("Most Time Spent", "Skate Bowl"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for individual speed stats
  Widget _buildSpeedStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(color: Colors.tealAccent[100], fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

//Tutorial Page
class TutorialsPage extends StatefulWidget {
  @override
  _TutorialsPageState createState() => _TutorialsPageState();
}

class _TutorialsPageState extends State<TutorialsPage> {
  late YoutubePlayerController _controller;

  final List<TutorialSection> tutorialSections = [
    TutorialSection(
      title: "Beginner Tutorials",
      tutorials: [
        Tutorial(
          title: "How to Ollie",
          description: "Learn the basics of the Ollie, the foundation of skateboarding.",
          videoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=QUttPNF9KzM")!,
          level: "Beginner",
        ),
        Tutorial(
          title: "Beginner Kickflip",
          description: "Master the kickflip with this easy guide.",
          videoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=kpVhjV-I6nM")!,
          level: "Beginner",
        ),
        Tutorial(
          title: "How to Shuvit",
          description: "An introduction to the Shuvit, a popular trick.",
          videoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=p3NXd3DhH08")!,
          level: "Beginner",
        ),
      ],
    ),
    TutorialSection(
      title: "Intermediate Tutorials",
      tutorials: [
        Tutorial(
          title: "Mastering the Kickflip",
          description: "A guide to take your kickflips to the next level.",
          videoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=DptyvAVi5Fo")!,
          level: "Intermediate",
        ),
        Tutorial(
          title: "How to Heelflip",
          description: "A step up with the heelflip trick.",
          videoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=bvXAHL_oaY8")!,
          level: "Intermediate",
        ),
      ],
    ),
    TutorialSection(
      title: "Advanced Tutorials",
      tutorials: [
        Tutorial(
          title: "Advanced Rail Grinding",
          description: "Take on rail grinding with advanced techniques.",
          videoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=bCZZTiAs2Co")!,
          level: "Advanced",
        ),
        Tutorial(
          title: "360 Flip Tutorial",
          description: "Learn how to land a 360 flip.",
          videoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=Sn68wmFnOHg")!,
          level: "Advanced",
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: tutorialSections[0].tutorials[0].videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playVideo(String videoId) {
    setState(() {
      _controller.load(videoId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Tutorials"),
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tutorialSections.length,
          itemBuilder: (context, index) {
            final section = tutorialSections[index];
            return _buildSection(section);
          },
        ),
      ),
    );
  }

  Widget _buildSection(TutorialSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            section.title,
            style: TextStyle(
              color: Colors.tealAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: section.tutorials.map((tutorial) {
            return _buildTutorialCard(tutorial);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTutorialCard(Tutorial tutorial) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[850],
      elevation: 6,
      child: ListTile(
        onTap: () => _openVideo(tutorial.videoId, tutorial.title),
        leading: Icon(
          Icons.play_circle_fill,
          color: Colors.tealAccent,
          size: 40,
        ),
        title: Text(
          tutorial.title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tutorial.description,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              "Level: ${tutorial.level}",
              style: TextStyle(color: Colors.tealAccent[100], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  void _openVideo(String videoId, String title) {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
      // Open video in external browser on Windows
      final url = "https://www.youtube.com/watch?v=$videoId";
      launchUrl(Uri.parse(url));
    } else {
      // Show embedded player on supported platforms
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey[850],
        builder: (context) => YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return Column(
              children: [
                Container(
                  color: Colors.grey[900],
                  child: player,
                ),
                SizedBox(height: 16),
                Text(
                  "Now playing: $title",
                  style: TextStyle(
                    color: Colors.tealAccent[400],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Tap the video to control playback.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 16),
              ],
            );
          },
        ),
      );
    }
  }
}

class TutorialSection {
  final String title;
  final List<Tutorial> tutorials;

  TutorialSection({required this.title, required this.tutorials});
}

class Tutorial {
  final String title;
  final String description;
  final String videoId;
  final String level;

  Tutorial({
    required this.title,
    required this.description,
    required this.videoId,
    required this.level,
  });
}

// Safety Page
class SafetyPage extends StatelessWidget {
  final List<SafetyTip> safetyTips = [
    SafetyTip(
      title: "Wear Protective Gear",
      description: "Always wear a helmet, knee pads, elbow pads, and wrist guards to protect yourself from falls and injuries.",
      icon: Icons.safety_check,
    ),
    SafetyTip(
      title: "Inspect Your Gear",
      description: "Check your skateboard, trucks, and wheels for any issues before riding. Regular maintenance is crucial.",
      icon: Icons.build,
    ),
    SafetyTip(
      title: "Warm Up and Stretch",
      description: "Warming up and stretching help prevent muscle injuries. Start with basic exercises before you skate.",
      icon: Icons.fitness_center,
    ),
    SafetyTip(
      title: "Stay Aware of Your Surroundings",
      description: "Always stay aware of other skaters, pedestrians, and obstacles in your path to avoid collisions.",
      icon: Icons.visibility,
    ),
    SafetyTip(
      title: "Know Your Limits",
      description: "Avoid attempting tricks that are too advanced for your skill level. Progress at your own pace.",
      icon: Icons.speed,
    ),
  ];

  final List<EmergencyContact> emergencyContacts = [
    EmergencyContact(name: "Local Emergency Services", number: "911"),
    EmergencyContact(name: "Park Safety Officer", number: "555-678-1234"),
    EmergencyContact(name: "Nearest Hospital", number: "555-890-5678"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Safety"),
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("Safety Tips"),
            _buildSafetyTipsGrid(),
            SizedBox(height: 24),
            _buildSectionTitle("Emergency Contacts"),
            _buildEmergencyContactsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.tealAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSafetyTipsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.9,
      ),
      itemCount: safetyTips.length,
      itemBuilder: (context, index) {
        final tip = safetyTips[index];
        return _buildSafetyTipCard(tip);
      },
    );
  }

  Widget _buildSafetyTipCard(SafetyTip tip) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[850],
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tip.icon,
              size: 40,
              color: Colors.tealAccent,
            ),
            SizedBox(height: 12),
            Text(
              tip.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              tip.description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactsList() {
    return Column(
      children: emergencyContacts.map((contact) => _buildEmergencyContactCard(contact)).toList(),
    );
  }

  Widget _buildEmergencyContactCard(EmergencyContact contact) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[850],
      elevation: 6,
      child: ListTile(
        leading: Icon(
          Icons.phone,
          color: Colors.tealAccent,
          size: 30,
        ),
        title: Text(
          contact.name,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          contact.number,
          style: TextStyle(color: Colors.tealAccent[100], fontSize: 14),
        ),
        onTap: () {
          // Log to the console instead of using the Snackbar
          print("Attempting to call ${contact.name}...");
        },
      ),
    );
  }
}

class SafetyTip {
  final String title;
  final String description;
  final IconData icon;

  SafetyTip({required this.title, required this.description, required this.icon});
}

class EmergencyContact {
  final String name;
  final String number;

  EmergencyContact({required this.name, required this.number});
}


// Shop Info Page
class SkateShopPage extends StatelessWidget {
  final List<ShopItem> shopItems = [
    ShopItem(
      imageUrl: 'assets/images/board1.jpg', // Replace with the correct path
      name: "Turtle Deck - Pro Series",
      description: "High-quality deck for advanced skaters. Made from premium maple wood.",
      price: 59.99,
    ),
    ShopItem(
      imageUrl: 'assets/images/shoes1.jpg', // Replace with the correct path
      name: "Turtle Skate Shoes",
      description: "Durable and comfortable shoes designed for skateboarding.",
      price: 74.99,
    ),
    ShopItem(
      imageUrl: 'assets/images/tshirt1.jpg', // Replace with the correct path
      name: "Turtle Logo T-Shirt",
      description: "Classic tee with the Turtle logo. 100% cotton and super comfortable.",
      price: 29.99,
    ),
    ShopItem(
      imageUrl: 'assets/images/hat1.jpg', // Replace with the correct path
      name: "Turtle Cap",
      description: "Stylish cap with adjustable fit, perfect for sunny days at the park.",
      price: 19.99,
    ),
    ShopItem(
      imageUrl: 'assets/images/grip1.jpg', // Replace with the correct path
      name: "Turtle Grip Tape",
      description: "Extra grip tape with Turtle's custom design. Provides excellent control.",
      price: 12.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Skate Shop"),
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.7,
          ),
          itemCount: shopItems.length,
          itemBuilder: (context, index) {
            final item = shopItems[index];
            return _buildShopItemCard(context, item);
          },
        ),
      ),
    );
  }

  Widget _buildShopItemCard(BuildContext context, ShopItem item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[850],
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              item.imageUrl,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.name,
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item.description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${item.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item.name} added to cart!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShopItem {
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  ShopItem({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  });
}

// Art Submissions Page
class ArtSubmissionsPage extends StatefulWidget {
  @override
  _ArtSubmissionsPageState createState() => _ArtSubmissionsPageState();
}

class _ArtSubmissionsPageState extends State<ArtSubmissionsPage> {
  PlatformFile? _selectedFile;

  final List<ArtSubmission> previousArtworks = [
    ArtSubmission(
      imageUrl: 'assets/images/artwork1.jpg',
      message: "Winner of January 2024 - Capturing the spirit of skate culture!",
      artist: "Alex Thompson",
    ),
    ArtSubmission(
      imageUrl: 'assets/images/artwork2.jpg',
      message: "February 2024 - Bold colors and dynamic movement.",
      artist: "Jordan Lee",
    ),
    ArtSubmission(
      imageUrl: '/assets/skate1.jpg',
      message: "March 2024 - A beautiful, raw representation of skate life.",
      artist: "Samantha Cruz",
    ),
  ];

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File selected: ${_selectedFile!.name}")),
      );
    }
  }

  void _submitArt() {
    if (_selectedFile != null) {
      // Show a success message and clear the selected file
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Art submission successful!")),
      );
      setState(() {
        _selectedFile = null; // Clear the selected file after submission
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image to submit.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Art Submissions"),
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Previous Winners",
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildPreviousArtworks(),
            Divider(color: Colors.tealAccent),
            SizedBox(height: 20),
            Text(
              "Submit Your Art",
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildArtSubmissionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousArtworks() {
    return Column(
      children: previousArtworks.map((art) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.grey[850],
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(art.imageUrl, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      art.message,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Artist: ${art.artist}",
                      style: TextStyle(color: Colors.tealAccent[100], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildArtSubmissionSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.tealAccent, width: 2),
            ),
            height: 200,
            width: double.infinity,
            child: _selectedFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(File(_selectedFile!.path!), fit: BoxFit.cover),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, color: Colors.tealAccent, size: 40),
                        SizedBox(height: 8),
                        Text(
                          "Tap to upload your art",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitArt,
          style: ElevatedButton.styleFrom(
            primary: Colors.tealAccent,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          ),
          child: Text(
            "Submit Artwork",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        if (_selectedFile != null) ...[
          SizedBox(height: 10),
          Text(
            "Selected image: ${_selectedFile!.name}",
            style: TextStyle(color: Colors.tealAccent[100], fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class ArtSubmission {
  final String imageUrl;
  final String message;
  final String artist;

  ArtSubmission({
    required this.imageUrl,
    required this.message,
    required this.artist,
  });
}
// Settings Page
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from shared preferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  // Save settings to shared preferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
    prefs.setBool('notificationsEnabled', notificationsEnabled);
  }

  // Toggle notification setting
  void _toggleNotification(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
    _saveSettings();
  }

  // Toggle dark mode setting
  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: Colors.teal,
      hintColor: Colors.tealAccent,
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: isDarkMode ? Colors.black : Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildAccountSection(),
              _buildAppearanceSection(),
              _buildNotificationSection(),
              _buildPrivacySection(),
            ],
          ),
        ),
      ),
    );
  }

  // Account settings section
  Widget _buildAccountSection() {
    return _buildSection(
      title: 'Account Settings',
      children: [
        _buildListTile('Edit Profile', Icons.person, _onEditProfile),
        _buildListTile('Change Password', Icons.lock, _onChangePassword),
      ],
    );
  }

  // Appearance settings section
  Widget _buildAppearanceSection() {
    return _buildSection(
      title: 'Appearance',
      children: [
        _buildSwitchTile('Dark Mode', Icons.dark_mode, isDarkMode, _toggleDarkMode),
      ],
    );
  }

  // Notification settings section
  Widget _buildNotificationSection() {
    return _buildSection(
      title: 'Notifications & Reminders',
      children: [
        _buildSwitchTile('Enable Notifications', Icons.notifications, notificationsEnabled, _toggleNotification),
      ],
    );
  }

  // Privacy settings section
  Widget _buildPrivacySection() {
    return _buildSection(
      title: 'Privacy & Security',
      children: [
        _buildListTile('Privacy Policy', Icons.privacy_tip, _onPrivacyPolicy),
        _buildListTile('Security Settings', Icons.security, _onSecuritySettings),
      ],
    );
  }

  // Helper method to create a section with a title and children
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  // Helper method to create a list tile with an icon and an onTap handler
  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.tealAccent),
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.tealAccent)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Helper method to create a switch list tile
  Widget _buildSwitchTile(String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.tealAccent)),
      secondary: Icon(icon, color: Colors.tealAccent),
      value: value,
      onChanged: onChanged,
    );
  }

  // Placeholder method for Edit Profile
  void _onEditProfile() {
    print('Navigate to Edit Profile');
  }

  // Placeholder method for Change Password
  void _onChangePassword() {
    print('Navigate to Change Password');
  }

  // Placeholder method for Privacy Policy
  void _onPrivacyPolicy() {
    print('Navigate to Privacy Policy');
  }

  // Placeholder method for Security Settings
  void _onSecuritySettings() {
    print('Navigate to Security Settings');
  }
}

// About Us Page
 class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Our Mission'),
            _buildSectionContent(
              "At Turtle, we're dedicated to creating a positive impact by promoting renewable energy, providing a safe space for all skaters, and celebrating the vibrant skateboarding culture. We believe in empowering the skater community of Christchurch, New Zealand, especially those in the Red Zone, to have fun while being eco-conscious. Through sustainable initiatives and local engagement, we aim to bring joy and renewable energy to all.",
            ),
            SizedBox(height: 24),
            _buildSectionTitle('What We Stand For'),
            _buildSectionContent(
              "We stand for inclusivity, sustainability, and community. Our goal is to provide a platform where skaters of all levels can come together and enjoy the sport they love. We're committed to fostering an environment of respect, where everyone feels welcomed and supported, regardless of their background. Through our efforts, we aim to make a tangible difference in both the skateboarding scene and the community of Christchurch.",
            ),
            SizedBox(height: 24),
            _buildSectionTitle('Giving Back to the Community'),
            _buildSectionContent(
              "In collaboration with local organizations, we're giving back to the people in the Red Zone of Christchurch. Through our efforts, we're providing opportunities for fun, physical activity, and renewable energy initiatives. We want to create a place where skaters can thrive while also contributing positively to the community's growth and well-being.",
            ),
            SizedBox(height: 24),
            _buildSectionTitle('Join Us on Our Journey'),
            _buildSectionContent(
              "Whether you're a skater, an environmental enthusiast, or someone who believes in community, Turtle is here for you. We're constantly looking for like-minded individuals to join our mission. Together, we can create a space where skateboarding and renewable energy come together to make a lasting impact.",
            ),
            SizedBox(height: 24),
            _buildContactButton(context),
          ],
        ),
      ),
    );
  }

  // Title for sections
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.tealAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Content for each section
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          height: 1.6,
        ),
      ),
    );
  }

  // Contact Button
  Widget _buildContactButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Add action to open contact page or similar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contact Us functionality coming soon!')),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}