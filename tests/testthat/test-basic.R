test_that("slope handles numeric, character and factor variables", {
  x_num <- c(0, 1, 0, 1)
  x_char <- c("A", "B", "A", "B")
  x_factor <- factor(c("A", "B", "A", "B"))
  
  expect_identical(slope(x_num), x_num)
  expect_identical(slope(x_char), x_char)
  expect_identical(slope(x_factor), x_factor)
})

test_that("frailtyPenal fits a model on readmission data", {
  data(readmission, package = "frailtypack")
  
  mod <- frailtyPenal(
    survival::Surv(time, event) ~ cluster(id) + dukes + charlson,
    data = readmission,
    n.knots = 6,
    kappa = 5000,
    recurrentAG = FALSE
  )
  
  expect_s3_class(mod, "frailtyPenal")
  expect_true(all(is.finite(mod$coef)))
})

expect_equal(
  unname(mod$coef),
  c(0.3354923, 1.1057064, 0.5049202, 0.4171215),
  tolerance = 0.01
)
