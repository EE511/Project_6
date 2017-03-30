%%--------------------------------------------------------------------------
%%Project-6:: Question - 1
%%To Simulate Box Muller method & Polar Marsaglia method
%%Author                Date               Revision
%%Rajasekar Raja     03/25/17         Initial Revision
%%--------------------------------------------------------------------------
function[] =  ee511_p6_q1(No_Of_Samples,No_of_trails)
%Initialize(Given values)
mean_of_X = 1; 
mean_of_Y = 2; 
var_of_X = 4; 
var_of_Y = 9;
theo_mean_sum = mean_of_X + mean_of_Y;
theo_var_sum = var_of_X + var_of_Y;

%Box Muller Method
time_elasped=zeros(1,No_of_trails);
%**** Code Reference from Piazza ****
for i=1:No_of_trails
    tic;% Start the timer
    r_number1 = rand(No_Of_Samples,1);
    r_number2 = rand(No_Of_Samples,1);
    % Generate X and Y that are N(0,1) random variables and independent
    rand_var_X = sqrt( - 2*log(r_number1)).*cos(2*pi*r_number2); 
    rand_var_Y = sqrt( - 2*log(r_number1)).*sin(2*pi*r_number2);
    % Scale them to a particular mean and variance 
    x = sqrt(var_of_X)*rand_var_X + mean_of_X;
    y = sqrt(var_of_Y)*rand_var_Y + mean_of_Y;    
    time_elasped(i)=toc; % Read elapsed time from stopwatch
    sum=x+y;
end
cov_x_and_y = cov(x,y);
disp('Summary of Simulation for BOX MULLER Method');
disp(['Calculated Mean ',num2str(mean(sum)),' Theoritical Mean ',num2str(theo_mean_sum)]);
disp(['Calculated Variance ',num2str(var(sum)),' Theoritical Variance ',num2str(theo_var_sum)]);
disp(['Sample Mean of Random Variable X is ',num2str(mean(x)),' and that of Y is ',num2str(mean(y))]);
disp(['Sample Variance of Random Variable X is ',num2str(var(x)),' and that of Y is ',num2str(var(y))]);
disp(['Covariance of Random Variables X and Y is ',num2str(cov_x_and_y(1,2))]);
disp(['Time taken to generate ',num2str(No_Of_Samples),' samples with ',num2str(No_of_trails),' experiments are ',num2str(time_elasped)]);
figure(1)
yyaxis left
hist(sum,20);
title('BOX MULLER: Random Variable X+Y overlay with PDF') 
xlabel('Value of sum of Random variables')
ylabel('Frequency')
yyaxis right
t=-80:0.1:80;
theo_pdf=normpdf(t,3,13);
plot(t,theo_pdf,'m--*');
ylabel('Theo Normal PDF');
legend({'Hist of A','Theoretical PDF of Normal Distribution'})

%POLAR MARSAGLIA Method
j=0;
for i=1:No_of_trails
    tic;% Start the timer
    while(j<=No_Of_Samples)
        r_number1 = 2*rand()-1;
        r_number2 = 2*rand()-1;
        s = r_number1^2 + r_number2^2;
        if(s < 1)
            j = j + 1;
            X(j) = sqrt(-2*log(s)/s)*r_number1;
            Y(j) = sqrt(-2*log(s)/s)*r_number2;
        end
    end
    x = sqrt(var_of_X)*X + mean_of_X;
    y = sqrt(var_of_Y)*Y + mean_of_Y;     
    time_elasped(i)=toc;% Read elapsed time from stopwatch
    sum=x+y;
end
cov_x_and_y = cov(x,y);
disp('Summary of Simulation for POLAR MARSAGLIA Method');
disp(['Calculated Mean ',num2str(mean(sum)),' Theoritical Mean ',num2str(theo_mean_sum)]);
disp(['Calculated Variance ',num2str(var(sum)),' Theoritical Variance ',num2str(theo_var_sum)]);
disp(['Sample Mean of Random Variable X is ',num2str(mean(x)),' and that of Y is ',num2str(mean(y))]);
disp(['Sample Variance of Random Variable X is ',num2str(var(x)),' and that of Y is ',num2str(var(y))]);
disp(['Covariance of Random Variables X and Y is ',num2str(cov_x_and_y(1,2))]);
disp(['Time taken to generate ',num2str(No_Of_Samples),' samples with ',num2str(No_of_trails),' experiments are ',num2str(time_elasped)]);
figure(2)
yyaxis left
hist(sum,20);
title('POLAR MARSAGLIA MULLER: Random Variable X+Y overlay with PDF') 
xlabel('Value of Random variable A')
ylabel('Frequency')
yyaxis right
t=-80:0.1:80;
theo_pdf=normpdf(t,3,13);
plot(t,theo_pdf,'c--o');
ylabel('Theo Normal PDF');
legend({'Hist of A','Theoretical PDF of Normal Distribution'})