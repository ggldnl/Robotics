syms a2 a3 q1 q2 q3 Px Py

Px = cos(q1) * (a3 * cos(q2 + q3) + a2 * cos(q2))
Py = sin(q1) * (a3 * cos(q2 + q3) + a2 * cos(q2))
O = q1 + q2 + q3

Px_q1 = diff(Px, q1);
Px_q2 = diff(Px, q2);
Px_q3 = diff(Px, q3);

Py_q1 = diff(Py, q1);
Py_q2 = diff(Py, q2);
Py_q3 = diff(Py, q3);

O_q1 = diff(O, q1);
O_q2 = diff(O, q2);
O_q3 = diff(O, q3);

disp('Jacobian:')
Jac = [Px_q1 Px_q2 Px_q3; Py_q1 Py_q2 Py_q3; O_q1 O_q2 O_q3]

disp('Determinant:')
det_J = simplify(det(Jac))

disp('Assume the configuration {0, 0, pi}')
J=subs(Jac,{q1,q2,q3},{0, 0, pi})

NullSpaceJ=null(J)
dimNullSpaceJ=size(NullSpaceJ,2);
disp('normalizing...')
if dimNullSpaceJ>1,
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

RangeJ=orth(J)
%RangeJ=simplify(orth(J))
pause

dimRangeSpaceJ=size(RangeJ,2)
pause