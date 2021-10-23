Return-Path: <SRS0=evXM=PL=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9680C433EF
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 16:01:25 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7253B60EB8
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 16:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7253B60EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="127559"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2021 18:01:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7A410E0019; Sat, 23 Oct 2021 18:01:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0404FE0015
	for <cocci@sympa.inria.fr>; Sat, 23 Oct 2021 18:01:18 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3AzIMypaDLAM1XahVW/+fhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAFbrgWt212EExjQdDWCFM/iKYmL1f95zPoS39RsC6JaAx9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljfvTHuCU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8tA9+?=
 =?us-ascii?q?/k7v9GqEIau6Pe1bezCMMAu773UMqSi8ai87XMNIedENWgnONls94zNFltJqqS?=
 =?us-ascii?q?A5vMLekdOE1CkMHTn0hVUFB0PqdSZSliuSRyEDua3b2yPVjFwc9Oohw0u1wCmp?=
 =?us-ascii?q?P3ecJLSgEKBGFneO/hryhIsFoh8I+PIzoMZkZt3VI0z7UF7AlTIrFTqGM4sVXt?=
 =?us-ascii?q?ArcLOgm8e32PpVCL2M1NVKeM1sfZxENBYx4h+mywH/yb1VlRJuujfJfywDuIMZ?=
 =?us-ascii?q?ZidAB6OboR+E=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATJQFKKjwVy2/2hEGfoMgt/eb3HBQXscji2hC?=
 =?us-ascii?q?6mlwRA09TyXPra6TdZMgtSMc5wxhOk3I8+rrBEDtewK4yXcX2+gs1MmZLWrbUQ?=
 =?us-ascii?q?KTRekIgLcKqAeOJ8SRzIJg6Zs=3D?=
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="127547"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 18:01:19 +0200
Date: Sat, 23 Oct 2021 18:01:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
cc: cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <alpine.DEB.2.22.394.2110231758550.2967@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] update Coccinelle entry
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 27
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110231758550.2967%40hadrien>

Update mailing list and website.  Drop Michal Marek as a maintainer, who
has not participated in a long time.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

For information.  This will be in my tree.

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d46f03e5037..8746149b6623 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4594,10 +4594,9 @@ COCCINELLE/Semantic Patches (SmPL)
 M:	Julia Lawall <Julia.Lawall@inria.fr>
 M:	Gilles Muller <Gilles.Muller@inria.fr>
 M:	Nicolas Palix <nicolas.palix@imag.fr>
-M:	Michal Marek <michal.lkml@markovi.net>
-L:	cocci@systeme.lip6.fr (moderated for non-subscribers)
+L:	cocci@inria.fr (moderated for non-subscribers)
 S:	Supported
-W:	http://coccinelle.lip6.fr/
+W:	https://coccinelle.gitlabpages.inria.fr/website/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git misc
 F:	Documentation/dev-tools/coccinelle.rst
 F:	scripts/coccicheck
