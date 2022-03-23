#!/user/bin/perl

########此程序用来将基因芯片表达数据中同一基因的表达数据做平均#############

use strict;

my @a;
my @b;
my @c;
my $arraydata;
my @probe;
my @geneid;
my @genename;
my @originalexpression;

my @finalprobe;
my @finalgeneid;
my @finalgenename;
my @averageexpression;

my $probenum;
my $geneidnum;
my $i;
my $j;
my $k;
my $l;
my $mark;
my $probeindex;

open(INmicroarry, "<expressiondata.txt") or die "expressiondata.txt open error!\n";


open(OUT, ">averageexpressiondata.txt") or die "averageexpressiondata.txt open error!\n";

$i=0;
while($arraydata=<INmicroarry>)        #读入芯片表达数据
{
    $arraydata=~s/\n//g;
    $arraydata=~s/\"//g;
    @a=split(/\t/,$arraydata);
    $probe[$i]=$a[0];
    $geneid[$i]=$a[1];
    $genename[$i]=$a[2];
    $originalexpression[$i]=$arraydata;
    $i++;	
}
$probeindex=0;
$k=1;
my @sumexpression;
my @numexpression;
for($i=0;$i<@probe;$i++)
{    
    if($i==0)
    {
         $k++;
    }
    if($i>0 && $geneid[$i] eq $geneid[$i-1]  && $i ne @probe-1)
    {
         $k++;
    }
    if($i>0 && $geneid[$i] ne $geneid[$i-1])
    {        
         $finalprobe[$probeindex]=$probe[$i-1];
         $finalgeneid[$probeindex]=$geneid[$i-1];
         $finalgenename[$probeindex]=$genename[$i-1];
         $averageexpression[$probeindex]=""; 
         
         $j=$i-1;         
         @a=split(/\t/,$originalexpression[$j]);
         for($l=3;$l<@a;$l++)
         {
             $sumexpression[$l-3]=0;
             $numexpression[$l-3]=0;             
         }
         for($j=$i-1;$j>=$i-$k;$j--)
         {
             @a=split(/\t/,$originalexpression[$j]);
             for($l=3;$l<@a;$l++)
             {
                 if($a[$l]>0)
                 { 
                     $sumexpression[$l-3]=$sumexpression[$l-3]+$a[$l];
                     $numexpression[$l-3]++;
                 }
             }
         }
         for($l=0;$l<@sumexpression;$l++)
         {
             if($numexpression[$l]>0)
             { 
                 $sumexpression[$l]=$sumexpression[$l]/$numexpression[$l];
             }
             my @temp;
             @temp=($averageexpression[$probeindex],$sumexpression[$l]);
             $averageexpression[$probeindex]=join(',',@temp);
         }
         $averageexpression[$probeindex]=~s/\,/\t/g;
         $k=1;
         $probeindex++; 
    }   
    
    if($i eq @probe-1 && $geneid[$i] ne $geneid[$i-1])
    {        
         $finalprobe[$probeindex]=$probe[$i];
         $finalgeneid[$probeindex]=$geneid[$i];
         $finalgenename[$probeindex]=$genename[$i];
         $averageexpression[$probeindex]=""; 
             
         @a=split(/\t/,$originalexpression[$i]);
         for($l=3;$l<@a;$l++)
         {
             $sumexpression[$l-3]=0;
             $numexpression[$l-3]=0;             
         }
         for($j=$i;$j>=$i;$j--)
         {
             @a=split(/\t/,$originalexpression[$j]);
             for($l=3;$l<@a;$l++)
             {
                 if($a[$l]>0)
                 { 
                     $sumexpression[$l-3]=$sumexpression[$l-3]+$a[$l];
                     $numexpression[$l-3]++;
                 }
             }
         }
         for($l=0;$l<@sumexpression;$l++)
         {
             if($numexpression[$l]>0)
             { 
                 $sumexpression[$l]=$sumexpression[$l]/$numexpression[$l];
             }
             my @temp;
             @temp=($averageexpression[$probeindex],$sumexpression[$l]);
             $averageexpression[$probeindex]=join(',',@temp);
         }
         $averageexpression[$probeindex]=~s/\,/\t/g;
         $k=1;
         $probeindex++; 
    }   
    
    if($i eq @probe-1 && $geneid[$i] eq $geneid[$i-1])
    {        
         $finalprobe[$probeindex]=$probe[$i];
         $finalgeneid[$probeindex]=$geneid[$i];
         $finalgenename[$probeindex]=$genename[$i];
         $averageexpression[$probeindex]=""; 
                
         @a=split(/\t/,$originalexpression[$i]);
         for($l=3;$l<@a;$l++)
         {
             $sumexpression[$l-3]=0;
             $numexpression[$l-3]=0;             
         }
         for($j=$i;$j>=$i-$k;$j--)
         {
             @a=split(/\t/,$originalexpression[$j]);
             for($l=3;$l<@a;$l++)
             {
                 if($a[$l]>0)
                 { 
                     $sumexpression[$l-3]=$sumexpression[$l-3]+$a[$l];
                     $numexpression[$l-3]++;
                 }
             }
         }
         for($l=0;$l<@sumexpression;$l++)
         {
             if($numexpression[$l]>0)
             { 
                 $sumexpression[$l]=$sumexpression[$l]/$numexpression[$l];
             }
             my @temp;
             @temp=($averageexpression[$probeindex],$sumexpression[$l]);
             $averageexpression[$probeindex]=join(',',@temp);
         }
         $averageexpression[$probeindex]=~s/\,/\t/g;
         $k=1;
         $probeindex++; 
    }
}     
for($i=0;$i<$probeindex;$i++)
{
    print OUT "$finalprobe[$i]\t$finalgeneid[$i]\t$finalgenename[$i]$averageexpression[$i]\n";
}
   
close(INmicroarry);

close(OUT);