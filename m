From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Nov 2016 07:17:49 +0100 (CET)
Subject: [Cocci] semantic patch to replace 'ASSERT'
In-Reply-To: <20161121234029.wper5znya2zjm2xd@xsjsorenbubuntu.xilinx.com>
References: <20161121234029.wper5znya2zjm2xd@xsjsorenbubuntu.xilinx.com>
Message-ID: <alpine.DEB.2.20.1611220710020.16376@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 21 Nov 2016, S?ren Brinkmann wrote:

> Hi,
>
> I am working with a code base that defines a custom macro 'ASSERT' that
> compared to the usual c 'assert' interprets the condition the other way
> around. Hence, I wanted to "fix" this and get the definition of ASSERT
> in line with assert.h and came up with:
>
> /* Invert condition in ASSERT */
> @ rule1 @
> expression E;
> @@
>  	ASSERT (
> -	E
> +	!(E)
> 	, ...)
>
> But that didn't seem to work, though, some experiments with slight
> variations do. Eventually, I ended up 'git grepping' the coccinelle
> sources and found some code that seems to introduce special handling for
> some macros/identifiers. I changed coccinelle like this:
> diff --git a/standard.h b/standard.h
> index 612cd54bc9d6..c9190222d3bf 100644
> --- a/standard.h
> +++ b/standard.h
> @@ -635,7 +635,6 @@ do {                                                                        \
>
>
>
> -#define ASSERT(x) MACROSTATEMENT
>  #define IRDA_ASSERT(x) MACROSTATEMENT
>
>  #define CHECK_NULL(x) MACROSTATEMENT
>
> and my patch started to work. I have no idea what other side effects that
> change might have, but overall, I kind of find the behavior that breaks
> on certain identifiers rather wrong.

standard.h is defined for the Linux kernel.  Apparently in the Linux
kernel there is (or was) an ASSERT definition that includes a ;, and thus
ASSERT(blah) would be used in practice without a semicolon after it.  This
introduces a definition for ASSERt(blah) that allows Coccinelle to
continue parsing functions that contain such unpleasant code, but it
implies that Coccinelle will do no transformation in that code, because it
is now using the macro expansion rather than the original code.  You can
see this when you run spatch --parse-c on your file.  It will give
comments about "passed" tokens.

The only impact that removing this definition could have is that parsing
some functions may fail, if your code ever uses ASSERT without a trailing
;.

julia



>
> 	S?ren
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
