From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Fri, 27 Sep 2013 11:07:10 +0200
Subject: [Cocci] multiple fields declaration
In-Reply-To: <1380268481.3191.15.camel@zamolxis.metaware.tm.fr>
References: <1380268481.3191.15.camel@zamolxis.metaware.tm.fr>
Message-ID: <CA+MoWDr1xiE9TCjS+=F+MtF=TWEc9N7VWsYT=SdwtEKfbNMtfw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

It worked for me when I've removed the two ... inside the struct, like:

@findvar@ identifier i; @@
 int i;

@expression@ identifier findvar.i; @@
+(
  i
+)

@findfld@ identifier id, id3; @@
 struct {
 int id;
 } id3;

@expression@ identifier x, findfld.id; @@
+(
  x.id
+)

Does it work for you?

[]'s

Peter

On Fri, Sep 27, 2013 at 9:54 AM, Nic Volanschi (R&D)
<volanschi@metaware.fr> wrote:
> Hi,
>
> I found an unfortunate asymmetry on matching an identifier declared in a
> multiple declaration. In short, it works fine on a multiple variables
> declaration, but not on a multiple fields declaration.
>
> For example, the following semantic patch, adding parentheses around
> uses of integer variables and integer fields:
>
> --- intvar2.cocci:
> @findvar@ identifier i; @@
>  int i;
>
> @expression@ identifier findvar.i; @@
> +(
>   i
> +)
>
> @findfld@ identifier id, id3; @@
>  struct {
>  ...
>  int id;
>  ...} id3;
>
> @expression@ identifier x, findfld.id; @@
> +(
>   x.id
> +)
>
> ---
> applied on the following program:
>
> --- intvar2.c:
> #include <stdio.h>
>
> struct {
>   int f1, f2;
>   int f3;
> } s;
>
> int main() {
>   int i1, i2;
>   int i3;
>   i1 = 11;
>   i2 = 22;
>   i3 = 33;
>   printf("%d, %d, %d\n", i1, i2, i3);
>   s.f1 = 44;
>   s.f2 = 55;
>   s.f3 = 66;
>   printf("{%d, %d, %d}\n", s.f1, s.f2, s.f3);
> }
>
> ---
> transforms variables i1, i2, i3, and field f3, but not fields f1 and f2.
>
> Is it possible to turn around this problem? Or even better, to fix
> it...?
>
> Thanks,
> Nic.
>
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Peter
