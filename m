From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Aug 2017 11:20:44 +0200 (CEST)
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <f19870ac-ba92-d635-d5b5-4d0a189e1c4e@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <8594a1d8-c2b1-2607-807b-2b7a1c42dd50@users.sourceforge.net>
 <f19870ac-ba92-d635-d5b5-4d0a189e1c4e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708161119130.2730@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Aug 2017, SF Markus Elfring wrote:

> > Unfortunately, the software version ?1.0.6-00186-g0acd38ee? does not like this
> > SmPL specification.
>
> I overlooked to add parentheses in my evolving SmPL script.
>
> @duplicated_code@
> identifier work;
> statement s1, s2;
> statement list sl;
> type T;
> @@
>  T work(...)
>  {
>  ... when any
> (
> *if ((...) < 0) {
> *   s1
> *   s2
>     ...
> *}
> &{
>     sl
>  }
> )
>  ...
> (
> *if ((...) < 0) {
> *   s1
> *   s2
>     ...
> *}
> &{
>     sl
>  }
> )
>  ...
>  }
>
>
> The following command does not show the expected source code analysis results at the moment.
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_same_statements2.cocci ../Probe/hdsp-excerpt1.c

There is no way that I can understand the problme without having the .c
file.

Note that most of your ...s have no annotation.  So they cannot contain
what comes before or after.  I would suggest to put when any on all of the
...s here that are at statement level.

julia

>
>
> Is there any more clarification needed for the use of SmPL conjunctions?
>
> Regards,
> Markus
>
