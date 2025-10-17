import 'package:adding_/widgets/adding_display.dart';
import 'package:adding_/widgets/specificButtons.dart';
import 'package:flutter/material.dart';
import "package:math_expressions/math_expressions.dart";

class Display extends StatefulWidget{
  const Display({super.key});


  @override
  State<Display> createState()=> _Setup();
}

class _Setup extends State<Display>{
  String expression="0";
  String _result="";
  String _history="";
  double _resultSize=37;
  double _historySize=0.0;
  String operators="";
  ScrollController _scrollController=ScrollController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(

        child: Column(
          children: [
            displayValue(
              userInput:expression,
              result: _result,
              history:_history,
              resultSize: _resultSize,
              historySize: _historySize,
              scrollController: _scrollController,
            ),
            
            Expanded(flex: 2,
              child: Container(
            
                width: double.infinity,
                
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white12.withValues(alpha: 0.4))),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0.5,
                      blurRadius: 1.5
                    )
                  ]
                ),
                child: _displayButtons(context),
              ),
            )
           
          ],
        ),
      )
    );
  }
  // create specific button
  Widget _CustomButton(BuildContext context,{text,isOperator=false,}){

    return CustomButton(
      text: text,
      isOperator: isOperator,
      onPressed: () => setState(() {
        DisplayText(context, text);
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve:Curves.easeInOutCirc
        );
       
        
      }),
    );
  }

  //get text value and set display screen
  /*
   this section: it is  implemented  Math operators 
   Clear operators,
   Delete operators,
   and  we took easy way with  this [math_expressions] package,
   so If user write math value like this 2x2 to input , 
   it will convetr Math evaluate from Math value.
   So we took that short way form long way
    */
  void DisplayText(BuildContext context,String getText){
    try{
        // Clear proccess
        if(getText=="C"){
            _history="";
            _result="";
            expression="0";
            _resultSize=37;
            operators="";
        }
        // Delete process
        else if(getText=="⌫"){
            if(expression.isNotEmpty) expression=expression.substring(0,expression.length-1);
            if(expression.length<1){
                expression="0";
            };
        }
        
        else if(getText=="="){
            if(expression.isNotEmpty&&expression!="0"){
                var user_exp=expression
                    .replaceAll("×", "*")
                    .replaceAll("÷", "/");

                ExpressionParser p=ShuntingYardParser();
                Expression exp=p.parse(user_exp);
                ContextModel cm=ContextModel();
                var finalResult=RealEvaluator(cm).evaluate(exp);
                var formatResult=(finalResult*100).roundToDouble()/100;
                _result=formatResult.toString();
                _history="$expression =$_result";
                
            }
            _resultSize=43;
            _historySize=25;
        
        }
        else if(expression.endsWith(".0")){
            expression=expression.substring(0,expression.length-1);
            
        }
        else{
            if(expression=="0"){
                expression=getText;
            }else getOperators(getText);
            
        }
    
    }
    catch(e){
        if(expression=="0") expression=getText;
        
        
    }
  }
  
  // avoid repeating operator symbols
  getOperators(String value){
    if(value=="%"||value=="÷"||value=="×"||value=="-"||value=="+"){
      if(expression.isEmpty&& value!="-") return;
      if(expression.isNotEmpty){
        String lastchr=expression[expression.length-1];
        if("+-×÷%".contains(lastchr)){
            expression=expression.substring(0,expression.length-1);
        }
      }
      
    }
    expression+=value;
  }
  Widget _displayButtons(BuildContext context,){
    return Column(
        
      children: [
        Expanded(
          
          child: Row(
            children: [
              Expanded(child:_CustomButton(context,text:"C", isOperator: true,)),
              Expanded(child:_CustomButton(context,text:"⌫",isOperator: true,)),
              Expanded(child:_CustomButton(context,text:"%",isOperator: true,)),
              Expanded(child:_CustomButton(context,text:"÷",isOperator: true,)),
            ],
          ),
        ),
        Expanded(
          
          child: Row(
            children: [
              Expanded(child:_CustomButton(context,text:"7",)),
              Expanded(child:_CustomButton(context,text:"8",)),
              Expanded(child:_CustomButton(context,text:"9",)),
              Expanded(child:_CustomButton(context,text:"×",isOperator: true,)),
            ],
          ),
        ),
        Expanded(
          
          child: Row(
            children: [
              Expanded(child: _CustomButton(context,text:"4",)),
              Expanded(child:_CustomButton(context,text:"5",)),
              Expanded(child:_CustomButton(context,text:"6",)),
              Expanded(child:_CustomButton(context,text:"-",isOperator: true,)),
            ],
          ),
        ),
        Expanded(
          
          child: Row(
            children: [
              Expanded(child:_CustomButton(context,text:"1",)),
              Expanded(child:_CustomButton(context,text:"2",)),
              Expanded(child:_CustomButton(context,text:"3",)),
              Expanded(child:_CustomButton(context,text:"+",isOperator: true,)),
            ],
          ),
        ),
        Expanded(
          
          child: Row(
            children: [
              Expanded(flex: 1,child:_CustomButton(context,text:".",)),
              Expanded(flex: 2, child:_CustomButton(context,text:"0",)),
              //Expanded(child:CustomButton(text:"^",isOperator: true,)),

              
              Expanded(flex: 1, child:_CustomButton(context,text:"=",isOperator: true,)),
            ],
          ),
        ),
        
        
      ],
    );
  
  }
  
}