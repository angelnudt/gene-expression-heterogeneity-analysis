#!/user/bin/perl

use strict;
my @p_name;   
my @p_id;    
my @pexpression;     
my @tissuenum_expression;               

my @sample;
my @structure;

my @hklist;
my @hkid;
my @hkid_num;
my @hknum_tissue;
my @hkpercent;
my @tslist;
my @tsid;
my @tsid_num;
my @tsnum_tissue;
my @tspercent;

my @hklist1;
my @hkid1;
my @hkid_num1;
my @hknum_tissue1;
my @hkpercent1;
my @tslist1;
my @tsid1;
my @tsid_num1;
my @tsnum_tissue1;
my @tspercent1;

my @melist;
my @meid;
my @meid_num;
my @menum_tissue;
my @mepercent;

my @hkmark;
my @num_tissue;

my $hsaid;
my $pid;
my $i;
my $j;
my $k;
my $l;
my $k1;
my $k2;
my $k3;
my $k4;
my $k5;
my $mark1;
my $mark2;
my $temp;
my $tissuenumber;

open(INprotein, "<averageexpressiondata.txt") or die "averageexpressiondata.txt open error!\n";
open(INsample, "<structurename_brain6.txt") or die "structurename_brain6.txt open error!\n";
open(INstructure, "<structureunify_brain6.txt") or die "structureunify_brain6.txt open error!\n";
#open(IN, "<tissuenum.txt") or die "tissuenum.txt open error!\n";
open(OUT, ">hkxin.txt") or die "hkxin.txt open error!\n";

$i=0;
while($hsaid=<INprotein>)        
{
	  $hsaid=~s/\n//g;
	  my @a;
	  @a=split(/\t/,$hsaid);
	  $p_name[$i]=$a[2];
	  $p_id[$i]=$a[1];
	  $pexpression[$i]=$hsaid;
    $i++;	
}

$i=0;
while($hsaid=<INsample>)        
{
	  $hsaid=~s/\n//g;
	  $sample[$i]=$hsaid;
    $i++;	
}

$i=0;
while($hsaid=<INstructure>)        
{
	  $hsaid=~s/\n//g;
	  $structure[$i]=$hsaid;
    $i++;	
}

 
my $temp_expression;
my @a;
my @b;
my @samplename;
my $indexsample;
my $samplenum;
$samplenum=@sample;
#$tissuenumber=946;

for($i=0;$i<@p_name;$i++)       
{
	  $tissuenum_expression[$i]=0;
	  $indexsample=0;
	  my @a;
	  @a=split(/\t/,$pexpression[$i]);
	  for($k=3;$k<@a;$k++) 
	  {
	  	  if($a[$k]>0)
	  	  {	  	  	  
	  	      #$tissuenum_expression[$i]=$tissuenum_expression[$i]+1;
	  	      $samplename[$indexsample]=$sample[$k-3];
	  	      $indexsample=$indexsample+1;
		    }
	  }
	  for($l=0;$l<@structure;$l++) 
	  {
	  	  $mark1=0;
	      for($j=0;$j<$indexsample;$j++)
	      {
	      	  if($samplename[$j] eq $structure[$l])
	      	  {
	      	  	  $mark1=1;
	      	  	  
	      	  }
	      }
	      if($mark1>0)
	      {
	      	  $tissuenum_expression[$i]=$tissuenum_expression[$i]+1;
	      }
	  }
	  print OUT "$tissuenum_expression[$i]\n";
}
$k1=0;
$k2=0;
$k3=0;
$k4=0;
$k5=0;

$tissuenumber=@structure;
print OUT "\ntissuenumber is $tissuenumber\n\n";

for($i=0;$i<@p_name;$i++) 
{
	  $hkmark[$i]=0;
	  if($tissuenum_expression[$i]>$tissuenumber-1)
	  {
	  	 $hklist[$k1]=$p_name[$i];
	  	 $hkid[$k1]=$p_id[$i];
	  	 $hkid_num[$k1]=$tissuenum_expression[$i];
	  	 $k1++;
	  	 $hkmark[$i]=1;
	  }
	  if($tissuenum_expression[$i]>$tissuenumber-10 && $tissuenum_expression[$i]<$tissuenumber)
	  {
	  	 $hklist1[$k2]=$p_name[$i];
	  	 $hkid1[$k2]=$p_id[$i];
	  	 $hkid_num1[$k1]=$tissuenum_expression[$i];
	  	 $k2++;
	  	 $hkmark[$i]=2;
	  }
	  if($tissuenum_expression[$i]>10 && $tissuenum_expression[$i]<$tissuenumber-11)
	  {
	  	 $melist[$k3]=$p_name[$i];
	  	 $meid[$k3]=$p_id[$i];
	  	 $meid_num[$k3]=$tissuenum_expression[$i];
	  	 $k3++;
	  	 $hkmark[$i]=3;
	  }
	  if($tissuenum_expression[$i]>1 && $tissuenum_expression[$i]<11)
	  {
	  	 $tslist1[$k4]=$p_name[$i];
	  	 $tsid1[$k4]=$p_id[$i];
	  	 $tsid_num1[$k4]=$tissuenum_expression[$i];
	  	 $k4++;
	  	 $hkmark[$i]=4;
	  }
	  if($tissuenum_expression[$i]<2 && $tissuenum_expression[$i]>0)
	  {
	  	 $tslist[$k5]=$p_name[$i];
	  	 $tsid[$k5]=$p_id[$i];
	  	 $tsid_num[$k5]=$tissuenum_expression[$i];
	  	 $k5++;
	  	 $hkmark[$i]=5;
	  }
}

