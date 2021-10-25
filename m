Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF9C433EF
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 18:32:05 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9231C6023B
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 18:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9231C6023B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3A+aoEdKM+TLZhFRbvrR2zlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQfogjoqgTRUy2VLWGHTP/3eYjSgf40kbYqwpBwAscPWm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPnSG+KmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFEcK?=
 =?us-ascii?q?gir+9c0sQQ7eUMxLmZnh+AvLyxEkZ4HVsiOBiaqJ0hUR/0l1lm/h6z95GtNm3V?=
 =?us-ascii?q?gEkJIXNnv4cWl9WCUmSOIUaoOCdcSLXXcu7iheun2HX6/5pB0o3FYQC8eZ2H2x?=
 =?us-ascii?q?Us/8VMjYAalaEne3e6Li6UfJ9iMoLI8ziPYdZsXZlpRnSCvsgTJbrTKDD5Nse1?=
 =?us-ascii?q?zA17uhCFPCYZYwGaD5rbR3FeDVAP14WDNQ1m+LArnX2bTxUs1WTqaQ450DcyQV?=
 =?us-ascii?q?w1P7mN9+9UtCHA95Sg1SR4GnB5Wn/HhAcHNOawDuBtHmrg4fnljjmXIYDPLK/8?=
 =?us-ascii?q?fFujRuYwWl7IBcbU1a3oPqlok6zWtRSbVYT8Sk1xYA58EusVfH/Xxa8p3mf+BU?=
 =?us-ascii?q?bXrJ4H+Q86QyJjK7Z8Q2QAG8sSj9HYcYh8sgsSlQC3V+Tnsj1AiRv9reSRHKY6?=
 =?us-ascii?q?b6QoT6oESwUK2UDeWkPSg5t3jVJiOnflTrXVNFvVaq0lcH4Aiypk3aLqjI/jvM?=
 =?us-ascii?q?dl6Y2O2yA1Qivq1qRSlLhFGbZPjnqY18=3D?=
X-IronPort-AV: E=Sophos;i="5.87,181,1631570400"; 
   d="scan'208";a="407282"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 20:32:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3747BE001A; Mon, 25 Oct 2021 20:32:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D49DE0015
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 20:31:59 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Af+yKmahl/cEiqdFn+oGga/rkDHBQXskji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHMoB1173TJYVoqMk3I+urhBEDjex3hHPdOiOEs1NyZMzUO1l?=
 =?us-ascii?q?HFEGgv1+rf6gylKmnF+ulR2bwIScVDNOE=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397326233"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 20:31:58 +0200
Date: Mon, 25 Oct 2021 20:31:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luis Chamberlain <mcgrof@do-not-panic.com>
cc: Joe Perches <joe@perches.com>, cocci@inria.fr, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Kees Cook <kees@outflux.net>
In-Reply-To: <CAB=NE6Wk3=iRrR_U7PBpkF6=JzUtcPHf4wZ4jkArQ59GzhWhpg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110252031230.2956@hadrien>
References: <alpine.DEB.2.22.394.2110231908290.21613@hadrien> <CAB=NE6Wk3=iRrR_U7PBpkF6=JzUtcPHf4wZ4jkArQ59GzhWhpg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: update Coccinelle entry
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 37
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110252031230.2956%40hadrien>



On Mon, 25 Oct 2021, Luis Chamberlain wrote:

> On Sat, Oct 23, 2021 at 10:10 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > -L:     cocci@systeme.lip6.fr (moderated for non-subscribers)
> > +L:     cocci@inria.fr (moderated for non-subscribers)
>
> BTW if one was subscribed to the old list, does the subscription move
> over to the new one? And do posts to the old list go to the new one?

Everyone should be moved over.  I just sent a message with the subject
Test.  Let me know if you did not receive it.

julia
