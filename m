From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 29 Nov 2013 14:55:59 +0100
Subject: [Cocci] version missmatch
In-Reply-To: <CA+MoWDr-CcXJ=q+VN8FUnxdYqpd7FJmESo6BZ0RpJ4apV3FfaQ@mail.gmail.com>
References: <20131129102538.GA11900@opentech.at>
 <CANrVCd1UyZdJWxPc1Oahw6hNH=YL9ipLKfw39z1xXiiuiXBgHg@mail.gmail.com>
 <alpine.DEB.2.10.1311291309400.2088@hadrien>
 <20131129124736.GB31818@opentech.at>
 <CA+MoWDr-CcXJ=q+VN8FUnxdYqpd7FJmESo6BZ0RpJ4apV3FfaQ@mail.gmail.com>
Message-ID: <20131129135559.GA26401@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 29 Nov 2013, Peter Senna wrote:

> As a "workaround", I did before running ./configure:
> 
> aclocal -I m4 --install
> autoconf
> 
> then:
> 
> ./configure
> make all
> 
> then:
> 
> ./spatch --version
> spatch version 1.0.0-rc18 with Python support and with PCRE support
> 
> I've tested this on Fedora 19 and Debian Wheezy. It only worked in
> Fedora. I'm trying to fix the issue, so the workaround will not be
> needed for long.
>
...before it gets complicated use brute force :)
the simples work around is to edit
configure and manually set it to rc18

PACKAGE_VERSION='1.0.0-rc18'
PACKAGE_STRING='coccinelle 1.0.0-rc18'

the build seems ok (that is make coccicheck in linux-3.12.1 is happy).

thx!
hofrat

the missing \n is here:
--- coccinelle-1.0.0-rc18/main.ml       2013-11-29 08:42:35.000000000 -0500
+++ coccinelle-1.0.0-rc18.release/main.ml       2013-08-19 04:40:12.000000000 -0
400
@@ -349,7 +349,7 @@
       if !Regexp.pcre_support then "with PCRE support"
       else "with Str regexp support "
     in
-    Printf.printf "spatch version %s %s Python support and %s\n"
+    Printf.printf "spatch version %s %s Python support and %s"
       Config.version withpython whichregexp;
     exit 0;
   ),
