From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Apr 2016 23:25:22 +0200
Subject: [Cocci] [PATCH] Coccinelle: setup_timer: Add space in front of
 parentheses
In-Reply-To: <1458451652-5933-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1458451652-5933-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <20160412212522.GC1526@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Mar 20, 2016 at 10:57:32AM +0530, Vaishali Thakkar wrote:
> Add space in front of the offending parentheses to silent the
> parse error for older Coccinelle versions. This makes the rule
> usable with all Coccinelle versions.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>

Tested-by: Wolfram Sang <wsa@the-dreams.de>

Can we have this in 4.6 as a bugfix? The script is totally broken this
way.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160412/85f8e028/attachment.asc>
