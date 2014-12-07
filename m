From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 7 Dec 2014 10:31:45 +0100 (CET)
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <54841AB2.6070609@users.sourceforge.net>
References: <5478F848.1080808@users.sourceforge.net>
 <547F8C2B.5090601@users.sourceforge.net>
 <alpine.DEB.2.02.1412032334330.2303@localhost6.localdomain6>
 <5481BF42.9040503@users.sourceforge.net>
 <alpine.DEB.2.10.1412051633240.2360@hadrien>
 <54820FEF.4080901@users.sourceforge.net>
 <54834F76.1090104@users.sourceforge.net>
 <alpine.DEB.2.10.1412061955440.2042@hadrien>
 <548358DE.6020409@users.sourceforge.net>
 <alpine.DEB.2.02.1412062139570.2256@localhost6.localdomain6>
 <548371FB.9060402@users.sourceforge.net>
 <alpine.DEB.2.02.1412062219530.2256@localhost6.localdomain6>
 <54837413.8000902@users.sourceforge.net>
 <alpine.DEB.2.02.1412062232470.2256@localhost6.localdomain6>
 <5483806D.3070805@users.sourceforge.net>
 <alpine.DEB.2.02.1412062342540.2256@localhost6.localdomain6>
 <5483902E.8060109@users.sourceforge.net>
 <alpine.DEB.2.02.1412070749130.2044@localhost6.localdomain6>
 <54841AB2.6070609@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1412071027040.2044@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

OK, now the C file is manageable, if I drop the 20 lines of comments at 
the top of the file.

The following is also a completely understandable semantic patch:

> @single_function_call@
> identifier caller, input, work;
> type input_type, return_type;
> @@
> *return_type caller(input_type input)
>  {
> (
>   work(input);
> |
>   return work(input);
> )
>  }
> 
> @single_function_call_with_pointer@
> identifier caller, element, input, work;
> type input_type, return_type;
> @@
> *return_type caller(input_type * input)
>  {
> (
>   work(input->element);
> |
>   return work(input->element);
> )
>  }

So, now what is the problem with the following output?

> elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file find_single_function_call1.cocci ast_ttm-excerpt1.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: ast_ttm-excerpt1.c
> diff = 
> --- ast_ttm-excerpt1.c
> +++ /tmp/cocci-output-19572-537bbf-ast_ttm-excerpt1.c
> @@ -25,24 +25,18 @@
>  /*
>   * Authors: Dave Airlie <airlied@redhat.com>
>   */
> -static int
> -ast_ttm_mem_global_init(struct drm_global_reference *ref)
>  {
>         return ttm_mem_global_init(ref->object);
>  }
>  
> -static void
> -ast_ttm_mem_global_release(struct drm_global_reference *ref)
>  {
>         ttm_mem_global_release(ref->object);
>  }
>  
> -static int ast_ttm_tt_populate(struct ttm_tt *ttm)
>  {
>         return ttm_pool_populate(ttm);
>  }
>  
> -static void ast_ttm_tt_unpopulate(struct ttm_tt *ttm)
>  {
>         ttm_pool_unpopulate(ttm);
>  }
> 
> 
> 
> One of my concerns here is the influence of the function return type
> on the SmPL evaluation speed so that more fine-tuning will be appropriate
> for the filter patterns.

Worrying about the speed of matching of a couple of tokens is completely 
pointless.  If you want to see that in practice, just use the --profile 
option and see what is the time with and without the matching you are 
concerned about.  Unless your pattern requires following a lot of 
different control-flow paths, eg due to sequences of conditionals, the C 
code parsing time will massively dominate the matching time.

julia
