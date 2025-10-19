Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE21CCD184
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PwnNJ7VG2VCadOZ2lJxq1NhOWg3V7ScJ5VyVLdN2i8s=;
  b=VaTeFlInDjQrH8wpaZ/Eu0X7IBDFXQ5omT3bz03+X9HXPr5COGBFeRX3
   spjo49LCIB4zWQbO0FYyvzhmcSTKv+TVhhEfbbduf2+foSKqd/PBA5/nr
   9WiONdcfNZf86mh1gVn1VJcaJtoeolAmpVVJRrGlGEMtc/hMw6GRarABL
   4=;
X-CSE-ConnectionGUID: MMZD3S4dTlWQyovLUyAh9A==
X-CSE-MsgGUID: wsbBtHbCRK6cES5dZ//tuw==
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
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208";a="245018248"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 18:26:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB1C4E0BE9; Sun, 19 Oct 2025 18:26:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D864E0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 18:26:12 +0200 (CEST)
X-CSE-ConnectionGUID: XOq+j2lqSwGGHg5iwywhuw==
X-CSE-MsgGUID: 7xYKkryUQPqbAhZg1xdaeQ==
IronPort-SDR: 68f51123_XTzG0g4gq1udR6dJS4jUBrV3ind9vcLPQoCacxG6RPYVouB
 tP1/Ugfz/GAT9pHBIb2duXIWNwi1sFza+42cJfw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAAACEPVogwsR49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT4CAQEBAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHV?=
 =?us-ascii?q?Yh5gVWBfQIPAQMBDU4BAgQBAQMEggyCdAKMTAIeBwEEMgcOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw4KMYZPDYJiAYEkgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBDwsODAImAgJWBgEUAQGCfoIjA?=
 =?us-ascii?q?QYQAQMPJwetKIEygQGCDAEBBtpfHywiWYFkCYEcLgGFbIJkAYVsO4NDeicPg?=
 =?us-ascii?q?VVEgTyDAz6EQ4NbgmmCJoEOhi6RLVJ4HANZLAFVExcLBwWBIBAzAyo0LSNLB?=
 =?us-ascii?q?S0dcwwoEhAfHBNgPRdAg0kbBmgPBoETGUkCAgIFAkI6gWkFARwGHxICAwECA?=
 =?us-ascii?q?jpXDYF3AgIEgjGBEIIpD4ZCAgELbT03BgMLGwY9kziECpk6r2s0B4I4gWeBZ?=
 =?us-ascii?q?AyfbAYTL4NxE5NODgaTBS6HZZBzIoI2pmmBbw0mgVwzGiSDNk8DGQ+OIRmEG?=
 =?us-ascii?q?sZ+QTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PwhrIfvNMklYQl5TA==
IronPort-HdrOrdr: A9a23:hFhJhaDW+3lSWsrlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3Ak1jsGWj1rqOdCVZGXy2ZRn7X+zJuQlrEj3WKJ1a?=
 =?us-ascii?q?DFklGaLLISECB56N5jJ87?=
X-Talos-MUID: 9a23:6XSMFgW47BuryK7q/GD8tRJhLtZV2py3AmkNo5pfq8WNOBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208";a="128613885"
X-MGA-submission: =?us-ascii?q?MDHl2VuMFcf3/6lAhVs/c5xp0D63bqU63xWf5Q?=
 =?us-ascii?q?IgrAo12A8L/Y88CrWTX/6bTITDq7oeA1nHNgVVN4MqhrP+PA0lAAYz0h?=
 =?us-ascii?q?bRDTcyL3N1iDYY+v4pfHIez63FdbM854hqRQECBJh9d+Pqvf5PvtSupP?=
 =?us-ascii?q?9GEeytGJJhbHzKq2gZilpqRA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 18:26:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760891129; x=1761495929; i=markus.elfring@web.de;
	bh=PwnNJ7VG2VCadOZ2lJxq1NhOWg3V7ScJ5VyVLdN2i8s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VpV87QNBXdcP7KJ5Ydjq15z0b7m7UvTl3eaDu1VYlbmJ737/3wIKa+G9HqrXsx50
	 ue18NJ4WXYsCsdiJu5WLBygRRRQopyQqoDy4vn0J/mfrub8iQJu/2r6LbVn5L9CQB
	 GEQ+t1ZOGmUdw/UEpCER5ECojO/VVKg9G9afuW036Il7fXVixigCnP+TTab5eUO5X
	 NwI3/bOFSlhRguWRmODEWoIXwmM6dsL9l2hTS6ghj8YBjjx+lOzvC1o0CrZa8F0VW
	 3x7tcAm0vQwFwJGQiVa/b+CIz/uz9TYf73Rfy6Ma1kpqzAVV4zH9Uy3fejOs3pZ3X
	 Mto5n769afwQxiaO9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovjQ-1uPwNr3Ysw-00gWxQ; Sun, 19
 Oct 2025 18:25:29 +0200
Message-ID: <fe93e337-7d8e-4b82-b187-b5a67b627544@web.de>
Date: Sun, 19 Oct 2025 18:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, LKML <linux-kernel@vger.kernel.org>
References: <20251014113234.44418-2-linux.amoon@gmail.com>
 <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:umLVQJpIYGS2+HeShb6AnbRIlX4jVAsM0N686gdXuV69BTJ1sHo
 ClvWmWlXilkiAjxPd0bgRxjIqzQUg5Y6VRAjRcPndrg8BL9igrGjPjOSUQ6Uh+IjhZ6sYlV
 s2W8IY56Kh32rfuVtsHQLVoywvflUGRn/ccAz9sR9vIz+J5W9Dv90BTlhv9gm+9zQ9/6tgl
 VrkgIHUHK9EeadmLUGj3A==
UI-OutboundReport: notjunk:1;M01:P0:E+vRZbEifN8=;3GPNTm5dJYrlVOpuzv3N0+SoRyc
 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
 yYxJ/ZSB/CZB5XbxAXrtp1r19Rh5kvnAUf4=
Subject: Re: [cocci] [1/3] PCI: j721e: Propagate dev_err_probe return value
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3083
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/fe93e337-7d8e-4b82-b187-b5a67b627544%40web.de>

>> How do you think about to achieve such a source code variant also with =
the help of
>> the semantic patch language (Coccinelle software)?
> I do not have any idea about this.

Your software understanding evolved into another direction.

Can the following source code search pattern represent discussed developme=
nt concerns
in a succinct way?

@display@
expression dev, e;
@@
*e =3D dev_err_probe(dev, e, ...)


The evaluation of such a tiny SmPL script can point out that 14 source fil=
es
of the software =E2=80=9CLinux next-20251017=E2=80=9D contain correspondin=
g update candidates.
Will any adjustments become helpful also at these places?

Regards,
Markus
