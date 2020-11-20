a=0.2; c=5.7;
R=0.001:0.001:1.6;
DATA_DIR='/home/browne/COMP/DATA3/';
for subj=randperm(length(R))
    FN_OUT=sprintf('%sS%04d.mat',DATA_DIR,subj);
    if exist(FN_OUT,'file')==0
        x1=[]; x2=[]; x3=[]; x4=[];
        for i=1:50
            write_a_in([3,4,12,13,21,24,27],[-1 -1 1 a R(subj) -c 1]);
            [u1,u2]=unix(sprintf('/home/claudia/TOOLS/integrate_ODE_nofile 0.05 %d x %f %f %f', ...
            50000+round(rand(1,1)*100),rand(1,3).*10));
            d=str2num(u2);
            d=d(end-5000+1:end)';
            tx1=d;
            tx2=add_noise(d,20); tx2=tx2';
            tx3=add_noise(d,10); tx3=tx3';
            tx4=add_noise(d,0); tx4=tx4';
            x1=[x1;tx1];
            x2=[x2;tx2];
            x3=[x3;tx3];
            x4=[x4;tx4];
        end
        eval(sprintf('save %s x1 x2 x3 x4',FN_OUT));
        clear x1 x2 x3 x4
    end
end