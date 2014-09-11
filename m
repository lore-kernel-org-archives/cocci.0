From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Sep 2014 15:34:14 +0200 (CEST)
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <20140911121635.GA23610@synchrotron-soleil.fr>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
Message-ID: <alpine.DEB.2.10.1409111513080.2419@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 11 Sep 2014, picca at synchrotron-soleil.fr wrote:

> Hello,
>
> first a big thanks for this fantastic tool... I am not kidding and this is not 'pour ?tre bien vu'.
>
> So here I am trying to do something like that
>
> @@
> identifier self, unit_type, error, f;
> @@
>
> f(...){
> ...
> + unsigned int n_values = darray_size(hkl_geometry_axes_names_get(self));
> + double values[n_values];

The problem is here.  You have some + code that is between two ...s.  So
Coccinelle does not know where you want to add it.  If you want to add
these variables at the beginning of the list of variable declarations,
then just drop the first ...  If you want to add it at the end of the list
of variable declarations, then it is more complicated.  Basically, you
would want to add it just before the fist statement that is not a
declaration.  This could be matched like this:

f(...){
  ... when != S
+ stuff to add
  S1
  ...
}

But S1 could coincide with the position of hkl_geometry_set_values_v.  And
also the rule above will modify every function, not necessarily the ones
with hkl_geometry_set_values_v.

Another issue is that there might be more than one call to
hkl_geometry_set_values_v in the function, and so you might want more than
one n_values variable.

In your subsequent email I see that you are OK with putting the new
declarations at the beginning of the function.  You can try the following:

@@
fresh identifier n_values = "n_values";
fresh identifier values = "values";
expression self, unit_type, error;
identifier f;
@@

f(...) {
++ unsigned int n_values = darray_size(hkl_geometry_axes_names_get(self));
++ double values[n_values];
<...
-hkl_geometry_set_values_v(self, unit_type, &error, ...)
+hkl_geometry_axes_values_set(self, values, n_values, unit_type, &error)
...>
}

julia

> ...
> -hkl_geometry_set_values_v(self, unit_type, &error, ...)
> +hkl_geometry_axes_values_set(self, values, n_values, unit_type, &error)
> ...
> }
>
>
> So the idea is to replace a method by another one but to be able to do that, I need to add two new variables n_values and values.
>
> Indeed when I try this spatch, I got this kind of error
>
> picca at ORD03037:~/Projets/hkl/scripts$ ./refactoring geometry.cocci ../tests/*.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> 190 193
> Fatal error: exception Failure("minus: parse error:
>  = File "geometry.cocci", line 11, column 0,  charpos = 190
>     around = '...', whole content = ...
> ")
> ../tests/hkl3d-test-t.c, ../tests/hkl-axis-t.c
>
>
> I do not understand what's going on, but I am ready to learn with your help.
>
> thanks a lot
>
> Fr?d?ric
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
