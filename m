Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EB7C5321E
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2024 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yi9R6pKfv/6cd2+VD2749fGxNjIaF1+8zRhTdbkKVB0=;
  b=GBx1eVeDve3uycSZLoTRUA9+ewP3u4C1HBNeY36DS72jkyDRuqCyqsYj
   s4kSjt3iqI/1IWBv2K64vjXEtnl2YwSBhmwrRng2MXschZIfiDW6VMeha
   +C18Yd84a8OPpk2WE6m/Lht9eo1vLojMZW5GCmamHNkxM00HM39e6rtP0
   k=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.10,175,1719871200"; 
   d="scan'208";a="179989301"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2024 21:30:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4853CE0141; Sun, 25 Aug 2024 21:30:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D1A0E00B7
	for <cocci@sympa.inria.fr>; Sun, 25 Aug 2024 21:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=yi9R6pKfv/6cd2+VD2749fGxNjIaF1+8zRhTdbkKVB0=;
  b=gzMI6cfpYjGwAlgGYQ7w2fp/9LHJOnWdYb4sSsE1H8hgV4LQ8cg1eJ8c
   bKwFGeYCowyiHLksCWsbXvOVkPamsqIOAD8ydNkdfJsNCAIpKe4zfgygP
   WN6g2RqiASXLLAx+kaGXB7oT2A10Cls1W9sh8v3W/LAI81LfeQyr4DXM5
   o=;
X-IronPort-AV: E=Sophos;i="6.10,175,1719871200"; 
   d="scan'208";a="179989295"
Received: from dmz02.dagstuhl.de (HELO hadrien) ([192.76.146.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 21:30:18 +0200
Date: Sun, 25 Aug 2024 21:30:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: cocci@inria.fr
Message-ID: <1b92fba9-8672-d14-73f9-c42a61fca6f@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] old versions of OCaml
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1864
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/1b92fba9-8672-d14-73f9-c42a61fca6f%40inria.fr>

Hello,

Due to some recent changes in OCaml, it may be difficult for Coccinelle to
continue to support some old OCaml versions.

Is anyone out there using OCaml 4.10 or earlier?

thanks,
julia
