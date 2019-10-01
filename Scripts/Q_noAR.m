function Q = Q_noAR(OPP, Q_bar)
%Computes the value of the bloodflow in the retinal vessels in absence of
%an autoregulation mechanism in the arterioles.
%At this stage, it is computed thanks to the graph A2.b of art1_CMEB.
%
%The datapoints have been collected thanks to www.graphreader.com

OPPs_q = [62.13 54.896 47.702 43.337 33.516]; % Sampled data for OPP in
                                              % the graph

Y_q = [0.721 0.859 1.005 1.088 1.284]; % Corresponding values of the normalized
                                       % bloodflow from the same graph.
                                       % Y(OPP) = Q(OPP)/Q_bar

Q = Q_bar * interp1(OPPs_q,Y_q, OPP, 'linear', 'extrap');

end