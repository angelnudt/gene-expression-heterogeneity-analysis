#!/user/bin/perl

use strict;
my @p_name;  
my @p_id;    
my @p_expression;              
my @m_expression;        
my @ppia;
my @ppib;       

my @ppia_valid;
my @ppib_valid;    
my @tissue_p;
my @tissue_m;
          
my $hsaid;
my $pid;
my $i;
my $j;
my $k;
my $k1;
my $k2;
my $mark1;
my $mark2;
my $tissuenumber;

open(INprotein, "<averageexpressiondata1.txt") or die "averageexpressiondata1.txt open error!\n";
open(INppi, "<ppi_norundant.txt") or die "ppi_norundant.txt open error!\n";

open(OUT, ">tissuenetwork.txt") or die "tissuenetwork.txt open error!\n";

$i=0;
while($hsaid=<INppi>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $ppia[$i]=$a[0];
	  $ppib[$i]=$a[1];
    $i++;	
}


$i=0;
while($hsaid=<INprotein>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $p_name[$i]=$a[2];
	  $p_id[$i]=$a[1];
	  $p_expression[$i]=$hsaid;
	  $tissuenumber=@a-3;
    $i++;	
}

$k=0;
for($i=0;$i<@ppia;$i++)        
{
	  $mark1=0;
	  $mark2=0;
	  for($j=0;$j<@p_name;$j++)
	  {
	  	 if($p_name[$j] eq $ppia[$i])
	  	 {
	  	 	    $mark1=1;	  	 	
	  	 }
	  	 if($p_name[$j] eq $ppib[$i])
	  	 {
	  	 	    $mark2=1;	  	 	
	  	 }
	  }
	  if($mark1==1&&$mark2==1)
	  {
	      $ppia_valid[$k]=$ppia[$i];
	      $ppib_valid[$k]=$ppib[$i];
	      #print OUT "$ppia_valid[$k]\t$ppib_valid[$k]\n";
	      $k++;
	  }
}
my $temp_expression;
my @a;
my @b;
#$tissuenumber=946;
for($i=0;$i<@ppia_valid;$i++)        
{
	  $k1=-1;
	  $k2=-1;
	  print OUT "$ppia_valid[$i]\t$ppib_valid[$i]\t";
	  for($j=0;$j<@p_name;$j++)
	  {
	  	 if($p_name[$j] eq $ppia_valid[$i])
	  	 {
	  	 	    $k1=$j;	  	 	
	  	 }
	  	 if($p_name[$j] eq $ppib_valid[$i])
	  	 {
	  	 	    $k2=$j;		  	 	
	  	 }
	  }
    if($k1>-1 && $k2>-1)
    {	      
	      @a=split(/\t/,$p_expression[$k1]);
	      @b=split(/\t/,$p_expression[$k2]);
	  }
	  for($j=0;$j<$tissuenumber;$j++) 
	  {
	  	  $tissue_p[$j]=0;
        if(($a[$j+3] > 0) && ($b[$j+3] > 0))
	      {
	      	  $tissue_p[$j]=1;	      	  
	      }
	      print OUT "$tissue_p[$j]\t";
	  }
	  print OUT "\n";
}

close(INprotein);
close(INppi);
close(OUT);