Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1391C3A59D
	for <cocci@archiver.kernel.org>; Sun, 23 Oct 2022 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gvlYLCZnvD9YS3+32J6qgTeE0aMbyprViy6k30A1wKY=;
  b=KJbY9WZ3lFBjC7hAG3+hSsKXcyPO7XuYV6mSlYwKu9+2wM5JkOkaYMrl
   8Rj66hbvQLVP/YUt3txb2VOZCYUD9Odj4m0hlogJw0trTkwvS3PoXmtAw
   56INd8SjB4fiV0ESc7NExrx2XAbjtkZ6pb/bNSrpgce5DU7IM5XcXewp/
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67941802"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2022 21:43:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DE921E013D; Sun, 23 Oct 2022 21:43:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BED6CE004E
	for <cocci@sympa.inria.fr>; Sun, 23 Oct 2022 21:36:14 +0200 (CEST)
IronPort-SDR: 635597ae_HeKYv77zEzJOKVaIsimhMPwNEipTnornEQ4eAne+Fhgo+D+
 +rxOt2jY1aCOlM3ZEwGl5ik0cgqNK94VPqex1Zw==
X-IPAS-Result: =?us-ascii?q?A0A+AgCWllVjkNlUsotaHgEBCxIMQIN8gQFWLgQLRQOES?=
 =?us-ascii?q?4h+h3shaZZSh24BAwENOQsEAQGFBYRzAh0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEBAQEWCR4eBSKFaA2CNSkBg2QBBSMPAQ0BA?=
 =?us-ascii?q?TcBDwsYAgImAgIQPAsGE4J9AYMgAwMNqzuBMoEBgggBAQaBQAGFLH4DBoERL?=
 =?us-ascii?q?It+g2N6J4IphD8+gkuCDoNCgmaVVjgDRB1AAws7Mg1RHFgOCR8cDhcNBQYSA?=
 =?us-ascii?q?yBuBUEPKC9nEBscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDy0HI3EJAgMhZ?=
 =?us-ascii?q?QUDAwQoLAMJIR8HJSQ8B1g6AQQDAhAiPAYDCQMCJFeBJCYFAw0XJQgFTgQIO?=
 =?us-ascii?q?gIFBlISAgoRAxIPBidHDko+ORYGJ0QBNA8OFgNjlwKCF4E7gjHCUgcDg2KDT?=
 =?us-ascii?q?od3lQIyg2STBpInhWeROo1BmjM1gUQjgVtwgzcSATscD44gUYMhhRSFTD80A?=
 =?us-ascii?q?gE4AgYBCgEBAwkBgVaJBwEB?=
IronPort-PHdr: A9a23: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
 lgxkAQsOYzFER/+8w08ehzBoy5iyCEM
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:phph3KuCy6UH7eW7BjKU4Otg7skDS9V00zEX/kB9WHVpm6yj+v
 xGUs5rtiMcrAxhIU3I/urwQJVoIEmsk6KdhLN8AV7MZmfbUQeTTb2KqLGSuAEIeBeOkdK1t5
 0QFpSWYeeYZTMR4voSojPId+rIq+P3kpxA692/80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67941525"
X-MGA-submission: =?us-ascii?q?MDFJTSmPAkKFdwVFi4DKEtv3sMlF5lE7IuwFdj?=
 =?us-ascii?q?B19eoIC3Cxg21U0yfQCmqaZZRSevP12n5z2r2gQvWYSTa8Xstt9RTO1l?=
 =?us-ascii?q?aV+Ilhu/K5MxGMFxu26pkGMlJM0ObqAEKGMsa7TM6shG24KBHSXkYLLK?=
 =?us-ascii?q?CUMvEMA4Kz2NflNQBxVVAqsg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:36:14 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A326560F13;
	Sun, 23 Oct 2022 19:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CC9C433D6;
	Sun, 23 Oct 2022 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1666553768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvlYLCZnvD9YS3+32J6qgTeE0aMbyprViy6k30A1wKY=;
	b=OFegwhHDuKu8TFIyLECXhXgGtBj29KC+QYP3a2ZABYDOT2ziHczpWlZnXHyfzaBnYiBJ5H
	1RHHllnS/8pBd05jVqBlo+H7NoHbYxGGDre3ka+8sZ08/0++j9tDLHs1INBriPjbKPzTO6
	CgwDUJkyxk37d4wYSeLdA9VJGpx7P1s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8ed0ebcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 23 Oct 2022 19:36:08 +0000 (UTC)
Date: Sun, 23 Oct 2022 21:36:04 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Message-ID: <Y1WXpHI5mhLNEn5x@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-5b69abe2-b503-4cbd-9d94-699da8dff88d-1666467943254@3c-app-webde-bap49>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-5b69abe2-b503-4cbd-9d94-699da8dff88d-1666467943254@3c-app-webde-bap49>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Replacing special do { =?UTF-8?Q?=E2=80=A6?= } while
 loops by selected function calls
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 674
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/Y1WXpHI5mhLNEn5x%40zx2c4.com>

On Sat, Oct 22, 2022 at 09:45:43PM +0200, Markus Elfring wrote:
> > I just sent these in:
> > https://lore.kernel.org/lkml/20221022014403.3881893-5-Jason@zx2c4.com/
> 
> I suggest to reconsider the usage of SmPL ellipses in more detail
> according to your SmPL code demonstration in the description for the change
> suggestion “[PATCH v1 4/5] treewide: use get_random_u32_{above,below}()
> instead of manual loop”.

I'll do `... when != I`.
