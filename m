From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Dec 2016 22:35:52 +0100 (CET)
Subject: [Cocci] Determination of static data types by SmPL constraints?
In-Reply-To: <a0aae8e0-28f3-d841-8750-3b56333bf07a@users.sourceforge.net>
References: <a0aae8e0-28f3-d841-8750-3b56333bf07a@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1612142235170.4147@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 14 Dec 2016, SF Markus Elfring wrote:

> Hello,
>
> I am using the following bit of code for semantic patch language scripts.
>
> ?
> @find_static depends on safety_check@
> identifier safety_check.work;
> position safety_check.pos;
> @@
>  static void work at pos(...)
>  {
>   ...
>  }
> ?
>
>
> The Coccinelle software was extended for the handling of special constraints
> by the execution of embedded scripts in supported programming languages
> to some degree.
> I got the idea that this functionality could also be used now to check
> the usage of a storage-class specifier like ?static? in data types for further
> source code analysis approaches.
>
> * How should such a specifier be determined by the programming interfaces
>   of ?Coccilib??
>
> * Would you like to compare run time characteristics for the execution
>   of the shown SmPL rule and a similar constraint implemented as
>   an OCaml (or Python) script?

I have no idea what you are talking about.

What is wrong with the rule that is shown?

julia
