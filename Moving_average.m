% A moving average filter

function output = Moving_average(signal, span)

% The "span" sets the span of the moving average (how many consecutive
% points are involved in the mean calculation).
% The "span" must be odd.


% Checking if the span is odd:
if mod(span,2) > 0
    
    % Proceed all the way through to the output:
    
    % Preallocating for speed:
    output = zeros( 1, length(signal) );
    
    % The number of elements in a successive set to the left or to the
    % right of the current element:
    one_side = ( span - 1 ) / 2;
    
    for k = 1 : length(signal)
        
        if ( ((k - 1) >= one_side) && ((length(signal) - k) >= one_side) )
            
            % A regular way of calculating the value:
            output(k) = mean( signal( (k - one_side) : (k + one_side) ) );
            
        else
            
            % Handling endpoints:
            num_of_el = min( [ k - 1, length(signal) - k ] );
            output(k) = mean( signal( (k - num_of_el) : (k + num_of_el) ) );
            
        end
        
        % The algorithm above should lead to the following result for "span
        % = 5", "signal = y", and "output = yy":
        % yy(1) = y(1)
        % yy(2) = (y(1) + y(2) + y(3))/3
        % yy(3) = (y(1) + y(2) + y(3) + y(4) + y(5))/5
        % yy(4) = (y(2) + y(3) + y(4) + y(5) + y(6))/5
        % ...
        
    end
    
else
    
    error('The span must be odd.')
    
end



% Examples of calling:
%
%
%
% signal_filt_back = Moving_average(signal_filt_back_original, 3); % Span = 3
% figure, plot( 1:1000,signal,'.-', 1:1000,signal_end,'.-', 1:1000,signal_filt_back,'.-' ), ...
% legend('noisy','true','restored','Location','Best'), grid on
% [ std(signal(10:991) - signal_end(10:991).'), std(signal_filt_back(10:991) - signal_end(10:991).') ]
% ans =
%     0.3517    0.1906
% % Let's check the output, by the way:
% [ signal_filt_back_original([1,2,3,4,10,807,997,998,999,1000]); ...
% signal_filt_back([1,2,3,4,10,807,997,998,999,1000]); ...
% [signal_filt_back_original(1), mean(signal_filt_back_original(1:3)),  mean(signal_filt_back_original(2:4)), ...
% mean(signal_filt_back_original(3:5)), mean(signal_filt_back_original(9:11)), ...
% mean(signal_filt_back_original(806:808)), mean(signal_filt_back_original(996:998)), ...
% mean(signal_filt_back_original(997:999)), mean(signal_filt_back_original(998:1000)), ...
% signal_filt_back_original(1000)] ]
% ans =
%   676.8902  676.8902  677.0937  676.8902  676.6868  675.0591  678.1109  678.3144  678.5178  678.8230
%   676.8902  676.9580  676.9580  676.9580  676.6868  674.9235  678.1788  678.3144  678.5517  678.8230
%   676.8902  676.9580  676.9580  676.9580  676.6868  674.9235  678.1788  678.3144  678.5517  678.8230
%
%
%
% signal_filt_back = Moving_average(signal_filt_back_original, 5); % Span = 5
% figure, plot( 1:1000,signal,'.-', 1:1000,signal_end,'.-', 1:1000,signal_filt_back,'.-' ), ...
% legend('noisy','true','restored','Location','Best'), grid on
% [ std(signal(10:991) - signal_end(10:991).'), std(signal_filt_back(10:991) - signal_end(10:991).') ]
% ans =
%     0.3517    0.1792
% % A very nice improvement.
% % Let's check the output, by the way:
% [ signal_filt_back_original([1,2,3,4,10,807,997,998,999,1000]); ...
% signal_filt_back([1,2,3,4,10,807,997,998,999,1000]); ...
% [signal_filt_back_original(1), mean(signal_filt_back_original(1:3)),  mean(signal_filt_back_original(1:5)), ...
% mean(signal_filt_back_original(2:6)), mean(signal_filt_back_original(8:12)), ...
% mean(signal_filt_back_original(805:809)), mean(signal_filt_back_original(995:999)), ...
% mean(signal_filt_back_original(996:1000)), mean(signal_filt_back_original(998:1000)), ...
% signal_filt_back_original(1000)] ]
% ans =
%   676.8902  676.8902  677.0937  676.8902  676.6868  675.0591  678.1109  678.3144  678.5178  678.8230
%   676.8902  676.9580  676.9309  676.9309  676.7274  674.8557  678.2330  678.3754  678.5517  678.8230
%   676.8902  676.9580  676.9309  676.9309  676.7274  674.8557  678.2330  678.3754  678.5517  678.8230
% % Correct.

