Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EE9C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Kso+Q87lM6T2u8x5G95j6qJPv5F1q1sX9RfqFA0/4ss=;
  b=uzw/6r734SN56EWPDcy0XGGmGpRHKp9VDtucGbSF5X4e5crnGnytTY63
   VX4LWLvoQQhk4cpck7Rq4eMYfMgzlQzVMI2yjT2Rva1GvBPJNSs2wdRd0
   Ja2Q4q3mBlkFshds/PhrlSFVDlXSnAY+EsUgpdq2IbeUIeItvRWe40NjN
   8=;
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213473456"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 13:26:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3C20E0264; Tue, 18 Mar 2025 13:26:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 39971E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 13:26:18 +0100 (CET)
IronPort-SDR: 67d9666b_oIHj2xo627/b0kYAkNLe8/THn0P+9X+9/NCgNXuFjYkKWBE
 62kFf5b+FW3nykX1K+LuYOX3ClV7xPqlC+ilh4Q==
X-IPAS-Result: =?us-ascii?q?A0HeAABuZdlngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDYnUzBAtIhFaPUIF0MIQ7hzuHU4h1gVaBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSFAAKLHwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?wQLCxoCJgICVgYBFAEBgn6CMAEDDiMHrWaBMoEBggwBAQbaXB8sIleBZQmBG?=
 =?us-ascii?q?i4BhWyCYwGGJ4Q8Jw+BVUSBPIMDPogegmmCM4RDZ5l7kBxSexwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSlDAyo0MSOBIgU0NA44KYFjaUk6Ag0CNYIbJFiCKGoEBYEkgjeEPoRBh?=
 =?us-ascii?q?VCCEYFdAwMiAYMfdRyDSHY+hGQtUIFNHUACAQttPTcJCxsGPaNJhEOBD6dOo?=
 =?us-ascii?q?T00B4I4gWaBYwyfXgYTL4NwAZNVDgaSfZJKhjQiqRGBbgsogVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIYQtth9CNTwCBwsBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:v4TdpaqsEF1/c6GF8iP6ZdIaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3Az6Tl12ryOokkJlNpi31X51rmUesETk/c43mPH1K?=
 =?us-ascii?q?hE3wuT5u+GE609qwxxg=3D=3D?=
X-Talos-MUID: 9a23:zVuZKAYTyDe09eBTtB/P2jxBE81S26GMUU01vZgtlNOHHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213473447"
X-MGA-submission: =?us-ascii?q?MDEiqwDZLRIzbvRtQGB7VeMpNyVf3qg5ICnrUW?=
 =?us-ascii?q?xZW4tm7Kw94FJ4RccyHDVLL94vayykVT9csKKhnbTJX+EWZ5Q3Z2CnWu?=
 =?us-ascii?q?8KRI5DBNnEBzsG0UAlrGFd2Ppx3b7KxZLEJjxkkNZ+bn7iDVesJa6Q/4?=
 =?us-ascii?q?OFiqhhHm0t5lzAnzvhwXQ8RA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:26:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742300777; x=1742905577; i=markus.elfring@web.de;
	bh=Kso+Q87lM6T2u8x5G95j6qJPv5F1q1sX9RfqFA0/4ss=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=inC08+4VgMwDBL8FdrXIm5ROBwvfwh1GPa4mLOmsqtUE95t8YZ6GMAJHXwx0jPpi
	 82vnmLw5K6mXy+8+61czp3m7R5Okl0ajNj2LxysHC+4KgUUes3qu1DaJD0l0Qn4ky
	 dICpP/ZDtHktcu/FQtayOXglxI4R4MQ/tCX1n8wPZjTBfFKS+WplluKCEETO7SM9V
	 4uFUphHZ3u8ocnLknV3wXWNgDElakHqSe2rbkPEvSNGuUuxZJ+XErQr587BMVuaTt
	 uvx4sJeH/aS085IXSrgcW2WjWYhZJqQCjVpSyhVukfKZo9VQRq5852SHRkkUuxl1f
	 L88TqbxduOQXX+dQQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1tGFew1WwR-00fBnI; Tue, 18
 Mar 2025 13:26:17 +0100
Message-ID: <1c9605e1-cf0f-48fa-a001-038e33a63f99@web.de>
Date: Tue, 18 Mar 2025 13:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250317080053.27298-1-olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317080053.27298-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:s7VOl5kpNR7ThBK5Tvbr8WiKcHKoHqSdDBP/hgNVVSvE63IgYKa
 cxScm5DK4wMGwztjN7iDdscSYPpn+Z2ccr+tTDDHk9kNmHXut2yg78ugaWJ+whxDPLFLSDk
 HwKqg+zOPfMr/c6PN3SIuJfRxuoQv8eJBaiEyy54LCqJLcr+kcxcwh/hLjROQ16WRIeEwXm
 alrnKYVtsR/cWeDDt9knw==
