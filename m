Return-Path: <SRS0=IoeI=NQ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525ECC4338F
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 11:06:35 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD076113C
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 11:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BD076113C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="525158876"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2021 13:06:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B285E0276; Wed, 25 Aug 2021 13:06:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77414E002F
	for <cocci@sympa.inria.fr>; Wed, 25 Aug 2021 13:06:28 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AlsCmxqsHg9PeOAsK/E4tno5G7skDRdV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qaTdZsguyMc5AxxZJhCo6HmBEDjewK/ybdN7YUdMd6ZLWrbUQ?=
 =?us-ascii?q?KTRekI0WKF+V3d8kbFm9K1u50LT0EHMqyVMbCt5fyX3ODCKadE/PC3tKqmnqPa?=
 =?us-ascii?q?x21xJDsEV51d?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="525158868"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 13:06:28 +0200
Date: Wed, 25 Aug 2021 13:06:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
Subject: Re: Checking time dimension for the migrated message archive
In-Reply-To: <379c9142-7739-e417-dece-127423b4c4a7@web.de>
Message-ID: <alpine.DEB.2.22.394.2108251303550.10017@hadrien>
References: <alpine.DEB.2.22.394.2108251014070.7158@hadrien> <379c9142-7739-e417-dece-127423b4c4a7@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-08/alpine.DEB.2.22.394.2108251303550.10017%40hadrien>



On Wed, 25 Aug 2021, Markus Elfring wrote:

> > The Coccinelle mailing list has been migrated to Inria (cocci@inria.fr).
> > This mailing list uses sympa rather than mailman.  It should be configured
> > so that everyone can view the archives.
>
> Thanks for another information.
>
>
> > Please let me know if there are any problems.
>
> Did you limit the amount of messages in the archive to this year (or even
> new data because of the switch) intentionally?
> https://sympa.inria.fr/sympa/arc/cocci/2021-08/
>
> How do you think about to extend the time range for searches in the history
> according to discussion contents?

Thanks for the report.  My first guess would be that the limitation to
this year would be because there are not messages from a year other than
this one?  I will collect the archives shortly from the previous mailing
list and put them on the website for historical purposes, but I don't know
if it's possible to propagate mailman archives to sympa.  Fortunately
there is lore which will hopefully soon be connected to the new list.

julia
