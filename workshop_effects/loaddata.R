
R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin20 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[R.app GUI 1.79 (8160) aarch64-apple-darwin20]

[History restored from /Users/dc/.Rapp.history]

> witness<-read.csv("/Users/dc/test_stuff/analysis_factor/datasets_irc_workshop/witness.csv")
> colnames(witness)
 [1] "ID"       "SEX_WITN" "AGE_WITN" "SEX_PART" "ACCURATE" "HONEST"   "MEMORY"   "COGNITIV" "SENIOR_S" "SENIOR_H" "ACC_Cen"  "AGEW_Cen" "COG_Cen"  "HON_Cen"  "MEM_Cen"  "SENH_Cen" "SENS_Cen"
> sapply(witness,class)
       ID  SEX_WITN  AGE_WITN  SEX_PART  ACCURATE    HONEST    MEMORY  COGNITIV  SENIOR_S  SENIOR_H   ACC_Cen  AGEW_Cen   COG_Cen   HON_Cen   MEM_Cen  SENH_Cen  SENS_Cen 
"integer" "integer" "integer" "integer" "integer" "integer" "integer" "integer" "integer" "integer" "numeric" "integer" "numeric" "numeric" "numeric" "numeric" "numeric" 
> data<-witness(, c(5,3,8,6,7,10,9))
Error in witness(, c(5, 3, 8, 6, 7, 10, 9)) : 
  could not find function "witness"
> data<-witness[, c(5,3,8,6,7,10,9)]
> cor(data,use="complete.obs")
            ACCURATE     AGE_WITN    COGNITIV      HONEST       MEMORY     SENIOR_H    SENIOR_S
ACCURATE  1.00000000  0.120769571  0.47600533  0.38962123  0.598772609 -0.070736556  0.04781964
AGE_WITN  0.12076957  1.000000000  0.04014397  0.15753348  0.003626903 -0.061679174  0.01600472
COGNITIV  0.47600533  0.040143967  1.00000000  0.36821091  0.555277286  0.001492170 -0.01978309
HONEST    0.38962123  0.157533483  0.36821091  1.00000000  0.385802722 -0.139249058 -0.07529522
MEMORY    0.59877261  0.003626903  0.55527729  0.38580272  1.000000000  0.008784244 -0.01873555
SENIOR_H -0.07073656 -0.061679174  0.00149217 -0.13924906  0.008784244  1.000000000  0.49955121
SENIOR_S  0.04781964  0.016004722 -0.01978309 -0.07529522 -0.018735549  0.499551211  1.00000000
> lm(witness$ACCURATE~witness$AGE_WITN, data=witness)

Call:
lm(formula = witness$ACCURATE ~ witness$AGE_WITN, data = witness)

Coefficients:
     (Intercept)  witness$AGE_WITN  
         3.45100           0.01058  

> lm(witness$ACCURATE~witness$AGE_WITN+witness$COGNITIV+witness$HONEST+witness$MEMORY+witness$SENIOR_H+witness$SENIOR_S, data=witness)

Call:
lm(formula = witness$ACCURATE ~ witness$AGE_WITN + witness$COGNITIV + 
    witness$HONEST + witness$MEMORY + witness$SENIOR_H + witness$SENIOR_S, 
    data = witness)

Coefficients:
     (Intercept)  witness$AGE_WITN  witness$COGNITIV    witness$HONEST    witness$MEMORY  witness$SENIOR_H  witness$SENIOR_S  
       -0.064697          0.006461          0.173565          0.155676          0.480034         -0.045838          0.052646  

> model<-lm(witness$ACCURATE~witness$AGE_WITN+witness$COGNITIV+witness$HONEST+witness$MEMORY+witness$SENIOR_H+witness$SENIOR_S, data=witness)
> summary(model)

Call:
lm(formula = witness$ACCURATE ~ witness$AGE_WITN + witness$COGNITIV + 
    witness$HONEST + witness$MEMORY + witness$SENIOR_H + witness$SENIOR_S, 
    data = witness)

Residuals:
     Min       1Q   Median       3Q      Max 
