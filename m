Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39426C38142
	for <cocci@archiver.kernel.org>; Tue, 31 Jan 2023 20:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=opNOf0bwZz0Eg6scZHkYbncLARrd3D/2ZOxCiFrK0hA=;
  b=l8Jxh0HeGG/Z0mEN8NvYlq17JdGeqFYNhdxksUAD16+XIvVY/2fUiJLB
   HdC2mF1cR8uJBWQ68VBIRC9qd8OtALMWMgi6Bn3Ky4qFawVrSYrsSIC4O
   r93RgMPM6VagPKQWPZFVshbQVLyRui02siiYfYjWbC4PNSbXqrMQcMZIU
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@lwn.net
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="90382993"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Jan 2023 21:52:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0D10E7441; Tue, 31 Jan 2023 21:52:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B56CE743E
	for <cocci@sympa.inria.fr>; Tue, 31 Jan 2023 21:39:06 +0100 (CET)
IronPort-SDR: 63d97c5a_wYouZd1DdpnuNn/ihLPkTNzoNN1iozH8GiBcYNdQAk+VJ+d
 9iIxKc49WK91yTbG+LZ7WdemXgcnh+OKODWjKNg==
X-IPAS-Result: =?us-ascii?q?A0FEAwDFe9ljfRxYTy1aHQEBAQEJARIBBQUBQIFPgVtSg?=
 =?us-ascii?q?V4uBAtFhE+RIjCfDA8BAwENQgIEAQEDAQOFAAKFJAIdBwEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABARsJPAUihWgNgjcpAXWBBgIBA?=
 =?us-ascii?q?QEmAg1SeAECAgEjHQEBNwEECwsaAgUhAgIPAUcGARKFbQMOIwMBBKsxgTKBA?=
 =?us-ascii?q?YIIAQEGnycJgRQskCx6JxyCDYFLgnQ+giCCOYNDgkUinBoKgTl2gSUOgUaBD?=
 =?us-ascii?q?wIJAhF0gQo3A0QdQAMLOzIKPzULC0oQGxobB4EGKigVAwQEAwIGEwMiAg0oM?=
 =?us-ascii?q?RQEKRMNJyZpCQIDImIDAwQoLQk/BxURJDwHVjcBBQIPHzcGAwkDAh9PgSAkB?=
 =?us-ascii?q?QMLFSpHBAg2BQYcNhICCA8SDwYmRA5CNzQTBlwBKQsODwIDUIFOBC+BYgYBK?=
 =?us-ascii?q?SaffoEOVaV7n0uDf4RLnCAyg2YBkySSJIUXkjggp3OBeSOBXDMaCCYKgyJPA?=
 =?us-ascii?q?xkPjiCIS44VITQ7AgcBCgEBAwmFRCYThiYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FnwUYfpNckxsfmov/kxDBQPkzpz3tAzB+o=
IronPort-HdrOrdr: A9a23:mgyGAKNCvkmtN8BcTsWjsMiBIKoaSvp037Dk7S5MoHtuA6qlfq
 GV7ZMmPX2dslwssRQb9OxoV5PwI080maQY3WBVB9eftWrdyQ+VxeNZnO7fKlTbckWUygce79
 YCT0EUMrzN5DZB4vrH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="46512515"
X-MGA-submission: =?us-ascii?q?MDFdGd1VjjCmW3TokdeEvShdUG9dOiS8c03qIq?=
 =?us-ascii?q?0d+OqSUsBasm/OZQFvAj9ae90jYf/R5wHA+8ccaMHGPSx2jBvToh7agJ?=
 =?us-ascii?q?NeHZ2cnplWACjqaI4ZVXVQupSYJNDYljR5OQjXFZTcY4tHKHliHWEfA/?=
 =?us-ascii?q?ANz8zgAq1Y7MhqRlDwuYs/kQ=3D=3D?=
Received: from ms.lwn.net ([45.79.88.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:38:49 +0100
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4D7EB31A;
	Tue, 31 Jan 2023 20:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D7EB31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1675197525; bh=opNOf0bwZz0Eg6scZHkYbncLARrd3D/2ZOxCiFrK0hA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hfXGurOVD63Ye4OdgH2ghZ1IY4t/vqsYxd9x/00gnbcHd9AGaEMBpic8O9k3UyVgB
	 kPGgkWEvLsYFbK7+y1iY9vEMPQs+PafQkXBbGQinMb2azM9qTlCG/ddFefYrJrozmY
	 L2bENgwydRZP+xU4x/nlofLwMNrD6msixRSxF/4eqSWPNTLayZGjs/M93xvTmRw271
	 EKSGJwmFL2bxgMlc9InFicVRE68bYDJ9tKcF1lcQLgVs197obD38A/kdgj8dCBdzmn
	 45tyrQz1pSGVdirVdcZO4BZDqelMZfysatH2c+AHediuwbsJcBZuddk8U1s6AtM2Wk
	 CunEF9sipdt6w==
From: Jonathan Corbet <corbet@lwn.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-doc@vger.kernel.org
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Julia
 Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr, linux-kernel@vger.kernel.org
In-Reply-To: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
References: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
Date: Tue, 31 Jan 2023 13:38:44 -0700
Message-ID: <87tu0630dn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Documentation: coccinelle: Escape --options to
 fix Sphinx output
Reply-To: Jonathan Corbet <corbet@lwn.net>
X-Loop: cocci@inria.fr
X-Sequence: 861
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/87tu0630dn.fsf%40meer.lwn.net>

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> Without such escaping, -- is rendered as =E2=80=93 (en dash).
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
