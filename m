From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 18 Dec 2016 20:05:05 +0100 (CET)
Subject: [Cocci] Checking incidence for SmPL initialisation rules after
 parallel script execution
In-Reply-To: <4a2af4ea-01ab-3e47-845e-15dae185791f@users.sourceforge.net>
References: <da6cd1b6-17a0-d5e9-3ba6-7565cc80ce39@users.sourceforge.net>
 <alpine.DEB.2.20.1612181659510.1965@hadrien>
 <4a2af4ea-01ab-3e47-845e-15dae185791f@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1612182004360.2075@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 18 Dec 2016, SF Markus Elfring wrote:

> >> Is it really appropriate that this header appears so often in the shown output file?
> >
> > Without having the semantic patch and the .c file, ideally with both
> > cut down to a minimal version that shows the problem,
> > I can't answer this question.
>
> Does the follow display look a bit better?
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> grep 'function|"data type"|"source file"|line|column' ~/Projekte/Bau/NetBSD/Coccinelle/functions1/API2.txt | wc -l
> 5
>
> (Four jobs plus one)
>
>
> I am looking for another update on the consequences from the parallel execution
> of scripts for the semantic patch language.
> How often should the specified initialisation be performed for the embedded
> programming language scripts?

Without having the semantic patch and the .c file, ideally with both
cut down to a minimal version that shows the problem,
I can't answer this question.

julia
