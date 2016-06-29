From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 29 Jun 2016 21:23:57 +0200
Subject: [Cocci] [PATCH] Coccinelle: Script to replace NULL test with
 IS_ERR test for devm_ioremap_resource
In-Reply-To: <20160629183347.GA17067@amitoj-Inspiron-3542>
References: <20160629183347.GA17067@amitoj-Inspiron-3542>
Message-ID: <20160629192357.GA9260@tetsubishi>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jun 30, 2016 at 12:03:47AM +0530, Amitoj Kaur Chawla wrote:
> This script detects cases which have incorrect error handling for
> devm_ioremap_resource function, employing a NULL test instead of an
> IS_ERR() test.
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

Why don't we fix the code at the same time?

And it should not be restricted to devm_ioremap_resource() but
extensible so other functions could be added later?

(Surprised to see that we don't have such a script yet)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160629/fe60e990/attachment.asc>
