test_that("frailtyPenal returns an object", {
  data("readmission", package = "frailtypack")
  
  fit <- frailtyPenal(
    Surv(time, event) ~ cluster(id),
    data = readmission,
    n.knots = 6,
    kappa = 1000
  )
  
  expect_s3_class(fit, "frailtyPenal")
})

