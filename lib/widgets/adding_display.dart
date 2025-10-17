
import "package:flutter/material.dart";

//we are creating display to text

/*class calculator_display extends StatefulWidget{
 // State<StatefulWidget> createState()=>_display();
}*/ 

class displayValue extends StatelessWidget{

  String? userInput;
  String? result;
  String? history;
  double? resultSize;
  double? historySize;
  ScrollController? scrollController;
  
  displayValue({super.key,
    this.userInput,
    this.result,
    this.history,
    this.resultSize,
    this.historySize,
    this.scrollController,
  });

  

  

  @override
  Widget build(BuildContext context){
    var getSize=MediaQuery.of(context).size;
   
    return Expanded(
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          padding:(result.toString().isNotEmpty)? EdgeInsets.only(top:80):EdgeInsets.only(top: 190),
          child: _BuildScreen(context),
          
        ),
      
    );
     
  }
  Widget _BuildScreen(BuildContext contex){
    return Column(
        children: [
            if(history.toString().isNotEmpty)
                Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(history.toString(),style: TextStyle(fontSize: historySize,color: Colors.white.withValues(alpha: 0.5)),),
                ),
            Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(userInput.toString(),style: TextStyle(fontSize: 37),),
            ),
            if(result.toString().isNotEmpty)
            Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.symmetric(horizontal: 15),
                
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color:Colors.white30.withValues(alpha: 0.2)))
                ),
                child: Text(result.toString(),style: TextStyle(fontSize:resultSize,color: Colors.amber.shade200),),
            ),
            
            
        ],
    );
  }
  
  
}