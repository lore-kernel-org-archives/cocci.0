From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Dec 2015 19:11:09 +0100 (CET)
Subject: [Cocci] Coccinelle for other programming languages
In-Reply-To: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C29A@Mail1.FCMD.local>
References: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C22C@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512171825240.10291@hadrien>
 <20151217221143.GV20409@wotan.suse.de>
 <5673BF55.4010902@users.sourceforge.net>
 <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C282@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512181603050.2499@hadrien>
 <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C291@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512181745050.2499@hadrien>
 <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C29A@Mail1.FCMD.local>
Message-ID: <alpine.DEB.2.10.1512181904210.2499@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I tried to run the attached cocci script on the attached C file. We got
> an error.
>
> Not sure whether the cocci files under the script directory are for the
> users to try or for other programs.

Please don't send screen shots.  They are voluminous...  Coccinelle just
uses text, so you can just copy-paste the output into your message.

The scripts in the Linux kernel are designed to be used with the
coccicheck make target of the Linux kernel.  This is described in the
Linux kernel documentation in Documentation/coccinelle.txt.  But they can
also be used "by hand".  You can look for the "virtual" declarations at
the top of the semantic patch file, and use command line arguments to
select the kind of output you want.  For example, if the semantic patch
starts with virtual patch, then you can use -D patch on the command line
to get patch output.  Or if there is virtual report (which there should be
in all cases), you can use -D report.

If you are writing your own semantic patch, there is typically no need for
these virtual declarations.

You may find eg the demos directory of the Coccinelle source tree easier
to start looking at.  A number of examples are also available here:

http://coccinelle.lip6.fr/rules/

You can also look at https://btrlinux.inria.fr/category/coccinelle/ for
some examples of patches using Coccinelle.

julia
