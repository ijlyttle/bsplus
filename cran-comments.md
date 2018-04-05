## Note to CRAN maintainers

This is in response to an email:

```
Pls see
<https://www.r-project.org/nosvn/R.check/r-devel-linux-x86_64-debian-gcc/bsplus-00check.html>.
The error can be reproduced by checking with
_R_S3_METHOD_LOOKUP_BASEENV_AFTER_GLOBALENV_=true in the environment,
which prevents foo.bar S3 method lookup along the search path.

To fix, can you pls add

S3method(bs_attr,default)
S3method(bs_attr,logical)

to your NAMESPACE?
```

I was not able to reproduce the error directly myself, but a user had filed a very similar issue that I could reproduce. 

I have fixed the user-identified issue (largely along the lines suggested in the email), so I am making this submission in good-faith that the original issue is also fixed.

## Test environments

* local OS X install, R 3.4.4
* ubuntu 14.04 (on travis-ci), R 3.3.3, R 3.4.4, R-devel
* win-builder (devel and release)
* r-hub: Fedora Linux, R-devel, clang, gfortran
* r-hub: Ubuntu Linux 16.04 LTS, R-release, GCC

Status: 1 NOTE

* Appears to pertain to manual check of maintainter and license. I believe no action to be necessary, please advise if otherwise.

```
Maintainer: ‘Ian Lyttle <ian.lyttle@schneider-electric.com>’

License components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2016-2017
  COPYRIGHT HOLDER: Ian Lyttle, Schneider Electric
```

* win-builder flags the spelling of "tooltips" in DESCRIPTION. The spelling used conforms to a term-of-art in the Twitter Bootstrap framework.

```
Possibly mis-spelled words in DESCRIPTION:
  tooltips (20:81)
```

* win-builder (R-oldrelease) found possibly invalid URLS - I have manually verified the validity of each:

```
Found the following (possibly) invalid URLs:
  URL: https://ebailey78.github.io/shinyBS/
    From: README.md
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://github.com/dgrtwo/gganimate
    From: README.md
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://github.com/ijlyttle/bsplus
    From: DESCRIPTION
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://github.com/ijlyttle/bsplus/issues
    From: DESCRIPTION
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://ijlyttle.github.io/bsplus/articles/carousel.html
    From: README.md
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://ijlyttle.github.io/bsplus/articles/overview.html
    From: README.md
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
```

## Reverse dependencies

There appear to be no reverse dependencies.
