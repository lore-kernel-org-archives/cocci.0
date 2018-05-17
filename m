From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 May 2018 21:28:00 +0200 (CEST)
Subject: [Cocci] Matching function pointer typedef
In-Reply-To: <20180515203606.GA3687@redhat.com>
References: <20180515203606.GA3687@redhat.com>
Message-ID: <alpine.DEB.2.20.1805172125150.2273@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 May 2018, Jerome Glisse wrote:

> Hello,
>
> I am trying to modify an function pointer typedef something like:
>
> @@
> @@
> - typedef void (*toto_t)(int a, int b);
> + typedef void (*toto_t)(int a, int b, int c);

This now works.  Currently, you need to remove the whole typedef and add
it back, not just add the third argument as H?kon suggested.

>
> But it seems spatch or the semantic does not handle function pointer.
> Or simply that typedef is not well handled in the first place. Thing
> like:
>
> @@
> @@
> - typedef int nombre;
> + typedef unsigned nombre;

Was this just an experiment, or is it something you need?  I would imagine
that the problem is that "unsigned" as a type by itself is not well
supported.

julia

> also fails to work. But if typedef is use with struct then it works.
> For instance:
>
> @@
> @@
> - typedef struct {int a;} nombre;
> + typedef struct {unsigned a;} nombre;
>
> Do work. Looking at declaration grammar i do not see why the former
> does not work. I am using fedora 27 coccinelle 1.0.6 if that matters.
>
> Is this a known limitation or am i writting it wrong ?
>
> Thank you for any input on this,
> J?r?me
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
