# LCMSQA

<details>

* Version: 1.0.2
* GitHub: NA
* Source code: https://github.com/cran/LCMSQA
* Date/Publication: 2024-01-12 11:20:05 UTC
* Number of recursive dependencies: 149

Run `revdepcheck::revdep_details(, "LCMSQA")` for more info

</details>

## Newly broken

*   R CMD check timed out
    

## Newly fixed

*   checking running R code from vignettes ...
    ```
      ‘LCMSQA.Rmd’ using ‘UTF-8’... failed
     ERROR
    Errors in running code in vignettes:
    when running code in ‘LCMSQA.Rmd’
      ...
    > library(BiocParallel)
    Warning: package ‘BiocParallel’ was built under R version 4.4.3
    
    > register(bpstart(MulticoreParam()))
    Warning in socketConnection(host, port, TRUE, TRUE, "a+b", timeout = connect_timeout) :
      port 11699 cannot be opened
    
      When sourcing ‘LCMSQA.R’:
    Error: cannot open the connection
    Execution halted
    ```

