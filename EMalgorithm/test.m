function []=test()
load('nips');
K=10;
[pro_w_given_z,pro_d_given_z,PI]=mycluster2(raw_count,K);
show_topics(pro_w_given_z, wl,fid)


end