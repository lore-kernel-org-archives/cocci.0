From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 12 Oct 2017 17:17:45 +0200
Subject: [Cocci] Checking for consistency of the version data by the
 software build system
Message-ID: <47243c43-824f-cc0e-d950-61044f0c0d64@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

The following command was executed on my test system again.

elfring at Sonne:~/Projekte/Coccinelle/20160205> make distclean && git checkout master && git pull && ./autogen && ./configure && echo "$(./version.sh)" && grep VERSION=1 Makefile.config
?
1.0.6-00335-g6e5973d4
VERSION=1.0.6-00318-g0bf53049


An essential build script contains the macro call ?AC_INIT(?, m4_esyscmd([./version.sh]), ?)?.
https://github.com/coccinelle/coccinelle/blob/436cc65a41ce2c5885cc7f1ee09b6c14fac1981c/configure.ac#L6

So I would expect that the determined version data will be immediately reused
in generated files. But I notice the shown mismatch occasionally.
Do you observe also similar differences in other software build environments?

Regards,
Markus
