Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DA7C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=m9wSTOhsPsIPsGVu1ecBL/Y5QxHKzlkCEhqMt8a3Li4=;
  b=Ew2JkbWFAltib8YX/0LmJY8SoRWgufcJ+KpHHLnz3BIxsEXu2BKsORVn
   bLUKcQwd4aENkEoKO6RbmKJj4TEHewjNPHqik2lFKszCxqFjjH+Hap/1L
   cxo578QGjHxWsHQVxPGHe6ygVo0MWEzcYQ/UvMdiPtVJLkRTL7F+FJpiR
   Y=;
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
   d="scan'208";a="213709186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 14:20:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A304DE0D20; Wed, 19 Mar 2025 14:20:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 48E3DE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 14:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m9wSTOhsPsIPsGVu1ecBL/Y5QxHKzlkCEhqMt8a3Li4=;
  b=MxiuQDJtm1gUi3FTaA0ofSrJdR3zd7c1Lk0s890OGRyIUKGuFCh//3rQ
   ciDfbk4xgwWHeaIb/sufDuXWgOI6Teg+SV4ODsGjEkpfIIdLE3WrWJdCD
   bog7EAR+W8SIKSckKzrsyqiljy4mF1wu++HrWCQtkVuxPUVQ2VoNq2aak
   U=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213709164"
Received: from pd9ef1166.dip0.t-ipconnect.de (HELO hadrien) ([217.239.17.102])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:20:16 +0100
Date: Wed, 19 Mar 2025 14:20:14 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr, 
    Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <b105e7e8-2576-41f2-9ba8-0185c0a1bd7b@web.de>
Message-ID: <2b221a7-7da8-261e-f75c-edb8fff59350@inria.fr>
References: <20250318111305.281abcca.olaf@aepfle.de> <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr> <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com> <20250319134816.3b7d026c.olaf@aepfle.de> <b105e7e8-2576-41f2-9ba8-0185c0a1bd7b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2651
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/2b221a7-7da8-261e-f75c-edb8fff59350%40inria.fr>



On Wed, 19 Mar 2025, Markus Elfring wrote:

> > In case one has to actually work on coccinelle.git for whatever reason,
> > there can not be any convenience, except 'opam install coccinelle'
> > which will install all required development packages.
>
> Please reconsider such a view once more.
>
> I can occasionally prefer other software development requirements.

Opam is ocaml culture, just like pip is python culture, cargo is rust
culture, etc.  Fine if you want to be part of that culture.  Annoying if
you just want to use a tool.

julia
