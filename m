From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 07 Mar 2013 18:07:43 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <CANrVCd3HS+i84W01R-pZv5B1jz_r9HJVjJfVh1OxN1mGMmxAuA@mail.gmail.com>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <5134C06D.4070906@users.sourceforge.net>
 <alpine.DEB.2.02.1303041645030.1984@hadrien>
 <5134C654.3050706@users.sourceforge.net>
 <CANrVCd3SaNhoMzaLFYsrkB6gX7vz9Nxb5L85be48pFNZ03Q6CA@mail.gmail.com>
 <5138B81B.2040100@users.sourceforge.net>
 <CANrVCd3HS+i84W01R-pZv5B1jz_r9HJVjJfVh1OxN1mGMmxAuA@mail.gmail.com>
Message-ID: <5138C95F.8010608@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Does it work as it is supposed to be?

It seems that the desired build configuration works also as expected on my
system with an out-of-source build after a small adjustment for a variable.
www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Build-Directories.html

diff --git a/configure.ac b/configure.ac
index 2f0f682..4905af0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,7 +8,7 @@ AC_CONFIG_MACRO_DIR([setup])
 AC_CONFIG_AUX_DIR([setup])
 AC_SUBST([CONFIGURE_FLAGS], ["$*"])
 AC_SUBST([COCCI_VERSION], ["$PACKAGE_VERSION"])
-AC_SUBST([COCCI_SRCDIR], ["$(pwd)"])
+AC_SUBST([COCCI_SRCDIR], ["$srcdir"])
 AC_MSG_NOTICE([configuring coccinelle $COCCI_VERSION in $COCCI_SRCDIR])
 AM_INIT_AUTOMAKE


I have got the impression that there are more update candidates to consider
since the macro call "AM_INIT_AUTOMAKE" was added.
https://github.com/coccinelle/coccinelle/blob/abad11c5570b7b9bbae5ff92b3050cf68fe3fd14/configure.ac#L13

- Would you like to drop the variable "COCCI_SRCDIR" eventually (because there
is a standard one available)?
- How do you think about to change comments in files like "Makefile.am"?

Regards,
Markus
