Return-Path: <SRS0=evXM=PL=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CAC433EF
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 17:10:11 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0890960FE3
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 17:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0890960FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="130441"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2021 19:10:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D9F0E001A; Sat, 23 Oct 2021 19:10:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D8D3BE0015
	for <cocci@sympa.inria.fr>; Sat, 23 Oct 2021 19:10:06 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3AxP+HLKuoygOErUJZx+N1dDrC6+fnVI5cMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3mGQaCD2FOPuIZzT2coxzaNjgoRlU65XQm9c3T1Y9ryhgHilAw?=
 =?us-ascii?q?SbnLYTAfx2oZ0t+DeWaERk5t51GAjX4wXFdokb0/n9BCZC86ykjvU20buCkUre?=
 =?us-ascii?q?dYnoqHVUMpBoJ0nqPpcZo2+aEvvDpW2thifuqyyHuEAfNNwxcagr42IrfwP9bh?=
 =?us-ascii?q?8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UYgrkExkR5tO?=
 =?us-ascii?q?Nyt4Xc2UKS7LIPAWI4pZUc/j/xEYS4HVoi+Bia6F0hUR/0l1lm/hz1dFMvNq0Q?=
 =?us-ascii?q?BggOqnkmeIHUhAeHTsW0ahuoeSffSPu2SCU5wicG5f2+N1sC0weJYAC8eZ6Gid?=
 =?us-ascii?q?F8vlwADsKZRuCr/mnxaqyDOhqnMUqasfxVKsbu3d93XTaAOwgTJTrXarH/5lb0?=
 =?us-ascii?q?S02i8QIGuzRD+IaZDd0RBPdfxNLJ0dRDp8i9NpELFGXnyZw8Q3O4/Ntui6NnEo?=
 =?us-ascii?q?hjf73PcSTYdKQA8NYgi6lSqv91zyRKnkn2Ba3kFJpKk6Ru9I=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/gNfSa5vvsDE8WBqigPXwNHXdLJyesId70hD?=
 =?us-ascii?q?6qkRc31om6mj/PxG885w6faKslYssR0b9OxoW5PvfZq/z/JICOAqVN+ftWLd11?=
 =?us-ascii?q?dAJbsSjrff/w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="130439"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 19:10:06 +0200
Date: Sat, 23 Oct 2021 19:10:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org, Kees Cook <kees@outflux.net>
Message-ID: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] [PATCH v2] coccinelle: update Coccinelle entry
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 30
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110231908290.21613%40hadrien>

Update mailing list, website, and tree.  Drop Michal Marek as a
maintainer, who has not participated in a long time.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

v2: adjust tree

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d46f03e5037..3548f956f734 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4594,11 +4594,10 @@ COCCINELLE/Semantic Patches (SmPL)
 M:	Julia Lawall <Julia.Lawall@inria.fr>
 M:	Gilles Muller <Gilles.Muller@inria.fr>
 M:	Nicolas Palix <nicolas.palix@imag.fr>
-M:	Michal Marek <michal.lkml@markovi.net>
-L:	cocci@systeme.lip6.fr (moderated for non-subscribers)
+L:	cocci@inria.fr (moderated for non-subscribers)
 S:	Supported
-W:	http://coccinelle.lip6.fr/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git misc
+W:	https://coccinelle.gitlabpages.inria.fr/website/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux.git
 F:	Documentation/dev-tools/coccinelle.rst
 F:	scripts/coccicheck
 F:	scripts/coccinelle/
