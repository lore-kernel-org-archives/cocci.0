Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3136DC35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RCFjjh14SP8HP/Xf3gb5cvIDbvohDPCxgeAm/bKYiE4=;
  b=RtCgkm/kIIB4loj20Jm51GP9X1ZeR0lSNM+Lg/yqLr28KhEzSrRxAkTo
   Mh6R69/vKCDGE+si+WLI0R2YOJhZcn/9vd8wkKJUA/Wm3He6Aizaw5C6p
   tGfsjkcX8LcXBcE9gQCCQxP3kNjKTvYz5NNIefeCNrdXyBu1+urWwGzqs
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213708678"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 14:18:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1A2CE0D1E; Wed, 19 Mar 2025 14:18:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 537E3E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 14:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RCFjjh14SP8HP/Xf3gb5cvIDbvohDPCxgeAm/bKYiE4=;
  b=lLGqvwMzKoCfT50016k1Y4hgpDJOFcRO/mC3oxi2AThpAi78OaztR4Mo
   yvCOmx+8QcC5//kigjE+2pAjN+ohsUScofUeOfJ9Y5pfvIV0emWpDBwoe
   u+UltRMVc9Rn9m8Q0WQT283b76cfaFsJz56NwYDOw2jhfY2JaukbR3bQl
   A=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112030689"
Received: from pd9ef1166.dip0.t-ipconnect.de (HELO hadrien) ([217.239.17.102])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:18:21 +0100
Date: Wed, 19 Mar 2025 14:18:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Victor Gambier <victor.gambier@inria.fr>
cc: Olaf Hering <olaf@aepfle.de>, Jacob Keller <jacob.e.keller@intel.com>, 
    Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <7508d3f9-1b01-4e4c-84cc-14b075d62d1a@inria.fr>
Message-ID: <2d932032-5325-ffe8-f5c-28fc35c342@inria.fr>
References: <20250318111305.281abcca.olaf@aepfle.de> <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr> <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com> <20250319134816.3b7d026c.olaf@aepfle.de> <7508d3f9-1b01-4e4c-84cc-14b075d62d1a@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2650
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/2d932032-5325-ffe8-f5c-28fc35c342%40inria.fr>



On Wed, 19 Mar 2025, Victor Gambier wrote:

> For what it's worth, I am also of the opinion that we should get rid of the
> bundles.
> They create issues, both on the developer side and the user side, and I don't
> think the problem they're supposed to solve is a real problem.
> I don't like them very much. I also believe that building the Flatpak locally,
> which is now possible, is a better way of building Coccinelle without worrying
> about dependencies.

As much as I don't want to figure out how which version of pip is required
to install python packages, I absolutely do not want to learn flatpak.  I
don't want to learn anything.  I just want to download the tool, compile
it, and run it.  Avoiding cultural barriers to entry is really important
to getting people to use a tool.

julia
