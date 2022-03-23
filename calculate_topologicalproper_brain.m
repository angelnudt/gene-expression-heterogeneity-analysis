clc
clear all
Files=dir(strcat('d:\\liuwei\\develop_vector\\','*.txt'));
LengthFiles=length(Files);
for k=1:LengthFiles
    k
      vec1=importdata(strcat('d:\liuwei\develop_vector\',Files(k).name));
    ii=[vec1(:,1)
        vec1(:,2)];
    jj=[vec1(:,2)
       vec1(:,1)];
    kk=[vec1(:,3)
       vec1(:,3)];
    vector=sparse(ii,jj,kk);
    betweenness(k,1)=mean(betweenness_centrality(vector));
    cc(k,1)=mean(clustering_coefficients(vector));
    num=0;
    D=all_shortest_paths(vector);
    [m,n]=size(D);
    for i=1:m
        for j=1:n
            if D(i,j)>100000 || D(i,j)<-100000
                D(i,j)=0;
%                 num=num+1;
            end
        end
    end     
    for i=1:m
        for j=1:n
            if D(i,j)>0
                num=num+1;
            end
        end
    end    
    diamer(k,1)=max(max(abs(D)));
    averagepath(k,1)=sum(sum(abs(D)))/num;
    
%     exponent(k,1)=compute_exponent(vector);
    A=full(vector);
    [m,n]=size(A);
    [d,v]=eig(A);                                         %����ؾ��������������������������ֵ
    d1=d(:,m);                                                  %����ؾ����������������%%�ڵ�����Ӷ�(�����������Ķ�)
    sum_d1=sum(d1);
    I=d1/sum_d1;                                                %������ڵ����Ҫ��
     for i=1:m
         Sp(i)=log(I(i))'*I(i);
         if  isnan(Sp(i))
             Sp(i)=0;
         end
     end
    Spp(k,1)=abs(sum(Sp));            %������������ 
    save allproper.mat Spp betweenness diamer averagepath cc exponent
    clear ii jj kk vector A d v I Sp m n d1
end

  
