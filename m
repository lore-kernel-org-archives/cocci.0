Return-Path: <SRS0=PQQq=WX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B6C3A59F
	for <cocci@archiver.kernel.org>; Tue, 27 Aug 2019 00:59:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC372070B
	for <cocci@archiver.kernel.org>; Tue, 27 Aug 2019 00:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC372070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7R0wkKm008933;
	Tue, 27 Aug 2019 02:58:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9BA5A7788;
	Tue, 27 Aug 2019 02:58:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A196C74B3
 for <cocci@systeme.lip6.fr>; Tue, 27 Aug 2019 02:58:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7R0wfEn011208
 for <cocci@systeme.lip6.fr>; Tue, 27 Aug 2019 02:58:41 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,435,1559512800"; d="scan'208";a="398956915"
Received: from unknown (HELO hadrien) ([183.173.92.181])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Aug 2019 02:58:39 +0200
Date: Tue, 27 Aug 2019 08:58:36 +0800 (CST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <17be79c5-00b6-33b0-730b-6b4b1d21f03b@web.de>
Message-ID: <alpine.DEB.2.21.1908270856160.2537@hadrien>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
 <c6f15b8d-561e-fda4-1531-191334f1142c@web.de>
 <alpine.DEB.2.21.1908251741460.2366@hadrien>
 <17be79c5-00b6-33b0-730b-6b4b1d21f03b@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1774677108-1566867521=:2537"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Aug 2019 02:58:47 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 27 Aug 2019 02:58:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking null pointer handling with SmPL
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1774677108-1566867521=:2537
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 26 Aug 2019, Markus Elfring wrote:

> > I don't know what you are trying to do.
>
> I am trying another software analysis approach out for the presentation
> of null pointer usage.
>
> Jia-Ju Bai contributed patches based on analysis results from
> the tool “STCheck” by the OSLAB group of the Tsinghua University.
> Some corresponding improvements are in the review queue.
>
> A specific script is available also for the semantic patch language.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/null/deref_null.cocci?id=a55aa89aab90fae7c815b0551b07be37db359d76
>
> Can this SmPL script become able to point remaining update candidates out
> in similar ways?

STCheck does interprocedural analysis, and has some features for path
sensitivity.  I haven't looked at these specific reports in detail, but in
general, the kinds of bugs found by STCheck may be difficult or
inconvenient to find with Coccinelle.  On the other hand, STCheck doesn't
have a particularly friendly language for specifying rules, at least not
for the moment.

julia


>
> Examples for further considerations:
> * fs: xfs: Fix possible null-pointer dereferences in xchk_da_btree_block_check_sibling()
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs/scrub/dabtree.c?id=afa1d96d1430c2138c545fb76e6dcb21222098d4
>   https://lore.kernel.org/lkml/20190729032401.28081-1-baijiaju1990@gmail.com/
>   https://lore.kernel.org/patchwork/patch/1106628/
>   https://lkml.org/lkml/2019/7/28/344
>
> * scsi: libiscsi: Fix possible null-pointer dereferences in iscsi_conn_get_addr_param()
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/libiscsi.c?id=a55aa89aab90fae7c815b0551b07be37db359d76#n3455
>   https://lore.kernel.org/lkml/20190729091339.30815-1-baijiaju1990@gmail.com/
>   https://lore.kernel.org/patchwork/patch/1106725/
>   https://lkml.org/lkml/2019/7/29/228
>
> Regards,
> Markus
>
--8323329-1774677108-1566867521=:2537
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1774677108-1566867521=:2537--
