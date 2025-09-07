
iterations = 100; %number of iterations of errors test
inital_guess = 10; %also the bound
guess_list1 = inital_guess*(rand([iterations,1])-0.5);
guess_list2 = inital_guess*(rand([iterations,1])-0.5);
constraint_list= [1e-15 1e-2 1e-14 1e-2 2];
convergance_analysis1("newton", @test_function, @newton_test_function,inital_guess,guess_list1, guess_list2,constraint_list);

function convergance_analysis1(solver,fun,nfun,x_guess0, guess_list1, guess_list2,constraint_list)
%CONVERGANCE_ANALYSIS1 function that takes a method and determines the
%convergance of errors for the root
    %solver: the method to be used for the analysis
    %fun: the mathamatical function that we are using to compute the root
    %nfun: newton method's function derivative
    %x_guess0 = inital guess used to compute x_r
    %guess_list1: a list of inital guesses for each trial
    %guess_list2: a 2nd list of inital guesses for each trail, if not
    %   needed = zero
    %filter_list: a list of constraints used to filter the collected data
    global input_list;
    disp(solver)
    xr = bisection_solver(fun, -x_guess0, x_guess0);
    if solver=="newton"
        [d1, d2] = approximate_derivative(fun, xr);
        kpred = abs(0.5*d2/d1);
    end
    input_list = [];
    xn = [];
    xn1 = [];
    n = [];
    for i=1:length(guess_list1)
        switch solver
            case "bisection"
                bisection_solver(fun, guess_list1(i)-x_guess0, guess_list1(i)+x_guess0);
            case "newton"
                newton_solver(nfun, guess_list1(i));
            case "secant"
                secant_solver(fun, guess_list1(i), guess_list1(i)+.1);
            case "fzero"
                fzero(fun,guess_list1(i));
            otherwise
                break
        end
        n=[n,1:length(input_list)-1];
        xn = [xn,input_list(1:end-1)];
        xn1 = [xn1,input_list(2:end)];
        input_list = [];
    end
    en = abs(xn-xr);
    en1 = abs(xn1-xr);
    plot_errors(en,en1,solver,'r',false)
    [en_filt,en1_filt] = filter_errors(en,en1,n,constraint_list);
    plot_errors(en_filt,en1_filt,solver,'b',true)
    [fit_line_x,fit_line_y] = generate_error_fit(en_filt,en1_filt);
    plot_errors(fit_line_x,fit_line_y,solver,'k',true)
end

%example of how to implement finite difference approximation
%for the first and second derivative of a function
%INPUTS:
%fun: the mathetmatical function we want to differentiate
%x: the input value of fun that we want to compute the derivative at
%OUTPUTS:
%dfdx: approximation of fun’(x)
%d2fdx2: approximation of fun’’(x)
function [dfdx,d2fdx2] = approximate_derivative(fun,x)
    %set the step size to be tiny
    delta_x = 1e-6;
    %compute the function at different points near x
    f_left = fun(x-delta_x);
    f_0 = fun(x);
    f_right = fun(x+delta_x);
    %approximate the first derivative
    dfdx = (f_right-f_left)/(2*delta_x);
    %approximate the second derivative
    d2fdx2 = (f_right-2*f_0+f_left)/(delta_x^2);
end
%example for how to compute the fit line
%data points to be used in the regression
%x_regression -> e_n
%y_regression -> e_{n+1}
%p and k are the output coefficients
function [fit_line_x,fit_line_y] = generate_error_fit(x_regression,y_regression)
    %generate Y, X1, and X2
    %note that I use the transpose operator (’)
    %to convert the result from a row vector to a column
    %If you are copy-pasting, the ’ character may not work correctly
    Y = log(y_regression');
    X1 = log(x_regression');
    X2 = ones(length(X1),1);
    %run the regression
    coeff_vec = regress(Y,[X1,X2]);
    %pull out the coefficients from the fit
    p = coeff_vec(1)
    k = exp(coeff_vec(2))
    %example for how to plot fit line
    %generate x data on a logarithmic range
    fit_line_x = 10.^[-16:.01:1];
    %compute the corresponding y values
    fit_line_y = k*fit_line_x.^p;
end
function [x_regression,y_regression] = filter_errors(error_list0,error_list1,index_list,filters)
    %example for how to filter the error data
    %currently have error_list0, error_list1, index_list
    %data points to be used in the regression
    x_regression = []; % e_n
    y_regression = []; % e_{n+1}
    %iterate through the collected data
    for n=1:length(index_list)
        %if the error is not too big or too small
        %and it was enough iterations into the trial...
        if error_list0(n)>filters(1) && error_list0(n)<filters(2) && ...
            error_list1(n)>filters(3) && error_list1(n)<filters(4) && ...
            index_list(n)>filters(5)
            %then add it to the set of points for regression
            x_regression(end+1) = error_list0(n);
            y_regression(end+1) = error_list1(n);
        end
    end
end
function plot_errors(en,en1,tit,color,h)
    if ~h
        figure;
    end
    loglog(en,en1,'Color',color,'MarkerSize',1,'Marker','.','LineStyle','none');
    if ~h
        title(tit);
        xlabel("\epsilon_n(-)");
        ylabel("\epsilon_{n+1}(-)");
        xlim([10^-16,10^2]);
        ylim([10^-16,10^2]);
    end
    hold on;
end
function output = test_function(x)
    %declare input_list as a global variable
    global input_list;
    %append the current input to input_list
    %formatted so this works even if x is a column vector instead of a scalar
    input_list(:,end+1) = x;
    %perform the rest of the computation to generate output
    %I just put in a quadratic function as an example
    output = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
end
function [f,fd] = newton_test_function(x)
    f=test_function(x);
    fd=3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end