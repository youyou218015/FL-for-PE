function [V] = rr_state_bellman(alpha,beta,gamma,Rsearch,Rwait)
% RR_STATE_BELLMAN - Seeks an iterative solution to the optimal Bellman equations for the state-value function.
% 
%  
% See ePage 226-227 for the Bellman equation for the optimal state-value function V^*(s)
% 
% Written by:
% -- 
% dylen               2021-10-03
% 
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----

if( nargin==0 ) 

  alpha   = 0.8; 

  beta    = 0.2; 
  % the learning rate: 
  gamma   = 0.9; 
  


  Rsearch = 2.0; % <- the reward given to searching 
  Rwait   = 1.0; % <- the reward given to waiting 
end
  
% Initialize our state-value function (high,low): 
V = [ 0 0 0]; 

% some parameters for convergence: 
% 
MAX_N_ITERS = 10000; iterCnt = 0; 
CONV_TOL    = 1e-10; delta = 1e10; 

while( ( (delta > CONV_TOL) && (iterCnt <= MAX_N_ITERS) ) || all(abs(T(:)-V(:))~=0) ) 
  T = V; 
  
  
  V(1) = 1*( Rwait + gamma*V(1) )/2 + ( alpha*( Rsearch + gamma*V(1) ) + (1-alpha)*( Rsearch + gamma*V(2) ) )/2 ;
  
  
  V(2) = 1*( -0.5 + gamma*V(1) )/3 + 1*( Rwait + gamma*V(2) )/3 + ( beta*( Rsearch + gamma*V(2) ) + (1-beta)*( Rsearch + gamma*V(3)) )/3 ;
   
  
   V(3) = 1* ( 0 + gamma*V(3) );
  

  iterCnt=iterCnt+1; 
  delta=sum( abs( T(:) - V(:) ));
  
  delta1 = sum( abs( T(1) - V(1) ));
  delta2 = sum( abs( T(2) - V(2) ));
  delta3 = sum( abs( T(3) - V(3) ));
  
  fprintf('iteration number %d   ',iterCnt);
  fprintf('V %5.20f   ',V);
  fprintf('delta  %5.20f   ',delta);
  fprintf('delta1  %5.20f  ',delta1);
  fprintf('delta2  %5.20f  ',delta2);
  fprintf('delta3  %5.20f\n',delta3);
end

fprintf('\n final results\n');
fprintf('V %5.20f\n',V);
fprintf('iteration number %d\n',iterCnt);
fprintf('delta  %5.20f\n',delta);





