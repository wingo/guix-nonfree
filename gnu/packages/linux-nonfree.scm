;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2012, 2013, 2014, 2015, 2017, 2018 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2013, 2014 Andreas Enge <andreas@enge.fr>
;;; Copyright © 2012 Nikita Karetnikov <nikita@karetnikov.org>
;;; Copyright © 2014, 2015 Mark H Weaver <mhw@netris.org>
;;; Copyright © 2015 Federico Beffa <beffa@fbengineering.ch>
;;; Copyright © 2015 Taylan Ulrich Bayırlı/Kammer <taylanbayirli@gmail.com>
;;; Copyright © 2015, 2017 Andy Wingo <wingo@igalia.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu packages linux-nonfree)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages tls)
  #:use-module (guix build-system trivial)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix download))

(define (linux-nonfree-urls version)
  "Return a list of URLs for Linux-Nonfree VERSION."
  (list (string-append
         "https://www.kernel.org/pub/linux/kernel/v4.x/"
         "linux-" version ".tar.xz")))

(define-public linux-nonfree
  (let* ((version "5.4.15"))
    (package
      (inherit linux-libre)
      (name "linux-nonfree")
      (version version)
      (source (origin
                (method url-fetch)
                (uri (linux-nonfree-urls version))
                (sha256
                 (base32
                  "1ccldlwj89qd22cl06706w7xzm8n69m6kg8ic0s5ns0ghlpj41v4"))))
      (synopsis "Mainline Linux kernel, nonfree binary blobs included.")
      (description "Linux is a kernel.")
      (license license:gpl2)
      (home-page "http://kernel.org/"))))

(define-public radeon-firmware-non-free
  (package
    (name "radeon-firmware-non-free")
    (version "65b1c68c63f974d72610db38dfae49861117cae2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
                    (commit version)))
              (sha256
               (base32
                "1anr7fblxfcrfrrgq98kzy64yrwygc2wdgi47skdmjxhi3wbrvxz"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder (begin
                   (use-modules (guix build utils))
                   (let ((source (assoc-ref %build-inputs "source"))
                         (fw-dir (string-append %output "/lib/firmware/radeon/")))
                     (mkdir-p fw-dir)
                     (for-each (lambda (file)
                                 (copy-file file
                                            (string-append fw-dir "/"
                                                           (basename file))))
                               (find-files source
                                           (lambda (file stat)
                                             (string-contains file "radeon"))))
                     #t))))

    (home-page "")
    (synopsis "Non-free firmware for Radeon integrated chips")
    (description "Non-free firmware for Radeon integrated chips")
    ;; FIXME: What license?
    (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.radeon_firmware;hb=HEAD"))))

(define-public ath10k-firmware-non-free
  (package
    (name "ath10k-firmware-non-free")
    (version "65b1c68c63f974d72610db38dfae49861117cae2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
                    (commit version)))
              (sha256
               (base32
                "1anr7fblxfcrfrrgq98kzy64yrwygc2wdgi47skdmjxhi3wbrvxz"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder (begin
                   (use-modules (guix build utils))
                   (let ((source (assoc-ref %build-inputs "source"))
                         (fw-dir (string-append %output "/lib/firmware/")))
                     (mkdir-p fw-dir)
                     (copy-recursively (string-append source "/ath10k")
                                       (string-append fw-dir "/ath10k"))
                     #t))))

    (home-page "")
    (synopsis "Non-free firmware for ath10k wireless chips")
    (description "Non-free firmware for ath10k integrated chips")
    ;; FIXME: What license?
    (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.radeon_firmware;hb=HEAD"))))

(define-public linux-firmware-non-free
  (package
    (name "linux-firmware-non-free")
    (version "1eb2408c6feacccd10b02a49214745f15d1c6fb7")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
                    (commit version)))
              (sha256
               (base32
                "0256p99bqwf1d1s6gqnzpjcdmg6skcp1jzz64sd1p29xxrf0pzfa"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder (begin
                   (use-modules (guix build utils))
                   (let ((source (assoc-ref %build-inputs "source"))
                         (fw-dir (string-append %output "/lib/firmware/")))
                     (mkdir-p fw-dir)
                     (copy-recursively source fw-dir)
                     #t))))

    (home-page "")
    (synopsis "Non-free firmware for Linux")
    (description "Non-free firmware for Linux")
    ;; FIXME: What license?
    (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.radeon_firmware;hb=HEAD"))))

(define-public perf-nonfree
  (package
    (inherit perf)
    (name "perf-nonfree")
    (version (package-version linux-nonfree))
    (source (package-source linux-nonfree))
    (license (package-license linux-nonfree))))

(define-public iwlwifi-firmware-nonfree
  (package
    (name "iwlwifi-firmware-nonfree")
    (version "65b1c68c63f974d72610db38dfae49861117cae2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
                    (commit version)))
              (sha256
               (base32
                "1anr7fblxfcrfrrgq98kzy64yrwygc2wdgi47skdmjxhi3wbrvxz"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder (begin
                   (use-modules (guix build utils))
                   (let ((source (assoc-ref %build-inputs "source"))
                         (fw-dir (string-append %output "/lib/firmware")))
                     (mkdir-p fw-dir)
                     (for-each (lambda (file)
                                 (copy-file file
                                            (string-append fw-dir "/"
                                                           (basename file))))
                               (find-files source "iwlwifi-.*\\.ucode$|LICENCE\\.iwlwifi_firmware$"))
                     #t))))

    (home-page "https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi")
    (synopsis "Non-free firmware for Intel wifi chips")
    (description "Non-free firmware for Intel wifi chips")
    ;; FIXME: What license?
    (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.iwlwifi_firmware;hb=HEAD"))))

(define-public ibt-hw-firmware-nonfree
  (package
    (name "ibt-hw-firmware-nonfree")
    (version "65b1c68c63f974d72610db38dfae49861117cae2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
                    (commit version)))
              (sha256
               (base32
                "1anr7fblxfcrfrrgq98kzy64yrwygc2wdgi47skdmjxhi3wbrvxz"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder (begin
                   (use-modules (guix build utils))
                   (let ((source (assoc-ref %build-inputs "source"))
                         (fw-dir (string-append %output "/lib/firmware/intel")))
                     (mkdir-p fw-dir)
                     (for-each (lambda (file)
                                 (copy-file file
                                            (string-append fw-dir "/"
                                                           (basename file))))
                               (find-files source "ibt-hw-.*\\.bseq$|LICENCE\\.ibt_firmware$"))
                     #t))))

    (home-page "http://www.intel.com/support/wireless/wlan/sb/CS-016675.htm")
    (synopsis "Non-free firmware for Intel bluetooth chips")
    (description "Non-free firmware for Intel bluetooth chips")
    ;; FIXME: What license?
    (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.ibt_firmware;hb=HEAD"))))
