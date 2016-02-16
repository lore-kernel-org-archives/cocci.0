From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 16 Feb 2016 18:19:52 +0100 (CET)
Subject: [Cocci] [PATCH 3/3] coccinelle: catch krealloc() on devm_*()
 allocated memory
In-Reply-To: <5783128fc07898adc6860a398fc4f4e0893bc91a.1455638829.git.ydroneaud@opteya.com>
References: <cover.1455638829.git.ydroneaud@opteya.com>
 <5783128fc07898adc6860a398fc4f4e0893bc91a.1455638829.git.ydroneaud@opteya.com>
Message-ID: <alpine.DEB.2.10.1602161819340.2685@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 16 Feb 2016, Yann Droneaud wrote:

> krealloc() must not be used against devm_*() allocated
> memory regions:
>
> - if a bigger memory is to be allocated, krealloc() and
>   __krealloc() could return a different pointer than the
>   one given to them, creating a memory region which is not
>   managed, thus it will not be automatically released on
>   device removal.
>
> - if a bigger memory is to be allocated, krealloc() could
>   kfree() the managed memory region which is passed to it.
>   The old pointer is left registered as a resource for the
>   device. On device removal, this dangling pointer will be
>   used and an unrelated memory region could be released.
>
> - if the requested size is equal to 0, krealloc() can also
>   just behave like kfree(). Here too, the old pointer is
>   kept associated with the device. On device removal, this
>   invalid pointer will be used and an unrelated memory
>   region could be released.
>
> For all these reasons, krealloc() must not be used on a
> pointer returned by devm_*() functions.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Pekka Enberg <penberg@cs.helsinki.fi>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/free/devm_free.cocci | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
> index 3794cd97494b..c990d2c7ee16 100644
> --- a/scripts/coccinelle/free/devm_free.cocci
> +++ b/scripts/coccinelle/free/devm_free.cocci
> @@ -66,6 +66,10 @@ position p;
>  |
>  * kzfree at p(x)
>  |
> +* __krealloc at p(x, ...)
> +|
> +* krealloc at p(x, ...)
> +|
>  * free_pages at p(x, ...)
>  |
>  * free_page at p(x)
> --
> 2.5.0
>
>
