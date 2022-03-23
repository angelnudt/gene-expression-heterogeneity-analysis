#!/user/bin/perl

use strict;
my @p_name;   
my @p_id;    
my @pexpression;     
my @tissuenum_expression;               

my @hklist;
my @hkid;
my @hknum_tissue;
my @hkpercent;
my @tslist;
my @tsid;
my @tsnum_tissue;
my @tspercent;
my @hkmark;
my @num_tissue;

my $hsaid;
my $pid;
my $i;
my $j;
my $k;
my $k1;
my $k2;
my $mark1;
my $mark2;
my $temp;
my $tissuenumber;
my $genenumber;

open(INprotein, "<averageexpressiondata.txt") or die "averageexpressiondata.txt open error!\n";
#open(IN, "<tissuenum.txt") or die "tissuenum.txt open error!\n";
open(OUT, ">hk.txt") or die "hk.txt open error!\n";

$i=0;
while($hsaid=<INprotein>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $p_name[$i]=$a[2];
	  $p_id[$i]=$a[1];
	  $pexpression[$i]=$hsaid;
	  $tissuenumber=@a-3;
    $i++;	
}
$genenumber=$i;

#$i=0;
#while($hsaid=<IN>)        
#{
#	  $hsaid=~s/\n//g;
#	  $num[$i]=$hsaid;
#    $i++;	
#}

my $temp_expression;
my @a;
my @b;
#$tissuenumber=946;

for($i=0;$i<@p_name;$i++)       
{
	  $tissuenum_expression[$i]=0;
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
$k1=0;
$k2=0;
for($i=0;$i<@p_name;$i++) 
{
	  $hkmark[$i]=0;
	  if($tissuenum_expression[$i]>$tissuenumber-2)
	  {
	  	 $hklist[$k1]=$p_name[$i];
	  	 $hkid[$k1]=$p_id[$i];
	  	 $k1++;
	  	 $hkmark[$i]=1;
	  }
	  if($tissuenum_expression[$i]<3 && $tissuenum_expression[$i]>0)
	  {
	  	 $tslist[$k2]=$p_name[$i];
	  	 $tsid[$k2]=$p_id[$i];
	  	 $k2++;
	  	 $hkmark[$i]=-1;
	  }
}

print OUT "\nhklist\n";
for($i=0;$i<@hklist;$i++) 
{
	  print OUT "$hklist[$i]\t$hkid[$i]\n";
}

print OUT "\n\ntslist\n";
for($i=0;$i<@tslist;$i++) 
{
	  print OUT "$tslist[$i]\t$tsid[$i]\n";
}

for($i=0;$i<$tissuenumber;$i++)       
{
	  $hknum_tissue[$i]=0;
	  $tsnum_tissue[$i]=0;
	  $num_tissue[$i]=0;
}
for($i=0;$i<@p_name;$i++)       
{	  
	  @a=split(/\t/,$pexpression[$i]);
	  for($k=3;$k<@a;$k++) 
	  {
	  	  if($a[$k]>0)
	  	  {
	  	      if($hkmark[$i]>0)
	  	      {
	  	          $hknum_tissue[$k-3]=$hknum_tissue[$k-3]+1;
		        }
		        if($hkmark[$i]<0)
		        {
		        	  $tsnum_tissue[$k-3]=$tsnum_tissue[$k-3]+1;
		        }
		        $num_tissue[$k-3]=$num_tissue[$k-3]+1;
		    }     
	  }
}

print OUT "\n\nhknum_tissue and tsnum_tissue\n";
for($i=0;$i<$tissuenumber;$i++)       
{
	  $hkpercent[$i]=$hknum_tissue[$i]*100/$num_tissue[$i];
	  $tspercent[$i]=$tsnum_tissue[$i]*100/$num_tissue[$i];
	  $temp=$num_tissue[$i]*100.0/$genenumber;
	  print OUT "$num_tissue[$i]\t$temp\t$hknum_tissue[$i]\t$hkpercent[$i]\t$tsnum_tissue[$i]\t$tspercent[$i]\n";
}
close(INprotein);
close(IN);
close(OUT);