Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F73C5B552
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6AwedbH9xzmX887SLAQHSExetf+2C90cY8z69nL0sDw=;
  b=P1njl0YDNtnzxO29RdEYQs3MaEIdE3lUD8CwafnYtOonVHos8Gr/wV64
   5Ej5hOub9YuFnDhOPPtf7gvgKEBRQaVBCJNw4Zv3MYaZNrF+RJOmhXdGS
   iudOyFnM9AeOAvsbdNlipk15+FPrKIH6ndzoDAK0DXVniiFUv9QOwbW/r
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="226173685"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 20:33:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6B85DE02E4; Tue, 10 Jun 2025 20:33:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0CEBFE0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 20:33:18 +0200 (CEST)
IronPort-SDR: 68487a6d_KAaJzbb7ZKFVEw2gpk+mUpfU2MJHhArCJuodCBesxtqz3vN
 y17+iuctXmXV2LhGm0ATvg+UEwUCzUltlkuCE2A==
X-IPAS-Result: =?us-ascii?q?A0G2AgAkeUhofgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIFaMwQLSYRVj1CCJIQ7hzyHU4h3g1ICDwEDAQ1OAQIEAQEDBIIMgmoKA?=
 =?us-ascii?q?otlAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7B?=
 =?us-ascii?q?w4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+giIBBhABAw4kB7BSgTKBAYIMAQEG2l4fLCJYgWUJgRsuh?=
 =?us-ascii?q?W2CYwGGJ4Q8Jw+BVUSBPIJSMT6ECjmDW4JpgiiBFo0Vh02MJVJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBIEMDKjQxIw88BS0dgg2FGR+Bc4FZAwMWDwGCJIFeHIM/gSOESStPg?=
 =?us-ascii?q?yKBf0wZQYNhHgZyDwcuQAIBC209NwkLGwY9mHGEfgGBMEDHJjQHgjiBZoFkD?=
 =?us-ascii?q?J9oBhMvg3GTWg4GkwKZBCKpFoF/I4FcMxokgzZPAxkPjiE+g3W3JkE1PAIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYpPNIFLAQE?=
IronPort-PHdr: A9a23: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
 NTCxvubwNZq9tXJ4Y0DCsKSJM/VaBIc
IronPort-Data: A9a23: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
 lTZiYyJrI9XhKIx/Qtdl6ZpJSwk
IronPort-HdrOrdr: A9a23:0oXEV62prY94BxSzEVWW4AqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:DKzz6WCTak9y58L6EzZa+FZPSuY1TnjinS2BP0b7EmJPcoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Aff3zSw/Amm8A5pwqsE5Av9SQf/pi3/2zLWIWq6k?=
 =?us-ascii?q?hkI6qPAleYSrMpiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118691237"
X-MGA-submission: =?us-ascii?q?MDHWXAGBGz2AuOsJmAkhetOmAL0ANVkVB4uZy0?=
 =?us-ascii?q?77FnWQeY4g2LScxnv+XCOIwuf78NKbrkgOnS2A33gYgH0FpGhp4jAK1f?=
 =?us-ascii?q?chqSO5HKMTEO8bFAZ4aSsCj0A+wQul2b+7vVU3ftZivmv2tx10+2okVA?=
 =?us-ascii?q?XM36Gu4uTCQMh/sMdg5kS4vQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:33:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749580396; x=1750185196; i=markus.elfring@web.de;
	bh=6AwedbH9xzmX887SLAQHSExetf+2C90cY8z69nL0sDw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wCkrnHpYUgBgGp1ml/VpvH7NfFpHm5n1zK0bxWP5if4ebZJQM6SfRQCBe5Ce+i59
	 xi6dtoiaEglA9tUwZ0udN7HQTWhixL9pRwXoJ0i5tdSm2R6G09Bt81j0Olqs4YL0d
	 PS8Ef6mRLET3yTNHJSOV+LMCz/RtJ6tlXBLtxJuYYUZCpwbQgWNj4a+Wr48XqQ5xb
	 dHxtXQaYBEV85B/+Z5oK1bexJVcrEVSD7D35HQxLfKBoWCWA37i/PIgnvSpBlcbeC
	 26mrqjNX0hOdifA4m2ZGOGvlKajPt+Llq7xR6xksHbK4Xe5PCzV0AhfyKFm3YByot
	 wR291QYLorawKDCP8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1uQzKG3cEZ-0091FA; Tue, 10
 Jun 2025 20:33:15 +0200
Message-ID: <b28bb07e-00d4-464a-8efb-d2d0862998a9@web.de>
Date: Tue, 10 Jun 2025 20:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
 <alpine.DEB.2.22.394.2506101831510.4658@hadrien>
 <be43fd17-4386-4ddb-bb14-72d2d33d793a@web.de>
 <alpine.DEB.2.22.394.2506101850030.4658@hadrien>
 <3f9b8788-e9fb-4643-aee7-5ce5400e94e7@web.de>
 <alpine.DEB.2.22.394.2506101925310.4658@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506101925310.4658@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lK8XbngSvdGyx6Z3F3XLIlGBenoSnDwnLne/rqYjhlSJ7GKwQfp
 58/7vfSwQEmWLY0GwleJnjhzqKdsYqxrSVCLTkN/6G7JfIbg13F/qh4IbmoCay51JueL2rr
 dz8MYwQZ4BGE61zAp78p2chL9Rtk6cGzhfOZ/H6Zpyi/vH89a4iVctahZ/NMX1EzsEq/KaC
 6J/gsK3odhDf5ASco+4Nw==
UI-OutboundReport: notjunk:1;M01:P0:FRNsktDWyQA=;lrnuzmnTnsK+EKEgwZKT9U/xTYx
 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
 TRbCXy1
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2758
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/b28bb07e-00d4-464a-8efb-d2d0862998a9%40web.de>

>> I would appreciate to clarify if mentioned files would be completely ac=
cessible
>> for the shown source code transformation approach.
>=20
> The number 7675 is not going to help me understand what the problem is.
Would you expect that any diff output should appear for the source file
=E2=80=9Cdrivers/infiniband/hw/cxgb4/device.c=E2=80=9D also in the file =
=E2=80=9Cdelete_redundant_checks4.diff=E2=80=9D?

Which data processing results do you observe in your software test environ=
ments?

Regards,
Markus
