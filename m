From: benitabose@gmail.com (benita bose)
Date: Tue, 14 Mar 2017 12:55:59 -0700
Subject: [Cocci] Coccinelle help needed
In-Reply-To: <alpine.DEB.2.20.1703142044050.3182@hadrien>
References: <CACeYHJNutXmPkSAc2ekU0rzKF4tTxjPsdcPrJSmoOY9QwidCPw@mail.gmail.com>
 <alpine.DEB.2.20.1703142044050.3182@hadrien>
Message-ID: <CACeYHJNDDtEFgnPsoW7igKiQYBSkSU+iG4J_+eu2vfY6Q4cFeA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I want to replace test_fn with a different function func_1. Both test_fn
and func_1 have variable arguments.

test_fn(a1,a2,a3)// to be replaced by
func_1(x1,a2,a3)

I came up with this with a little bit of googling

@@ expression E;
identifier test_fn;@@
-test_fn(E, ...)

+func_1(x)

but not sure how to pass the arguments from the ... in test_fn to func_1 .


On Tue, Mar 14, 2017 at 12:45 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Tue, 14 Mar 2017, benita bose wrote:
>
> > Hi,
> > I'm new to Coccinelle and the tutorials were very helpful. However I've
> hit
> > a roadbloack and need help with replacing a function which has variable
> > arguments. I'm not sure how to denote variable arguments in Coccinelle.
> > Please help me with the issue below.
> >
> > http://stackoverflow.com/q/42776220/4677874?sem=2
> >
> >
> > I've searched the internet extensively and have had no help in the
> regard. I
> > would really appreciate any/all help here.
>
> You want to match a ... that appears in the C code?  That is ......
>
> Please feel free to ask any further questions.
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170314/89ea0989/attachment.html>
