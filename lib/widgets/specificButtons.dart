import 'package:flutter/material.dart';

// create btn but it will be custome buttons
class CustomButton extends StatelessWidget{
  
  final String  text;
  final bool isOperator;
  
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOperator=false,
    
  });
  
  @override
  Widget build(BuildContext context){
    final theme=Theme.of(context);
    Color ButtonColors;
    Color TextColor;
    
    if(isOperator){
      ButtonColors=theme.copyWith(primaryColor: Colors.white24).primaryColor;
      TextColor=theme.copyWith(primaryColor: Colors.amberAccent).primaryColor;

    }else{
      TextColor=theme.colorScheme.onPrimaryContainer;
      ButtonColors=theme.colorScheme.outlineVariant;
    }
    
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(8),
        
        child:InkWell(
            splashColor: ButtonColors,
            borderRadius: BorderRadius.circular(100),
            onTap: onPressed,
            child: Center(
                child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontFamily: "Ubuntu",
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: TextColor,
                )
                    
            ),
          
        ), 
        ) 
       
      ),
    );
  }
}