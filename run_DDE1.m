DATA_DIR = '/home/browne/COMP/DATA2/';

N_MOD=3;
nr_delays=2;
dm=4;
order=2;
CHAN = [ 1 2 3 4 ];

TAU_ALL_FN='TAU_50.mat';
P=monomial_list(nr_delays,order);
MOD=make_MOD_new(N_MOD,nr_delays,order);
SYM_all=make__SYM(MOD,P);

mm=2;
TAU=[42 47];
MODEL=find(MOD(mm,:));
SYM=SYM_all(mm);
L_AF=length(MODEL)+1;

N_SUBJ=1600;

for CH = randperm(max(CHAN))
    VN=sprintf('x%d',CH);
    for subj=randperm(N_SUBJ)
        FN = sprintf('%sS%d.mat',DATA_DIR,subj);
        OUT_DDE=sprintf('/home/browne/COMP/OUT_DDE2/N%d_S%d.mat',CH,subj);
        if exist(OUT_DDE,'file')==0
            unix(['touch ',OUT_DDE]);
            disp(OUT_DDE);
            run_DDE_C(FN,VN,OUT_DDE,dm,nr_delays,order,MODEL,[],[],TAU,50,[],[],[]);
            load(OUT_DDE);
            eval(sprintf('save %s SYM MODEL -append',OUT_DDE))
        end
    end
end