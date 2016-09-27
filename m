From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 27 Sep 2016 16:49:39 +0200 (CEST)
Subject: [Cocci] coccinelle 1.0.6
In-Reply-To: <alpine.DEB.2.10.1609271609410.3044@hadrien>
References: <alpine.DEB.2.10.1609271609410.3044@hadrien>
Message-ID: <alpine.DEB.2.10.1609271648370.3044@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 27 Sep 2016, Julia Lawall wrote:

> Coccinelle 1.0.6 is released.
>
> The most important fix is that Coccinelle no longer crashes when run with
> -j and when there are no relevant files.  This issue was causing a crash
> in make coccicheck in the Linux kernel.
>
> Other changes include adding identifier list as a metavariable type to be
> used in the parameter list of a #define and cleaning up some parallelism
> related issues.

There is a problem with the links, due to a problem with the version
number when creating the release.  The release is available on github.  I
will fix the web site as soon as possible.

julia
