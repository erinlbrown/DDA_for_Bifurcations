COND = ['C1';'C2'];
CHAN = [ 1 2 3 4 ];

IN_DIR = '/home/browne/COMP/OUT_DDE_CV/';

order = 2; nr_delays = 2; N_MOD = 3;
P = monomial_list(nr_delays,order);
MOD = make_MOD_new(N_MOD,nr_delays,order);
SYM_all = make__SYM(MOD,P);
mm_range = 1:size(MOD,1);
dm = 4;

OUT_CV = sprintf('/home/browne/COMP/OUT_CV/');
TAU_ALL_FN='TAU_50.mat';
N_trial=1; N_subj=41;
TempDir = TempDirectoryConfig('DDA_EB');

for CH = randperm(max(CHAN))
    TR_TS_FILE = sprintf('/home/browne/COMP/TR_TS__C_%d.mat',CH);
    for mm = randperm(max(mm_range))
        [MODEL,SYM,modell,L_AF]=make_MODEL(MOD,SYM_all,mm); %% CL
        TAU_name=sprintf('TAU_all_%d',SYM);
        N_TAU=get_var_size_in_file(TAU_ALL_FN,TAU_name); N_TAU=N_TAU(1);
        % Input file name from consolidated DDE outputs.
        AF_file = sprintf('%sN%d_MOD_%s.mat',IN_DIR,CH,modell);
        % Output file name to contain CV outputs.
        CV_file = sprintf('%sN%d_MOD_%s.mat',OUT_CV,CH,modell);
        % Organized for parallelization.
        if exist(CV_file,'file')==0
            unix(['touch ',CV_file]);
            disp(CV_file);
            AF=nan(N_TAU*2,L_AF*N_trial*N_subj);
            for cond=1:2
                for subj=1:N_subj
                    DDE_OUT=sprintf('/home/browne/COMP/OUT_DDE/N%d_MOD_%d_C%d_S
                    %d.mat',CH,mm,cond,subj);
                    load(DDE_OUT);
                    AF((1:N_TAU)+(cond-1)*N_TAU,(1:L_AF*N_trial)+(subj-1)*L_AF*N_trial)=A;
                    clear A T;
                end
            end
            AF_file=sprintf('%s/N%d_MOD_%d.mat',TempDir,CH,mm);
            eval(sprintf('save %s AF -v7.3',AF_file));
            AF_name='AF';
            run_CV_C(AF_file,AF_name,CV_file,TR_TS_FILE,N_TAU,N_trial);
            unix(['rm ',AF_file]);
        end
    end
end