function [y1] = DLS(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 09-Jun-2015 13:48:37.
% 
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = 7xQ matrix, input #1
% and returns:
%   y = 1xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

  % ===== NEURAL NETWORK CONSTANTS =====
  
  % Input 1
  x1_step1_xoffset = [-1;-1;-1;-1;-1;-1;-1];
  x1_step1_gain = [1;1;1;1;1;1;1];
  x1_step1_ymin = -1;
  
  % Layer 1
  b1 = [-0.029898572525050474;-0.029898572525049912;-0.67600014570019651;-0.15516355794304071;0.029898572525050311;-0.011707096246225908;0.029898572525052361;-0.32807206092314062;0.2847799592751572;0.029898572525053912;-0.029898572525051736;-0.029898572525050529;0.029898572525050286;0.84001792961750599;-0.029898572525053665;-0.42305672314907322;0.029898572525052389;-0.029898572525050234;-0.029898572525050075;0.56559770797962661;-0.029898572525050151;0.029898572525048534;-0.02989857252505149;0.029898572525051237;-0.32975078319533807;-0.029898572525051872;-0.55560249490599345;-0.029898572525051754;0.029898572525052826;0.029898572525050796];
  IW1_1 = [0.042564153625735887 -0.066858123507853848 0.0077775577086581522 -0.005323627522814834 0.043562388180480957 0.0036243746002350328 -0.028582084840285699;0.042564153625735193 -0.066858123507853473 0.007777557708657519 -0.0053236275228144662 0.043562388180481026 0.0036243746002343775 -0.02858208484028359;-0.068987971189608144 -0.42780297285039492 -0.095097104321529985 -0.51165226392359242 0.88170686752889726 -0.75647128868152802 0.021079232999003321;-0.29520915112366403 -0.10395603386130807 0.077770987130983529 -0.45357114860267583 -0.49772812925894405 0.18274009980416647 0.36249518770188405;-0.042564153625735568 0.066858123507857178 -0.0077775577086559022 0.005323627522814337 -0.043562388180482484 -0.0036243746002352878 0.028582084840286265;-0.059247831336396099 -0.65862695831468587 0.18114539116652892 0.96446332719157135 0.33476279925818875 -0.14829766110996451 -0.088335750191168974;-0.042564153625736484 0.066858123507855929 -0.0077775577086593006 0.005323627522814553 -0.043562388180481797 -0.0036243746002356872 0.028582084840286726;-0.27861956562674151 0.42369661197667469 0.20937789643252008 0.31095737159796377 -0.43759695013180572 -0.49162939551064966 0.5069832109578799;-0.70234584610221729 -0.56730490686635304 0.013900608004551569 0.55933553665972291 -0.19376239763464098 0.36333795709374428 0.18542589512727853;-0.04256415362573783 0.066858123507856485 -0.0077775577086583482 0.0053236275228150075 -0.043562388180483295 -0.0036243746002352388 0.028582084840286133;0.042564153625732709 -0.066858123507851738 0.0077775577086581314 -0.0053236275228145313 0.043562388180479313 0.0036243746002349152 -0.028582084840283881;0.042564153625736567 -0.066858123507853084 0.0077775577086572701 -0.0053236275228147516 0.043562388180480818 0.0036243746002342274 -0.028582084840284676;-0.042564153625733681 0.066858123507850239 -0.0077775577086585286 0.0053236275228141358 -0.043562388180479257 -0.0036243746002346654 0.028582084840284964;0.23624193733849991 -0.17190687377333996 -0.54697403751501061 0.0054957805795313106 -0.20008919233023573 1.0709966794370132 -0.52848301570057099;0.04256415362573765 -0.066858123507856124 0.0077775577086588608 -0.005323627522814677 0.043562388180482983 0.0036243746002355063 -0.028582084840286522;0.49008415073738809 0.75385064904948285 -0.63174093966217659 0.48140712847124645 -0.55530193760242452 0.6290881838558291 -1.0316541696775898;-0.042564153625737455 0.066858123507856915 -0.0077775577086562943 0.0053236275228145582 -0.043562388180482997 -0.0036243746002355475 0.028582084840287649;0.042564153625733327 -0.066858123507851544 0.0077775577086584054 -0.005323627522813945 0.043562388180480374 0.0036243746002353073 -0.028582084840283434;0.042564153625734798 -0.066858123507852196 0.0077775577086580316 -0.0053236275228144472 0.043562388180480381 0.003624374600234459 -0.028582084840284027;-1.0706067765737191 0.15790200131323315 0.40938351942494849 0.16561068332151926 0.14470880708027858 -0.29684660010179398 1.0826811488451338;0.04256415362573629 -0.066858123507851835 0.0077775577086582831 -0.0053236275228144211 0.043562388180480957 0.0036243746002349647 -0.02858208484028477;-0.042564153625733903 0.066858123507852585 -0.0077775577086569032 0.005323627522814206 -0.043562388180480582 -0.0036243746002356911 0.028582084840285571;0.042564153625737011 -0.066858123507858053 0.007777557708658389 -0.0053236275228148366 0.04356238818048256 0.0036243746002353021 -0.028582084840288652;-0.042564153625736401 0.066858123507857872 -0.0077775577086569934 0.0053236275228148227 -0.043562388180482761 -0.0036243746002356447 0.028582084840286712;0.27870470080264864 -0.28741067336838111 0.79541948925639372 -0.092026683774707019 -0.44647576678071288 1.0205036373590577 -0.78485700302290162;0.042564153625735429 -0.066858123507854875 0.0077775577086573924 -0.0053236275228143656 0.043562388180481061 0.003624374600233818 -0.02858208484028579;0.21741153811052569 0.82599415972276302 -0.042390303838583956 -0.26350631018754833 -0.31735252982990025 0.52876219288728421 -1.757839030944186;0.042564153625734603 -0.066858123507853959 0.0077775577086586509 -0.0053236275228142789 0.043562388180481068 0.0036243746002353433 -0.028582084840284079;-0.042564153625736595 0.066858123507857248 -0.0077775577086597386 0.0053236275228141158 -0.043562388180482713 -0.0036243746002360498 0.02858208484028496;-0.042564153625734527 0.066858123507855693 -0.0077775577086577428 0.0053236275228148913 -0.043562388180481422 -0.0036243746002349265 0.02858208484028699];
  
  % Layer 2
  b2 = 0.30606179788380572;
  LW2_1 = [-0.10183710477862896 -0.10183710477862901 0.80216263164301294 0.71484980594753467 0.10183710477863275 0.70386999535326977 0.1018371047786302 0.61049610749939898 -0.93067518090724977 0.1018371047786344 -0.10183710477863092 -0.1018371047786282 0.10183710477862302 0.96371651837404193 -0.10183710477863443 0.93932652191835031 0.1018371047786342 -0.1018371047786254 -0.10183710477862812 1.0543205352334704 -0.10183710477863069 0.10183710477862654 -0.1018371047786345 0.10183710477863192 0.91205605195724582 -0.1018371047786282 -0.98862075547052775 -0.10183710477863459 0.10183710477863392 0.10183710477862964];
  
  % Output 1
  y1_step1_ymin = -1;
  y1_step1_gain = 0.722047727354778;
  y1_step1_xoffset = 0.6873;
  
  % ===== SIMULATION ========
  
  % Dimensions
  Q = size(x1,2); % samples
  
  % Input 1
  xp1 = mapminmax_apply(x1,x1_step1_gain,x1_step1_xoffset,x1_step1_ymin);
  
  % Layer 1
  a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);
  
  % Layer 2
  a2 = repmat(b2,1,Q) + LW2_1*a1;
  
  % Output 1
  y1 = mapminmax_reverse(a2,y1_step1_gain,y1_step1_xoffset,y1_step1_ymin);
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings_gain,settings_xoffset,settings_ymin)
  y = bsxfun(@minus,x,settings_xoffset);
  y = bsxfun(@times,y,settings_gain);
  y = bsxfun(@plus,y,settings_ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings_gain,settings_xoffset,settings_ymin)
  x = bsxfun(@minus,y,settings_ymin);
  x = bsxfun(@rdivide,x,settings_gain);
  x = bsxfun(@plus,x,settings_xoffset);
end
