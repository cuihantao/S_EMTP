%% 通过三相正弦瞬时功率计算有功和无功功率
%% 输入量
Vabc_PSC=result_PSC(:,47:49)/1e3;
Iabc_PSC=-result_PSC(:,118:120)/1e3;
Vabc_CPP=result_CPP(:,47:49)/1e3;
Iabc_CPP=-result_CPP(:,118:120)/1e3;

%% 计算DQ轴电量
n_PSC=length(t_PSC);
n_CPP=length(t_CPP);
Vdq_PSC=zeros(n_PSC,2);
Idq_PSC=zeros(n_PSC,2);
Vdq_CPP=zeros(n_CPP,2);
Idq_CPP=zeros(n_CPP,2);

for i=1:n_PSC
t=t_PSC(i);
theta=100*pi*t;
T=2/3*[cos(theta) cos(theta-2/3*pi) cos(theta+2/3*pi);-sin(theta) -sin(theta-2/3*pi) -sin(theta+2/3*pi);];
Vdq_PSC(i,:)=(T*Vabc_PSC(i,:)')';
Idq_PSC(i,:)=(T*Iabc_PSC(i,:)')';
end
for i=1:n_CPP
t=t_CPP(i);
theta=100*pi*t;
T=2/3*[cos(theta) cos(theta-2/3*pi) cos(theta+2/3*pi);-sin(theta) -sin(theta-2/3*pi) -sin(theta+2/3*pi);];
Vdq_CPP(i,:)=(T*Vabc_CPP(i,:)')';
Idq_CPP(i,:)=(T*Iabc_CPP(i,:)')';
end
%% 计算有功和无功功率
P_PSC=zeros(n_PSC,1);
Q_PSC=zeros(n_PSC,1);
P_CPP=zeros(n_CPP,1);
Q_CPP=zeros(n_CPP,1);

for i=1:n_PSC
P_PSC(i)=Vdq_PSC(i,1)*Idq_PSC(i,1)+Vdq_PSC(i,2)*Idq_PSC(i,2);
Q_PSC(i)=-Vdq_PSC(i,1)*Idq_PSC(i,2)+Vdq_PSC(i,2)*Idq_PSC(i,1);
end
for i=1:n_CPP
P_CPP(i)=Vdq_CPP(i,1)*Idq_CPP(i,1)+Vdq_CPP(i,2)*Idq_CPP(i,2);
Q_CPP(i)=-Vdq_CPP(i,1)*Idq_CPP(i,2)+Vdq_CPP(i,2)*Idq_CPP(i,1);
end
%% 画图
P_PSC=1.5*P_PSC;
Q_PSC=1.5*Q_PSC;
P_CPP=1.5*P_CPP;
Q_CPP=1.5*Q_CPP;
figure(1)
plot(t_PSC,P_PSC,t_CPP,P_CPP);
figure(2)
plot(t_PSC,Q_PSC,t_CPP,Q_CPP);