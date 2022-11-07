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
%-----

if( nargin==0 ) 

  alpha   = 0.8; 

  beta    = 0.2; 
  % the learning rate: 
  gamma   = 0.9; 
  
  % Recieved Rewards (Rsearch > Rwait): 
  % 
  Rsearch = 2.0; % <- the reward given to searching 
  Rwait   = 1.0; % <- the reward given to waiting 
end
  

V = [ 0 0 0]; 

% some parameters for convergence: 
% 
MAX_N_ITERS = 10000; iterCnt = 0; 
CONV_TOL    = 1e-10; delta = 1e10; 


while( ( (delta > CONV_TOL) && (iterCnt <= MAX_N_ITERS) ) || all(abs(T(:)-V(:))~=0) ) 
  T = V; 
  
  V(1) = min( [ 1*( Rwait + gamma*V(1) ), alpha*( Rsearch + gamma*V(1) ) + (1-alpha)*( Rsearch + gamma*V(2) ) ] );
  
  
  V(2) = min( [ 1*( -0.5 + gamma*V(1) ), 1*( Rwait + gamma*V(2) ), beta*( Rsearch + gamma*V(2) ) + (1-beta)*( Rsearch + gamma*V(3)) ] );
  
  
  V(3) = min( 1* ( 0 + gamma*V(3)) );
  
  
  iterCnt=iterCnt+1; 
  delta=sum( abs( T(:) - V(:) ));
  
  fprintf('iteration number %d   ',iterCnt);
  fprintf('V %5.20f   ',V);
  fprintf('delta  %5.20f\n',delta);
end

fprintf('\n final results\n');
fprintf('V %5.20f\n',V);
fprintf('iteration number %d\n',iterCnt);
fprintf('delta  %5.20f\n',delta);





