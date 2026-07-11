import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/tokens.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({required this.currentUserId, super.key});
  
  final String currentUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Investor Demo Mock Data
    const peaceScore = 92;
    const userName = 'Krishna';
    
    final hour = DateTime.now().hour;
    var greeting = 'Good Evening';
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(LCSpacing.lg),
                child: Text(
                  '$greeting $userName 👋',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              // Hero Metric: Family Peace Index
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LCSpacing.lg),
                child: Container(
                  padding: const EdgeInsets.all(LCSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2E5BFF), Color(0xFF0038FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(LCSpacing.lg),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E5BFF).withAlpha(77), // 0.3 opacity
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Family Peace Index',
                        style: TextStyle(
                          color: Colors.white.withAlpha(230), // 0.9 opacity
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: LCSpacing.sm),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '$peaceScore%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: LCSpacing.sm, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(51), // 0.2 opacity
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.arrow_upward, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  '+8 this week',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: LCSpacing.xxl),

              // Today's Priorities
              _buildSectionHeader(context, "Today's Priorities"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LCSpacing.lg),
                child: Column(
                  children: [
                    _buildPriorityTile("Dad's BP Medicine", true),
                    _buildPriorityTile('Electricity Bill', true),
                    _buildPriorityTile('EMI Tomorrow', true),
                    _buildPriorityTile('Insurance Renewal', true),
                  ],
                ),
              ),
              const SizedBox(height: LCSpacing.xl),

              // Family Status
              _buildSectionHeader(context, 'Family Status'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: LCSpacing.lg),
                child: Row(
                  children: [
                    _buildFamilyStatusCard('Mother', 'Healthy', Colors.green),
                    const SizedBox(width: LCSpacing.md),
                    _buildFamilyStatusCard('Father', 'Medicine Due', Colors.orange),
                    const SizedBox(width: LCSpacing.md),
                    _buildFamilyStatusCard('Wife', 'All Good', Colors.blue),
                  ],
                ),
              ),
              const SizedBox(height: LCSpacing.xl),

              // Analytics Snapshot
              _buildSectionHeader(context, 'Analytics Snapshot'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LCSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildAnalyticBox("Today's Peace Score", '92%'),
                    ),
                    const SizedBox(width: LCSpacing.md),
                    Expanded(
                      child: _buildAnalyticBox('Confidence', '98%'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LCSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LCSpacing.lg, vertical: LCSpacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
      ),
    );
  }

  Widget _buildPriorityTile(String title, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: LCSpacing.sm),
      padding: const EdgeInsets.symmetric(vertical: LCSpacing.md, horizontal: LCSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(LCSpacing.md),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isDone ? Colors.green : Colors.transparent,
              border: Border.all(color: isDone ? Colors.green : Colors.grey.shade400),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, size: 16, color: isDone ? Colors.white : Colors.transparent),
          ),
          const SizedBox(width: LCSpacing.md),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone ? Colors.grey.shade500 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyStatusCard(String relation, String status, Color statusColor) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(LCSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(LCSpacing.lg),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5), // 0.02 opacity
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: statusColor.withAlpha(26), // 0.1 opacity
            child: Icon(Icons.person, color: statusColor),
          ),
          const SizedBox(height: LCSpacing.md),
          Text(
            relation,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(LCSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(LCSpacing.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: LCSpacing.sm),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
