enum GifImageItems {coffeGirl,loginView,onerioHome,splashBackground}

extension GifImagesExtension on GifImageItems {
  String _gifPath() {
    switch (this) {
      
      case GifImageItems.coffeGirl:
      return "coffegirl";
  
      case GifImageItems.loginView:
      return "login_view_image";
       
      case GifImageItems.onerioHome:
      return "onerio_home";

      case GifImageItems.splashBackground:
      return "splash_background";
     
    }
  }
  String get gifPath => "assets/${_gifPath()}.gif";
}