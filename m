Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1E7C433EF
	for <cocci@archiver.kernel.org>; Mon,  9 May 2022 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3zNCuF3UUSrCa4kKKwo73HwRILJhhaoKpM3NZZ2ktEs=;
  b=l40Kg724Q2Gy4R+cPbOIWACXe0pz2ntIhy2BV0NouM+eNCG5wjYzrbSD
   P49zCDFlk6IO0nlm3nh2Oj456yl2Xd05IQ1NumH93liB5qtRbVS2DMJn+
   tktvdejipsaA6ULuoHNuefEnEJcdVp1uSX2KH1VIME9Z0Er8rGQ5h9AIV
   A=;
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
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="35329121"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2022 12:17:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 48FA4E01BE; Mon,  9 May 2022 12:17:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B55E6E009B
	for <cocci@sympa.inria.fr>; Mon,  9 May 2022 12:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3zNCuF3UUSrCa4kKKwo73HwRILJhhaoKpM3NZZ2ktEs=;
  b=OvJLWs6Z4YVDX11j2BUmW/EIKcwNk8laYLm3JdCrw+x9D0NIlhx3ZZ02
   ZGpEMsAvUJLSD/jyFOBtxr2OtJ12Bu4YCJOyf37OCD1T5IXKzl1SU12pp
   g61xuWvcWmF7wwYlfwMWDZOHxrGRU0OE1TMDvEDSJpT3o4MZx1NQdz7RS
   E=;
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="35329109"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 12:17:35 +0200
Date: Mon, 9 May 2022 12:17:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205091216530.2394@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] List global variables.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 367
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205091216530.2394%40hadrien>



On Mon, 9 May 2022, Alessandro Carminati wrote:

> Hello,I need to build a tool that just lists the global variables for a
> given c project.

@r@
type T;
identifier i;
position p : script:python(i) { p[0].current_element == i};
@@

*T i@p;

The * is just for illustration.  You can do whatever you want with i.

julia
