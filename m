Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6720C43334
	for <cocci@archiver.kernel.org>; Sat,  4 Jun 2022 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hgzbNPV3iLUWh7tDf3IdMGo3CmfkfpL5bTFs5RTOp90=;
  b=SNiOonJUaIMbcHWRPt8AbuvJZ2fIUUVPaMOrde9+aj9yYgdAotNESdoB
   GwtlJ7rkO2Jaxx5/Wfk5vMpdJZ/6HqUUrvu/mYJtGkj4dj6eJbMHedRQZ
   Db7HOfeoj02+J2D/ztJmy4MSKKO9Zpk6vIu3kAeD5eUFprR8pokvuQRuo
   M=;
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
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39502856"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2022 15:26:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3F4FE02B4; Sat,  4 Jun 2022 15:26:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D6D4CE007E
	for <cocci@sympa.inria.fr>; Sat,  4 Jun 2022 15:26:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hgzbNPV3iLUWh7tDf3IdMGo3CmfkfpL5bTFs5RTOp90=;
  b=gNx6m5ITwDJ4jo6Yk0rwacwLHOZQVIpUOBhbpQre2rJ6MXg6B7d+QglZ
   OBGSZfyrT1kHR6U3LXwXWBdFGc9e5Vw6N+lYMm4dYuD9jjkuwXr5R/mQJ
   YnFAa1Yh6MKyfs2JlBZ4vq9J1vhnhbEdjuXhVHiZ48whpAZZ7BfoFb9ZZ
   Y=;
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="15922284"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 15:26:46 +0200
Date: Sat, 4 Jun 2022 15:26:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thomas Klausner <wiz@gatalith.at>
cc: cocci@inria.fr
In-Reply-To: <YptMBWjnTCgTQJVD@yt.nih.at>
Message-ID: <alpine.DEB.2.22.394.2206041526360.31956@hadrien>
References: <YptMBWjnTCgTQJVD@yt.nih.at>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] coccinelle PR#280: Fix unportable test(1) operator
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 413
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206041526360.31956%40hadrien>



On Sat, 4 Jun 2022, Thomas Klausner wrote:

> Hi!
>
> I've filed pull request 280 on github and was asked to present the
> patch to this mailing list.
>
> It fixes an unportable test(1) operator in the configure.ac script.

Thanks for the fix.

julia
