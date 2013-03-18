From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Mar 2013 10:50:43 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <CANrVCd2jbGE2X+C6K9s=VanN_CquDp98f2Ne6fYOBAJt+nU8Yg@mail.gmail.com>
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
 <5138C95F.8010608@users.sourceforge.net>
 <5144D0F8.3040302@users.sourceforge.net>
 <CANrVCd2jbGE2X+C6K9s=VanN_CquDp98f2Ne6fYOBAJt+nU8Yg@mail.gmail.com>
Message-ID: <5146E373.8090702@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Unlikely, unless there is a clear need to do so.

I wonder why you do not see the need for corrections in your current build
specification and corresponding configuration scripts so far.
https://github.com/coccinelle/coccinelle/blob/abad11c5570b7b9bbae5ff92b3050cf68fe3fd14/configure.ac

I recommend adjustments for places like the following.
1. A "working directory" should not be referenced by the macro call
'AC_SUBST([COCCI_SRCDIR], ["$(pwd)"])'.

2. I find it strange that OCaml source files are passed in the macro call
'AC_CONFIG_FILES([...])'.

http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Configuration-Files.html

3. How do you think about to rename the extension for the "top level Makefile"
to ".mk"?

4. How would you like to fix the following error message?
   elfring at Sonne:~/Projekte/Coccinelle/Bau> LANG=C make -j6 -f Makefile.config
   make: *** No targets.  Stop.

5. I find that your "Makefile.am" files became inappropriate.
   - outdated comments

   - Which subdirectories should be used?

http://www.gnu.org/software/automake/manual/html_node/Conditional-Subdirectories.html

   - Which source files should be assigned to the variable "spatch_SOURCES"?
     http://www.gnu.org/software/automake/manual/html_node/Program-Sources.html

   - When will the OCaml compiler and linker be called there?

Regards,
Markus
