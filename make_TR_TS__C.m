CHAN = [1 2 3 4];
for CH = CHAN
    LIST = [1:41; 1:41];
    TR_TS_FILE = sprintf('TR_TS__C_%d.mat',CH);
    LTrain = length(LIST);
    N_TRIAL = 400;
    COND = ['C1';'C2'];
    N_cv = 100;
    N_classes = 1;
    for c = 1:size(COND,1)
        N_SUBJ = length(find(LIST(c,1:LTrain)>=0));
        %%list = LIST(c,1:N_SUBJ); list=1:length(list);
        list = 1:N_SUBJ;
        N_train(c) = ceil(2*N_SUBJ/3);
        N_test(c) = N_SUBJ-N_train(c);
        [TR,TS]=make_TR_TS_list(N_cv,N_classes,length(list),N_train(c),N_test(c),list);
        eval(sprintf('TR_%d = TR; TS_%d = TS;',c,c)); clear TR TS
    end
    TRTS=-ones(N_cv*size(COND,1),max(N_train)+max(N_test));
    for c=1:size(COND,1)
        eval(sprintf('TRTS((1:N_cv)+(%d-1)*N_cv,1:N_train(%d))=TR_%d;',c,c,c));
        eval(sprintf('TRTS((1:N_cv)+(%d-1)*N_cv,max(N_train)+(1:N_test(%d)))=TS_%d;',c,c,c));
    end
    eval(sprintf('save %s TRTS N_train N_test N_cv LIST COND N_TRIAL',TR_TS_FILE));
end