-2.79125 -0.53540  0.00283  0.56504  2.32801 

Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)      -0.064697   0.500390  -0.129  0.89725    
witness$AGE_WITN  0.006461   0.004179   1.546  0.12362    
witness$COGNITIV  0.173565   0.063879   2.717  0.00714 ** 
witness$HONEST    0.155676   0.071037   2.191  0.02953 *  
witness$MEMORY    0.480034   0.068770   6.980 3.92e-11 ***
witness$SENIOR_H -0.045838   0.024553  -1.867  0.06332 .  
witness$SENIOR_S  0.052646   0.025465   2.067  0.03994 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.848 on 207 degrees of freedom
  (6 observations deleted due to missingness)
Multiple R-squared:  0.4302,	Adjusted R-squared:  0.4137 
F-statistic: 26.05 on 6 and 207 DF,  p-value: < 2.2e-16

> install.packages("car")
--- Please select a CRAN mirror for use in this session ---
also installing the dependencies ‘diffobj’, ‘rematch2’, ‘fansi’, ‘pkgconfig’, ‘utf8’, ‘brio’, ‘praise’, ‘waldo’, ‘ellipsis’, ‘generics’, ‘tibble’, ‘tidyr’, ‘pillar’, ‘tidyselect’, ‘testthat’, ‘colorspace’, ‘broom’, ‘dplyr’, ‘numDeriv’, ‘SparseM’, ‘MatrixModels’, ‘minqa’, ‘nloptr’, ‘Rcpp’, ‘RcppEigen’, ‘farver’, ‘labeling’, ‘munsell’, ‘RColorBrewer’, ‘viridisLite’, ‘carData’, ‘abind’, ‘pbkrtest’, ‘quantreg’, ‘lme4’, ‘scales’

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/diffobj_0.3.5.tgz'
Content type 'application/octet-stream' length 1011109 bytes (987 KB)
==================================================
downloaded 987 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/rematch2_2.1.2.tgz'
Content type 'application/octet-stream' length 43890 bytes (42 KB)
==================================================
downloaded 42 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/fansi_1.0.4.tgz'
Content type 'application/octet-stream' length 379598 bytes (370 KB)
==================================================
downloaded 370 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/pkgconfig_2.0.3.tgz'
Content type 'application/octet-stream' length 17697 bytes (17 KB)
==================================================
downloaded 17 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/utf8_1.2.3.tgz'
Content type 'application/octet-stream' length 208793 bytes (203 KB)
==================================================
downloaded 203 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/brio_1.1.3.tgz'
Content type 'application/octet-stream' length 43835 bytes (42 KB)
==================================================
downloaded 42 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/praise_1.0.0.tgz'
Content type 'application/octet-stream' length 16076 bytes (15 KB)
==================================================
downloaded 15 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/waldo_0.4.0.tgz'
Content type 'application/octet-stream' length 99881 bytes (97 KB)
==================================================
downloaded 97 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/ellipsis_0.3.2.tgz'
Content type 'application/octet-stream' length 38646 bytes (37 KB)
==================================================
downloaded 37 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/generics_0.1.3.tgz'
Content type 'application/octet-stream' length 78238 bytes (76 KB)
==================================================
downloaded 76 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/tibble_3.1.8.tgz'
Content type 'application/octet-stream' length 724320 bytes (707 KB)
==================================================
downloaded 707 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/tidyr_1.3.0.tgz'
Content type 'application/octet-stream' length 1337026 bytes (1.3 MB)
==================================================
downloaded 1.3 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/pillar_1.8.1.tgz'
Content type 'application/octet-stream' length 676781 bytes (660 KB)
==================================================
downloaded 660 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/tidyselect_1.2.0.tgz'
Content type 'application/octet-stream' length 220687 bytes (215 KB)
==================================================
downloaded 215 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/testthat_3.1.6.tgz'
Content type 'application/octet-stream' length 2922981 bytes (2.8 MB)
==================================================
downloaded 2.8 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/colorspace_2.1-0.tgz'
Content type 'application/octet-stream' length 2621291 bytes (2.5 MB)
==================================================
downloaded 2.5 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/broom_1.0.3.tgz'
Content type 'application/octet-stream' length 1855943 bytes (1.8 MB)
==================================================
downloaded 1.8 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/dplyr_1.1.0.tgz'
Content type 'application/octet-stream' length 1571805 bytes (1.5 MB)
==================================================
downloaded 1.5 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/numDeriv_2016.8-1.1.tgz'
Content type 'application/octet-stream' length 113230 bytes (110 KB)
==================================================
downloaded 110 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/SparseM_1.81.tgz'
Content type 'application/octet-stream' length 1096247 bytes (1.0 MB)
==================================================
downloaded 1.0 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/MatrixModels_0.5-1.tgz'
Content type 'application/octet-stream' length 434920 bytes (424 KB)
==================================================
downloaded 424 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/minqa_1.2.5.tgz'
Content type 'application/octet-stream' length 338803 bytes (330 KB)
==================================================
downloaded 330 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/nloptr_2.0.3.tgz'
Content type 'application/octet-stream' length 1791184 bytes (1.7 MB)
==================================================
downloaded 1.7 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/Rcpp_1.0.10.tgz'
Content type 'application/octet-stream' length 3270380 bytes (3.1 MB)
==================================================
downloaded 3.1 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/RcppEigen_0.3.3.9.3.tgz'
Content type 'application/octet-stream' length 4626500 bytes (4.4 MB)
==================================================
downloaded 4.4 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/farver_2.1.1.tgz'
Content type 'application/octet-stream' length 1933421 bytes (1.8 MB)
==================================================
downloaded 1.8 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/labeling_0.4.2.tgz'
Content type 'application/octet-stream' length 60132 bytes (58 KB)
==================================================
downloaded 58 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/munsell_0.5.0.tgz'
Content type 'application/octet-stream' length 241653 bytes (235 KB)
==================================================
downloaded 235 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/RColorBrewer_1.1-3.tgz'
Content type 'application/octet-stream' length 52946 bytes (51 KB)
==================================================
downloaded 51 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/viridisLite_0.4.1.tgz'
Content type 'application/octet-stream' length 1297181 bytes (1.2 MB)
==================================================
downloaded 1.2 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/carData_3.0-5.tgz'
Content type 'application/octet-stream' length 1820950 bytes (1.7 MB)
==================================================
downloaded 1.7 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/abind_1.4-5.tgz'
Content type 'application/octet-stream' length 61342 bytes (59 KB)
==================================================
downloaded 59 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/pbkrtest_0.5.2.tgz'
Content type 'application/octet-stream' length 186846 bytes (182 KB)
==================================================
downloaded 182 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/quantreg_5.94.tgz'
Content type 'application/octet-stream' length 1649063 bytes (1.6 MB)
==================================================
downloaded 1.6 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/lme4_1.1-31.tgz'
Content type 'application/octet-stream' length 7010500 bytes (6.7 MB)
==================================================
downloaded 6.7 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/scales_1.2.1.tgz'
Content type 'application/octet-stream' length 610060 bytes (595 KB)
==================================================
downloaded 595 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/car_3.1-1.tgz'
Content type 'application/octet-stream' length 1703621 bytes (1.6 MB)
==================================================
downloaded 1.6 MB


