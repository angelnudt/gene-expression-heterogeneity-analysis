#!/user/bin/perl

use strict;

my @a;
my $temp;
my $hsaid;
my @ppia;
my @ppib;
my @ppimark;

my @spoint1;
my @spoint2;
my $i;
my $j;
my $jj;
my $k;
my $mark;
my $nodesnum;
my $l;
my $mark1;
my $tissuenumber;

open(IN, "<tissuenetwork.txt") or die "tissuenetwork.txt open error!\n";

$i=0;
while($hsaid=<IN>)
{
    $hsaid=~s/\n//g;	  
	  @a=split(/\t/,$hsaid);
	  $ppia[$i]=$a[0];
	  $ppib[$i]=$a[1];
	  $tissuenumber=@a-2;
	  $ppimark[$i]=$hsaid;
    $i++;	
}

my $ii;
for($ii=0;$ii<$tissuenumber;$ii++)        ##组织特异网络编号
#for($ii=0;$ii<1;$ii++)        ##组织特异网络编号
{
	  open(OUT, ">vec$ii.txt") or die "vec$ii.txt open error!\n";
    my $plistindex;
	  my @Proteinlist;
	  $plistindex=0;
	  for($l=0;$l<@ppia;$l++)               ##生成组织特异的相互作用
	  {
	  	  @a=split(/\t/,$ppimark[$l]);
	  	  $mark=$a[$ii+2];
	  	  if($mark==1)
	  	  {
	  		     $mark1=0;
	  	       for($j=0;$j<$plistindex && $mark1==0;$j++)
	  	       {
	      	      	if($ppia[$l] eq $Proteinlist[$j])
	      		      {
	      	  	      	$mark1=1;
	      	  	      	$spoint1[$l]=$j+1;
	      	  	    }
	 	         }
	  	       if($mark1==0)
	  	       {
	          	  	$Proteinlist[$plistindex]=$ppia[$l];
	          	  	$spoint1[$l]=$plistindex+1;
	      	      	$plistindex++;
	  	       }
	  	       $mark1=0;
	  	       for($j=0;$j<$plistindex && $mark1==0;$j++)
	  	       {
	      	    	  if($ppib[$l] eq $Proteinlist[$j])
	      		      {
	      	     	   	  $mark1=1;
	      	     	   	  $spoint2[$l]=$j+1;
	      		      }
	   	      }
	   	      if($mark1==0)
	  	      {
	      		      $Proteinlist[$plistindex]=$ppib[$l];
	      		      $spoint2[$l]=$plistindex+1;
	      	        $plistindex++;
	          }
	          print OUT "$spoint1[$l]\t$spoint2[$l]\t1\n";
	 	    }	 	    
	  } 
   close(OUT);
}
close(IN);
