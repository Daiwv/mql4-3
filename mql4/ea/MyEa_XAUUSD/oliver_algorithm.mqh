//+------------------------------------------------------------------+
//|                                             oliver_algorithm.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

bool checkDistance(double price1,double price2,double distance)
{
   return MathAbs(price1-price2)<=distance;
}

void 找出重复最多(double &nums[], // 要在该数组中查找
                    double distance,//误差
                    double& result1,
                     double& result2
                  
){
   ArraySort(nums,WHOLE_ARRAY,0,MODE_DESCEND);
   int count=ArraySize(nums);
   int repeat_times[200];
   double price[200];
   ArrayInitialize(repeat_times,0);
   ArrayInitialize(price,0.0);
   
   int c=0;
   int biggest = 0;
   int pos = 0;
   for(int i=0;i<count-1;i++){
        
        if(MathAbs(nums[i]-nums[i+1])<=distance)
        {
            repeat_times[c]+=1;
        }
        else
        {
            if(repeat_times[c]>biggest)
            {
               biggest = repeat_times[c];
               pos = c;
            }
            price[c]= nums[i];
            ++c;
        }
        
   }
   
   if(repeat_times[c]>biggest)
   {
      biggest = repeat_times[c];
      pos = c;
      price[pos] = nums[count-1];
   }

   result1= price[pos];
   result2 = repeat_times[pos];

}
