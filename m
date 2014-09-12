From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 Sep 2014 11:10:10 +0200 (CEST)
Subject: [Cocci] How to add a few declarations?
In-Reply-To: <20140912085945.GE3099@synchrotron-soleil.fr>
References: <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
 <20140911141340.GA7418@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111614550.2419@hadrien>
 <20140911142737.GA7480@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111634070.2419@hadrien>
 <20140911145145.GA8047@synchrotron-soleil.fr>
 <5412ACF0.8050408@users.sourceforge.net>
 <20140912084025.GA3099@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409121043310.2580@hadrien>
 <20140912085945.GE3099@synchrotron-soleil.fr>
Message-ID: <alpine.DEB.2.10.1409121104520.2580@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I want to transform this method
>
> int f(T1 x, T2 y, T3 z, ...);
>
> called like this
>
> f(x, y, z, 0.0, 6.0, 5.0)
>
> into
>
> {
> 	double values[] = {0.0, 6.0, 5.0};
> 	unsigned int n_values = ARRAY_SIZE(values);
> 	f2(x, values, n_values, y, z);
> }
>
> where the signature of f2 is
>
> int f(T1 x, double[] v, unsigned int n_v, T2 y, T3, z)
>
>
> the variadic part of the method contain only double in my case.

At the moment you can't match against ... in a parameter list.  So you
would have to know which methods have this property.  However, you can
replace the parameter list and put in a new one.

Matching the call site is more feasible.  You could match the above call
as:

@@
expression x, y, z;
expression list es;
fresh identifier values, n_values;
@@

- f(x, y, z, es);
+ { double values[] = { es };
+   unsigned int n_values = ARRAY_SIZE(values);
+   f2(x, values, n_values, y, z);
+ }

I'm not completely sure that it will let you use an expression list in
this way.  If it doesn't work out, then write back and I will give you a
more hackish solution.

julia
