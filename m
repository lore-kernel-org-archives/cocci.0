Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED67C0219B
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=c3aWFIlPBUoecC2ouhNVj7O4qfPzDKEyFH1mNGkCda4=;
  b=HSQXXURp0JZKUhWw9vEWSYLX4P4hMLfJdi4rGIB+8ayxj86JiaaF8Xw2
   Pp/6eLhdA/lOP7M0W/2k1orM9uUN4IhJtkzA8MFrDuhR+TUsqqSIVogJ+
   IVhj/TwFiJly55BkLBgvnriZ19hb486gyIJWZFxrPvx4HFJ+SaDoEy8YM
   o=;
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
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207775108"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 18:44:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9DDB8E0D1D; Tue, 11 Feb 2025 18:44:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BB08DE0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 18:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c3aWFIlPBUoecC2ouhNVj7O4qfPzDKEyFH1mNGkCda4=;
  b=poamxdiYuTrhI/P+Sij+GcrJ1maz5GTb6VRgqVpnGB2abJTsONRPjMOX
   O0139t2Fqsx4MlMuywbEAKDYJJxBzpfRpivAeZ5q6u7+o3d0nT2COL2Ua
   NShkLZMtmddcj+3Ld50ZHVePDW6is+TCqaGX70kM8RV/a9xJyeLUbZ9pc
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="108819033"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:44:30 +0100
Date: Tue, 11 Feb 2025 18:44:30 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
cc: cocci@inria.fr
In-Reply-To: <537594832.54620672.1739295352359.JavaMail.zimbra@synchrotron-soleil.fr>
Message-ID: <24871c64-9c5d-238c-201e-d76988bed1a@inria.fr>
References: <537594832.54620672.1739295352359.JavaMail.zimbra@synchrotron-soleil.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] how to write an spatch in order to replace guard vs
 #prama once
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2410
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/24871c64-9c5d-238c-201e-d76988bed1a%40inria.fr>



On Tue, 11 Feb 2025, PICCA Frederic-Emmanuel wrote:

> Hello,
>
> I am trying to write an spatch in order to replace  in my code, the header guard, by the #pragma once.
>
> Is there somewhere a repository of spatches, where I can inspire myself ?

Could you make a small example of what you are trying to do?

There is this page, but I don't know if it has examples related to
#pragma,

http://coccinellery.org/

julia
