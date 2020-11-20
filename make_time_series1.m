a=0.2; c=5.7;
R=0.001:0.001:1.6;
DATA_DIR='/home/browne/COMP/DATA2/';
for subj=randperm(length(R))
    FN_OUT=sprintf('%sS%d.mat',DATA_DIR,subj);
    if exist(FN_OUT,'file')==0
        write_a_in([3,4,12,13,21,24,27],[-1 -1 1 a R(subj) -c 1]);
        [u1,u2]=unix(sprintf('/home/claudia/TOOLS/integrate_ODE_nofile 0.05 %d x %f %f %f', ...
            50000+round(rand(1,1)*100),rand(1,3).*10));
        d=str2num(u2);
        d=d(end-5000+1:end)';
        x1=d;
        x2=add_noise(d,20); x2=x2';
        x3=add_noise(d,10); x3=x3';
        x4=add_noise(d,0); x4=x4';
        eval(sprintf('save %s x1 x2 x3 x4',FN_OUT));
    end
end