From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 2 Apr 2014 07:53:42 +0200 (CEST)
Subject: [Cocci] coccinelle: trivial linux code style reformatting
In-Reply-To: <1396393876.21529.99.camel@joe-AO722>
References: <1396374174.21529.93.camel@joe-AO722>
 <CA+MoWDr-vry3W3T-duYPYr=H4b3OE0YshuDN9caH56o+WE4CQA@mail.gmail.com>
 <1396393876.21529.99.camel@joe-AO722>
Message-ID: <alpine.DEB.2.02.1404020749280.2007@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 1 Apr 2014, Joe Perches wrote:

> On Tue, 2014-04-01 at 20:29 +0200, Peter Senna Tschudin wrote:
> > I changed the first rule to:
> > 
> > @@
> > identifier func;
> > expression S,E;
> > @@
> > void func(...) {
> > ...
> > - if (E) return S;
> > + if (E) {S; return;}
> 
> Thanks Peter, that makes more sense than
> what I wrote.

I don't think it makes any more sense.  Indeed, it works mostly better, 
because Coccinelle takes charge of the interaction between the ) and the 
{, but if ther is some specific spacing in E, that will be lost.  I think 
that version rc20 should have handled the original rule correctly.  I will 
look into it.

On the other hand, I didn't understand the second rule, 

> @@
> identifier func;
> expression S;
> @@
> void func(...) {
> ...
>         if (...) {
> ...
> -               return S;
> +               S;
>         }
> ...
> }

at all.  Should it be + S; return;?

Finally, in both cases, I guess you want the rule to apply anywhere it 
occurs.  So eg the first rule should be:

void func(...) {
<...
- if (E) return S;
+ if (E) {S; return;}
...>
}

julia
