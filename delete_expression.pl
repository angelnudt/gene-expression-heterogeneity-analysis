#!/user/bin/perl

use strict;
my @p_name;  
my @p_id;    
my @p_expression;              
        
my $hsaid;
my $pid;
my $i;
my $j;
my $sumexpression;


open(INprotein, "<averageexpressiondata.txt") or die "averageexpressiondata.txt open error!\n";

open(OUT, ">averageexpressiondata1.txt") or die "averageexpressiondata1.txt open error!\n";

$i=0;
while($hsaid=<INprotein>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $p_name[$i]=$a[2];
	  $p_id[$i]=$a[1];
	  $p_expression[$i]=$hsaid;
	  $sumexpression=0;
	  for($j=3;$j<@a;$j++)
	  {
	  	  $sumexpression=$sumexpression+$a[$j];
	  }
	  if($sumexpression>0)
	  {
	  	  print OUT "$p_expression[$i]\n";
	  }
    $i++;	
	  
}

close(INprotein);
close(OUT);