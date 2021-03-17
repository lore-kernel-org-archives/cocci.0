Return-Path: <SRS0=Sj7A=IP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC76C433DB
	for <cocci@archiver.kernel.org>; Wed, 17 Mar 2021 20:32:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFA264F0F
	for <cocci@archiver.kernel.org>; Wed, 17 Mar 2021 20:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFA264F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12HKWEWu011230;
	Wed, 17 Mar 2021 21:32:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6B80877CD;
	Wed, 17 Mar 2021 21:32:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8B0A424DD
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 21:32:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12HKWDLc011428
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 21:32:13 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8Wj5HKNZ5Hie+8BcTiCjsMiAIKoaSvp033AA?=
 =?us-ascii?q?0UdtRRtJNvGJjszGpoV+6TbYgCscMUtKpfmuI6+FKEm3ybdU5s0rMa6mTE3avg?=
 =?us-ascii?q?KTTb1KyavH73neFzbl9uhbvJ0QFpRWLNHrF1B1gYLbzWCDc+oI+9WM/KC2ieq2?=
 =?us-ascii?q?9R4EcShQZ65t9At/AAqAe3cGJzVuP4YzF5aX+6N8yQaIRHJ/VKiGL0UeU/OGj9?=
 =?us-ascii?q?PGk4+OW29lOzcXrDjLtz+u5bLgeiL04j4VWVp0rosfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,257,1610406000"; d="scan'208";a="376060724"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 21:32:12 +0100
Date: Wed, 17 Mar 2021 21:32:12 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <c62bd578-1f83-d876-d6f1-cc39513ecbd9@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103172131210.2981@hadrien>
References: <c62bd578-1f83-d876-d6f1-cc39513ecbd9@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Mar 2021 21:32:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Mar 2021 21:32:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Incorrect match with when != condition
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Wed, 17 Mar 2021, Denis Efremov wrote:

> Hi,
>
> I'm trying to write the check to detect the absence of commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=51b2ee7d006a736a9126e8111d1f24e4fd0afaa6
> in kernel. The pattern can be:
>
> @err exists@
> identifier namlen, dchild, dparent, exp;
> position p;
> statement S;
> @@
>
> compose_entry_fh(..., int namlen, ...)
> {
> 	...
> 	if (namlen == 2) {
> *		dchild =@p dget_parent(dparent);
> 		... when != dparent == exp->ex_path.dentry

add when forall here.  There does exist a path that does not contain the
dparent == exp->ex_path.dentry test.  That is the path that takesthe first
goto out.

julia

> 	} else S
> 	...
> }
>
> But unfortunately, it matches even the fixed source. I think
> that condition "... when != dparent == exp->ex_path.dentry" doesn't
> work as expected. Steps to reproduce:
>
> $ cd linux # latest master branch
> $ wget
> https://raw.githubusercontent.com/evdenis/cvehound/b2d109c959c299dce10274c1806406fc5653e5d0/cvehound/cve/CVE-2021-3178.cocci
> $ spatch -D detect --cocci-file CVE-2021-3178.cocci fs/nfsd/nfs3xdr.c
> fs/nfsd/nfs3xdr.c:935:10-11: ERROR: CVE-2021-3178
> diff =
> --- fs/nfsd/nfs3xdr.c
> +++ /tmp/cocci-output-526900-b87df1-nfs3xdr.c
> @@ -932,7 +932,6 @@ compose_entry_fh(struct nfsd3_readdirres
>          if (isdotent(name, namlen)) {
>                 if (namlen == 2) {
> 			// !!! shouldn't match because of if (dparent ==
> exp->ex_path.dentry) goto out; check after
> -                       dchild = dget_parent(dparent);
>                         /*
>                          * Don't return filehandle for ".." if we're at
>                          * the filesystem or export root:
> $ spatch --version
> spatch version 1.1.0 compiled with OCaml version 4.11.1
>
> Thanks,
> Denis
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
