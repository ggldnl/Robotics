% Subspaces (images and kernels) of the Jacobian of a robot and their dimensions
% Example: planar 3R robot with equal (unitary) links
% by A. De Luca, first 25 Nov 2011 
% revised 3 Dec 2018 (run twice: for regular and singular cases)
% available in the course material of Robotics 1

clear all
clc

syms q1 q2 q3 real

disp('Subspace analysis (range and null spaces): R(J), N(J), R(J^T), N(J^T)')
disp('of the robot Jacobian (a mxn matrix) in a given configuration q')
pause
disp(' ')
disp('robot: planar 3R arm with unitary links (n=3)')
disp('task: end-effector position in the plane (m=2)')
pause
disp(' ')
disp('direct (task) kinematics')
p=[cos(q1) + cos(q1+q2) + cos(q1+q2+q3);
   sin(q1) + sin(q1+q2) + sin(q1+q2+q3)]
pause

q=[q1 q2 q3]';

disp('Jacobian (a 2x3 matrix)')
Jac=jacobian(p,q)
pause

% first case: a configuration that is regular

disp('REGULAR CASE: in the configuration q=(0, pi/2, pi/2)') %(0, pi/2, pi/4)
disp(' ')
disp('a) working with the Jacobian')
J=subs(Jac,{q1,q2,q3},{0,pi/2,pi/2}) %{0,pi/2,pi/4}
pause

% Question 1: If I apply any joint velocity on the joints, where can I go with the end effector? -> rank
%             If full rank, we can go everywhere
% Question 2: Can we move the joints such that the end effector does not move? -> null space
%             If the null space only contains the zero vector, this is not possible i.e. we can't find 
%             a configuration different from qi = 0 for each i that results in a zero end effector velocity


% second case: a configuration that is singular

% disp('SINGULAR CASE: in the configuration q=(pi/2, 0, pi)')
% disp(' ')
% disp('a) working with the Jacobian')
% J=subs(Jac,{q1,q2,q3},{pi/2,0, pi})
% pause

rankJ=rank(J)
pause

NullSpaceJ=null(J)
dimNullSpaceJ=size(NullSpaceJ,2);
disp('normalizing...')
if dimNullSpaceJ>1
   NullSpaceJ(:,1)=NullSpaceJ(:,1)/norm(NullSpaceJ(:,1));
   NullSpaceJ(:,2)=NullSpaceJ(:,2)/norm(NullSpaceJ(:,2));
   NullSpaceJ
else
   NullSpaceJ=NullSpaceJ/norm(NullSpaceJ)
end
pause

dimNullSpaceJ=size(NullSpaceJ,2)
pause

disp('check null-space joint velocity: J*NullSpaceJ ?')
pause
simplify(J*NullSpaceJ)
pause

% The range tells us what space we can generate with the end effector
% velocities (e.g. two linearly independent vectors are a basis for a plane
% so we can produce velocity vectors on the whole plane with the end
% effector based on a hypothetical configuration)

RangeJ=orth(J)
%RangeJ=simplify(orth(J))
pause

dimRangeSpaceJ=size(RangeJ,2)
pause

disp('b) working with the Jacobian transpose')
JT=J'
pause

% The rank does not change for the transpose but the subspace we generate
% is different (e.g. rank(J) can be max 2 (min(2,3) but can be lower if
% there is linear dependency between the row/col vectors of the matrix; 
% rank(J^T) can be max 2 (min(2, 3), ...); the null space of J has
% dimension 3; the null space of J^T has dimension 2

rankJT=rank(JT)
pause

NullSpaceJT=null(JT);
dimNullSpaceJT=size(NullSpaceJT,2);
if dimNullSpaceJT>0,
   NullSpaceJT=NullSpaceJT/norm(NullSpaceJT)
else
   NullSpaceJT
end
pause

dimNullSpaceJT=size(NullSpaceJT,2)
pause

RangeJT=orth(JT);
RangeJT=simplify(RangeJT)
dimRangeSpaceJT=size(RangeJT,2);
disp('de-normalizing...') %assuming that the first elements of the columns are non-zero, else...
RangeJT(:,1)=RangeJT(:,1)/RangeJT(1,1);
if dimRangeSpaceJT>1
   RangeJT(:,2)=RangeJT(:,2)/RangeJT(1,2);
end
RangeJT
pause

dimRangeSpaceJT=size(RangeJT,2)
pause

disp('c) final check on dimensions of subspaces')

disp(' ')
disp('dim Range(J) + dim Null(J^T) ?')
pause 
dimRangeSpaceJ+dimNullSpaceJT
disp('..equal to the task-space dimension')
pause

disp(' ')
disp('dim Range(J^T) + dim Null(J) ?')
pause
dimRangeSpaceJT+dimNullSpaceJ
disp('..equal to the joint-space dimension')

% end