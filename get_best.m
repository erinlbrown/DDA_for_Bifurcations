order = 2; nr_delays = 2; N_MOD = 3;
P = monomial_list(nr_delays,order);
MOD = make_MOD_new(N_MOD,nr_delays,order);
SYM_all = make__SYM(MOD,P);
mm_range = 1:size(MOD,1);
TAU_ALL_FN='TAU_50.mat';
load(TAU_ALL_FN);
A_best=[];
W=[];
T=[];
CH=4;
for mm=mm_range
    [MODEL,SYM,modell,L_AF]=make_MODEL(MOD,SYM_all,mm);
    FN=sprintf('/home/browne/COMP/OUT_CV/N%d_MOD_%s.mat',CH,modell);
    load(FN);
    A_max=max(AprimeMean);
    A_best=[A_best; A_max];
    I_best=find(AprimeMean==max(AprimeMean));
    W=[W;Wmean(I_best,:)];
    TAU=eval(sprintf('TAU_all_%d',SYM));
    T=[T;TAU(I_best,:)];
end
eval(sprintf('save out_best%d.mat W A_best T',CH));