clear all
close all

tic
% Fixed parameters - Don't exceed two species
s1=1;
n1=1;
e1=0;

% Variable
n2=0.1:0.1:3.0;
s2=[0.5 1.0 2.5];
bif=NaN(length(n2),length(s2));

% Figures
fig=figure(1);
ax=gca;
hold(ax,'on');

cfig=figure('Visible','off');
axc=gca;

for j=1:length(s2)
	for i=1:length(n2)
		x=-0.002:0.001:8;
		ex=0:0.001:8;

		[X,Y]=meshgrid(x,ex);
		fn=n1*(e1-X).*exp(-((e1-X).^2)/(2*s1^2))+n2(i)*(Y-X).*exp(-((Y-X).^2)/(2*s2(j)^2));

		M=contour(axc,X,Y,fn,[0 0],'Visible','off');
		[i j size(M)];

		% Find number of branches (cts) and only save interior minima (bifurcation points)
		cts=1;
		check=0;
		Mi=M(2,1);
		[m mx]=min(M(2,2:Mi+1));
		if mx~=1 && mx~Mi
	%		[m M(1,1+mx)]
	%		plot(ax,n2(i),m,'*-k');
			bif(i,j)=m;
			check=1;
		end
		while Mi~=size(M,2)-cts
			cts=cts+1;
			[m mx]=min(M(2,Mi+cts+1:Mi+M(2,Mi+cts)));
			if ~isempty(m)
				if mx~=1 && mx~=M(2,Mi+cts)-cts
	%				[m M(1,Mi+cts+mx)]
	%				plot(ax,n2(i),m,'*-k');
					if check==1
						fprintf('Finding second bifurcation point at n2=%0.2f and s2=%0.2f\n',n2(i),s2(j));
					else
						bif(i,j)=m;
						check=1;
					end
				end
			end
			Mi=Mi+M(2,Mi+cts);
		end
		%drawnow
		%bif(i,j)
		%pause
	end
end

plot(ax,n2,bif,'-','LineWidth',2);
myTxtFmt(xlabel(ax,'Strength of conditioning (\eta_2)'),20,0);
myTxtFmt(ylabel(ax,'Bifurcation point (\epsilon_2)'),20,0);
legend(ax,{'\omega_2=0.5','\omega_2=1.0','\omega_2=2.5'},'Location','northwest','FontSize',15,'AutoUpdate','off');
myTxtFmt(title(ax,'Two species','FontWeight','normal'),15,0);
ylim(ax,[0 10]);
hold(ax,'off');
printPdf(fig,'fig2a');
toc
