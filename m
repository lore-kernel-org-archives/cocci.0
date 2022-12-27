Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4549BC4332F
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=6HoRXJ+NVIqeoMc/Lc1KNCtc5Y+sL5DZHNkblMNv6i4=;
  b=QIiTf2NduqdTq5xpSM4I57HYvFIhCUFWQIer0cb8LZnHWIoRteXx0bFX
   LBtdLFE58nFVNBUz5x/Z5O6vRDc8VwYRDmV3sPFf7BEH2f7vM5CFaNw2S
   HOIkY5SbzFB4l4FnepcBCD9p4Z5L7waSl94g77u8+M19BuXv4v7YgCwhG
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85153885"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 13:53:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 514DAE0133; Tue, 27 Dec 2022 13:53:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2BAECE0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 13:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6HoRXJ+NVIqeoMc/Lc1KNCtc5Y+sL5DZHNkblMNv6i4=;
  b=cAYzTKfbx9ZiYn47EnU0vChUjt5Jv2wIQL1MVOHYG0Ijey5S+iONSOgb
   V3fP2Mz5AVW6fYe3lSFn6gSGwwtC2WMhx5aomZO5YApVkoWGNPLur9lsA
   D72kgwEA/j4dGhIw5vZgvLRQYOQAn+WfWV4crtM+fNfdArYOFq/0hSuno
   U=;
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="43695142"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 13:53:33 +0100
Date: Tue, 27 Dec 2022 13:53:33 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <4ee46301-0ce0-58c6-38da-4d87dfbaa5b4@web.de>
Message-ID: <df343d6f-dd63-e4c4-4431-cfd2861a698@inria.fr>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de> <alpine.DEB.2.22.394.2212260740380.2980@hadrien> <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de> <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr> <29059e41-6c8e-56d9-48c0-d4cc61e02e77@web.de>
 <alpine.DEB.2.22.394.2212271047470.2927@hadrien> <4ee46301-0ce0-58c6-38da-4d87dfbaa5b4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Another extension for the software documentation
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 803
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/df343d6f-dd63-e4c4-4431-cfd2861a698%40inria.fr>



On Tue, 27 Dec 2022, Markus Elfring wrote:

> >>> Lists can be empty.
> >>
> >> Are you going to add this information to the SmPL manual?
> >>
> >> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15af39865329c2fe23460d/docs/manual/cocci_syntax.tex#L315
> > OK
>
>
> Thanks for your tiny documentation adjustment.
>
> make clear that list metavariables can match nothing
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b9603af4eca7f4c771d57a3861855332e9bb1c4c
>
>
> Can it occasionally be required that such list metavariables should match
> one item at least?

When you have a list metavariable, you can access the size, and then you
can use some script code to ensure that the size is greater than 0.

julia
