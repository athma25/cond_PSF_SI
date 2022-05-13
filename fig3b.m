clear all
close all

tic
% Fixed parameters - Don't exceed three species
s=[1 1 1];
n=[1 1 1];
e=[0 2.5];

% Variable
n0=0.05:0.01:0.5;
e3=[4 5];
bif1=NaN(length(n0),length(e3),2);
bif2=NaN(length(n0),length(e3),2);

% Figures
fig=figure(1);
ax=gca;
hold(ax,'on');

cfig=figure('Visible','off');
axc=gca;

for j=1:length(e3)
	for i=1:length(n0)
		x=0:0.001:e3(j);
		ex=0:0.001:e3(j);

		[X,Y]=meshgrid(x,ex);
		fn=n0(i)*(Y-X)+n(1)*(e(1)-X).*exp(-((e(1)-X).^2)/(2*s(1)^2))+n(2)*(e(2)-X).*exp(-((e(2)-X).^2)/(2*s(2)^2))+n(3)*(e3(j)-X).*exp(-((e3(j)-X).^2)/(2*s(3)^2));
		M=contour(axc,X,Y,fn,[0 0],'Visible','off');

		cts=0;
		Mi=0;
		check=0;
		while check==0
			ind1=NaN;
			ind2=NaN;
			cts=cts+1;
			ind1=find(islocalmax(M(2,Mi+cts+1:Mi+M(2,Mi+cts))));
			if ~isnan(ind1)
				for k=1:length(ind1)
					bif1(i,j,k)=M(2,Mi+cts+ind1(k));
				end
			end
			ind2=find(islocalmin(M(2,Mi+cts+1:Mi+M(2,Mi+cts))));
			if ~isnan(ind2)
				if length(ind2)==1
					bif2(i,j,1)=M(2,Mi+cts+ind2(1));
				else
					bif2(i,j,1)=M(2,Mi+cts+ind2(2));
					bif2(i,j,2)=M(2,Mi+cts+ind2(1));
				end
			end
			Mi=Mi+M(2,Mi+cts);
			if Mi>=size(M,2)-cts
				check=1;	
			end
		end
	end
end

plot(ax,n0,squeeze(bif1(:,:,1)),'-','LineWidth',2);
set(ax,'ColorOrderIndex',1);
plot(ax,n0,squeeze(bif1(:,:,2)),'-','LineWidth',2);
set(ax,'ColorOrderIndex',1);
plot(ax,n0,squeeze(bif2(:,:,1)),'-','LineWidth',2);
set(ax,'ColorOrderIndex',1);
plot(ax,n0,squeeze(bif2(:,:,2)),'-','LineWidth',2);
myTxtFmt(xlabel(ax,'Strength of abiotic driver (\eta_0)'),20,0);
myTxtFmt(ylabel(ax,'Bifurcation point (\epsilon_0)'),20,0);
legend(ax,{'\epsilon_3=4','\epsilon_3=5'},'Location','northeast','FontSize',15,'AutoUpdate','off');
plot(ax,n0,2.5*ones(length(n0),1),'--k','LineWidth',2);
%set(ax,'ColorOrderIndex',1);
%plot(ax,n0,[1.5 2 2.5]'*ones(length(n0),1)');
ylim(ax,[0 5]);
myTxtFmt(title(ax,'Three species','FontWeight','normal'),15,0);
hold(ax,'off');
printPdf(fig,'fig3b');
toc
