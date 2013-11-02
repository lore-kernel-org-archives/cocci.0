From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 22:01:41 +0100 (CET)
Subject: [Cocci] Matching an absence of statements before the closing
 brace of a function?
In-Reply-To: <20131102155224.GX15704@leaf>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021455070.2261@hadrien> <20131102145412.GT15704@leaf>
 <alpine.DEB.2.02.1311021555360.2261@hadrien> <20131102155224.GX15704@leaf>
Message-ID: <alpine.DEB.2.02.1311022158150.2028@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> --- a/lib/xz/xz_crc32.c
> +++ b/lib/xz/xz_crc32.c
> @@ -43,7 +43,7 @@ XZ_EXTERN void xz_crc32_init(void)
>  		xz_crc32_table[i] = r;
>  	}
>  
> -	return;
> +	RETURN;
>  }
>  
>  XZ_EXTERN uint32_t xz_crc32(const uint8_t *buf, size_t size, uint32_t crc)

This is indeed a parsing problem.  When it has the whole file, when it
comes to the definition of xz_crc32 it is able to detect that XZ_EXTERN is
something that it should ignore.  But after it makes the transformation in
xz_crc32_init, it reparses just that function and does not obtain this
information.

Perhaps it is possible to fix.  But I have the impression that I undid
something in this regard, because it is not always desirable to use the
macro information inferred from one part of a file in parsing things
elsewhere in the file, so fixing this problem may break something else...

julia
