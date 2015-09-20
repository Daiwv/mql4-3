//+------------------------------------------------------------------+
//|                                                    Z-include.mq4 |
//|                      Copyright � 2007, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.ru/ |
//+------------------------------------------------------------------+
#property copyright "Copyright � 2007, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.ru/"

#define StatParameters 7

//  See http://www.itl.nist.gov/div898/handbook/eda/section3/eda35b.htm
//  http://en.wikipedia.org/wiki/Kurtosis
//  http://en.wikipedia.org/wiki/Skewness

//+------------------------------------------------------------------+
//| ���������� ���� ���� ��� �����                                   |
//+------------------------------------------------------------------+
double Znak(double Val)
   {
   double res;
//----
   if (Val<0) res=-1;
   if (Val>=0) res=1;
//----
   return(res);   
   }

//+------------------------------------------------------------------+
//| ���������� ���������� �� �������                                 |
//+------------------------------------------------------------------+
double GetStatFromSeria(double Array[])
   {
   double res;
   double Results[];
   int W,L,i,size=ArraySize(Array);
   double StandardError;
   ArrayResize(Results,StatParameters);
   if (size==0) 
      {
      Print("� ������� GetStatFromPriceSeria ��� ������� ������ Array[] ������� �����");
      }
   double Z,x,r,w,l,n;
   double Max,Min,MO,Std,Sn;
   double Kurtosis;  // �������
   double Skewness;  // ����
   int Seria[];
//----

   ArrayResize(Array,size);
   ArrayResize(Seria,size);

   n=size;
   Max=Array[ArrayMaximum(Array)];
   Min=Array[ArrayMinimum(Array)];
   MO=iMAOnArray(Array,0,size,0,MODE_SMA,0);
   Std=iStdDevOnArray(Array,0,size,0,MODE_SMA,0);
   // Skewness
   for (i=0;i<size;i++)
      {
      Sn=Sn+MathPow(Array[i]-MO,2.0);
      if (i==0) Seria[i]=1;
      if (Znak(Array[i])*Znak(Array[i-1])<0) 
         {
         Seria[i]=Seria[i-1]+1;
         }
      else 
         {
         Seria[i]=Seria[i-1];
         }
      if (Array[i]>=0) W++;
      if (Array[i]<0) L++;
      }
   if (n==1) Print("����� ������� �� ���� � ��������� Sn=MathSqrt(Sn/(n-1));  � ������� GetStatFromPriceSeria");   
   else if (n>1) Sn=MathSqrt(Sn/(n-1));

   r=Seria[size-1];// ���������� �����
   w=W;
   l=L;
   if (l>0 && w>0)
      {   
      x=2.0*w*l;

      if (x==n) Print("����� ������� �� ���� � ��������� MathSqrt((x*(x-n))/(n-1)  � ������� GetStatFromPriceSeria");   
      Z=(n*(r-0.5)-x)/MathSqrt((x*(x-n))/(n-1));
      }   
   else
      {
      if (l==0) Z=100000; else Z=-100000;
      Print("Z-���� ��������� ������, ��� ��� ��� ����������� �����");
      }
   for (i=0;i<size;i++)
      {
      Skewness=Skewness+MathPow((Array[i]-MO)/Sn,3.0); 
      }

   if (n==2) 
      {
      Print("����� ������� �� ���� � ��������� Skewness=n/((n-1)*(n-2))*Skewness;  � ������� GetStatFromPriceSeria");   
      
      }
   else if (n>2) Skewness=n/((n-1)*(n-2))*Skewness;
   // Skewness
   
   //measure of kurtosis

   for (i=0;i<size;i++)
      {
      Kurtosis=Kurtosis+MathPow((Array[i]-MO)/Sn,4.0);
      }
   if (n==3)    Print("����� ������� �� ���� � ��������� n*(n+1)/((n-1)*(n-2)*(n-3))*Kurtosis-3*(n-1)*(n-1)/((n-3)*(n-3));  � ������� GetStatFromPriceSeria");   
   else if (n>3) Kurtosis=n*(n+1)/((n-1)*(n-2)*(n-3))*Kurtosis-3*(n-1)*(n-1)/((n-2)*(n-3));
   //measure of kurtosis
   
   
   Results[0]=Min;
   Results[1]=Max;
   Results[2]=MO;
   Results[3]=Sn;       // Standard deviation
   Results[4]=Skewness; // http://en.wikipedia.org/wiki/Skewness
   Results[5]=Kurtosis; // http://en.wikipedia.org/wiki/Kurtosis
   Results[6]=Z;        // Z score
//----
   res=Z;
   return(res);   
   }

//+------------------------------------------------------------------+
//|  ���������� Z-���� ����������� ������ ��� ����� ������           |
//+------------------------------------------------------------------+
double getZ()
   {
   double res;
//----
   if ((IsTesting()&&!IsOptimization())||!IsTesting())
      {
      if (OrdersHistoryTotal()>0)
         {
         int counter=0;
         int i,total=OrdersHistoryTotal();
         double Returns[];
         //---
         for (i=0;i<=total;i++)
            if (OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
               {
               if (OrderType()==OP_BUY || OrderType()==OP_SELL) 
                  {
                  ArrayResize(Returns,counter+1);
                  Returns[counter]=OrderProfit();
                  counter++;
                  }
               }
         } 
         Print(" counter = ",counter,", total = ",total);
         res=GetStatFromSeria(Returns);
         if (MathAbs(res)==100000) Print("Z ���� �� ���������!!!");   
      }
//----
   return(res);   
   }
//+------------------------------------------------------------------+

