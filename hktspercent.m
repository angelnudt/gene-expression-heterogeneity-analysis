function [expresspercent,hkpercent,tspercent]=hktspercent(donordata)
%�ú�������donordata������İٷֱȣ����һ���ٷֱȺ���֯�������ٷֱȡ����ǻ�������������

    [m,n]=size(donordata);
    expressionid=1:m;
    index2=find(donordata(1,:)>-0.5);
    tissuenum=numel(index2);         %%�����ߵ���֯��Ŀ
    for j=1:m
        index3=find(donordata(j,:)>0);
        expressnum(j,1)=numel(index3);    %%�����ߵ���֯�����Ŀ
    end    
    
    index4=find(expressnum>(tissuenum-1));
    hklist=expressionid(index4);
   
    index5=find(expressnum<2&expressnum>0);
    tslist=expressionid(index5);

    index6=find(expressnum>0);
    expressgenelist=expressionid(index6);

    for k=1:n
        index7=find(donordata(:,k)>0);
        sampleid=expressionid(index7);
        c=intersect(hklist,sampleid);       %%����������֮����ͬ��Ԫ��
        hknum(k,1)=numel(c);
        d=intersect(tslist,sampleid);       %%����������֮����ͬ��Ԫ��
        tsnum(k,1)=numel(d);
        e=intersect(expressgenelist,sampleid);       %%����������֮����ͬ��Ԫ��
        expressgenenum(k,1)=numel(e);
        
        expresspercent(k,1)=expressgenenum(k,1)/m*100;
        hkpercent(k,1)=0;
        tspercent(k,1)=0;
        if expressgenenum(k,1)>0
            hkpercent(k,1)=hknum(k,1)/expressgenenum(k,1)*100;
            tspercent(k,1)=tsnum(k,1)/expressgenenum(k,1)*100;
        end
    end
    
%     expresspercent(i,:)=expressgenenum(i,:)/genenumber;
%     hkpercent(i,:)=hknum(i,:)/expressgenenum(i,:);
%     tspercent(i,:)=tsnum(i,:)/expressgenenum(i,:);

