%%--------------------------------------------------------------------------
%%Project-6:: Question - 2
%%To Calculate Gamma(5.5,1) using Accept-Reject Method
%%Author                Date               Revision
%%Rajasekar Raja     03/24/17         Initial Revision
%%--------------------------------------------------------------------------
function [] = ee511_p6_q2(No_of_samples)
%Initialize Variables
  x = 0:0.05:10;
  rej_samp = 0;
  value = 11/2;
  %Calculate the value of C so that u<=f(y)/c*g(y)
  % function f
  func_X = @(x) 1/gamma(value) .* x.^(value-1) .* exp(-x); 
  % function g
  func_Y = @(y) (1/value) * exp(-y/value);
  X_by_Y = func_X(x)./func_Y(x);
  const_c = max(X_by_Y);
  c_value=(value/(const_c*gamma(5.5)));
  
  for iter=1:No_of_samples
      while(1)
          r_number=rand;
          uniform_i=-value*log(r_number);
          if rand<((c_value)*(uniform_i^(value-1))*exp(-uniform_i*(1-(1/value))))
              accept(iter)=uniform_i;
              break;
          else
              rej_samp = rej_samp+1;
          end
      end
  end
  
  yyaxis left;
  hist(accept,15);
  title('Overlaying of theoretical pdf and the histogram of the generated samples');
  xlabel('Accept Values');
  ylabel('Frequency of the generated samples');  
  yyaxis right;
  x=0:0.1:40;
  theo_gamma=gampdf(x,value,1);
  plot(x,theo_gamma,'m--*');
  ylabel('Theo PDF of the gammma distribution');  
  accept_rate=(No_of_samples/(rej_samp+No_of_samples))*100;   
  disp(['The Acceptance rate for calculating Gamma(5.5,1)is % ',num2str(accept_rate)]);
end
