From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 10 Sep 2013 15:21:36 +0200 (CEST)
Subject: [Cocci] if (expr) expr   ->  if (expr) { expr }
In-Reply-To: <623657CD9C4EC04888E24CFF07E08211A209D3F8@DKAAR-EXDB02.BEUMER.com>
References: <623657CD9C4EC04888E24CFF07E08211A209D3F8@DKAAR-EXDB02.BEUMER.com>
Message-ID: <alpine.DEB.2.02.1309101521170.3644@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 10 Sep 2013, Aaen, Andreas.Bach wrote:

>
> Hi,
>
> ?
>
> How can you make Coccinelle assist you in inserting braces around expressions after if
> statements?
>
> Semantically the two expressions are identical, but the variant without braces often lead to
> bugs when the code is extended.

Could you send a concrete example?

thanks,
julia
