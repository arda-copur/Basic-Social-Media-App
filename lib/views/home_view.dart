import 'package:flutter/material.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/service/auth_service.dart';
import 'package:user_app/views/add_status_view.dart';
import 'package:user_app/views/welcome.view.dart';
import 'package:user_app/widgets/status_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
final AuthService _authService = AuthService();
 String hosgeldinMesaji = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(hosgeldinMesaji),
        backgroundColor: ProjectColors.primaryColor,
          leading: FutureBuilder<String?>(
            future: _authService.getUserProfileImage(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              else if (snapshot.hasError) {
                  return const CircleAvatar(backgroundColor: Colors.grey);
              }
              else if (snapshot.data != null) {
                return GestureDetector(
                  onTap: () {
                    
                  },
                  child: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!),),
                );
                
              }
              else {
                return const Icon(Icons.account_circle_sharp);
              }
            },
          ),
          actions: [
            IconButton(onPressed: ()  {
                     _authService.signOut();
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const WelcomeView()), (route) => false);
            }, icon: const Icon(Icons.exit_to_app))
          ],
      ),
      body: const StatusList(),
      floatingActionButton: IconButton(style: IconButton.styleFrom(backgroundColor: ProjectColors.primaryColor),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddStatusView()));
        },
        icon:  Icon(
          Icons.plus_one_outlined,
          color: ProjectColors.white,
        ),
      ),
    );
  }
   



}
