From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Feb 2017 22:59:29 +0100 (CET)
Subject: [Cocci] Hunt for array users of roc_dointvec()
In-Reply-To: <20170201203531.GI24047@wotan.suse.de>
References: <20170201203531.GI24047@wotan.suse.de>
Message-ID: <alpine.DEB.2.20.1702012259050.2021@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 1 Feb 2017, Luis R. Rodriguez wrote:

> I'm trying to hunt for users of the proc_dointvec() handler in
> setups where more than one value is expected to be used. The way
> this old API works is it lets you specifiy in a structure the
> variables and the size of the variables. In the singular case the
> size will be maxlen = sizeof(int). If an array is used a user
> may use maxlen = 2*sizeof(int), or other things.
>
> Since I am looking for unsigned int users of proc_dointvec() to later
> consider converting them to proc_douintvec() I can just focus for now
> when the is not maxlen = (unsigned int) or maxlen = sizeof(int), and then
> manually review the cases. Unfrotunately I cannot seem to construct
> grammar to query context for this.
>
> Let's consider just trying to get context for the case where the size is
> not  maxlen = sizeof(unsigned int). I tried this bug get no results:

Do you have an example of a C file on which you expect to get a match?

julia

>
> virtual context
>
> @ find_proc @
> identifier ctls;
> expression name;
> @@
>
> struct ctl_table ctls[] = {
> 	{
> 		.procname = name,
> 		.proc_handler = proc_dointvec,
> 	},
> };
>
> @ singular_ints @
> identifier find_proc.ctls;
> expression find_proc.name;
> @@
>
> struct ctl_table ctls[] = {
> 	{
> 		.procname = name,
> 		.maxlen = sizeof(unsigned int),
> 	},
> };
>
> @ array_ints depends on context && !singular_ints @
> identifier find_proc.ctls;
> expression find_proc.name, E;
> @@
>
> struct ctl_table ctls[] = {
> 	{
> *		.procname = name,
> *		.maxlen = E,
> 	},
> };
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
