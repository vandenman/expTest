
values <- matrix(c(
  -1e6, 1e6,
  -1e4, 1e4,
  -1e3, 1e3,
  -1e2, 1e2,
  -1e1, 1e1,
  -1e-3, 1e-3
), ncol = 2, byrow = TRUE)
size <- 1E6L

for (i in seq_len(nrow(values))) {
  from <- values[i, 1]
  to   <- values[i, 2]
  cat("i = ", i, ", Testing range: ", from, " to ", to, "\n")
  test_values <- seq(from, to, length.out = size)
  y_R <- exp(test_values)
  y_R2 <- expTest:::rcpp_ieee754_exp(test_values)
  result <- all.equal(y_R, y_R2)

  abs_error = max(abs(y_R - y_R2),         na.rm = TRUE)
  rel_error = max(abs((y_R - y_R2) / y_R), na.rm = TRUE)

  cat("i = ", i, ", All.equal = ", isTRUE(result),
      " max abs error: ", sprintf("%.8g", abs_error),
      " max rel error: ", sprintf("%.8g", rel_error),
      "\n", sep = "")
}

values <- matrix(c(
  1e10, 1e30,
  1e04, 1e09,
  1e01, 1e03,
  1e-2, 1e01,
  1e-5, 1e-3,
  1e-20, 1e-6
), ncol = 2, byrow = TRUE)
size <- 1E6L

for (i in seq_len(nrow(values))) {
  from <- values[i, 1]
  to   <- values[i, 2]
  cat("i = ", i, ", Testing range: ", from, " to ", to, "\n")
  test_values <- seq(from, to, length.out = size)
  y_R <- log(test_values)
  y_R2 <- expTest:::rcpp_ieee754_log(test_values)
  result <- all.equal(y_R, y_R2)

  abs_error = max(abs(y_R - y_R2),         na.rm = TRUE)
  rel_error = max(abs((y_R - y_R2) / y_R), na.rm = TRUE)

  cat("i = ", i, ", All.equal = ", isTRUE(result),
      " max abs error:", sprintf("%.8g", abs_error),
      " max rel error:", sprintf("%.8g", rel_error),
      "\n")
}

bench_press <- bench::press(
  size = 3L:6L,
  {
    n <- 10^size
    x = runif(n)
    bench::mark(
      exp = exp(x),
      expTest = expTest:::rcpp_ieee754_exp(x)
    )
  }
)
summary(bench_press)[, 1:10]

# R version 4.5.1 (2025-06-13)
# Platform: x86_64-pc-linux-gnu
# Running under: Manjaro Linux
# A tibble: 8 × 10
# expression  size      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time
# <bch:expr> <int> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm>
#   1 exp            3   3.99µs   4.12µs   228254.    7.86KB    45.7   9998     2     43.8ms
# 2 expTest        3   9.36µs   9.76µs    99494.    7.86KB     9.95  9999     1    100.5ms
# 3 exp            4   38.7µs  40.05µs    24668.   78.17KB    32.1   9987    13    404.9ms
# 4 expTest        4  86.86µs  87.86µs    11204.   78.17KB    14.8   5313     7    474.2ms
# 5 exp            5  388.1µs 399.64µs     2421.   781.3KB    31.6   1073    14    443.2ms
# 6 expTest        5 855.69µs 859.12µs     1152.   781.3KB    14.9    541     7    469.6ms
# 7 exp            6   4.03ms   4.81ms      216.    7.63MB    75.2     69    24    318.9ms
# 8 expTest        6   8.71ms   9.44ms      108.    7.63MB    34.1     38    12    352.1ms
