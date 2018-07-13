From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Fri, 13 Jul 2018 22:12:13 +0530
Subject: [Cocci] Coccinelle: change strncpy+truncation to strlcpy
In-Reply-To: <5e93dba5-1a57-ee59-e714-17a80b3fb031@users.sourceforge.net>
References: <20180713091412.GA11250@himanshu-Vostro-3559>
 <5e93dba5-1a57-ee59-e714-17a80b3fb031@users.sourceforge.net>
Message-ID: <20180713164213.GA2747@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jul 13, 2018 at 04:26:41PM +0200, SF Markus Elfring wrote:
> > (
> > - strncpy(
> > + strlcpy(
> >   dest, src, sizeof(sz));
> > - dest[sizeof(sz) - 1] = '\0';
> > |
> > - strncpy(
> > + strlcpy(
> >   dest, src, f); 
> > - dest[f - 1] = '\0';
> > )
> 
> How do you think about the following code transformation specification
> which would work with SmPL disjunctions at other places?
> 
> -strncpy
> +strlcpy
>         (dest, src, \( sizeof(sz) \| f \) );
> -dest[\( sizeof(sz) \| f \) - 1] = '\0';

Great!!!
Much cleaner than mine I would say.

Btw, Markus, I am curious to know how do you benchmark Coccinelle rules?

> > Also, it is advised to put a space affer '+/-'
> 
> It depends on the circumstances.

I advised only for improving readability and what is followed in every
Cocci rule in the mainline kernel.

Bikeshedding ;)

> * Will you become interested in the usage of the double addition token?
>   http://coccinelle.lip6.fr/docs/main_grammar005.html#sec11
> 
> * The Coccinelle software contains software development challenges as can be
>   seen in the feature request ?Support replacement of arithmetic operators
>   with SmPL?.
>   https://github.com/coccinelle/coccinelle/issues/144

Ah, I see.

Great working on improving Coccinelle.

I wish to see Coccinelle handling headers in source file in future.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
