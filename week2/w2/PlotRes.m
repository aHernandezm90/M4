function PlotRes(tp,tn,fp,fn,precision,recall,f1,alpha)
	colorVec=[1 0 0 ; 0 0 1 ; 0.1 0.8 0.8 ; 0 1 1]; 
	leg = {'tp','tn','fp','fn'};

	aux= zeros (3,4);
	aux(:,1)=tp';
	aux(:,2)=tn';
	aux(:,3)=fp';
	aux(:,4)=fn';
	set(gca, 'ColorOrder', colorVec, 'NextPlot', 'replacechildren');
	figure ('Name','Tn,Tp,Fn,Fp')
		plot(alpha,aux);
		legend(leg);

	figure ('Name','Precision vs Recall')
		plot (precision,recall);

	figure ('Name','F1')
		plot (f1);
end