print OUT "\nhklist\n";
for($i=0;$i<@hklist;$i++) 
{
	  print OUT "$hklist[$i]\t$hkid[$i]\t$hkid_num[$i]\n";
}

print OUT "\n\nhklist1\n";
for($i=0;$i<@hklist1;$i++) 
{
	  print OUT "$hklist1[$i]\t$hkid1[$i]\t$hkid_num1[$i]\n";
}

print OUT "\nmelist\n";
for($i=0;$i<@melist;$i++) 
{
	  print OUT "$melist[$i]\t$meid[$i]\t$meid_num[$i]\n";
}

print OUT "\n\ntslist1\n";
for($i=0;$i<@tslist1;$i++) 
{
	  print OUT "$tslist1[$i]\t$tsid1[$i]1\t$tsid_num1[$i]\n";
}
print OUT "\n\ntslist\n";
for($i=0;$i<@tslist;$i++) 
{
	  print OUT "$tslist[$i]\t$tsid[$i]\t$tsid_num[$i]\n";
}


for($i=0;$i<$samplenum;$i++)       
{
	  $hknum_tissue[$i]=0;
	  $tsnum_tissue[$i]=0;
	  $menum_tissue[$i]=0;
	  $hknum_tissue1[$i]=0;
	  $tsnum_tissue1[$i]=0;
	  $num_tissue[$i]=0;
}
for($i=0;$i<@p_name;$i++)       
{	  
	  @a=split(/\t/,$pexpression[$i]);
	  for($k=3;$k<@a;$k++) 
	  {
	  	  if($a[$k]>0)
	  	  {
	  	      if($hkmark[$i] == 1)
	  	      {
	  	          $hknum_tissue[$k-3]=$hknum_tissue[$k-3]+1;
		        }
		        if($hkmark[$i] == 2)
	  	      {
	  	          $hknum_tissue1[$k-3]=$hknum_tissue1[$k-3]+1;
		        }
		        if($hkmark[$i] == 3)
	  	      {
	  	          $menum_tissue[$k-3]=$menum_tissue[$k-3]+1;
		        }
		        if($hkmark[$i] == 4)
	  	      {
	  	          $tsnum_tissue1[$k-3]=$tsnum_tissue1[$k-3]+1;
		        }
		        if($hkmark[$i] == 5)
		        {
		        	  $tsnum_tissue[$k-3]=$tsnum_tissue[$k-3]+1;
		        }
		        $num_tissue[$k-3]=$num_tissue[$k-3]+1;
		    }     
	  }
}

print OUT "\n\nhknum_tissue and tsnum_tissue\n";
for($i=0;$i<$samplenum;$i++)       
{
	  $hkpercent[$i]=$hknum_tissue[$i]*100/$num_tissue[$i];
	  $tspercent[$i]=$tsnum_tissue[$i]*100/$num_tissue[$i];
	  $hkpercent1[$i]=$hknum_tissue1[$i]*100/$num_tissue[$i];
	  $tspercent1[$i]=$tsnum_tissue1[$i]*100/$num_tissue[$i];
	  $mepercent[$i]=$menum_tissue[$i]*100/$num_tissue[$i];
	  $temp=$num_tissue[$i]*100.0/@p_name;
	  print OUT "$num_tissue[$i]\t$temp\t$hknum_tissue[$i]\t$hkpercent[$i]\t$hknum_tissue1[$i]\t$hkpercent1[$i]\t$menum_tissue[$i]\t$mepercent[$i]\t$tsnum_tissue1[$i]\t$tspercent1[$i]\t$tsnum_tissue[$i]\t$tspercent[$i]\n";
}
close(INprotein);
close(INsample);
close(INstructure);
close(OUT);