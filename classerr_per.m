function [err,idx_wrong] = classerr_per(label,nclass,nexample)

if nclass == 2
    if nexample == 1
        filename = 'testlabel2C.txt';
    elseif nexample == 2
        filename = 'testlabel_ESL_2C.txt';
%     else
%         filename = 'testlabel2C_uv.txt';
    end
    fid = fopen(filename,'r');
    true = fscanf(fid,'%d \n');
    fclose(fid);

elseif nclass == 3
    if nexample == 2
        filename = 'testlabel3C.txt';
    else
        filename = 'testlabel_ESL_3C.txt';
    end
    fid = fopen(filename,'r');
    true = fscanf(fid,'%d \n');
    fclose(fid);
elseif nclass == 10
      [~, lbl] = read_hw;
       true = lbl(16001:20000)+1;
end

wrong = 0;
idx_wrong = [];
for i=1:length(true)
    if true(i) ~= label(i)
        wrong = wrong + 1;
        idx_wrong = [idx_wrong,i];
    end
end

err = wrong/length(true);
