bench_press_exp <- bench::press(
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
summary(bench_press_exp)[, 1:10]

# R version 4.5.1 (2025-06-13)
# Platform: x86_64-pc-linux-gnu
# Running under: Manjaro Linux
# A tibble: 8 × 10
# expression  size      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time
# <bch:expr> <int> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm>
# 1 exp            3   3.99µs   4.12µs   228254.    7.86KB    45.7   9998     2     43.8ms
# 2 expTest        3   9.36µs   9.76µs    99494.    7.86KB     9.95  9999     1    100.5ms
# 3 exp            4   38.7µs  40.05µs    24668.   78.17KB    32.1   9987    13    404.9ms
# 4 expTest        4  86.86µs  87.86µs    11204.   78.17KB    14.8   5313     7    474.2ms
# 5 exp            5  388.1µs 399.64µs     2421.   781.3KB    31.6   1073    14    443.2ms
# 6 expTest        5 855.69µs 859.12µs     1152.   781.3KB    14.9    541     7    469.6ms
# 7 exp            6   4.03ms   4.81ms      216.    7.63MB    75.2     69    24    318.9ms
# 8 expTest        6   8.71ms   9.44ms      108.    7.63MB    34.1     38    12    352.1ms

# R version 4.5.1 (2025-06-13 ucrt)
# Platform: x86_64-w64-mingw32/x64
# Running under: Windows 11 x64 (build 22631)
# A tibble: 8 × 10
# expression  size      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time
# <bch:expr> <int> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm>
# 1 exp            3     40µs   41.1µs   22908.     7.86KB     2.29  9999     1      436ms
# 2 expTest        3   12.1µs   13.6µs   66978.     7.86KB     6.70  9999     1      149ms
# 3 exp            4  404.2µs  418.6µs    2346.    78.17KB     4.22  1111     2      474ms
# 4 expTest        4  116.9µs  134.1µs    7286.    78.17KB     8.89  3280     4      450ms
# 5 exp            5   4.15ms   4.18ms     235.    781.3KB     2.04   115     1      490ms
# 6 expTest        5   1.27ms   1.36ms     719.    781.3KB    11.3    319     5      444ms
# 7 exp            6  41.41ms  43.04ms      23.3    7.63MB     8.74     8     3      343ms
# 8 expTest        6  12.53ms  12.96ms      74.6    7.63MB    12.4     30     5      402ms
bench_press_log <- bench::press(
  size = 3L:6L,
  {
    n <- 10^size
    x = runif(n, 1e-6)
    bench::mark(
      exp = log(x),
      expTest = expTest:::rcpp_ieee754_log(x)
    )
  }
)
summary(bench_press_log)[, 1:10]

# R version 4.5.1 (2025-06-13)
# Platform: x86_64-pc-linux-gnu
# Running under: Manjaro Linux
# # A tibble: 8 × 10
# expression  size      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time
# <bch:expr> <int> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm>
# 1 exp            3   4.93µs   5.01µs   181793.    7.86KB     36.4  9998     2       55ms
# 2 expTest        3   9.29µs   9.61µs   101719.    7.86KB     20.3  9998     2     98.3ms
# 3 exp            4  46.69µs  48.08µs    20507.   78.17KB     46.6  8806    20    429.4ms
# 4 expTest        4  87.15µs  87.81µs    11029.   78.17KB     24.8  4899    11    444.2ms
# 5 exp            5 462.31µs  490.1µs     1825.   781.3KB     22.1   826    10    452.6ms
# 6 expTest        5 863.67µs 878.18µs     1057.   781.3KB     12.7   498     6    470.9ms
# 7 exp            6   5.63ms   5.76ms      168.    7.63MB     42.6    59    15    351.8ms
# 8 expTest        6   9.29ms   9.51ms      105.    7.63MB     26.9    39    10    371.1ms


# R version 4.5.1 (2025-06-13 ucrt)
# Platform: x86_64-w64-mingw32/x64
# Running under: Windows 11 x64 (build 22631)
# # A tibble: 8 × 10
# expression  size      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time
# <bch:expr> <int> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm>
# 1 exp            3     22µs   23.1µs   41147.     7.86KB     4.12  9999     1      243ms
# 2 expTest        3   11.2µs   12.6µs   68821.     7.86KB     6.88  9999     1      145ms
# 3 exp            4  227.2µs  240.5µs    4113.    78.17KB     6.37  1936     3      471ms
# 4 expTest        4    114µs  124.5µs    7191.    78.17KB     8.72  3298     4      459ms
# 5 exp            5   2.27ms   2.41ms     408.    781.3KB     6.48   189     3      463ms
# 6 expTest        5   1.13ms   1.23ms     784.    781.3KB    11.3    348     5      444ms
# 7 exp            6  23.26ms  23.42ms      42.4    7.63MB    10.6     12     3      283ms
# 8 expTest        6  11.13ms  11.35ms      87.1    7.63MB    12.8     34     5      390ms
