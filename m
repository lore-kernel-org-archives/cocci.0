Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDD0C3DA49
	for <cocci@archiver.kernel.org>; Sun, 28 Jul 2024 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xE9qQ8JjAe0GjPZ1elbEpRoJ3Tr5LI1WLCpWfIal59c=;
  b=kmIvq61VYgwlnxlouAgweZVUu0kV3w8eY2sjbF3orOhWjZKtPqdDXK1V
   jYR3wK9L5DgrOwjMJT/8pxpZNPDTKs8uW9G9JAithd7sonJJuH5hg5LD5
   dmndfgA/ONDClndFZmGLZWK58s6mnjo/vIsVjh5xTEkZKJsjxOXMAtlX8
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,243,1716242400"; 
   d="scan'208";a="177252669"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jul 2024 09:43:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B34FE0035; Sun, 28 Jul 2024 09:43:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A43A5E0035
	for <cocci@sympa.inria.fr>; Sun, 28 Jul 2024 09:43:05 +0200 (CEST)
IronPort-SDR: 66a5f674_QT5OEsGY4wE9jL6JnGGLUEZMKIaaAiTk2IrRD6I90AhoV5q
 05XoLDY0OyWOrCcBLNzENtrITDxaypn9e+fWUQw==
X-IPAS-Result: =?us-ascii?q?A0EgAAD/9aVmhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDfFozBAtIhFaIHYcugXUwhDuPC4h1gVaBQD4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDBIR/Aok9Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAToHDgkyhXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06R?=
 =?us-ascii?q?AEBAQIBIx0BAREmAQ8LGgImAgJWBgEUAQGCfAGCLwEDDiMHDaw7gTITboIMA?=
 =?us-ascii?q?QEG2lkfLCJXgWMDBoEaLgGIPAGGDYNNeicPgVVEgTwLgkcxPoJKFwQYgUaDW?=
 =?us-ascii?q?4JpjxyDEIIfiVwmjXdSexwDWSETAVUTFwsJBYlPCoMlKYFLJoQZCIEtFYNkg?=
 =?us-ascii?q?WsMYYd2YoEPgT6BXwFJgnhKg2ccgWWBJB1AAgELbT01CQsbBj2iKIUygj3FZ?=
 =?us-ascii?q?TQHgjaBYoFjDIollSoGEy+DcpNKDgaSbphuIo1ZmxiBZzqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGR+DdYRhxypBNQIBOAIHCwEBAwmFRgEBg1qBSgEB?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:l53G4K3AD6mAioj7AuPY3AqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AUFVaOWuF6+WYqNS2iBxTZ0RX6IskQG/B81X3J3P?=
 =?us-ascii?q?hBH1FUbO2UU22149dxp8=3D?=
X-Talos-MUID: 9a23:e9OXGgrydJ2XNfnC+9wezwxNd+dR0ZqwMns2ysUUsNSNKQ5WHyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,243,1716242400"; 
   d="scan'208";a="93101356"
X-MGA-submission: =?us-ascii?q?MDG8/tMtIb4sJayHNHG788huClyIFcSKM+JmXS?=
 =?us-ascii?q?tmAIdhJxsrTlPE6cYwrDpxKefUn5ICFMiEw8+n3TY0bCZuavK3VrrPiR?=
 =?us-ascii?q?esO9TCIXPUmVnNkJA+hby+KMVGneFDSFEqKUEtbjFU6S/unqJVh5Sc8o?=
 =?us-ascii?q?BpozTYueisdy8H0VXFWqqZSw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 09:42:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722152557; x=1722757357; i=markus.elfring@web.de;
	bh=xE9qQ8JjAe0GjPZ1elbEpRoJ3Tr5LI1WLCpWfIal59c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AHL6aTFqd9CpGDpCpYXgHEuHLFeMaFJ62W9cl3WMdmue+LFvcVl0SL9u7k6DmCX0
	 KWNbiq8ueTq1UswcHtLRMuCqRNK5K/xwiP/xCsGn200HfjPG5NVWyVRF2uhqUDkUu
	 FyyNSRBCklnBrPuw6Laa81jEVYqBHc6YtwElNS2vy/Y0sXBe/XgtDz/2uaDmYL5Z1
	 2vxg7ROqxZBV/Hd3PsMysni5dJT4WDkhHMsL/LOVD2lZGVsDn3pEK2TpDnipZR6/1
	 U50lKQSL4gr0aeWx2n4l/xmEUxcb1F8jAmI6yJJpqTf48M9r3w780+WpvEIRRjZ+b
	 WICNDPGXg1ZTPBy40A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ZZo-1sbFo83SVw-009Gyv; Sun, 28
 Jul 2024 09:42:36 +0200
