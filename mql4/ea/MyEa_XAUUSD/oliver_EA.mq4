//+------------------------------------------------------------------+
//|                                                    oliver_EA.mq4 |
//|                                                        oliverlee |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "oliverlee"
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict

#include <MyModels.mqh>

// 可调参数
extern int mainTF = PERIOD_H1;
extern int largeTF = PERIOD_D1;

extern int mainMAFast = 12;
extern int mainMASLow = 50;

extern int slowMAFast = 200;
extern int slowMASlow = 377;


extern int condition1 = 0x05;
extern double lot1 = 1;
//extern int condition2  = 0;
//extern double lot2 = 0.01;
//extern int condition3  = 0;
//extern double lot3 = 0.01;
//extern int conditionOut = 0;

extern int lsDeviation200 = 300;// 200均线与377均线的多空差距



extern int stoplose = 1500; // 止损点数  -------------->OK
extern int takeprofile = 2500;// 止盈点数 -------------->OK

extern double  MaximumRisk        = 0.02;/* 单次最大亏损百分比*/
extern double  DecreaseFactor     = 3;/* 降低仓位因子*/
extern int MovingShift = 0;

extern int crossEffectPeriod =30;  // -----------------> OK

//extern int magic = 61616;

// ============================
GlobalInfo *G;
DecisionMaker *decisionMaker;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
      G = new GlobalInfo();
      
      G.mainTF = mainTF;
      G.largeTF = largeTF;
      
      G.mainMAFast =mainMAFast;
      G.mainMASLow = mainMASLow;
      
      G.slowMAFast = slowMAFast;
      G.slowMASlow = slowMASlow;
      
      G.condition1 = condition1;
      //G.condition2 = condition2;
      //G.condition3 = condition3;
      
      G.lot1 = lot1;
      //G.lot2 = lot2;
      //G.lot3 = lot3;

      G.lsDeviation200 = lsDeviation200;
     
      G.stoplose = stoplose;
      G.takeprofile = takeprofile;
      
      G.MaximumRisk = MaximumRisk;
      G.DecreaseFactor = DecreaseFactor;
      G.MovingShift = MovingShift;
      
      G.crossEffectPeriod = crossEffectPeriod;
      
      decisionMaker = new DecisionMaker();
      decisionMaker.g = G;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void start()
  {
//---
       G.prepare();
       decisionMaker.makeDecision();
  }
//+------------------------------------------------------------------+