The downloaded binary packages are in
	/var/folders/fq/80jq913s6551wcf2tpmpj3hh0000gn/T//RtmpsJGed9/downloaded_packages
> library(car)
Loading required package: carData
> vif(model)
witness$AGE_WITN witness$COGNITIV   witness$HONEST   witness$MEMORY witness$SENIOR_H witness$SENIOR_S 
        1.034128         1.508129         1.286461         1.538960         1.364337         1.337666 
> birth<-read.csv("/Users/dc/test_stuff/analysis_factor/datasets_irc_workshop/BIRTH.csv")
> colnames(birth)
 [1] "bfacil"          "mage"            "restatus"        "mrace"           "married"         "unmarried"       "meduc"           "fage"            "frace"           "feduc"           "priorlive"       "priordead"       "birth_order_cat" "last_preg"      
[15] "precare"         "precare_cat"     "previs"          "previs_rec"      "cig_0"           "cig_1"           "cig_2"           "cig_3"           "cig_prior"       "cig_1st"         "cig_2nd"         "cig_3rd"         "bmi"             "bmi_cat"        
[29] "pre_wgt"         "del_wgt"         "wtgain"          "wtgain_cat"      "deliver_method"  "attendant"       "payment"         "apgar5"          "apgar10"         "gestation"       "gestrec10"       "gest_cat2"       "down_syn"        "sex"            
[43] "wic"             "bfed"            "cig_rec"         "bwt"             "bwt_pnds"       
> sapply(birth,class)
         bfacil            mage        restatus           mrace         married       unmarried           meduc            fage           frace           feduc       priorlive       priordead birth_order_cat       last_preg         precare     precare_cat 
      "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer" 
         previs      previs_rec           cig_0           cig_1           cig_2           cig_3       cig_prior         cig_1st         cig_2nd         cig_3rd             bmi         bmi_cat         pre_wgt         del_wgt          wtgain      wtgain_cat 
      "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "numeric"       "integer"       "integer"       "integer"       "integer"       "integer" 
 deliver_method       attendant         payment          apgar5         apgar10       gestation       gestrec10       gest_cat2        down_syn             sex             wic            bfed         cig_rec             bwt        bwt_pnds 
      "integer"       "integer"       "integer"       "integer"     "character"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "integer"       "numeric"       "numeric" 
