function Y=sub_output_pred(ker,trnX,tstX,beta,cc)

H_test=sub_kernel_matrix(ker,tstX,trnX,cc);

Y=H_test*beta;

