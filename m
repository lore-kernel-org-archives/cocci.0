From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 27 Apr 2014 07:14:28 +0200
Subject: [Cocci] [PATCH 1/1] scripts/coccinelle: use BIT() macro if
 possible
In-Reply-To: <1398558586-28931-1-git-send-email-javier@dowhile0.org>
References: <1398558586-28931-1-git-send-email-javier@dowhile0.org>
Message-ID: <20140427051428.GA2671@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Apr 27, 2014 at 02:29:46AM +0200, Javier Martinez Canillas wrote:
> Using the BIT() macro instead of manually shifting bits
> makes the code less error prone and also more readable.

Does it? It is a taste thing, yet I don't think it makes the code that
much more readable that it is worth changing the whole tree.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140427/a43fce6f/attachment.asc>
