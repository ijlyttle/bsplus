## Test environments

* local OS X install, R 3.3.2
* ubuntu 12.04 (on travis-ci), R 3.3.2
* win-builder (devel and release)
* r-hub: Fedora Linux, R-devel, clang, gfortran
* r-hub: Ubuntu Linux 16.04 LTS, R-release, GCC
* r-hub: Windows Server 2008 R2 SP1, R-devel, 32/64 bit

## Resubmission notes

* The URL in DESCRIPTION is now enclosed in <...>.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new submission.

```
New submission
```

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
  tooltips (19:81)
```

## Reverse dependencies

This is a new release, so there are no reverse dependencies.


