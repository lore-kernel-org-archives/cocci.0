Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5695ECCD183
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Tk37jpeMdFvHZy3dQaNON8uYRTCnaAQQ51qGDSZG5Ok=;
  b=Kq3VHx6RmM0QJvBbtcM3uH5bP8zUBCas1M5/fJOT9J/Cu4c2IEjYxWeg
   86F0SvBk8GeZJVpu5D3+iIbLKV7tmRX5aJrVfvzhpvjhYA3EydGX2UFpB
   j6lguUTsu5PrVuRN+tdxMP20Q5wPC2o96fXpa4R/X+ttHtxnK/1x7Lhfj
   M=;
X-CSE-ConnectionGUID: Oqofce/RT/K8DKaXq4dRaA==
X-CSE-MsgGUID: 5naQCdtgS+CkdONra4YDnw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245012848"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 16:25:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 14F13E0C55; Sun, 19 Oct 2025 16:25:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 758DBE0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 16:25:51 +0200 (CEST)
X-CSE-ConnectionGUID: vLOcLpKITxOfhBdwyaZt7w==
X-CSE-MsgGUID: 4v8DXL9mQLmuYQ8XF4UvGg==
IronPort-SDR: 68f4f4ef_ZmJ1IFgygKEp+rhoCuAc4HMcgjkNfibqr+4XWPuXkBQ4w77
 s/XF5oOcxf/T23MMdUzoFNGRln0RxukFljPBORQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FRAAAn9PRogAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwMBAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHVYh5g1ICDwEDAQ1OA?=
 =?us-ascii?q?QIEAQEDBIIMgnQCjEwCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBA?=
 =?us-ascii?q?QECASMdAQERJwQLCxoCJgICVgYBFAEBF4JngiMBBhABAw8nB60fgTITboIMA?=
 =?us-ascii?q?QEG2l8fLCJZgWQJgRwuAYVsgmQBhieEPScPgVVEgTyCUjE+iB6CaYImgQ6XW?=
 =?us-ascii?q?1J4HANZLAFVExcLBwWBIEMDKjQtI0sFLR2BJyIfHBNgPRdAg0kbBmgPBoETG?=
 =?us-ascii?q?UkCAgIFAkI6gWkiBh8SAgMBAgI6Vw2BdwICBIIxgRCCKQ+GQgIBC209NwkLG?=
 =?us-ascii?q?wY9kziCdII8JaYVoUU0B4I4gWeBZAyfbAYTL5dSDgaTBZkGIqkfgX4kgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIYQzxmBBNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 lgphwE4bel/rF/R
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kOdu0qjyzaQy916PI0/IEVR8cHBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3Aa/lLNWuxNnrF9MUbPIJwVDX26Is7VlrW6G/zAnO?=
 =?us-ascii?q?oLmhpYrGKWFai5Px7xp8=3D?=
X-Talos-MUID: 9a23:t/DxhwnHLvZNFh95V9pJdno+KpdE04D/DXkplIg3gpm0G3BNJRiS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245012847"
X-MGA-submission: =?us-ascii?q?MDE0TZAinC71Ihwcg/vlRLeimCpFe8+towZFH7?=
 =?us-ascii?q?7FxoTkh/iCgROkoF1qTjczjebXGhwk+P1suTua88fIUQGNyiEAIoVFQd?=
 =?us-ascii?q?LB4FJ78fDEKxhubhWTwv5xNIxD7daMDs2dfcUiDQVdQsrq5W8GLvlYLz?=
 =?us-ascii?q?b+hLHlUekpCPI/sMiLKLZc0g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 16:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760883950; x=1761488750; i=markus.elfring@web.de;
	bh=Tk37jpeMdFvHZy3dQaNON8uYRTCnaAQQ51qGDSZG5Ok=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C4R8r+MosjZJkXGQQV72jjfGWjBzncmwU6l3K+uDQoRQRXp3aYDhP3lOIRM3tArb
	 f3tedqb3Q4Jmo9MP2dIGbn2/FkSsr9j7L32WhSrk5MnyCW8uHyAiERxYSKJuiU6kO
	 +5/CSanaj9c5GTWsHRFpnnHUjt38tZFqZL5D0v3tn31LpiL8cGp53w3PiX7kLog7W
	 fSIHs8OnCpNcTm+pJn9UnogmebIEzNiepgIAkmoAcf5gIk6YT7RzEm/izw3SFpp2M
	 PwxYkVMA9w2fMKp4QSANVB4osQU3bCv8pXsO5rVmJgNtX/ln4Kj9+qjfMQDdWqSff
	 m3TbnFdWWnP5CVZByQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkEhH-1uUnru2szR-00Zd2t; Sun, 19
 Oct 2025 16:25:47 +0200
Message-ID: <c55ea172-2c1b-4bbf-b5d4-e2d421e18b1f@web.de>
Date: Sun, 19 Oct 2025 16:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
 <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kREb3guaBANIuj3ik9DuUIr33AHHA3+DWIzayWZJiCEvHeuXNw0
 NRYIu2cHfjhBD3TWbyt/rgiXA+UVIpMaIfmRd+WJ94nD22hPpoUUWBMA/DOMnjvTuU1UGqa
 jImCgjjGLgj8Qd7Yn+mHDCVEOnqrnkgLAxHGgoJHjTFJ3xzS9eXVBYdtmY40z9h/cQ9jRxg
 RtJEYclNw/+8AMzAvy9yA==
UI-OutboundReport: notjunk:1;M01:P0:lglchLebFcU=;jeq7CZBbbn92Bo1VcQjOgjUDohs
 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
 Q1ia10uRt9+lxXpxcjeQNZXfc97lDJav/Lw=
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3078
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/c55ea172-2c1b-4bbf-b5d4-e2d421e18b1f%40web.de>

>> Will further clarifications become more interesting for corresponding case distinctions?
> There is no guarantee that two metavariables don't match the same thing.

Will such information become helpful for better software documentation?


> If you don't want them to match the same thing, then you need to use a
> disjunction.  In the first branch, the same metavariable should be used
> twice, and then in the second branch there would be the two different
> metavariables.  The match should only be indicated for the second branch.

Does such a solution approach indicate a data processing requirement
for multiple source code searches so that anything would be excluded finally?

Regards,
Markus
