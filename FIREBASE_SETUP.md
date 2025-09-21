# Firebase Configuration Setup

This project uses Firebase for hosting and other services. To set up the Firebase configuration:

## Setup Instructions

1. **Install Firebase CLI** (if not already installed):
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Generate Firebase Options**:
   ```bash
   firebase init
   ```
   
   Or regenerate the configuration:
   ```bash
   flutterfire configure
   ```

4. **Copy Template**:
   ```bash
   cp lib/firebase_options.dart.template lib/firebase_options.dart
   ```

5. **Update Configuration**:
   Edit `lib/firebase_options.dart` with your actual Firebase project credentials.

## Important Notes

- ⚠️ **Never commit `lib/firebase_options.dart`** - it contains sensitive API keys
- ✅ The file is already added to `.gitignore`
- 📝 Use `lib/firebase_options.dart.template` as a reference
- 🔄 Run `flutterfire configure` to regenerate if needed

## Project Configuration

- **Project ID**: flutter-portfolio-74db1
- **Hosting URL**: https://flutter-portfolio-74db1.web.app
- **Custom Domain**: https://leonardolazzari.it

## Deployment

```bash
# Build and deploy
flutter build web --release --no-tree-shake-icons
firebase deploy --only hosting
```