Message-ID: <7e6bf10f-4cd0-433d-9454-ace6a5eab205@web.de>
Date: Sun, 28 Jul 2024 09:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
 <74d26d15-2c7f-49d7-8081-3fdaedcac273@web.de>
 <alpine.DEB.2.22.394.2407271844070.3211@hadrien>
 <6619fd74-fea1-4ccd-ab69-fab324c4917e@web.de>
 <alpine.DEB.2.22.394.2407280932210.3358@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2407280932210.3358@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d6t9UY3JJkNDgqDQckYL0xxgMt9Rp0ysMuPLQVNiKEQzsbngNhg
 rJn1PmKHolpYgp0ni3slN4xkzwuqZnLL0GU7tKCSV7FcLF4/u9XW65L1UA09lHixwcpDefL
 Uxsb64/qrHDmtdN6LrxAsKSwr4HJzg3uiJlQHponSawkY1BToVJWd8yammxON/OU+hCEA+F
 0208XxHRmWBNbe4WYK7vg==
UI-OutboundReport: notjunk:1;M01:P0:uPGW267cEhQ=;vNWAOgje3cTMJWz/xmtS/G53Iaz
 5ZAnw0hdXmH/I5FVF9323I6oXZjLLZHxDaXoIyo/fZxX4aOKEAIT9Pu2nbKvedmVtNxtFtNcP
 pAlyiTrpp2hrN++9eqnOBZEl6hEUU9OxuNf13mFRHHGoKynKvcVploNbsoHUgHYyra63HkmUu
 V+rw6Zf5pVZ4NV3hb6zWc8XTLfPmtjf/KWgyLrdwLbDLPTLXEuaDfCNzyVRvnWJupVZsAVWit
 uLIESQ0s+i4/AYeXRD+tL5srRl2YQZDZm9aAVsbB7nS4iFSviqPnee/qaV1w2H/d+F+AunTNC
 lPiNqkzX80uu+up3Q6jE76ewDBTlUWktpAn7sUJF5rGXH84x8FAkemgavLorvSQvU4w89LB+w
 Aw7KdyPmUFXSy4XygYP8VIJqKkqS2dxmYNV0+T13spkqRPTdoeMJY0cBZIqe1qb8bKc+HiPsb
 zRgt7kXNpPB8VAkFb0rP2uOLfi8aKMGoINwJHHCNdYvEE665pzsS7loSIFiQt1n02BqLx8ArH
 j3ABj3ZEHl0LY4R8DgEpAeyrEgCljCt7nUx8SiDb8WaGboLO+OzFT06v2Vci+DMmj/Ilccf4W
 MmFi6rVsDzp0/pZ1oFo8zVXt7eRLXHM70bGFTy6VhuDQ4Zs86TjDjKFDqnQEfjSCa9IRQHI2q
 ZUUlq2/wqT/M85J260F+vClERAb3qUEDIFkPfqo6WB+7fvCjrP7s4JZqr1WUnOkkfyhbNvD33
 BaphLfiZHRpmyB4cHsfF/wmPiCy3C9D77+sBAvm8BWk2H1+NGTSF7ro49o8lkDIERkkUYIrWr
 Y7XL5Pegk9tvOLBp1EzEugS/a+hFcGsMa6mQdVU8eF7k8=
Subject: Re: [cocci] Code adjustment challenges according to the comma
 operator (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1829
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/7e6bf10f-4cd0-433d-9454-ace6a5eab205%40web.de>

>> Would you become interested to support the integration of another SmPL =
script variant
>> for the coccicheck tool?
>
> I think that such a script already exists.  Or at least the transformati=
on
> has aready been extensively applied some years ago.

Which transformation approaches have you got in mind so far?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/coccinelle?h=3Dv6.10

Regards,
Markus
