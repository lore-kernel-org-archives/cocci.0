From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 18 Feb 2016 22:10:27 -0500 (EST)
Subject: [Cocci] Coccinelle parse errors
In-Reply-To: <2821164A880A16429BC851319A6EBBC57128DD99@ORSMSX111.amr.corp.intel.com>
References: <2821164A880A16429BC851319A6EBBC57128DD99@ORSMSX111.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.10.1602182209430.2821@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 19 Feb 2016, Chegondi, Harish wrote:

>
> Hello,
>
> ?
>
> I am trying to run coccicheck (make coccicheck M=<path>) against my code and
> I have been seeing the following exception failure parse errors with
> Coccinelle releases 1.0.2 and 1.0.4. I have installed OCaml version 4.01.0.
> Any help on how to resolve these issues would be appreciated.
>
> ?
>
> ?
>
> With release 1.0.2:
>
> ?
>
> 999 1000
>
> Fatal error: exception Failure("minus: parse error:
>
> = File "./scripts/coccinelle/iterators/device_node_continue.cocci", line 46,
> column 0,? charpos = 999
>
> ??? around = 'i', whole content = i at p1(...) {
>
> ")
>
> ?
>
> ?
>
> With release 1.0.4:
>
> ?
>
> 3561 3562
>
> Fatal error: exception Failure("minus: parse error:
>
> = File "./scripts/coccinelle/iterators/use_after_iter.cocci", line 126,
> column 0,? charpos = 3561
>
> ??? around = '&', whole content = &c->member

Please use 1.0.4.  A patch has been submitted for this problem.  The
solution is just to put a space in front of this line.  Sorry for the
inconvenience.

julia

>
> ")
>
> ?
>
> ?
>
> ?
>
> Thank You very much
>
> Harish.
>
>
>
