From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Dec 2014 10:09:02 +0100 (CET)
Subject: [Cocci] [patch] CodingStyle: add some more error handling
	guidelines
In-Reply-To: <20141202085950.GA13434@mwanda>
References: <20141202085950.GA13434@mwanda>
Message-ID: <alpine.DEB.2.10.1412021007560.2483@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@ -403,9 +408,10 @@ The rationale is:
>  int fun(int a)
>  {
>  	int result = 0;
> -	char *buffer = kmalloc(SIZE);
> +	char *buffer;
>
> -	if (buffer == NULL)
> +	buffer = kmalloc(SIZE);

kmalloc actually takes two arguments.  Perhaps it would be better to show
something that looks like a valid call.

Otherwise,

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

julia

> +	if (!buffer)
>  		return -ENOMEM;
>
>  	if (condition1) {
> @@ -413,14 +419,25 @@ int fun(int a)
>  			...
>  		}
>  		result = 1;
> -		goto out;
> +		goto out_buffer;
>  	}
>  	...
> -out:
> +out_buffer:
>  	kfree(buffer);
>  	return result;
>  }
>
> +A common type of bug to be aware of it "one err bugs" which look like this:
> +
> +err:
> +	kfree(foo->bar);
> +	kfree(foo);
> +	return ret;
> +
> +The bug in this code is that on some exit paths "foo" is NULL.  Normally the
> +fix for this is to split it up into two error labels "err_bar:" and "err_foo:".
> +
> +
>  		Chapter 8: Commenting
>
>  Comments are good, but there is also a danger of over-commenting.  NEVER
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
