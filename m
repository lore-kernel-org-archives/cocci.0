Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3563AD116F3
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bhNrll062hQ3sGZSJezdtIBztLX54G0Ur1DBtvkAY30=;
  b=CkcQHHqK1E6zVgYfgSeMyPw3Jj1QFsrAqIQcjomC/519OX2At5P/sZPP
   j7ZD8e7U/ADXC0F2OemoBxc+4R9fStEzWkN4HckJ34zzLhqLQhdn6wg5W
   Ui0vgBhp3bwexerz2eoTowelRAawlsyzpnXQFBzlr8wm20pRFKo2LhhKr
   E=;
X-CSE-ConnectionGUID: yB1QaO6sSGSa61IHm5v0xA==
X-CSE-MsgGUID: biIMGjtrSFiGfpslsvrjcw==
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
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252168158"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 16:35:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77527E0CD5; Mon,  1 Dec 2025 16:35:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 86815E0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 16:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bhNrll062hQ3sGZSJezdtIBztLX54G0Ur1DBtvkAY30=;
  b=ucn2g5qVmYWRY9EziwGq4Ix31LytYvOFzeJpp6gCjumWXrH5/mj2LFHt
   bJ98HpkKg7+XQ89/IFzFNodx/gTDbKoKvlGdKQdeCzBG97zDIQBVA5OGx
   jTQsws+kD8izRUo6OGyAzwvXQnYnb6RzT1ZbxiPVRPyoy4pGs24V4dXGQ
   s=;
X-CSE-ConnectionGUID: Hg+CQKspTYemvYGWU3YohA==
X-CSE-MsgGUID: /EmbK3acRtmcA9x9BtH3Mw==
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="132447349"
Received: from unknown (HELO hadrien) ([41.193.224.162])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 16:35:53 +0100
Date: Mon, 1 Dec 2025 17:35:50 +0200 (SAST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tobias Deiminger <tobias.deiminger@posteo.de>
cc: cocci@inria.fr
In-Reply-To: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
Message-ID: <5013c5b-d899-bd2d-520-f3216077fc@inria.fr>
References: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] bug: Matching a specific declarer actually matches any
 declarer
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3230
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/5013c5b-d899-bd2d-520-f3216077fc%40inria.fr>



On Mon, 1 Dec 2025, Tobias Deiminger wrote:

> Hi,
>
> to reproduce the issue, try mutex2.cocci from coccinellery [1] with the code
> below.
>
> Expectation: Only spin_lock calls where the variable was declared with
> DEFINE_MUTEX() are patched.
>
> Actual: The declarer name seems to be ignored. All spin_lock calls are
> patched, regardless of the declarer name
>
> // mutex2.c
> DEFINE_MUTEX(my_mutex);
> OTHER_DECLARER(other_mutex);
>
> void main() {
>     // this should be changed, declarer was DEFINE_MUTEX
>     spin_lock(&my_mutex);
>
>     // this should not be changed, declarer was OTHER_DECLARER
>     spin_lock(&other_mutex)
> }
>
> // mutex2.cocci
> @def@
> declarer DEFINE_MUTEX;

This should be declarer name, not declarer.  Declarer matches any declarer
name.

julia

> identifier m;
> @@
>
> DEFINE_MUTEX(m);
>
> @@
> identifier def.m;
> @@
>
> (
> - spin_lock(&m)
> + mutex_lock(&m)
> |
> - spin_unlock(&m)
> + mutex_unlock(&m)
> )
>
> The unexpected result:
>
> $ spatch --sp-file mutex2.cocci mutex2.c
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> HANDLING: mutex2.c
> SPECIAL NAMES: adding OTHER_DECLARER as a declarer
> diff =
> --- mutex2.c
> +++ /tmp/cocci-output-71243-6eaa4e-my.c
> @@ -3,8 +3,8 @@ OTHER_DECLARER(other_mutex);
>
>  void main() {
>      // this should be changed, declarer was DEFINE_MUTEX
> -    spin_lock(&my_mutex);
> +    mutex_lock(&my_mutex);
>
>      // this should not be changed, declarer was OTHER_DECLARER
> -    spin_lock(&other_mutex)
> +    mutex_lock(&other_mutex)
>  }
>
>
> Could you confirm, and maybe suggest a workaround? I used the coccinellery
> example as reproducer because it's public, but actually stumbled upon the
> issue in a simpler case: I searched for all occurrences of
> DEVICE_ATTR_RO(attr) in the Linux kernel, but actually found every place where
> *any* macro was used to declare something.
>
> Cheers
> Tobias
>
> PS: I'm using spatch 1.3 from Debian trixie.
>
> [1] https://github.com/coccinelle/coccinellery/blob/master/cris/mutex2.cocci
>