> model_birth<-lm(birth$bwt_pnds~birth$pre_wgt+birth$wtgain+birth$del_wgt, data=birth)
> summary(model_birth)

Call:
lm(formula = birth$bwt_pnds ~ birth$pre_wgt + birth$wtgain + 
    birth$del_wgt, data = birth)

Residuals:
    Min      1Q  Median      3Q     Max 
-6.9088 -0.6295  0.1248  0.7834  3.9624 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)    6.10195    0.18365  33.226   <2e-16 ***
birth$pre_wgt  0.03749    0.04148   0.904    0.366    
birth$wtgain   0.05243    0.04196   1.250    0.212    
birth$del_wgt -0.03391    0.04146  -0.818    0.414    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.266 on 1196 degrees of freedom
Multiple R-squared:  0.04619,	Adjusted R-squared:  0.04379 
F-statistic:  19.3 on 3 and 1196 DF,  p-value: 3.159e-12

> birth_small=select(birth,bwt_pnds,pre_wgt,wtgain,del_wgt)
Error in select(birth, bwt_pnds, pre_wgt, wtgain, del_wgt) : 
  could not find function "select"
> install.packages("tidyverse")
also installing the dependencies ‘sys’, ‘bit’, ‘sass’, ‘cachem’, ‘memoise’, ‘base64enc’, ‘fastmap’, ‘rappdirs’, ‘rematch’, ‘askpass’, ‘bit64’, ‘prettyunits’, ‘bslib’, ‘htmltools’, ‘jquerylib’, ‘tinytex’, ‘assertthat’, ‘blob’, ‘DBI’, ‘data.table’, ‘gtable’, ‘isoband’, ‘gargle’, ‘uuid’, ‘cellranger’, ‘curl’, ‘ids’, ‘mime’, ‘openssl’, ‘timechange’, ‘clipr’, ‘vroom’, ‘tzdb’, ‘progress’, ‘rmarkdown’, ‘selectr’, ‘dbplyr’, ‘dtplyr’, ‘forcats’, ‘ggplot2’, ‘googledrive’, ‘googlesheets4’, ‘haven’, ‘hms’, ‘httr’, ‘lubridate’, ‘modelr’, ‘readr’, ‘readxl’, ‘reprex’, ‘rstudioapi’, ‘rvest’

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/sys_3.4.1.tgz'
Content type 'application/octet-stream' length 50670 bytes (49 KB)
==================================================
downloaded 49 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/bit_4.0.5.tgz'
Content type 'application/octet-stream' length 1233784 bytes (1.2 MB)
==================================================
downloaded 1.2 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/sass_0.4.5.tgz'
Content type 'application/octet-stream' length 2408956 bytes (2.3 MB)
==================================================
downloaded 2.3 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/cachem_1.0.6.tgz'
Content type 'application/octet-stream' length 67650 bytes (66 KB)
==================================================
downloaded 66 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/memoise_2.0.1.tgz'
Content type 'application/octet-stream' length 47932 bytes (46 KB)
==================================================
downloaded 46 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/base64enc_0.1-3.tgz'
Content type 'application/octet-stream' length 33622 bytes (32 KB)
==================================================
downloaded 32 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/fastmap_1.1.0.tgz'
Content type 'application/octet-stream' length 178206 bytes (174 KB)
==================================================
downloaded 174 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/rappdirs_0.3.3.tgz'
Content type 'application/octet-stream' length 46800 bytes (45 KB)
==================================================
downloaded 45 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/rematch_1.0.1.tgz'
Content type 'application/octet-stream' length 12231 bytes (11 KB)
==================================================
downloaded 11 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/askpass_1.1.tgz'
Content type 'application/octet-stream' length 22910 bytes (22 KB)
==================================================
downloaded 22 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/bit64_4.0.5.tgz'
Content type 'application/octet-stream' length 560611 bytes (547 KB)
==================================================
downloaded 547 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/prettyunits_1.1.1.tgz'
Content type 'application/octet-stream' length 34701 bytes (33 KB)
==================================================
downloaded 33 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/bslib_0.4.2.tgz'
Content type 'application/octet-stream' length 4832719 bytes (4.6 MB)
==================================================
downloaded 4.6 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/htmltools_0.5.4.tgz'
Content type 'application/octet-stream' length 347889 bytes (339 KB)
==================================================
downloaded 339 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/jquerylib_0.1.4.tgz'
Content type 'application/octet-stream' length 526050 bytes (513 KB)
==================================================
downloaded 513 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/tinytex_0.44.tgz'
Content type 'application/octet-stream' length 133453 bytes (130 KB)
==================================================
downloaded 130 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/assertthat_0.2.1.tgz'
Content type 'application/octet-stream' length 52186 bytes (50 KB)
==================================================
downloaded 50 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/blob_1.2.3.tgz'
Content type 'application/octet-stream' length 45895 bytes (44 KB)
==================================================
downloaded 44 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/DBI_1.1.3.tgz'
Content type 'application/octet-stream' length 754245 bytes (736 KB)
==================================================
downloaded 736 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/data.table_1.14.6.tgz'
Content type 'application/octet-stream' length 2352436 bytes (2.2 MB)
==================================================
downloaded 2.2 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/gtable_0.3.1.tgz'
Content type 'application/octet-stream' length 159185 bytes (155 KB)
==================================================
downloaded 155 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/isoband_0.2.7.tgz'
Content type 'application/octet-stream' length 1870161 bytes (1.8 MB)
==================================================
downloaded 1.8 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/gargle_1.3.0.tgz'
Content type 'application/octet-stream' length 582362 bytes (568 KB)
==================================================
downloaded 568 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/uuid_1.1-0.tgz'
Content type 'application/octet-stream' length 71153 bytes (69 KB)
==================================================
downloaded 69 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/cellranger_1.1.0.tgz'
Content type 'application/octet-stream' length 100745 bytes (98 KB)
==================================================
downloaded 98 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/curl_5.0.0.tgz'
Content type 'application/octet-stream' length 776462 bytes (758 KB)
==================================================
downloaded 758 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/ids_1.0.1.tgz'
Content type 'application/octet-stream' length 119183 bytes (116 KB)
==================================================
downloaded 116 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/mime_0.12.tgz'
Content type 'application/octet-stream' length 36161 bytes (35 KB)
==================================================
downloaded 35 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/openssl_2.0.5.tgz'
Content type 'application/octet-stream' length 2480785 bytes (2.4 MB)
==================================================
downloaded 2.4 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/timechange_0.2.0.tgz'
Content type 'application/octet-stream' length 884285 bytes (863 KB)
==================================================
downloaded 863 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/clipr_0.8.0.tgz'
Content type 'application/octet-stream' length 50341 bytes (49 KB)
==================================================
downloaded 49 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/vroom_1.6.1.tgz'
Content type 'application/octet-stream' length 3119693 bytes (3.0 MB)
==================================================
downloaded 3.0 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/tzdb_0.3.0.tgz'
Content type 'application/octet-stream' length 1216863 bytes (1.2 MB)
==================================================
downloaded 1.2 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/progress_1.2.2.tgz'
Content type 'application/octet-stream' length 83510 bytes (81 KB)
==================================================
downloaded 81 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/rmarkdown_2.20.tgz'
Content type 'application/octet-stream' length 3658239 bytes (3.5 MB)
==================================================
downloaded 3.5 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/selectr_0.4-2.tgz'
Content type 'application/octet-stream' length 488388 bytes (476 KB)
==================================================
downloaded 476 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/dbplyr_2.3.0.tgz'
Content type 'application/octet-stream' length 1072435 bytes (1.0 MB)
==================================================
downloaded 1.0 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/dtplyr_1.2.2.tgz'
Content type 'application/octet-stream' length 328423 bytes (320 KB)
==================================================
downloaded 320 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/forcats_1.0.0.tgz'
Content type 'application/octet-stream' length 422491 bytes (412 KB)
==================================================
downloaded 412 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/ggplot2_3.4.0.tgz'
Content type 'application/octet-stream' length 4211193 bytes (4.0 MB)
==================================================
downloaded 4.0 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/googledrive_2.0.0.tgz'
Content type 'application/octet-stream' length 1864229 bytes (1.8 MB)
==================================================
downloaded 1.8 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/googlesheets4_1.0.1.tgz'
Content type 'application/octet-stream' length 489109 bytes (477 KB)
==================================================
downloaded 477 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/haven_2.5.1.tgz'
Content type 'application/octet-stream' length 1068680 bytes (1.0 MB)
==================================================
downloaded 1.0 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/hms_1.1.2.tgz'
Content type 'application/octet-stream' length 97473 bytes (95 KB)
==================================================
downloaded 95 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/httr_1.4.4.tgz'
Content type 'application/octet-stream' length 504652 bytes (492 KB)
==================================================
downloaded 492 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/lubridate_1.9.1.tgz'
Content type 'application/octet-stream' length 979659 bytes (956 KB)
==================================================
downloaded 956 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/modelr_0.1.10.tgz'
Content type 'application/octet-stream' length 200927 bytes (196 KB)
==================================================
downloaded 196 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/readr_2.1.3.tgz'
Content type 'application/octet-stream' length 1960780 bytes (1.9 MB)
==================================================
downloaded 1.9 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/readxl_1.4.1.tgz'
Content type 'application/octet-stream' length 1545432 bytes (1.5 MB)
==================================================
downloaded 1.5 MB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/reprex_2.0.2.tgz'
Content type 'application/octet-stream' length 495855 bytes (484 KB)
==================================================
downloaded 484 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/rstudioapi_0.14.tgz'
Content type 'application/octet-stream' length 292533 bytes (285 KB)
==================================================
downloaded 285 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/rvest_1.0.3.tgz'
Content type 'application/octet-stream' length 211149 bytes (206 KB)
==================================================
downloaded 206 KB

