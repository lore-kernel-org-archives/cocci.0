From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Aug 2016 22:37:54 -0400 (EDT)
Subject: [Cocci] Coccinelle issues with Linux kernel 4.8-rc1
In-Reply-To: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
References: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.10.1608172237200.3281@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 18 Aug 2016, Chegondi, Harish wrote:

>
> Hello,
>
> ?
>
> With the 4.8-rc1 kernel, when I run Coccinelle check using the command ?make
> coccicheck MODE=report M=<path to directory>?, I get ?coccicheck failed?
> message. I get the same failure message even with ?MODE=patch? in the
> command. I didn?t see this error message with 4.7 kernel.
>
> ?
>
> However, with the 4.8-rc1 kernel, if I turn off parallelization with J=1
> option, I don?t see the error message. The check seem to be running
> successfully, even though it takes longer to run. I tried J=2, J=4,?? and I
> got error messages. So there seem to be a problem with J not equal to 1.

Concretely, this seems to be how to give extra arguments to Coccinelle:

# You can use SPFLAGS to append extra arguments to coccicheck or override any
# heuristics done in this file as Coccinelle accepts the last options when
# options conflict.

julia


>
> ?
>
> Below I have mentioned the spatch version and ocaml version.
>
> ?
>
> -bash-4.2$ spatch --version
>
> spatch version 1.0.4 with Python support and with PCRE support
>
> ?
>
> -bash-4.2$ ocaml
>
> ??????? OCaml version 4.02.3
>
> ?
>
> ?
>
> ?
>
> Can you please let me know how can I resolve the ?coccicheck failed?
> message?
>
> ?
>
> Thank You
>
> Harish.
>
>
>
