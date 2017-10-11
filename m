From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Wed, 11 Oct 2017 21:09:35 +0200
Subject: [Cocci] make install broken
In-Reply-To: <f2a91d70-e81d-4344-8854-6baa5227e700@email.android.com>
References: <f2a91d70-e81d-4344-8854-6baa5227e700@email.android.com>
Message-ID: <f25e9b52-4f37-bedf-6c43-97cd3419d1fe@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Thierry,

On 10/11/2017 03:42 PM, Thierry Martinez wrote:
> I wrote:
>> I just pushed on GitHub a more portable way for determining the path
> of the
> executable relying on proc_pidpath
> 
> I just noticed that you will need the libproc-dev package from your
there is no such thing in Fedora. I found a procps-ng-devel but that
doesn't provide libproc.h.

> distribution to compile (Debian or Ubuntu, name on other distribution
I'm checking Debian but cannot find a libproc there either:
https://packages.debian.org/search?keywords=libproc
The libproc-* is for perl.
There are libprocps packages but the .h files in those seem to match
what Fedora has in procps-ng-devel.

A quick search finds libproc.h on github but that has an Apple copyright
in it. It's basically this one:
https://opensource.apple.com/source/xnu/xnu-2422.1.72/libsyscall/wrappers/libproc/libproc.h.auto.html


> may vary). I will update install.txt and provide a fallback if the
> function is not available (probably by reading /proc/self/exe if it
> exists, otherwise by considering "_" as before).
> 
> Thank you for the report.
> --?
> Thierry.
> 

bye
	micheal
