Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FC0C3DA4A
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2024 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=EpOF/Muebmnrc20ICWbSbTMwZSdIHTh88/4YPF0wQcg=;
  b=vpjxRIbLMDH68zTzkukqpGhOJMBt5kFiKBOBg2cILvV0bibrEnzBr9ow
   i/LPcrNasA7fKD10SKpGFMRctFK1vBW950JnKEExIB5ipqJUmrH2PndeA
   qyhRFkLauRgTSpQ0rodZKAKa7hERVsYpoleQMehnyCSgqbJs5oEbTwzNK
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="178956311"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Aug 2024 09:22:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F65FE0145; Wed, 14 Aug 2024 09:22:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC297E0035
	for <cocci@sympa.inria.fr>; Wed, 14 Aug 2024 09:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EpOF/Muebmnrc20ICWbSbTMwZSdIHTh88/4YPF0wQcg=;
  b=DNNaYq6QjOrc57GYtjAO5x3DMD5TAIWxqw2zWVzXVYVX70gMGO5n+SUR
   alJb812bKIktjLqcR/w9qifrsgSJYYXJmd491mcO18pQAvRSDVaewogVr
   kjpBj/dGOW+lKRQHp90l7W++zA7jjJLtkSHwlkqVY1m4Ze5897RfHH+Ra
   4=;
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="178956296"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 09:21:59 +0200
Date: Wed, 14 Aug 2024 09:21:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Andrzej Hajda <andrzej.hajda@intel.com>
cc: Peter Senna Tschudin <peter.senna@gmail.com>, 
    Peter Senna Tschudin <peter.senna@linux.intel.com>, cocci@inria.fr
In-Reply-To: <03d047e0-577c-4c39-b75e-6f8fb998ae57@intel.com>
Message-ID: <3ff57fbc-3083-511b-cd3e-6230d99ef2f8@inria.fr>
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com> <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr> <CA+MoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ@mail.gmail.com> <1e637cb0-24cd-dc10-9178-69f314598ce@inria.fr>
 <03d047e0-577c-4c39-b75e-6f8fb998ae57@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-287869659-1723620119=:3440"
Subject: Re: [cocci] Iterator macros
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1855
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/3ff57fbc-3083-511b-cd3e-6230d99ef2f8%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-287869659-1723620119=:3440
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> Try run for example:
> $ spatch --parse-c tests/intel/gem_ctx_exec.c
> ...
> NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
> nb good = 385,  nb passed = 19 =========> 3.12% passed
> nb good = 385,  nb bad = 204 =========> 66.45% good or passed
>
> As I understand, lines marked as "bad" are skipped during cocci pass, am I
> right?
> Some workaround is to define iterators by hand in the script or include files.

With the definitions I mentioned, this file is at 100%.

julia
--8323329-287869659-1723620119=:3440--
