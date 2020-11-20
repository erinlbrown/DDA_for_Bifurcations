load out_best4.mat W
W=W(2,:);
CHAN=1:4;
N_SUBJ=1600;
N_MOD=3;
nr_delays=2;
order=2;
P=monomial_list(nr_delays,order);
MOD=make_MOD_new(N_MOD,nr_delays,order);
SYM_all=make__SYM(MOD,P);
mm=2;
TAU=[42 47];
MODEL=find(MOD(mm,:));
SYM=SYM_all(mm);
L_AF=length(MODEL)+1;
nr_trials=1;
for CH=CHAN
    D_all=[]; A1=[]; A2=[]; A3=[]; A4=[];
    for subj=1:N_SUBJ
        FN=sprintf('/home/browne/COMP/OUT_DDE2/N%d_S%d.mat',CH,subj);
        load(FN);
        A1=[A1; A(1)];
        A2=[A2; A(2)];
        A3=[A3; A(3)];
        A4=[A4; A(4)];
        A=reshape(A,L_AF,nr_trials);
        A=[ones(nr_trials,1) A'];
        d=A*W';
        D_all=[D_all; d];
    end
    eval(sprintf('save N%d_out.mat A1 A2 A3 A4 D_all',CH));
    clear D_all A1 A2 A3 A4
end