trying URL 'https://cran.microsoft.com/bin/macosx/big-sur-arm64/contrib/4.2/tidyverse_1.3.2.tgz'
Content type 'application/octet-stream' length 425892 bytes (415 KB)
==================================================
downloaded 415 KB


The downloaded binary packages are in
	/var/folders/fq/80jq913s6551wcf2tpmpj3hh0000gn/T//RtmpsJGed9/downloaded_packages
> library(tidyverse)
── Attaching packages ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.2 ──
✔ ggplot2 3.4.0     ✔ purrr   1.0.1
✔ tibble  3.1.8     ✔ dplyr   1.1.0
✔ tidyr   1.3.0     ✔ stringr 1.5.0
✔ readr   2.1.3     ✔ forcats 1.0.0
── Conflicts ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
✖ dplyr::recode() masks car::recode()
✖ purrr::some()   masks car::some()
> birth_small=select(birth,bwt_pnds,pre_wgt,wtgain,del_wgt)
> colnames(birth_small)
[1] "bwt_pnds" "pre_wgt"  "wtgain"   "del_wgt" 
> corr(birth_small, use="complete.obs")
Error in corr(birth_small, use = "complete.obs") : 
  could not find function "corr"
> cor(birth_small, use="complete.obs")
           bwt_pnds     pre_wgt     wtgain   del_wgt
bwt_pnds 1.00000000  0.06337767  0.1847228 0.1342839
pre_wgt  0.06337767  1.00000000 -0.2235245 0.9277806
wtgain   0.18472279 -0.22352452  1.0000000 0.1556489
del_wgt  0.13428386  0.92778064  0.1556489 1.0000000
> res_model<-resid(model)
> qqnorm(res_model)
> qqline(res_model)
> res_model_birth<-resid(model_birth)
> qqnorm(res_model_birth)
> qqline(res_model_birth)
skewness(res_model_birth)
kurtosis(res_model_birth)
jarque.test(res_model_birth)