function [ best ] = PCA( image )
% Separating Components
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
[r , c] = size(R);
% Calculating Mean or Average of each element
R_mean = mean2(R);
G_mean = mean2(G);
B_mean = mean2(B);
% Reducing means from all elements
R_minus_mean = R - R_mean;
G_minus_mean = G - G_mean;
B_minus_mean = B - B_mean;
% Calculating the Covariance matrix
C_RR = mean2(R.* R);
C_GG = mean2(G.* G);
C_BB = mean2(B.* B);
C_RG = mean2(R.* G);
C_RB = mean2(R.* B);
C_GB = mean2(G.* B);
Covariance = [ C_RR , C_RG , C_RB ; C_RG , C_GG , C_GB ; C_RB , C_GB , 
C_BB];
% Special Values of Covariance matrix
Special_Values = eig(Covariance);
V1 = Covariance / [Special_Values(1) Special_Values(1) 
Special_Values(1)];
V2 = Covariance / [Special_Values(2) Special_Values(2) 
Special_Values(2)];
V3 = Covariance / [Special_Values(3) Special_Values(3) 
Special_Values(3)];
% Calculating length of each vector to produce the matrix A
V1_length = norm(V1);
V2_length = norm(V2);
V3_length = norm(V3);
% unit vectors of V
V1_unit = V1 / V1_length;
V2_unit = V2 / V2_length;
V3_unit = V3 / V3_length;
% Matrix A for Transportation
A = [ V1_unit V2_unit V3_unit];
new_R = zeros ( r , c , 'uint8');
new_G = zeros ( r , c , 'uint8');
new_B = zeros ( r , c , 'uint8');
for i = 1 : r 
 
 for j = 1 : c
 
 P_OLD = [ R(i,j) ; G(i,j) ; B(i,j)];
 Temp = A * double(P_OLD);
 new_R (i , j ) = Temp (1 , 1);
 new_G (i , j ) = Temp (2 , 1);
 new_B (i , j ) = Temp (3 , 1);
 
 end
 
end
%Finding the Max_Element - Min_Element of each matrix ...
%...in order to choose the best one
dif_R = max (max(new_R)) - min(min(new_R));
dif_G = max (max(new_G)) - min(min(new_G));
dif_B = max (max(new_B)) - min(min(new_B));
%Choosing the best matrix out of new ones
if dif_R >= dif_G
 
 if dif_R >= dif_B
 best = new_R;
 else
 best = new_B;
 end
 
else
 
 if dif_G >= dif_B
 best = new_G;
 else
 best = new_B;
 end
 
end
figure('Name','Originial RGB components');
subplot ( 3 , 1 , 1);
imshow(R);
title('Original R-Component');
subplot ( 3 , 1 , 2);
imshow(G);
title('Original G-Component');
subplot ( 3 , 1 , 3);
imshow(B);
title('Original B-Component');
figure('Name','New RGB components after performing PCA');
subplot ( 3 , 1 , 1);
imshow(new_R);
title('New R after performing PCA');
subplot ( 3 , 1 , 2);
imshow(new_G);
title('New G after performing PCA');
subplot ( 3 , 1 , 3);
imshow(new_B);
title('New B after performing PCA');
figure('Name','The best :)');
subplot (1 , 1, 1);
imshow(best);
title('The best componet produced by PCA');
end