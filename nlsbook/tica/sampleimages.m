function X=sampleimages(patchsize,sample_per_img)
    nimg=13;
    nsample=nimg*sample_per_img;
    inputsize=patchsize*patchsize;
    X=zeros(inputsize,nsample);
    for i=1:nimg
        str=['data/' num2str(i) '.tiff'];
        fprintf('sampling %s\n',str);
        image=imread(str);
        image=double(image);
        ncols=size(image,2);
        nrows=size(image,1);   
        for j=1:sample_per_img
            pcol=randi(ncols-patchsize+1);
            prow=randi(nrows-patchsize+1);
            id=(i-1)*sample_per_img+j;
            X(:,id)=reshape(image(prow:prow+patchsize-1,pcol:pcol+patchsize-1),inputsize,1);
        end
    end
    %display_network(X(:,end-63:end)./128.0-1);
end