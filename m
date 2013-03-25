From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 25 Mar 2013 22:27:04 +0100 (CET)
Subject: [Cocci] parameter list to expression list?
In-Reply-To: <515076A4.1030701@redhat.com>
References: <515076A4.1030701@redhat.com>
Message-ID: <alpine.DEB.2.02.1303252225550.2046@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 25 Mar 2013, Michael Stefaniuc wrote:

> Hello,
> 
> is there an intrinsic way to get from a parameter list to an expression
> list? That would come in handy when forwarding from one function to
> another one. At the moment I help myself with a python rule that
> transforms the parameter list to an identifier but that feels clumsy.
> E.g. in SmPL pseudo code something like this would be nice:
> 
> @@
> type T;
> parameter list P;
> expression list E = P;
> expression ret;
> @@
>  T foo(P)
>  {
>      return
> -           ret
> +           bar(E)
>      ;
>  }

No, there is nothing. I guess your transformation gets rid of the types in 
the parameter list?  Perhaps what you would liek is a way to just match 
the list of identifier parts?

julia
