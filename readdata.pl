#!/user/bin/perl

######################�˳��������������оƬ�������########################

use strict;

my @a;
my @b;
my @c;
my $arraydata;
my @probe;
my @geneidlist;
my @genenamelist;
my @originalexpression;
my @probeid;
my @pacall;
my @geneid;
my @genename;
my @interexpression;


my $probenum;
my $geneidnum;
my $i;
my $j;
my $k;
my $mark;

open(INmicroarry, "<MicroarrayExpression.txt") or die "MicroarrayExpression.txt open error!\n";
open(INPACall, "<PACall.txt") or die "PACall.txt open error!\n";
open(INProbes, "<Probes.txt") or die "Probes.txt open error!\n";

open(OUT, ">expressiondata.txt") or die "expressiondata.txt open error!\n";

$i=0;
while($arraydata=<INmicroarry>)        #����ԭʼ��оƬ�������
{
    $arraydata=~s/\n//g;
    @a=split(/\,/,$arraydata);
    $probe[$i]=$a[0];
    $originalexpression[$i]=$arraydata;
    $i++;	
}

$i=0;
while($arraydata=<INProbes>)        #����̽������
{
    $arraydata=~s/\n//g;
    @a=split(/\,/,$arraydata);
    $probeid[$i]=$a[0];
    $geneid[$i]=$a[2];
    $genename[$i]=$a[3];
    $i++;	
}

$i=0;
while($arraydata=<INPACall>)        #����PACall����
{
    $arraydata=~s/\n//g;
    @a=split(/\,/,$arraydata);
   # $probe[$i]=$a[0];
    $pacall[$i]=$arraydata;
    $i++;	
}

for($i=0;$i<@probe;$i++)
{
    $interexpression[$i]="";
    @a=split(/\,/,$originalexpression[$i]);
    @b=split(/\,/,$pacall[$i]);
    for($j=1;$j<@a;$j++)
    {
        if($b[$j] eq "0")
        {
             $a[$j]=0; 
        }
        my @temp;
        @temp=($interexpression[$i],$a[$j]);
        $interexpression[$i]=join(',',@temp);
    }
    $interexpression[$i]=~s/\,/\t/g;
}
for($i=0;$i<@probe;$i++)
{
    $mark=0;
    $geneidlist[$i]="";
    for($j=0;$j<@probeid&&$mark==0;$j++)
    {
         if($probe[$i] eq $probeid[$j])
         {
              $k=$j;
              $mark=1;              
         }
    }
    if($mark==1)
    {
         $geneidlist[$i]=$geneid[$k];
         $genenamelist[$i]=$genename[$k];
    }
    print OUT "$probe[$i]\t$geneidlist[$i]\t$genenamelist[$i]$interexpression[$i]\n";
}     
close(INmicroarry);
close(INPACall);
close(INProbes);
close(OUT);
