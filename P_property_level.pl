#!/user/bin/perl

use strict;
           
my @protein;
my @tissuenum;       
my @level;   
my @degree;   
my @rate;  

my @pid;  
my @pexpression;
  
my @average_expression;   
my @average_degree;  
my @average_tissuenum;  
my @average_rate;  
my $standard_expression;   
my $standard_degree;  
my $standard_tissuenum;  
my $hsaid;
my @num_tissuenum;
my @num_expression;
my @num_degree;
my @num_rate;

my $i;
my $j;
my $k;
my $k1;
my $k2;
my $k3;
my $mark1;
my $mark2;
my $tissuenumber;
open(INexpression, "<averageexpressiondata.txt") or die "averageexpressiondata.txt open error!\n";
open(INproper, "<proper_gene.txt") or die "proper_gene.txt open error!\n";
open(OUT, ">proper_sample.txt") or die "proper_sample.txt open error!\n";

$i=0;
while($hsaid=<INexpression>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $pid[$i]=$a[2];
	  $pexpression[$i]=$hsaid;
	  $tissuenumber=@a-3;
    $i++;	
}

$i=0;
while($hsaid=<INproper>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $protein[$i]=$a[0];
	  $tissuenum[$i]=$a[2];
	  $level[$i]=$a[3];
	  $degree[$i]=$a[4];
	  $rate[$i]=$a[5];
    $i++;	
}


######################计算基因的表达脑区数目##############################

#$tissuenumber=946;
for($i=0;$i<$tissuenumber;$i++)       
{
	  $average_tissuenum[$i]=0;
	  $average_expression[$i]=0;
	  $average_degree[$i]=0;	  
	  $average_rate[$i]=0;	
	  $num_tissuenum[$i]=0;	  
	  $num_expression[$i]=0;	
	  $num_degree[$i]=0;
	  $num_rate[$i]=0;	  
}
$k1=0;

my $proteinnum;
$proteinnum=0;
my $maxlevel;
$maxlevel=0;
my $maxdegree;
$maxdegree=0;
my $maxrate;
$maxrate=0;
for($i=0;$i<@pid;$i++)       
{  
	  my @a;
	  @a=split(/\t/,$pexpression[$i]);
	  for($k=3;$k<@a;$k++) 
	  {
	  	  if($a[$k]>0)
	  	  {
	  	  	  if($tissuenum[$i]>0)
	  	      {
	  	      	  $average_tissuenum[$k-3]=$average_tissuenum[$k-3]+$tissuenum[$i];
	  	          $num_tissuenum[$k-3]++;
	  	      }
	  	      if($level[$i]>0)
	  	      {
	  	          $average_expression[$k-3]=$average_expression[$k-3]+$level[$i];
	  	          $num_expression[$k-3]++;
	  	      }
	  	      if($degree[$i]>0)
	  	      {
	  	          $average_degree[$k-3]=$average_degree[$k-3]+$degree[$i];
	  	          $num_degree[$k-3]++;
	  	      }
	  	      if($rate[$i]>0)
	  	      {
	  	          $average_rate[$k-3]=$average_rate[$k-3]+$rate[$i];
	  	          $num_rate[$k-3]++;
	  	      }
		    }		    
	  }
		$proteinnum=$proteinnum+1;
}

my $temp_tissuenum;
my $temp_expression;
my $temp_degree;
my $temp_rate;

for($i=0;$i<$tissuenumber;$i++)       
{
	  if($num_tissuenum[$i]>0)
	  {
	  	  $average_tissuenum[$i]=$average_tissuenum[$i]/$num_tissuenum[$i];
	  }
	  if($num_expression[$i]>0)
	  {
	  	  $average_expression[$i]=$average_expression[$i]/$num_expression[$i];
	  }
	  if($num_degree[$i]>0)
	  {
	  	  $average_degree[$i]=$average_degree[$i]/$num_degree[$i];
	  }
	  if($num_rate[$i]>0)
	  {
	  	  $average_rate[$i]=$average_rate[$i]/$num_rate[$i];
	  }
}

for($i=0;$i<$tissuenumber;$i++)       
{
	  if($average_expression[$i]>$maxlevel)
	  {
	  	  $maxlevel=$average_expression[$i];
	  }
	  if($average_degree[$i]>$maxdegree)
	  {
	  	  $maxdegree=$average_degree[$i];
	  }
	  if($average_rate[$i]>$maxrate)
	  {
	  	  $maxrate=$average_rate[$i];
	  }
}
#print OUT "$maxlevel\t$maxdegree\t$maxrate\n\n\n";
for($i=0;$i<$tissuenumber;$i++)       
{
	  $temp_tissuenum=$average_tissuenum[$i]*100/$tissuenumber;
	  if($maxlevel>0)
	  {
	      $temp_expression=$average_expression[$i]*100/$maxlevel;
	  }
	  if($maxdegree>0)
	  {
	      $temp_degree=$average_degree[$i]*100/$maxdegree;
	  }
	  if($maxrate>0)
	  {
	      $temp_rate=$average_rate[$i]*100/$maxrate;
	  }
	  print OUT "$average_tissuenum[$i]\t$temp_tissuenum\t$average_expression[$i]\t$temp_expression\t$average_degree[$i]\t$temp_degree\t$average_rate[$i]\t$temp_rate\n";
}

close(INexpression);
close(INproper);
close(OUT);