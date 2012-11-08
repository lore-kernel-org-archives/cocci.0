From: tipecaml@gmail.com (Cyril Roelandt)
Date: Thu, 08 Nov 2012 21:09:49 +0100
Subject: [Cocci] [Review needed] Ensure that calls to d_find_alias() are
 followed by dput().
In-Reply-To: <alpine.DEB.2.02.1211080820540.1945@localhost6.localdomain6>
References: <509B0B81.50304@gmail.com>
 <alpine.DEB.2.02.1211080820540.1945@localhost6.localdomain6>
Message-ID: <509C118D.3010109@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 11/08/2012 08:21 AM, Julia Lawall wrote:
> How many cases do you find?
>

Well, only 2 cases (in drivers/iommu/tegra-smmu.c and fs/ceph/export.c). 
It's worth noticing that the d_find_alias() function is only called 20 
times though, so this seems to be quite a common mistake.

I attached an updated semantic patch, to deal with cases where the 
dentry is assigned a new value and dput() has not been called.


WBR,
Cyril Roelandt.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: d_find_alias.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20121108/750882da/attachment.ksh>
