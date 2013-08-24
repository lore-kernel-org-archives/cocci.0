From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Sat, 24 Aug 2013 10:44:25 +0200
Subject: [Cocci] coccinelle-1.0.0-rc18
In-Reply-To: <alpine.DEB.2.02.1308240929340.1996@localhost6.localdomain6>
References: <54AA37D70A06414FB8288E4A5662904A01024F2DD4@NB-EX-MBX01.diasemi.com>
 <alpine.DEB.2.02.1308240929340.1996@localhost6.localdomain6>
Message-ID: <CA+MoWDoZ1P0DFBShrO5QVsiVwUPEuWbC3UTeBCZ0MNzysNQbsA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Some Linux distributions tools can help you with dependencies:

For Fedora:
$ sudo yum-builddep coccinelle

For Debian/Ubuntu:
$ sudo apt-get build-dep coccinelle

Those commands wil ltell you what are the recommended packages to have
installed in the system for building Coccinelle, and can save you some
time. Please let us know if you still have problems.

Peter

On Sat, Aug 24, 2013 at 9:30 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> Perhaps try the option --without-pkg-config, if pkg-config is not well set
> up on your machine.
>
> julia
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Peter
