% function [someOutput]=SRDM(imagein)

% Test code
imagein =  randi([0,255],100,100);


% load image
[rowsize, colsize]=size(imagein);

imagein = imagein + 1;
SRDMatrix=zeros(24,16);

for i=4:rowsize-3
    for j=4:colsize-3
        countR2=0;
        countR1=0;
        %R2
        for m=i-3:i+3
            if m==i-3 || m==i+3
                for n=j-3:j+3
                    if imagein(m,n) > imagein(i,j)
                        countR2=countR2+1;
                    end
                end
            else
                if imagein(m,j-3) > imagein(i,j)
                    countR2=countR2+1;
                end
                if imagein(m,j+3) > imagein(i,j)
                    countR2=countR2+1;
                end
            end 
        end
        %R1
        for m=i-2:i+2
            if m==i-2 || m==i+2
                for n=j-2:j+2
                    if imagein(m,n) > imagein(i,j)
                        countR1=countR1+1;
                    end
                end
            else
                if imagein(m,j-2) > imagein(i,j)
                    countR1=countR1+1;
                end
                if imagein(m,j+2) > imagein(i,j)
                    countR1=countR1+1;
                end
            end
        end
        %Increment1
        if countR1 ~=0 && countR2 ~=0
            SRDMatrix(countR2,countR1)=SRDMatrix(countR2,countR1)+1;
        end

    end
end

disp(SRDMatrix);



