From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 8 Oct 2018 13:21:14 +0200
Subject: [Cocci] uses of Coccinelle
In-Reply-To: <alpine.DEB.2.21.1810070800560.2347@hadrien>
References: <alpine.DEB.2.21.1810070800560.2347@hadrien>
Message-ID: <ec787a03-2394-c3db-f439-f49131dc2853@embeddedor.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On 10/7/18 8:02 AM, Julia Lawall wrote:
> Hello,
> 
> It would be helpful to me to have a list of some things that Coccinelle
> has recently been used for.  A one sentence description, would be quite
> sufficient.
> 

I have used Coccinelle for the following list of things:

- Fix duplicate code
- Add NULL checks on function return values (like devm_kzalloc() and devm_kmemdup())
- Fix error return codes
- Fix NULL pointer dereferences
- Replace open-code with the swap macro
- Constification
- Use true and false for boolean values
- Remove unnecessary NULL checks
- Replace open-code with the PTR_ERR_OR_ZERO macro
- Replace PTR_RET with PTR_ERR_OR_ZERO
- Fix inconsistent IS_ERR and PTR_ERR
- Fix uninitialized variables
- Replace open-code with the ARRAY_SIZE macro
- Fix application of sizeof to pointer
- Fix incorrect bit mask
- Use BUG_ON instead of if condition followed by BUG
- Compress return logic into one line
- Remove unnecessary cast on kmalloc
- Identify potential integer overflows during memory allocation

Thanks
--
Gustavo
