# Foodgo Home Screen (Flutter + BLoC)

## 1. Dependencies

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  http: ^1.2.2
```

Then run:
```
flutter pub get
```

## 2. Folder structure

```
lib/
  models/food_item.dart
  repositories/food_repository.dart
  blocs/home/home_event.dart
  blocs/home/home_state.dart
  blocs/home/home_bloc.dart
  widgets/custom_search_bar.dart
  widgets/category_tabs.dart
  widgets/food_grid_card.dart
  widgets/custom_bottom_nav.dart
  screens/home_screen.dart
```

## 3. Wiring it to your login flow

After your login API call succeeds, you have `access`, `refresh`, and `email`.
Navigate to `HomeScreen` and pass the access token in:

```dart
final response = await loginRepository.login(email, password);
// response.access = the JWT access token

Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => HomeScreen(
      accessToken: response.access,
      userAvatarUrl: 'https://your-cdn.com/avatar.jpg', // optional
    ),
  ),
);
```

If you're using your own `AuthBloc`/`AuthCubit` to store the token, just read
it from there instead and pass it the same way.

## 4. About the food list endpoint

You only shared the login endpoint, so `FoodRepository` currently calls a
placeholder `GET https://api.gulika.app/api/foods/` with:

```
Authorization: Bearer <access_token>
```

If that call fails (e.g. 404 because the endpoint doesn't exist yet), it
automatically falls back to mock data so the UI matches your screenshot
exactly. Once your backend team gives you the real endpoint and response
shape, update:

- `FoodRepository.fetchFoods()` — the URL/query params
- `FoodItem.fromJson()` — the field names, if they differ

Everything else (BLoC, widgets, screen) will keep working unchanged.

## 5. Favorites

Tapping the heart icon dispatches `ToggleFavorite`, updates the UI
optimistically, then calls `POST /foods/{id}/favorite/` in the background.
Adjust that endpoint too once confirmed.
