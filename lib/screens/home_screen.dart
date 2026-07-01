import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodgo_app_test/bloc/home/home_bloc.dart';
import 'package:foodgo_app_test/bloc/home/home_event.dart';
import 'package:foodgo_app_test/bloc/home/home_state.dart';
import 'package:foodgo_app_test/models/food_item.dart';
import 'package:foodgo_app_test/repositories/food_repository.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/category_tabs.dart';
import '../widgets/food_grid_card.dart';
import '../widgets/custom_bottom_nav.dart';

/// Entry point for the Home screen. Pass the access token you received
/// from the login API so authenticated requests can be made.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeBloc(foodRepository: FoodRepository())..add(const LoadFoods()),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();
  static const categories = ['All', 'Combos', 'Sliders', 'Classics'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              CustomSearchBar(
                onChanged: (q) => context.read<HomeBloc>().add(SearchFoods(q)),
                onFilterTap: () {},
              ),
              const SizedBox(height: 20),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return CategoryTabs(
                    categories: categories,
                    selected: state.selectedCategory,
                    onSelected: (cat) =>
                        context.read<HomeBloc>().add(ChangeCategory(cat)),
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.status == HomeStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == HomeStatus.failure) {
                      return Center(
                        child: Text(
                          state.errorMessage ?? 'Something went wrong',
                        ),
                      );
                    }
                    if (state.filteredFoods.isEmpty) {
                      return const Center(child: Text('No items found'));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: state.filteredFoods.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.72,
                          ),
                      itemBuilder: (context, index) {
                        final food = state.filteredFoods[index];
                        return FoodGridCard(
                          food: food,
                          onFavoriteTap: () => context.read<HomeBloc>(),
                          // .add(ToggleFavorite(food.id)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 0,
        onTap: (_) {},
        onAddTap: () {},
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foodgo',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                fontFamily: 'Lobster',
                color: Color(0xFF3C2F2F),
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Order your favourite food!',
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),
          ],
        ),
        SizedBox(width: 40),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/profile.png',
            width: 65,
            height: 65,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
