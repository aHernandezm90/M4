function PlotRes(tp,tn,fp,fn,precision,recall,f1,alpha)
	colorVec=[1 0 0 ; 0 0 1 ; 0.1 0.8 0.8 ; 0 1 1]; 
	leg = {'tp','tn','fp','fn'};

	aux= zeros (4,4);
	aux(:,1)=tp';
	aux(:,2)=tn';
	aux(:,3)=fp';
	aux(:,4)=fn';
	set(gca, 'ColorOrder', colorVec, 'NextPlot', 'replacechildren');
	figure ('Name','Tn,Tp,Fn,Fp')
		plot(alpha,aux);
		legend(leg);
		xlabel('Alpha','FontSize',12,'FontWeight','bold','Color','blue');
    	ylabel('Pixel','FontSize',12,'FontWeight','bold','Color','blue');

	figure ('Name','Precision vs Recall')
		plot (precision,recall);
		xlabel('Recall','FontSize',12,'FontWeight','bold','Color','blue');
    	ylabel('Precision','FontSize',12,'FontWeight','bold','Color','blue');

	figure ('Name','F1')
		plot (alpha,f1);
		xlabel('Alpha','FontSize',12,'FontWeight','bold','Color','blue');
    	ylabel('F1','FontSize',12,'FontWeight','bold','Color','blue');
end