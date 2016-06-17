From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 17 Jun 2016 20:10:14 +0200 (CEST)
Subject: [Cocci] [PATCH] bundles/pycaml/: force pycaml preparation to be
 done serially
In-Reply-To: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.10.1606172009220.3164@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 17 Jun 2016, Luis R. Rodriguez wrote:

> This fixes parallel compilation when using 32 threads on a 32-core
> system:
>
> The error:
>
> make[6]: Entering directory '/home/mcgrof/coccinelle/bundles/pycaml'
> /usr/bin/ocamlopt.opt -I chemoelectric-pycaml-8614105 -cclib
> -lpycaml_stubs -ccopt -I/usr/include/python2.7 -ccopt
> -I/usr/include/x86_64-linux-gnu/python2.7 -cclib -lpython2.7 -c
> chemoelectric-pycaml-8614105/pycaml.ml -o
> chemoelectric-pycaml-8614105/pycaml.cmx
> make[6]: *** No rule to make target
> 'chemoelectric-pycaml-8614105/pycaml.a', needed by
> 'all-opt-build-targets'.  Stop.
> make[6]: *** Waiting for unfinished jobs....
> make[6]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
> ../Makefile.bundles:33: recipe for target 'all.opt' failed
> make[5]: *** [all.opt] Error 2
> make[5]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
> Makefile:186: recipe for target
> '/home/mcgrof/coccinelle/bundles/pycaml/.opt' failed
> make[4]: *** [/home/mcgrof/coccinelle/bundles/pycaml/.opt] Error 2
> make[4]: Leaving directory '/home/mcgrof/coccinelle'
> Makefile:180: recipe for target 'subdirs.opt' failed
> make[3]: *** [subdirs.opt] Error 1
> make[3]: Leaving directory '/home/mcgrof/coccinelle'
> Makefile:163: recipe for target 'opt-compil' failed
> make[2]: *** [opt-compil] Error 2
> make[2]: Leaving directory '/home/mcgrof/coccinelle'
> Makefile:143: recipe for target 'all-release' failed
> make[1]: *** [all-release] Error 2
> make[1]: Leaving directory '/home/mcgrof/coccinelle'
> Makefile:121: recipe for target 'all' failed
> make: *** [all] Error 2
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  bundles/pycaml/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/bundles/pycaml/Makefile b/bundles/pycaml/Makefile
> index 5045c27..4a619f4 100644
> --- a/bundles/pycaml/Makefile
> +++ b/bundles/pycaml/Makefile
> @@ -17,6 +17,8 @@ export PYMAJOR=$(shell echo ${PYTHON_VERSION} | sed -e 's/\..*//')
>
>  include ../Makefile.bundles
>
> +.NOTPARALLEL: .prepare
> +
>  .prepare: $(MARKER)
>  	rm -f "$(SRC_DIR)/pycaml.mli"
>  	$(CC) -E -w -D PYMAJOR$(PYMAJOR) -xc pycaml.pp.ml >$(SRC_DIR)/pycaml.ml

Thanks for the patch.  I'm not sure that it will address all possible
issues, but if it is an improvement, then ok.

julia
