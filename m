From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 3 Oct 2017 15:09:05 +0200 (CEST)
Subject: [Cocci] make install broken
In-Reply-To: <9bf92fad-06e9-b1d5-cae2-6ba4fb9fc022@mykolab.com>
References: <9bf92fad-06e9-b1d5-cae2-6ba4fb9fc022@mykolab.com>
Message-ID: <alpine.DEB.2.20.1710031508430.3693@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 3 Oct 2017, Michael Stefaniuc wrote:

> Hello,
>
> while my Makefile patch lets make install finish a lot of stuff is missing:
> spatch foo.cocci foo.c
> warning: Can't find macro file: ./../lib/coccinelle/standard.h
> warning: Can't find default iso file: ./../lib/coccinelle/standard.iso
> Python error: No module named 'coccilib'
>
> Only this stuff gets installed:
> find /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spatch
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spgen
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib/coccinelle
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib/coccinelle/dllpyml_stubs.so
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc/bash_completion.d
> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc/bash_completion.d/spatch

Thanks for the various feedback.  Thierry should be able to take care of
it tomorrow.

julia
