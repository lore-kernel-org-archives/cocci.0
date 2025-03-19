Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCFC35FFF
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+7fXOIfFeM9Aco63gs4Udu4ZnJGtc0O2KA6Zu0PvAB0=;
  b=qpgW1qgOTKVcngpGnvgoRK3zgBxeWA6v1HvrhFbej5BN3dZZB22qwx0u
   nF1b2YQmhMtmiWKjc93DsKM03ab+bEHztfAVgamm2PYszk8cYOcRLGdAJ
   7Je23mGzobinXIIPb+eA57IafJNOzQN18fJ08h8ksV2hsJZLNMUiBQG2J
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213652536"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 10:29:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B8FA5E0D82; Wed, 19 Mar 2025 10:29:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D4C4E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 04:31:33 +0100 (CET)
IronPort-SDR: 67da3a94_iSdjj0vmjxPEG3DeP2MC+J1ni4il1xBysxvzRx2qGtEj93B
 GHOkI09j6ITnZl4JYp7aYDVvVgNHwFH6CNRSplA==
X-IPAS-Result: =?us-ascii?q?A0EBAAD5Odpnj1vBS5NaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBAtIjHNfhlSCJJJMi0iBfg8BAwENR?=
 =?us-ascii?q?AQBAQMEhQACiyACHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBAQEBOQUOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBA?=
 =?us-ascii?q?ycTBgEBNwEPCxguVgaDFYJlA64ogQEzgQGCDAEBBtwggWUJgUgBhWyCYwGGM?=
 =?us-ascii?q?IMUJXonG4INgRWDKj6IWIIvgjOBaYM/iU6IVJgZUnscA1ksAUsKExcLBwU5K?=
 =?us-ascii?q?EhDA4EPI4EiBTQ/OCmBY2lJOgINAjWCCBNdH4IogheCNoQ+gzCBEIFlg2uCE?=
 =?us-ascii?q?YFdAwMiAYIwb3ccgxaBKz+EYS1QghQdQAMLbT03FBsGpCiFGzaCOZQOj1KCI?=
 =?us-ascii?q?KEGhCWBY6AyE4E4lXuTES6YUKkzgWc6gVwzGggoCIMiTwMZD44hGYh0sCgjN?=
 =?us-ascii?q?TwCBwsBAQMJkByBSwEB?=
IronPort-PHdr: A9a23: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
 MM3ht1juVerlq+I0DU1CHJz
IronPort-Data: A9a23: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
 RvKeodG34xaNrH/d0fkVxLFTJKY0c62I/U=
IronPort-HdrOrdr: A9a23:f46PFqo328XpcmDVPIP3qRYaV5okeYIsimQD101hICG9vPb4qy
 mLpoV96faUskd0ZJhEo7290ca7LU80maQb3WBVB8bFYOCEghrMEGgB1/qA/9SIIUSXnYRgPO
 VbAspD4bbLbWSS4/yV3DWF
X-Talos-CUID: =?us-ascii?q?9a23=3A66Ulemgi/hVIPcCDHlnCphcfCzJuVmfFl06KIW2?=
 =?us-ascii?q?DBllNQ7CyWA+c4YhijJ87?=
X-Talos-MUID: 9a23:zZEfWwqY9VGeC4dnFQUezy1NPudhw7rtMlgAgK8LvpLUGDB8HA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,258,1736809200"; 
   d="scan'208";a="111973808"
X-MGA-submission: =?us-ascii?q?MDFlYkfyEnXUeFeq0f1hcpkLv98K4zvBBdM2oS?=
 =?us-ascii?q?EvTJoMejzpAbzf6nr2qClSBAC0+s87pof32giKOU3zJM6NJX5tnaNimq?=
 =?us-ascii?q?v4nVN8K3xUEMA0PI7PS68HbOkTn9NQ/rjk096zrHDCp//Ne1CA8o5HlW?=
 =?us-ascii?q?tC6YKnvqrRub5bJZvVHZVCVQ=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:31:33 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2B12EA48D3D;
	Wed, 19 Mar 2025 03:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF04C4CEEA;
	Wed, 19 Mar 2025 03:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742355090;
	bh=7F/lkt+Cu9pifzlRgMsUfzDfsnqOctqe3DfKVDZMuSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdYa4C4At9hbt7uGCyA85BLxmdLSProvn5wHNgLTO/mam4D0lBLuZHumJQ3uWyvYc
	 qXQPEwK/XX6fVUbPdjjfUBfIq6XWEPi6EEYQuddiMUTFTJba9UR0V5XYwRmxaCT16D
	 fvggsQUiapJEHrDpzjpKlbYAfbX7/KhagieGr+TGK23lnIuQNJohzBdrF18x2CeRbM
	 PBcWcvEBh7kdfrKcQC4Jzjk7uIAkv+upLliRgXBSQYpQKgVAkKAgSO12w9Jxj8JGZp
	 A5Ng46Ixx3XWW+rQn6rTwueDw46cn0VDUt1jpu/9oy40CwxA733mf9Gs7Mez4EiXoe
	 tf8SrDi/v94GA==
Date: Tue, 18 Mar 2025 20:31:27 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <202503182023.D7C4D91@keescook>
References: <202503180924.2135CF8FD@keescook>
 <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2641
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503182023.D7C4D91%40keescook>

On Tue, Mar 18, 2025 at 06:56:40PM +0100, Julia Lawall wrote:
> I think you want
> 
> Expression *m;
> 
> A->@m b
> 
> B would be an identifier

But how does "B" get correctly type restricted? (Or in my example,
"NAME"?)

I tried:

@direct depends on !(file in "tools") && !(file in "samples")@
type TYPE;
TYPE *P;
TYPE *MEMBER;
TYPE INST;
identifier NAME;
expression COMP;
identifier ALLOC =~ "^kv?[mz]alloc";
fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
@@

       \(\(P\|COMP.@MEMBER NAME\|COMP->@MEMBER NAME\) \& VAR\)
-       = ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
+       = ALLOC_OBJ(*VAR, GFP);

This parses, but don't match (from crypto/asymmetric_keys/x509_cert_parser.c):

	cert->pub = kzalloc(sizeof(struct public_key), GFP_KERNEL);

But does match (via "P"):

	cert = kzalloc(sizeof(struct x509_certificate), GFP_KERNEL);

/me continues to scratch head


-- 
Kees Cook
