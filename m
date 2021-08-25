Return-Path: <SRS0=IoeI=NQ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F72C432BE
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 08:18:41 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5C7610F7
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 08:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C5C7610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="525126187"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2021 10:18:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68163E0276; Wed, 25 Aug 2021 10:18:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 03216E0030
	for <cocci@sympa.inria.fr>; Wed, 25 Aug 2021 10:18:34 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AlSROfau+lAWOWyzbYCBkFGmR7skDd9V00zEX?=
 =?us-ascii?q?/kB9WHVpmwKj+vxG785rsiMc6QxhPE3I9urhBEDtexzhHNtOkOws1NSZLWvbUQ?=
 =?us-ascii?q?mTTb2KPbGN/9SIIUSXygce78tdmsNFY+EYY2IRsS+32njaL+od?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="525126171"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 10:18:33 +0200
Date: Wed, 25 Aug 2021 10:18:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: cocci@inria.fr
Subject: new Coccinelle mailing list
Message-ID: <alpine.DEB.2.22.394.2108251014070.7158@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-08/alpine.DEB.2.22.394.2108251014070.7158%40hadrien>

Hello,

The Coccinelle mailing list has been migrated to Inria (cocci@inria.fr).
This mailing list uses sympa rather than mailman.  It should be configured
so that everyone can view the archives.  Please let me know if there are
any problems.  I will also check that messages continue to be archived on
lore.  A few people were subscribed to receive a digest.  I am looking
into how that can be done for the new list.

julia
