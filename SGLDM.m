%  function [someOutput]=SGLDM(imagein,d)

%  local test
imagein =  randi([0,255],100,100);
d=1;

%  load image
[rowsize, colsize]=size(imagein);

%  Initialise cooccurence matrices to zero
%  Dn is co-occurence matrix for angle n
coocsize=256;
D0=zeros(coocsize,coocsize);
D45=D0;
D90=D0;
D135=D0;

%  increment entire image to give index to cooccurence matrix(1:256)
imagein=imagein+1;

%  Add edge of image
%  d is distance
newIamge=ones(rowsize+2*d,colsize+2*d)*coocsize;
newIamge((1+d):(rowsize+d),(1+d):(colsize+d))=imagein;

%  work through entire image, calculating cooccurence matrices
%  count pixels in one direction only in loop
for row=(1+d):(rowsize+d)
	for col=(1+d):(colsize+d)

		value=newIamge(row,col);

		rowmd=row-d;
		colmd=col-d;
		colpd=col+d;

		D0(value,newIamge(row,colpd))=D0(value,newIamge(row,colpd))+1;

		D45(value,newIamge(rowmd,colpd))=D45(value,newIamge(rowmd,colpd))+1;

		D90(value,newIamge(rowmd,col))=D90(value,newIamge(rowmd,col))+1;

		D135(value,newIamge(rowmd,colmd))=D135(value,newIamge(rowmd,colmd))+1;

	end
end

%  add transpose of matrices to themselves, to include effect of
%  pixels in equal and opposite directions
D0=D0+D0';
D45=D45+D45';
D90=D90+D90';
D135=D135+D135';

%  discard elements in P matrices corresponding pixels outside region of interest
greylevelsp1=256;
D0(greylevelsp1:coocsize,:)=[];
D0(:,greylevelsp1:coocsize)=[];
D45(greylevelsp1:coocsize,:)=[];
D45(:,greylevelsp1:coocsize)=[];
D90(greylevelsp1:coocsize,:)=[];
D90(:,greylevelsp1:coocsize)=[];
D135(greylevelsp1:coocsize,:)=[];
D135(:,greylevelsp1:coocsize)=[];

