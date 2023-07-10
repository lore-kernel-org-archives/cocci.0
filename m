Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B65EB64D9
	for <cocci@archiver.kernel.org>; Mon, 10 Jul 2023 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jYSB+mieq3qfdbcT4hmvTeMNRtC47qVCeFAchnB04Aw=;
  b=N4fhNMuVVQpUtNwSwQDLuky5OIIaYo4IwpwDvhlrHDKocMzoo3MaHiE4
   TEZ5LX7B2nfnql6NqLG/KX4BZJh8GMGr9LPymM4xzbUvaJ6VEa1wHQcmt
   RnGnEbGu6NPE6avSdGfWMSFouRZmakdN1d9/2iFSqNaN3wjJug9blUiaf
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linuxfoundation.org
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="116964812"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jul 2023 19:44:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5D43E0D54; Mon, 10 Jul 2023 19:44:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 414EDE00B6
	for <cocci@sympa.inria.fr>; Mon, 10 Jul 2023 19:12:45 +0200 (CEST)
IronPort-SDR: 64ac3c0d_QdVqzmeSZKgSo+h1cB7fpWevgf2io7aIsadU1kwVNjjpkJX
 iEXhgCIxbJiGNXA2s4gwH3M5H01rt/+UWTsPJXw==
X-IPAS-Result: =?us-ascii?q?A0EDAACdOqxkkNlUsotaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYIydVYwBAtHjG9fhjuCJ4VzjECFZYVagSUDV?=
 =?us-ascii?q?g8BAwENOwkEAQEDBIR/AoYfAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBQECEAEBAQEBASAeEA4nhWgNgjcpAXWBCAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CDXkBAgM6BgEBNwEPCxguVwYTgn4BglwDAw4GqXSBNIEBggkBAQaydQMGg?=
 =?us-ascii?q?UIBh38BhH6DfnonG4INhEA+gmIEiCCOIYVXB4NHih2BJ2+BHoEeegIJAhFng?=
 =?us-ascii?q?QgIXoFwPgINVQsLY4Ecgk0CAhEnExRTeBsDBwOBBRAvBwQvHQkGCRgYFyUGU?=
 =?us-ascii?q?QctJAkTFUEEg1MKgQk/FQ4RglIrNjsbTYJqCRcONVN+EDEEFB11A0QdQAN7P?=
 =?us-ascii?q?TUUGwYlAUmBVzCBRCQkom0DP4InRIE5UIEtxSSEFYt9lR9FlwKSRC6HQJA4i?=
 =?us-ascii?q?2uBdJpfgWM6PIEgMxoIKAiDIhM8AxkPjiAZHohRimc/NAIBOAIHCwEBAwmLS?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
 wGG3TxZdzpUP8c=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5LnohKEHtozn4KjFpLqE58eALOsnbusQ8zAXPo5KKCC9Vvbo8P
 xG/c5rsSMc7Qx9ZJhOo7y90cW7Lk80sKQFh7X5Xo3SOTUO2lHYT72KhLGKq1aLJ8S9zJ8+6U
 4KSchD4bPLY2RHsQ==
X-Talos-CUID: 9a23:gxvINGHBoS4iohmAqmJ42nE7KOF+UEHilnuKAhC1MV9SF6asHAo=
X-Talos-MUID: 9a23:wPLJxQYIqCB3zeBTvGXxgj9YNOBRw6n0GHAKrssvhZmdDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="116962524"
X-MGA-submission: =?us-ascii?q?MDEYWRkuycUTKDyMkBmHohXkJxh8G0vZi6enWo?=
 =?us-ascii?q?j9Qgf7mmHQSuJYHbICVCx9MezaBv6CmIAk/wiBihSZ8UYafCjmQeqgCR?=
 =?us-ascii?q?yHBOcIh/L/dD8xDF13Zl+e15CZs1VAofBNRBh+CcM0AQw17C8Qj0F+z+?=
 =?us-ascii?q?6UuRtFDQgu56WN5BJ5LD4gNA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:12:44 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AB6E261127;
	Mon, 10 Jul 2023 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B067DC433C8;
	Mon, 10 Jul 2023 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689009161;
	bh=Qtl+hxmukqB8zjd/I8ng8xkRJV7hErdY/DKxeZGpp70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIBPfXFOHz8lPi/2vbyPct1ImRyBxadGsoe7AisEDvJrri4pIIfePYsOkIMufAFBP
	 NOkIiw/qIqnVyMe/xgE3OVfNeoiPGQvSgtcyyJ9Z1CT3CvN200dZVCuELDC5uxAKAI
	 /E0NC1ZCxauy8rvd/z+7yn0gztm422gtkXxiGnCA=
Date: Mon, 10 Jul 2023 19:12:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2023071029-liqueur-vowel-ab42@gregkh>
References: <20230710170652.473788-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710170652.473788-1-seanjc@google.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
Reply-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 1214
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-07/2023071029-liqueur-vowel-ab42%40gregkh>

On Mon, Jul 10, 2023 at 10:06:52AM -0700, Sean Christopherson wrote:
> Remove coccinelle's recommendation to use DEFINE_SIMPLE_ATTRIBUTE()
> instead of DEFINE_SIMPLE_ATTRIBUTE().  Regardless of whether or not the
> "significant overhead" incurred by debugfs_create_file() is actually
> meaningful, warnings from the script have led to a rash of low-quality
> patches that have sowed confusion and consumed maintainer time for little
> to no benefit.  There have been no less than four attempts to "fix" KVM,
> and a quick search on lore shows that KVM is not alone.
> 
> This reverts commit 5103068eaca290f890a30aae70085fac44cecaf6.
> 
> Link: https://lore.kernel.org/all/87tu2nbnz3.fsf@mpe.ellerman.id.au
> Link: https://lore.kernel.org/all/c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com
> Link: https://lkml.kernel.org/r/20230706072954.4881-1-duminjie%40vivo.com
> Link: https://lore.kernel.org/all/Y2FsbufV00jbyF0B@google.com
> Link: https://lore.kernel.org/all/Y2ENJJ1YiSg5oHiy@orome
> Link: https://lore.kernel.org/all/7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
