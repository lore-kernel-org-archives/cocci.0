From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Thu, 11 Sep 2014 14:16:35 +0200
Subject: [Cocci] how to add a few decalrations
Message-ID: <20140911121635.GA23610@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

first a big thanks for this fantastic tool... I am not kidding and this is not 'pour ?tre bien vu'.

So here I am trying to do something like that

@@
identifier self, unit_type, error, f;
@@

f(...){
...
+ unsigned int n_values = darray_size(hkl_geometry_axes_names_get(self));
+ double values[n_values];
...
-hkl_geometry_set_values_v(self, unit_type, &error, ...)
+hkl_geometry_axes_values_set(self, values, n_values, unit_type, &error)
...
}


So the idea is to replace a method by another one but to be able to do that, I need to add two new variables n_values and values.

Indeed when I try this spatch, I got this kind of error

picca at ORD03037:~/Projets/hkl/scripts$ ./refactoring geometry.cocci ../tests/*.c
init_defs_builtins: /usr/share/coccinelle/standard.h
190 193
Fatal error: exception Failure("minus: parse error: 
 = File "geometry.cocci", line 11, column 0,  charpos = 190
    around = '...', whole content = ...
")
../tests/hkl3d-test-t.c, ../tests/hkl-axis-t.c


I do not understand what's going on, but I am ready to learn with your help.

thanks a lot

Fr?d?ric
