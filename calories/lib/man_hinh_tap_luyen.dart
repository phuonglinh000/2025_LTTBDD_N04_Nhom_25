import 'package:flutter/material.dart';

class ManHinhTapLuyen extends StatelessWidget {
  const ManHinhTapLuyen({super.key});

  Widget _itemBaiTap({
    required String title,
    required String subtitle,
    required String assetPath,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              22,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.70),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(
            20,
            0,
            20,
            22,
          ),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.end,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF7EE07E),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        24,
      ),
      children: [
        const SizedBox(height: 4),
        const Text(
          "Danh sách bài tập",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E8B57),
          ),
        ),
        const SizedBox(height: 14),

        _itemBaiTap(
          title: "Dành cho người mới",
          subtitle: "14 ngày",
          assetPath: "imgs/14.png",
        ),
        const SizedBox(height: 16),

        _itemBaiTap(
          title: "Giảm cân toàn thân",
          subtitle: "28 ngày",
          assetPath: "imgs/28.jpg",
        ),
        const SizedBox(height: 16),

        _itemBaiTap(
          title: "Đốt cháy mỡ bụng",
          subtitle: "18 ngày",
          assetPath: "imgs/18.jpg",
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _buildPageContent()),
    );
  }
}
