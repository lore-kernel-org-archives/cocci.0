From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 1 Feb 2018 13:25:01 +0300
Subject: [Cocci] [PATCH] coccinelle: reduce false positives
In-Reply-To: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20180201102501.kc5pfxojn7fhxat4@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Feb 01, 2018 at 10:48:52AM +0100, Julia Lawall wrote:
> Some files use both a non-devm allocation and a devm_allocation.  Don't
> complain about a free when the same function contains a non-devm
> allocation.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

That's surprising...  Do you have an example false positive?

regards,
dan carpenter
