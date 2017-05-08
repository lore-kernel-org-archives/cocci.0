From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 9 May 2017 07:50:36 +0800 (SGT)
Subject: [Cocci] 773 777 coccicheck failed
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E866375E7EF27@FMSMSX108.amr.corp.intel.com>
References: <14063C7AD467DE4B82DEDB5C278E866375E7EF27@FMSMSX108.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1705090748390.3309@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 8 May 2017, Ruhl, Michael J wrote:

> Hi,
>
> I am using the coccicheck feature of the latest Linux kernel (4.11.0-rc6) and I am getting the following failure:
>
> 773 777 coccicheck failed
>
> When I run this:
>
> % export COCCI=scripts/coccinelle/misc/boolconv.cocci
> % make coccicheck MODE=report M=drivers/infiniband/hw/hfi1 V=1 J=1
>
> (the actual driver does not appear to be an issue, I tested with several and they have all failed)
>
> This is the only .cocci test that is failing.
>
> I was wondering if you could give me some insight as to what this failure might be?
>
> Thanks,
>
> Mike
>
> spatch --version
> spatch version 1.0.4 with Python support and with PCRE support

I don't know what is the exact problem, but the error is a parsing error
(message on stderr, but stderr may be thrown away with make coccicheck
depending on the options) and it parses fine for me.  So you probably need
to update your version of Coccinelle.  The most recent release is 1.0.6
and the version available from github is even more recent.

julia
