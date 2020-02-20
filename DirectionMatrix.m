function [Cx,Cy] = DirectionMatrix(exits,vm, matSize)

%Exit matrix, vm and matSize is imported.

noOfExits = size(exits,1);

Cx = zeros(matSize,matSize); %The output is a vector field and has a Cx and Cy velocity respectively. 
Cy = zeros(matSize,matSize); %This is generated from the matrix size previously reported

exMatx = zeros(matSize, matSize); %This is to store the exit positions in x and y. 
exMaty = zeros(matSize, matSize); 

thetMat = zeros(matSize,matSize); %Is the angle between 

cMat = ChoiceMatrix(exits,matSize); %Choice Matrix is generated by a seperate function

for i=1:noOfExits
    exMaty(cMat == i) = exits(i,1); %Corresponding Exit x & y value assigned in each matrix
    exMatx(cMat == i) = exits(i,2);
end

for i=1:matSize %This is done to store the i,j position of each matrix within each matrix
    Cx(i,:) = 1:matSize;
    Cy(:,i) = 1:matSize; 
end

valMatx = ones(matSize,matSize); 
valMaty = ones(matSize,matSize);

valMaty((Cy-exMaty) ~= abs(Cy-exMaty)) = -1; %Coefficients to ensure the vectors are pointing in the right direction
valMatx((exMatx-Cx) ~= abs(exMatx-Cx)) = -1; %Preserves the sign that would otherwise be lost through the thetMat matrix

thetMat = atand(abs(Cy-exMaty)./abs(exMatx-Cx)); %Angles are determined. Only positive angles considered to prevent issues

%^ NaN is produced here as it is where 0/0 is made. 

Cy = -valMaty.*vm.*sind(thetMat); %The sign matrices are multiplied to obtain the appropriate value
Cx = valMatx.*vm.*cosd(thetMat); 

end 