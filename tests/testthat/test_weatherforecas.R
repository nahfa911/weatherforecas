context("weatherforecas")




test_that("Error messages are returned for erronous input", {
  expect_error(weatherdata <- cityweather$new(1))
  expect_error(weatherdata <- cityweather$new(test))
  expect_error(weatherdata <- cityweather$new("test"))
})

test_that("class is correct", {
  weatherdata <- cityweather$new("stockholm")

  expect_true(class(weatherdata)[1] == "cityweather")
  expect_true(class(weatherdata$content) == "list")
  expect_true(class(weatherdata$content$city) == "list")
  expect_true(class(weatherdata$content$list) == "data.frame")
})

test_that("output is correct", {

  weatherdata <- cityweather$new("stockholm")

  expect_true(weatherdata$content$city$name == "Stockholm")
  expect_true(weatherdata$content$city$coord$lat == "59.3251")
  expect_true(weatherdata$content$city$coord$lon == "18.0711")

})
