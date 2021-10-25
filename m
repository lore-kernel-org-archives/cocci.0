Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B077FC433F5
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 18:31:28 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6759D60FE8
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 18:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6759D60FE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3A1weE4KvRUW0Jdg19yPcfebFLNefnVEBfMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3nDMWDWqGO/iNZDGjco0kOoXk8E9TvZbcztM1HQJs/ClgHilAw?=
 =?us-ascii?q?SbnLYTAfx2oZ0t+DeWaERk5t51GAjX4wXFdokb0/n9BCZC86ykjvU20buCkUre?=
 =?us-ascii?q?dYnosHVUMpBoJ0nqPpcZo2+aEvvDpW2thifuqyyHuEAfNNwxcagr42IrfwP9bh?=
 =?us-ascii?q?8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UYgrkExkR5tO?=
 =?us-ascii?q?Nyt4Xc2URU7vKNE6PjGBXUu6smHCupARriPZ9ZaFaMBkNzWzXx7idy/0U3XC0Y?=
 =?us-ascii?q?QwuNabN3eMCVRRCOyB4J6xPvrHdSZS6mZDLkBefKhMAxN0rVinaJ7Yw8eF8CmB?=
 =?us-ascii?q?m/OYTKDETYwrFhO+sxr+/DO52iawLJsjwJ5IRtFlvyDjYCbAtRpWra67N6NlV2?=
 =?us-ascii?q?h8/g8lPGbDVYM9xQTZmalLCJQJOPlMWAZcltOitj3j7NTZfrTq9qaMp4mTIywp?=
 =?us-ascii?q?93rfpGNXQc92OA85Smy6wqm+A5GPkEBhcP9uFxDyZ83SEierGnCe9U4UXfJWz7?=
 =?us-ascii?q?eNuhEy7yWsUBxkbE1C8pJGRgEO4Vt5eKFA8+icvq6V07kugTcKVdxa8p3mflhw?=
 =?us-ascii?q?cUN5XFPZ84waIooLY6gCYC2xCSjNTY9Ugs+cyRDojzFjPmMnmbRRksKeUUm6a7?=
 =?us-ascii?q?rfSpzS/OS0KJGsOaDUsSQoD6dj/5oo0i3ryonxLeEKupsXvHj21xzGRsCUlmux?=
 =?us-ascii?q?Dy88NzaSyu17d6w9Ab6PhFmYdjjg7lEr5hu+hWLOYWg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,181,1631570400"; 
   d="scan'208";a="407211"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 20:31:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EFA5E001B; Mon, 25 Oct 2021 20:31:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BF214E0015
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 20:31:21 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2Osde69ShhdIr+RDsJJuk+DLI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlEfBw+PrEoB1273XJYVUqOE3I++rvBEDoexq1yXcf2+Ys1NmZMDUO9F?=
 =?us-ascii?q?HIEKhSqbqn+THmFiHkn9Qx6Ztd?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397326202"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 20:31:21 +0200
Date: Mon, 25 Oct 2021 20:31:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: cocci@inria.fr
Message-ID: <alpine.DEB.2.22.394.2110252031050.2956@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] test
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 36
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110252031050.2956%40hadrien>

Sorry for the noise.
