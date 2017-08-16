From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Aug 2017 11:01:37 +0200 (CEST)
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <8594a1d8-c2b1-2607-807b-2b7a1c42dd50@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <8594a1d8-c2b1-2607-807b-2b7a1c42dd50@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708161100510.2049@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Aug 2017, SF Markus Elfring wrote:

> >> Can the search for duplicated source code be improved by the means of the
> >> semantic patch language?
> >
> > For two statements at least you could do:
> >
> > (
> > {
> > s1
> > s2
> > ...
> > }
> > &
> > {
> > sl
> > }
> > )
>
> I constructed another SmPL script based on this suggestion as follows.
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
> *if ((...) < 0) {
> *   s1
> *   s2
>     ...
> *}
> &{
>     sl
>  }
>  ...
> *if ((...) < 0) {
> *   s1
> *   s2
>     ...
> *}
> &{
>     sl
>  }
>  ...
>  }
>
>
> Unfortunately, the software version ?1.0.6-00186-g0acd38ee? does not like this
> SmPL specification.

The syntax is exactly the same as that of a disjunction

(
&
)

There are no outer parentheses in column 0 in your specification.

julia


>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --parse-cocci show_same_statements2.cocci
> ?
> minus: parse error:
>   File "show_same_statements2.cocci", line 15, column 0, charpos = 156
>   around = '&',
>   whole content = &{
>
>
> How can my understanding become better also for the use of SmPL conjunctions?
>
> Regards,
> Markus
>
