
[spmatrix, tokenlist, trainCategory] = readMatrix('MATRIX.TRAIN');

trainMatrix = full(spmatrix);
numTrainDocs = size(trainMatrix, 1);
numTokens = size(trainMatrix, 2);

% trainMatrix is now a (numTrainDocs x numTokens) matrix.
% Each row represents a unique document (email).
% The j-th column of the row $i$ represents the number of times the j-th
% token appeared in email $i$. 

% tokenlist is a long string containing the list of all tokens (words).
% These tokens are easily known by position in the file TOKENS_LIST

% trainCategory is a (1 x numTrainDocs) vector containing the true 
% classifications for the documents just read in. The i-th entry gives the 
% correct class for the i-th email (which corresponds to the i-th row in 
% the document word matrix).

% Spam documents are indicated as class 1, and non-spam as class 0.
% Note that for the SVM, you would want to convert these to +1 and -1.


% YOUR CODE HERE
m1=trainMatrix(find(trainCategory==1),:);
m0=trainMatrix(find(trainCategory==0),:);
phi1=sum(m1,1);
phi0=sum(m0,1);
lensum1=sum(phi1);
lensum0=sum(phi0);
log_phi1=log((phi1+1)./(lensum1+numTokens));
log_phi0=log((phi0+1)./(lensum0+numTokens));
phiy=sum(trainCategory)/numTrainDocs;
diff=[log_phi1-log_phi0;1:numTokens];
mi=zeros(1,5);
mp=zeros(1,5);
for i=1:5
    [mp(i),ii]=max(diff(1,:));
    mi(i)=diff(2,ii);
    diff(:,ii)=[];
end
remain=tokenlist;
tokens=textscan(tokenlist,'%s','delimiter',' ');
tokens{1}(mi)