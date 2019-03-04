clear all;
close all;
clc;
% [filename,path]=uigetfile('*.txt');
% textfile=[path,filename];
% msg=textread(textfile, '%d', 'whitespace', ''); 
% [lex,g]=hammgen(5);
% display(g);
% display (lex);
code=[1 0 1 0 1 1 0 0 1 1 0 0 0 0 1 1 1 1 0 0 1];
lex=[1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0
     0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	1	0	0	0
     1	1	0	0	0	1	1	1	1	0	0	0	1	1	1	0	0	0	1	0	0
     0	0	1	1	0	1	1	0	0	1	1	0	1	1	0	1	0	0	0	1	0
     1	0	1	0	1	1	0	1	0	1	0	1	1	0	1	1	0	0	0	0	1];
disp('Adjacent "2" error bit detection for HAMMING[21,16]:');
disp('codeword=');disp(code);
disp('lexicographic=');disp(lex);


% Generating the 2 bit error in the hamming codeword
syn_value=zeros(21,21);

for i=1:20
   for j=(i+1):21
     c=[code(1) code(2) code(3) code(4) code(5) code(6) code(7) code(8) code(9) code(10) code(11) code(12) code(13) code(14) code(15) code(16) code(17) code(18) code(19) code(20) code(21)];
     if c(i)==0
        c(i)=1;
     else
        c(i)=0;
     end
     if c(j)==0
        c(j)=1;
     else
        c(j)=0;
     end 
     
     % calculating the syndrome matrix for each error_codeword  
     syn=mod((lex*c'),2); 
     syn_value(i,j)=bin2dec(num2str(syn'));  % syndrome value in decimal
   end
end
disp('syndrome value=');disp(syn_value);

% obtaining syndrome value > codeword length
g8syn_value=zeros(21,21);
for i=1:20
    for j=(i+1):21
      if syn_value(i,j)>length(code)
         g8syn_value(i,j)=syn_value(i,j);
      else
         g8syn_value(i,j)=0;
      end
    end
end

%% printing error bits with wrong syndrome
biterror_comb=[];

d=[];
for i=1:21
    for j=1:21
        if g8syn_value(i,j)~=0
           d=[i j];
           biterror_comb=[biterror_comb;d];
        end
    end
end
disp('error bits=');disp(biterror_comb);
[row,col]=size( biterror_comb);
disp('Number of 2 bit error detected=');disp(row);

% printing adjacent error bits with wrong syndrome

adjerror_comb=[];j=1;l=[];a=0;
for i=1:row
    
        if (biterror_comb(i,j)==(biterror_comb(i,j+1)-1)) 
            l=[biterror_comb(i,j) biterror_comb(i,j+1)];
            adjerror_comb=[adjerror_comb; l];
        end
    
end
disp('adjacent bits in error=');disp(adjerror_comb);         
        
%%%%%------------------------END OF CODE----------------------------%%%%%        