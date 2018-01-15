From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Jan 2018 21:29:14 +0100 (CET)
Subject: [Cocci] [PATCH] demos: python_regexp: Fix regex matching
In-Reply-To: <1516019805-4523-1-git-send-email-himanshujha199640@gmail.com>
References: <1516019805-4523-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <alpine.DEB.2.20.1801152129040.2251@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Jan 2018, Himanshu Jha wrote:

> Fix regex matching by using correct python syntax by passing the
> compiled regex object to the argument of search function for effective
> searching.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Applied, thanks.

julia

> ---
>  demos/python_regexp.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/demos/python_regexp.cocci b/demos/python_regexp.cocci
> index ce43367..ffb4bd1 100644
> --- a/demos/python_regexp.cocci
> +++ b/demos/python_regexp.cocci
> @@ -16,7 +16,7 @@ id << r_init.id;
>  @@
>
>  print "COCCI: Analyzing %s" % id
> -if m.search(id.ident) != None:
> +if m.search(id) != None:
>  	print "COCCI: %s matchs '_new$'" % id
>  else:
>  	print "COCCI: %s discarded" % id
> --
> 2.7.4
>
>
