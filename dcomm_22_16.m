clear all;
close all;
clc;
%%generting the haamming codeword & lexicographic matrix
% [filename,path]=uigetfile('*.txt');
% textfile=[path,filename];
% msg=textread(textfile, '%d', 'whitespace', ''); 
% [lex,g]=hammgen(5);
% display(g);
% display (lex);
code=[0 1 0 1 0 1 0 1 0 1 1 1 1 0 1 1 1 0 1 1 0 1];      %msg 0101010101111011

lex=[1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0
     0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	1	0	0	0
     1	1	0	0	0	1	1	1	1	0	0	0	1	1	1	0	0	0	1	0	0
     0	0	1	1	0	1	1	0	0	1	1	0	1	1	0	1	0	0	0	1	0
     1	0	1	0	1	1	0	1	0	1	0	1	1	0	1	1	0	0	0	0	1];
disp('Adjacent "3" error bit detection for Extended HAMMING[22,16]:');
disp('codeword=');disp(code);
disp('lexicographic=');disp(lex);


% Generating the 3 bit error in the hamming codeword
syn_value=zeros(21,21,21);

for i=1:19
    for j=(i+1):20
        for k=(j+1):21
           cod=[code(1) code(2) code(3) code(4) code(5) code(6) code(7) code(8) code(9) code(10) code(11) code(12) code(13) code(14) code(15) code(16) code(17) code(18) code(19) code(20) code(21) code(22)];  
           if cod(i)==0
              cod(i)=1;
           else
              cod(i)=0;
           end
           
           if cod(j)==0
              cod(j)=1;
           else
              cod(j)=0;
           end
           
           if cod(k)==0
              cod(k)=1;
           else
              cod(k)=0;
           end
        % error codeword without parity bit     
        c=[cod(2) cod(3) cod(4) cod(5) cod(6) cod(7) cod(8) cod(9) cod(10) cod(11) cod(12) cod(13) cod(14) cod(15) cod(16) cod(17) cod(18) cod(19) cod(20) cod(21) cod(22)];
        % calculating syndrome for all  error codeword_without a parity bit
        syn = mod((lex*c'),2);
        syn_value(i,j,k) = bin2dec(num2str(syn'));
        end
    end
end
disp('syndrome value=');disp(syn_value);

% obtaining syndrome value > codeword length
g8syn_value=zeros(21,21,21);

for i=1:19
    for j=(i+1):20
        for k=(j+1):21
          if syn_value(i,j,k)>length(code)
             g8syn_value(i,j,k)=syn_value(i,j,k);
          else
          g8syn_value(i,j,k)=0;
          end
        end
    end
end

%% printing error bits with wrong syndrome
biterror_comb=[];

d=[];
for i=1:21
    for j=1:21
        for k=1:21
          if g8syn_value(i,j,k)~=0
             d=[i j k];
             biterror_comb=[biterror_comb;d];
          end
        end
    end
end
disp('error bits=');disp(biterror_comb);
[row,col]=size( biterror_comb);
disp('Number of 3 bit error detected=');disp(row);


% printing adjacent error bits with wrong syndrome

adjerror_comb=[];j=1;l=[];a=0;
for i=1:row
    
        if (biterror_comb(i,j)==(biterror_comb(i,j+1)-1)&& biterror_comb(i,j+1)==(biterror_comb(i,j+2)-1)) 
            l=[biterror_comb(i,j) biterror_comb(i,j+1) biterror_comb(i,j+2)];
            adjerror_comb=[adjerror_comb; l];
        end
    
end
disp('3 adjacent bits in error=');disp(adjerror_comb);   
        
%%%%%------------------------END OF CODE----------------------------%%%%%
