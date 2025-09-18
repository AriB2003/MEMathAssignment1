x_guesses = 0:0.1:50;
success_failure_analysis1("fzero", @ test_function03, @ newton_test_function03, x_guesses, 1)


function success_failure_analysis1(solver,fun,nfun, guess_list1, guess_list2)
% Function that tests convergence of a root-finding method by analyzing its 
% error progression.

% solver: the method to be used for the analysis
% fun: the mathamatical function that we are using to compute the root
% nfun: newton method's function derivative
% x_guess0 = inital guess used to compute x_r
% guess_list1: a list of inital guesses for each trial
% guess_list2: a 2nd list of inital guesses for each trial 
%   (used for bisection method). If not needed = zero
% filter_list: a list of constraints used to filter the collected data

    disp(solver)
    
   list_status = zeros(size(guess_list1));
   success = true;
  
    % run the solver for all initial guesses
    for i=1:length(guess_list1)
        % pick which solver is used. Additional solvers can be added by adding additional cases
        switch solver
            case "bisection"
                [~, success] = bisection_solver(fun, guess_list1(i), guess_list2(i));
            case "newton"
                [~, success] = newton_solver(nfun, guess_list1(i));
            case "secant"
                [~, success] = secant_solver(fun, guess_list1(i), guess_list1(i)+.1);
            case "fzero"
                z = fzero(fun,guess_list1(i));
                success = abs(fun(z))<0.1;
            otherwise
                break
        end
        list_status(i) = success;
    end

    % Process list and guess values
    list_status = logical(list_status);
    guess_values = fun(guess_list1);

    % Plot function
    x_values = 0:0.05:50;
    y_values = fun(x_values);
    plot(x_values,y_values,"LineWidth", 2)

    % Plot results
    hold on
    yline(0)
    plot(guess_list1(list_status),guess_values(list_status),"g.")
    plot(guess_list1(~list_status),guess_values(~list_status),"r.")
    title('FZero - Success vs Failure')

end


%Example sigmoid function
function f_val = test_function03(x)
    a = 27.3; b = 2; c = 8.3; d = -3;
    H = exp((x-a)/b);
    L = 1+H;
    f_val = c*H./L+d;
end

function [f_val,dfdx] = newton_test_function03(x)
    a = 27.3; b = 2; c = 8.3; d = -3;
    H = exp((x-a)/b);
    dH = H/b;
    L = 1+H;
    dL = dH;
    f_val = test_function03(x);
    dfdx = c*(L.*dH-H.*dL)./(L.^2);
end