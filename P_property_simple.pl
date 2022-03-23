#!/user/bin/perl

use strict;
           
my @ppia;
my @ppib;       

my @pid;  
my @pid_rate;  
my @pname;  
my @pexpression;
my @tissuenum_expression;   
my @average_expression;   
my @degree;
my @rate;  
my @allrate;  
my $hsaid;

my $i;
my $j;
my $k;
my $k1;
my $k2;
my $mark1;
my $mark2;

open(INexpression, "<averageexpressiondata1.txt") or die "averageexpressiondata1.txt open error!\n";
open(INrate, "<rate.txt") or die "rate.txt open error!\n";
open(INppi, "<ppi_norundant.txt") or die "ppi_norundant.txt.txt open error!\n";
open(OUT, ">proper_gene.txt") or die "proper_gene.txt open error!\n";

$i=0;
while($hsaid=<INexpression>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $pid[$i]=$a[2];
	  $pname[$i]=$a[1];
	  $pexpression[$i]=$hsaid;
    $i++;	
}

$i=0;
while($hsaid=<INrate>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $pid_rate[$i]=$a[0];
	  $allrate[$i]=$a[5];
    $i++;	
}

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

######################计算基因的表达脑区数目##############################

for($i=0;$i<@pid;$i++)       
{
	  $tissuenum_expression[$i]=0;
	  $k=0;
	  my @a;
	  @a=split(/\t/,$pexpression[$i]);
	  for($k=3;$k<@a;$k++) 
	  {
	  	  if($a[$k]>0)
	  	  {
	  	      $tissuenum_expression[$i]=$tissuenum_expression[$i]+1;
		    }
	  }
}

######################计算基因的平均表达水平##############################

for($i=0;$i<@pid;$i++)       
{
	  $average_expression[$i]=0;
	  $k=0;
	  my @a;
	  @a=split(/\t/,$pexpression[$i]);
	  for($k=3;$k<@a;$k++) 
	  {
	  	  if($a[$k]>0)
	  	  {
	  	      $average_expression[$i]=$average_expression[$i]+$a[$k];
		        $k++;
		    }
	  }
	  if($k>0)
	  {
	  	  $average_expression[$i]=$average_expression[$i]/$k;
	  }
	  #print OUT "$pid[$i]\t$average_expression[$i]\n";
}

######################计算基因的进化速率##############################

for($i=0;$i<@pid;$i++)       
{
	  $rate[$i]=0;
	  $mark1=0;
	  for($j=0;$j<@pid_rate&&$mark1==0;$j++)       
    {
    	  if($pid[$i] eq $pid_rate[$j])
    	  {
    	  	  $rate[$i]=$allrate[$j];
    	  	  $mark1=1;
    	  }
    }	  
}

######################计算基因的连接度##############################

#print OUT "compute degree\n\n\n";
my $mark;
my $l;
for($i=0;$i<@pid;$i++)       
{
	  $k=0;
	  for($l=0;$l<@ppia;$l++)
	  {
	  	  if($pid[$i] eq $ppia[$l] || $pid[$i] eq $ppib[$l])
	  	  {
	  	      $k++;
	      }
	  }
	  $degree[$i]=$k;
	  print OUT "$pid[$i]\t$pname[$i]\t$tissuenum_expression[$i]\t$average_expression[$i]\t$degree[$i]\t$rate[$i]\n";
}
close(INexpression);
close(INppi);
close(OUT);