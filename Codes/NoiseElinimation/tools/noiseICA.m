function [X,Y,W] = noiseICA(srcMat,numSrc,flag)
% % %     srcMat is numSrc x n, numSrc is the number of audios
% % %     X: rawdata, Y: output
% % %     [X,Y] = noiseICA(data',2,1);
    A=zeros(numSrc,numSrc);
    X = srcMat;
    eta = 0.005;
    eta0 = eta;
    T=1000;
    num_iter=5000;

    %Make some random guess of mix-matrix inverse
    W = rand(size(A)) ./ 10;
    for i=0:num_iter
        Y = W*X;			% predict source matrix based on guessed mix matrix
        [delW, ~] = mygradient(eta, Y, W);	% gradient descent - shift by delta
        W = W + delW;			% update W
        eta = eta0 / (1 + (i/T));	% annealing - learning rate
        if(mod(i,100) == 0 && flag == 1)
        	fprintf('runs %d/%d\n',i,num_iter);
        %	W
        %	corrMat = correlations(srcMat,Y)
        %	%fflush(stdout);
        end
    end
    Y = W*X;				% predict source matrix based on guessed mix matrix
    Y = (Y - min(min(Y))) ./ (max(max(Y)) - min(min(Y)));
end