From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 6 Oct 2013 15:49:21 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle/api: remove
 devm_request_and_ioremap.cocci
In-Reply-To: <1376562633-16204-1-git-send-email-wsa@the-dreams.de>
References: <1376562633-16204-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20131006134921.GA4173@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 15, 2013 at 12:30:25PM +0200, Wolfram Sang wrote:
> Use of this function is discouraged in favour of
> devm_ioremap_resource(). Don't advertise it.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Ping.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20131006/27cce88a/attachment.asc>