UI-OutboundReport: notjunk:1;M01:P0:I2XpUNSNZ+s=;vZ0GGRvJvHYHwYQA3rwt6EpnTNk
 IOyWDCahKY+Z9omUE/aaGHKo5EUVFNW4Mp1LDoq7V9xBXejlAFLnsF2bEm7RCjndLc3ejV9YQ
 1k/GPSuo92ZaMbR9Ir5Hczcoy0pEwdXHCqH5zuaLOkhcBvYQN0WIdBhq3+BRsMoXaYW8gL2oH
 EKwnJOmR9VN/yjCdvlEJPF3R2I+Hcc5gbH2hbSzVSz41nR8xHqcWsg2CZOoGYJ4zL0ZfQLGCR
 rUlOju6mo1qBkv6BxSDLUiKcuKFWWx1veqnkSWBgqHOikIGPL70EBj6lqaNJExXpLZTCfRYDl
 SZN3rgXcW3IaQyd9wAQ/3Gt02JKg5+geLSyNm1nTJ3mHLgEGttppePeEVigwaZq5/mRImlxfW
 ViTRrmVl8vJB39w1YapwLGPyqZDQf9kRJ/w92Uu7N1It4HyTJn7Coq6UWU5BbM65512b3XbNF
 8tRxhXAQZA7j7yPVLtbZ36y78kY+32Ncn05QF4oJSYa7N60bGzYQkV/COvnetLdeyxM9Wt03B
 EI1DWIpTEaZDYR8q4izICN/RA0aR6ndNezqFKPCWqHgAPWmXdC3sLKiyBqjr7I24bxhjPIdGk
 OArwaIkcWlMy/E1XNX6V0QHt+eb2i7PX5TT0wQ7LDig4ncf9cEawp/VEqO/CBxw53nPGpbLMd
 GY62Ike2n419h6TAtmGRTBijtqoucdp3WC9ViOmIzupmPTrlZXT4IpWwIYhF3baB8bS0kljvq
 QNzoZZpYSDiJizbztZkDlka8evzVrqnc8nzlGjUOacwBiftrnsHHJqa6TOVoURhqGcpRhoZ5Q
 JdoKMvAqIdkqNAqNqBtRqTqzLpfY+QgN3Ql+wGw11ML5QnV2rKRRuasy9iin2qbX2XxBcQLw5
 eZ3WwimrSfzkSBWHX+KIVAppQfXvxx0lx04DS+y8bjyBAAZ7eiRcUTEqpzKvx6tT4d7rnW6M3
 xqAJw4UvRW8jxOXDMm2xk4WnOQE/YYcWILpWc6RqOiOx+3S6QW2YRokR6CGGQX6Qeb6bmng+9
 2jTSpLwJuhw/vCrdbaGNsn5jQCmgMxGiPBDU5qPhaPfqLld5WUurNm8oGe1YBeaZq6Q8dt0Pt
 rrsomrE56UWo6+vk5yz/zCVe9EJ7tCGOzhVVBzzPVBA7pAuGENCdlek/GkLvQ/9fBSCEW+zkG
 BPADF2dql7GzPXz5ND41UMPgE9DABOmVMAzkwEtaZPhESOQuZhB0ndbZtuQ1jCs0qhzcqvI6n
 2ARrDaKmXXhR3+uNH5Yi+2zTJwSH0DIqidRQTb+VNLWzVZD34GejALuKTR7GyL5d4FnAMykTs
 VauxTfb+HRRc+bZor3+mArc7WSZlgSZZPZXKOEZpHQObpwAAcRnyiUUAcaUhCyO74XruPnipC
 wchHsMBM8ibCrMqXpcWJxk8aKxaGhOLoWCb1HXRF6HtRNT536tllr9fFPxVnEIFPi1liVq7BL
 rWHbAN+MesWY8FZtrzzho3uT6xZYp5niIq5V5W0xKUJiirw1o
Subject: Re: [cocci] [PATCH] Adjust help text for --with-metainfo configure
 option
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2615
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/1c9605e1-cf0f-48fa-a001-038e33a63f99%40web.de>

> Fixes 3c20ea6f8 ("Install AppStream metadata file")

I would appreciate a bit more information for a better change description.

Regards,
Markus
