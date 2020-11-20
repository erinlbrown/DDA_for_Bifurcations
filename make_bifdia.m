dt=.05; % Time step for integration
x0=[1 1 1]; % Initial conditions
a=0.2; % Parameter for Rossler system
c=-5.7; % Parameter for Rossler system
t=dt:dt:22000*dt; % Set time array
B=0.01:.001:1.6; % Set bifurcation parameter array 1.6
H_range=-13:.01:-2;
H=zeros(length(B),length(H_range));
n_B=1:length(B); % Number of values for bifurcation parameter
for bb=n_B
    fprintf(1,'%3d ',bb);
    if mod(bb,20)==0, fprintf(1,'\n'); end
    b=B(bb);
    write_a_in([3,4,12,13,21,24,27],[-1 -1 1 a b c 1]);
    [u1,u2]=unix('/home/claudia/TOOLS/integrate_ODE_nofile 0.05 50000 xyz 1 1 1');
    d=str2double(u2);
    %size(d)
    d=d(10001:end,1:2);
    for k=1:2
        d(:,k)=add_noise(d(:,k),20);
    end
    s=sqrt(c^2-4*a*b);
    x1=(-c-s)/2; y1=(c+s)/(2*a); % fixed point inside
    x2=(-c+s)/2; y2=(c-s)/(2*a);
    [X,Y]=poin(d,y1);
    f=find(X<x1);
    H(bb,:)=hist(X(f),H_range);
end
fprintf(1,'\n');
H_ori=H;
for bb=n_B, H(bb,:)=H(bb,:)./max(H(bb,:)); end
save ROS_bifdia_4.mat H H_ori B H_range