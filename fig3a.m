clear all
close all

tic
% Fixed parameters - Don't exceed two species
s=[1 1];
n=[1 1];
e=0;

% Variable
n0=0.1:0.01:1.0;
e2=[2.5 3.5];
bif1=NaN(length(n0),length(e2));
bif2=NaN(length(n0),length(e2));

% Figures
fig=figure(1);
ax=gca;
hold(ax,'on');

cfig=figure('Visible','off');
axc=gca;

for j=1:length(e2)
	for i=1:length(n0)
		x=0:0.001:e2(j);
		ex=0:0.001:e2(j);

		[X,Y]=meshgrid(x,ex);
		fn=n0(i)*(Y-X)+n(1)*(e(1)-X).*exp(-((e(1)-X).^2)/(2*s(1)^2))+n(2)*(e2(j)-X).*exp(-((e2(j)-X).^2)/(2*s(2)^2));

		M=contour(axc,X,Y,fn,[0 0],'Visible','off');
	
		ind1=NaN;
		ind2=NaN;
		if M(2,1)==size(M,2)-1
			ind1=find(islocalmin(M(2,2:end))==1);
			if ~isnan(ind1) 
				if length(ind1)==1 
					bif1(i,j)=M(2,1+ind1(1));
				end
			end
			ind2=find(islocalmax(M(2,2:end))==1);
			if ~isnan(ind2) 
				if length(ind2)==1
					bif2(i,j)=M(2,1+ind2(1));
				end
			end
		end
	end
end

plot(ax,n0,bif1,'-','LineWidth',2);
set(ax,'ColorOrderIndex',1);
plot(ax,n0,bif2,'-','LineWidth',2);
myTxtFmt(xlabel(ax,'Strength of abiotic driver (\eta_0)'),20,0);
myTxtFmt(ylabel(ax,'Bifurcation point (\epsilon_0)'),20,0);
legend(ax,{'\epsilon_2=2.5','\epsilon_2=3.5'},'Location','northeast','FontSize',15,'AutoUpdate','off');
%set(ax,'ColorOrderIndex',1);
%plot(ax,n0,[1.5 2 2.5]'*ones(length(n0),1)');
myTxtFmt(title(ax,'Two species','FontWeight','normal'),15,0);
ylim(ax,[0 3.5]);
hold(ax,'off');
printPdf(fig,'fig3a');
toc
