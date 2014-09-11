From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Thu, 11 Sep 2014 15:45:30 +0200
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <alpine.DEB.2.10.1409111513080.2419@hadrien>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111513080.2419@hadrien>
Message-ID: <20140911134530.GA7006@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> fresh identifier n_values = "n_values";
> fresh identifier values = "values";
> expression self, unit_type, error;
> identifier f;
> @@
> 
> f(...) {
> ++ unsigned int n_values = darray_size(hkl_geometry_axes_names_get(self));
> ++ double values[n_values];
> <...
> -hkl_geometry_set_values_v(self, unit_type, &error, ...)
> +hkl_geometry_axes_values_set(self, values, n_values, unit_type, &error)
> ...>
> }

I understand better but now I get this error.

I will try to make this spatch evolve with your help until it does the right things.
So be prepare to have a few email :)

picca at ORD03037:~/Projets/hkl/scripts$ ./refactoring geometry.cocci ../tests/*.c
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: ../tests/hkl3d-test-t.c ../tests/hkl-axis-t.c ../tests/hkl-bench-t.c ../tests/hkl-detector-t.c ../tests/hkl-geometry-t.c ../tests/hkl-interval-t.c ../tests/hkl-lattice-t.c ../tests/hkl-matrix-t.c ../tests/hkl-parameter-t.c ../tests/hkl-pseudoaxis-e4ch-t.c ../tests/hkl-pseudoaxis-e4cv-t.c ../tests/hkl-pseudoaxis-e6c-t.c ../tests/hkl-pseudoaxis-k4cv-t.c ../tests/hkl-pseudoaxis-k6c-t.c ../tests/hkl-pseudoaxis-soleil-sixs-med-t.c ../tests/hkl-pseudoaxis-t.c ../tests/hkl-pseudoaxis-zaxis-t.c ../tests/hkl-quaternion-t.c ../tests/hkl-sample-t.c ../tests/hkl-source-t.c ../tests/hkl-unit-t.c ../tests/hkl-vector-t.c ../tests/runtests.c
Fatal error: exception Failure("SP line 11: Not found a value in env for: self")
../tests/hkl3d-test-t.c, ../tests/hkl-axis-t.c

Frederic
