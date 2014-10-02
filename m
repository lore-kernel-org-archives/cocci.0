From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Oct 2014 12:24:20 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <20141002093551.GA30575@rei.suse.cz>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.10.1410011504340.2489@hadrien>
 <20141002093551.GA30575@rei.suse.cz>
Message-ID: <alpine.DEB.2.02.1410021223110.2068@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 2 Oct 2014, Cyril Hrubis wrote:

> Hi!
> And here is another small nit:
> 
> nit.c:
> int main(void)
> {
>         f(param1, "Long string that fits to 80 chars .........................",
>           param2, param3);
> }
> 
> nit.cocci:
> @@
> expression list L;
> @@
> - f(L);
> + g(L);
> 
> output:
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: nit.c
> diff = 
> --- nit.c
> +++ /tmp/cocci-output-30698-a2be52-nit.c
> @@ -1,5 +1,4 @@
>  int main(void)
>  {
> -       f(param1, "Long string that fits to 80 chars .........................",
> -         param2, param3);
> +       g(param1, "Long string that fits to 80 chars .........................", param2, param3);
>  }
> 
> Here the whole list of parameters is put on single line after the substitution
> which sometimes creates 150 chars long lines for printf-like functions.
> 
> Unfortunatelly I cannot think of a good solution here. Conservative one would
> be keeping the parameters as they are, but that would break anyway if function
> name lenght, number or lenght of parameters changes.

It should do the right thing here.  I will look into it.  Maybe the 
problem is the expression list...

julia
