context(cityweather)

test_that('The first argument should be a city name',{
 expect_error(cityweather$new('Na'))
})

test_that('The API key should be valid',{
  expect_error(status_code(cityweather$new('linkoping',key = '3c656bd3014279a8f41b')))
})

