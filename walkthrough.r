#' # h2o GLM Walk Through
#' Taken from here https://github.com/h2oai/h2o-3/blob/master/h2o-docs/src/booklets/v2_2015/PDFs/online/GLM_Vignette.pdf
#+

library(h2o)
h2o.init(nthreads = -2)

#' ### Differences between `glm` and `h2o.glm`
#' 
#' * the `x`, and `y` arguments are names or positions of the variables to use and predict. 
#' * you can fit penalized models in `h2o.glm`. In fact this is the default behavior. To not use a penalty you must set 'lambda' to 0. 
#' * You can also do CV right in `h2o.glm`. You can supply the fold id's or method to generate them. 
#' * You specify interactions with the `interactions` parameter but I'm not sure exactly how that works. 
#' * you can also mean impute missing values directly with `missing_values_handling`
#' 
#' #### Plain Ol' Regression
path <- system.file("extdata", "prostate.csv", package = "h2o")
h2o_df <- h2o.importFile(path)
gaussian.fit <- h2o.glm(y = "VOL", 
                        x = c("AGE", "RACE", "PSA", "GLEASON"), 
                        training_frame = h2o_df,
                        family = "gaussian", 
                        lambda = 0)

#' #### Logistic Regression
#' Apparently the y variable needs to be a factor
h2o_df_logistic <- h2o.importFile(path)
is.factor(h2o_df_logistic$CAPSULE)
h2o_df_logistic$CAPSULE <- as.factor(h2o_df_logistic$CAPSULE)
is.factor(h2o_df_logistic$CAPSULE)
binomial.fit <- h2o.glm(y = "CAPSULE",
                        x = c("AGE", "RACE", "PSA", "GLEASON"),
                        training_frame = h2o_df_logistic,
                        family = "binomial",
                        lambda = 0)


