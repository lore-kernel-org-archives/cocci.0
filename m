From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 16 Dec 2014 11:55:36 +0100
Subject: [Cocci] 1.0.0-rc23 release - Clarification of build tweaks
In-Reply-To: <alpine.DEB.2.02.1412131202520.2062@localhost6.localdomain6>
References: <alpine.DEB.2.10.1412111413400.2600@hadrien>
 <548C172E.8070401@users.sourceforge.net>
 <alpine.DEB.2.02.1412131202520.2062@localhost6.localdomain6>
Message-ID: <54900FA8.2020303@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Who did update the build files like "configure.ac" and "commons/Makefile"?
>> https://github.com/coccinelle/coccinelle/commit/c5ff9aff461df30b31ff23b17d2487127c8b9d0a#diff-67e997bcfdac55191033d57a16d1408a
> 
> Why do you want to know this?  They were updated mostly to accomodate 
> changes in more recent versions of ocaml.

I have tried another configuration variant out with the command "./configure --enable-release --enable-ocamlbuild".
The corresponding software build was quickly interrupted.

elfring at Sonne:~/Projekte/Coccinelle/1.0.0-rc23> LANG=C make all
make all-release
make[1]: Entering directory '/home/elfring/Projekte/Coccinelle/1.0.0-rc23'
Building opt-only
make opt-only
make[2]: Entering directory '/home/elfring/Projekte/Coccinelle/1.0.0-rc23'
/usr/bin/ocamlbuild -j 0 main.native
Finished, 0 targets (0 cached) in 00:00:00.
SANITIZE: a total of 2 files that should probably not be in your source tree
  has been found. A script shell file
  "/home/elfring/Projekte/Coccinelle/1.0.0-rc23/_build/sanitize.sh" is being
  created. Check this script and run it to remove unwanted files or use other
  options (such as defining hygiene exceptions or using the -no-hygiene
  option).


Would you like to improve this situation?

Regards,
Markus
