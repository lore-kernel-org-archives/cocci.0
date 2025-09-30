Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C5CAC5B8
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FhWGIbww3II4LIlmLX1DcGogc+sctvfoZlXhRs+moug=;
  b=bq/taQEXTUNVO18rE8N3RlZjvWB7LXHGmUx7/SrdWREz86NvbTSb9O02
   fuuKqMXk1xlzNRUg/vN2eIisJEa+0VJE3rdA8RjrwQPEA8WRKALJWVCuw
   TyMtogq/71ySMZXZdpPHJDami6N90PqbNZPrpEuC/ORDOBY1xXXf/4y6e
   E=;
X-CSE-ConnectionGUID: 5vYepYXFQIynqhR/xWl1Qw==
X-CSE-MsgGUID: k3ZJzngTRy6KlO9YPHsg5Q==
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
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="241840092"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 19:30:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9FEAE0172; Tue, 30 Sep 2025 19:30:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EC606E0171
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 19:30:52 +0200 (CEST)
X-CSE-ConnectionGUID: lzIzCZbvRVmeco3dEihJFg==
X-CSE-MsgGUID: Qq3wtuI2Tvixf1c0egteZA==
IronPort-SDR: 68dc13cb_nLtee4ziZvQe1y6gCE0saGJmlJMlOrg4QzN8QutCf+OwaYj
 b83nadAT8EWs+RW1Im5QXzh4qsQ2fP915vcY/XA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ELAAD1EtxogAQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYI/ZSNUMwQLSYRViByHNIZfhzyHVYh5gVWBf?=
 =?us-ascii?q?QIPAQMBDU4BAgQBAQMENwGESIxIAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQJHRicdAQERJgEuAQUCJgJeARICAQGCfoIjAQYQAQM1B7oIgTKBAYIMA?=
 =?us-ascii?q?QEG2l8fLCJZgWQJgRsuAYVsgmQBhWw7g0KBIQ+BVUSBPINBiB6CaYMoFJAxf?=
 =?us-ascii?q?Y4ZgUocA1ksAVUTFwsHBYEwMwMgCjQxAhQdEg8EFjIdcwwoEoNsgQ2EHitPh?=
 =?us-ascii?q?A50PlqDUyRrDwaBFYEbgkAFAYlLIA+BDQIBC209NwYDCxsGPZh4g0aBDoJ2k?=
 =?us-ascii?q?weDPQGvazQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwUuh2WQcyKpH4FoOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiGEM48KAbkjQTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bjn4p6yukrXfbhGTEawMKrPw9L1zdoMgy1knxilNoNJuA66lfr
 OV/MjzsiWE7gr5OUtQ/uxoXZPqfZqyz/FICOUqTNKftWrd1ldATrsP0WKK+VSJdhEWndQtsZ
 uIHZIOa+HYMXg/q9rm6w+lFNsazMCA673Av5ak854gd2BXg7oL1XYBNu93KDwPeOHMaKBSKK
 ah
X-Talos-CUID: 9a23:k+a922FuKwUX4w1/qmJj5m8GMfIvbEfjyXrbJBS0JGdpapOaHAo=
X-Talos-MUID: 9a23:gC5DxwXOtISpIlzq/Ab13y5+KeYy37qvGE5Ums0LtNWJBwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="126968838"
X-MGA-submission: =?us-ascii?q?MDH0LhDKEdewyoTGm9QY/iUAPhjeiB3ZTeDpXn?=
 =?us-ascii?q?MPF82Wis5GlLGQL5Bz/3E18Slc44rWHU+NNHDSjCFv/FNgd/kQVjyg/W?=
 =?us-ascii?q?hJ5CPuMQFox91CG8mpfFw3BleSvFWfd85B3ReX6m30tUQJco++yDpdp2?=
 =?us-ascii?q?B4C1PmnrEQpf5PGRqzz+68RA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:30:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253427; x=1759858227; i=markus.elfring@web.de;
	bh=FhWGIbww3II4LIlmLX1DcGogc+sctvfoZlXhRs+moug=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TuBEgx26/6EbiczAI8Q9U5iItCtAlBbX3mxZ2K1Hw0WNLEhujBUTpg8Nbw/FfU7k
	 U91z5UNEeOtH/JX2vCaNRVewJ6QgB3/tynmBR5CGshF8ncXJ195XdWsa29RibGKjl
	 PQP68cvlDJK3LXEavQ1TFzIb6MZ/+QLMZQPRCMMeIEEGUmUYr3f1PkOVdsOjM69c0
	 lcLIpAuxq/cD87LnsetvPt9yND8Xrvy+nE0/oUMOPVLyl2nluOJ9G3mtwW4INmVO0
	 V0lvke3Xv05cqKuXI/YCduyfJzVXpkub8ZDF4JBTo1Xlh9FcEg72+WYSkSStIVITa
	 qrdT20zdzKbKH6MCmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1u9lmB2dkS-00tT5h; Tue, 30
 Sep 2025 19:30:27 +0200
Message-ID: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Date: Tue, 30 Sep 2025 19:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ifg0K8XLz2kD1r2OLZz3SGGJ2z264BN76aRcY4vNzm8Pnk5phy1
 6L/QMQtsFMTXfyZkw5KJ8dFSe1tkJkFZ1pWJxIihvO+ZRjz4exAJl62XPZFVWeYw7bNXCRp
 UnAZYinXcA930JrydyNsFBqZDIQ9yVB7PeimBLhYCr6jhCm2oRYoNgeeTTtlgsPhNT068+J
 R8/8znSCLXn604vSB5gng==
UI-OutboundReport: notjunk:1;M01:P0:F+osHgO2r8U=;3sAQa9EyhjFsKr5IWyXkmnMsgE9
 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
Subject: [cocci] [PATCH 0/6] Coccinelle: ptr_err_to_pe: Adjustments for SmPL
 code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3056
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/d5d3df5c-3cbf-403c-ad89-aa039ed85579%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 19:19:38 +0200

Refine some implementation details for further development considerations.

Markus Elfring (6):
  Omit an URL comment line
  Reduce repetition of the key word =E2=80=9Cvirtual=E2=80=9D
  Restrict the metavariable type =E2=80=9Cconstant=E2=80=9D for the usage =
of string literals
  Omit a redundant space character
  Simplify two SmPL dependency specifications
  Distinguish implementation details better for operation mode properties

 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

=2D-=20
2.51.0

