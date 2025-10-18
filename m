Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E771ECCD184
	for <cocci@archiver.kernel.org>; Sat, 18 Oct 2025 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rFRibB9Qt7JGgXkVO4Hx93pWdntl56FRy/NNmI1KJYY=;
  b=DIjyvbcxw1FbURbWub0wRj2mY4PvGL7I0LDbSh6JoGVnh62Ss/0ZTWJo
   svKxKS8Sw0GpQo6wBe1+P/kkylrj5qs/CXDkIT193y+l/R97xLh6CrUP/
   Wn0ohI9MYeqb1IT+CC36Wr7SXgu4l1dA0xHMBysTtGnRqVK5QNGdafb0q
   s=;
X-CSE-ConnectionGUID: hTUc5EHRSgq1OZ3Iba/kkQ==
X-CSE-MsgGUID: LhsQ70/tQdmHz32yh4Ub1w==
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
X-IronPort-AV: E=Sophos;i="6.19,238,1754949600"; 
   d="scan'208";a="244944810"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Oct 2025 13:40:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3AA9FE0C55; Sat, 18 Oct 2025 13:40:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 38B24E0171
	for <cocci@sympa.inria.fr>; Sat, 18 Oct 2025 13:40:54 +0200 (CEST)
X-CSE-ConnectionGUID: 8o66aVq+RiqalKHoD1aeMw==
X-CSE-MsgGUID: NXxWX3ssSOGsyer15JMupw==
IronPort-SDR: 68f37cc5_SIiccIUzRtimMq30SL0tKtACcRDXNWV7djjERo0UIOvDl14
 pxoTQUzLfbyfg0yeOt1DlYNEXEaSIFdJHt0404Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EFAADke/NogAwR49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgTwEAQEBAQELAYI/ZSNYMwQLSYRViByHNoIkhDuHP?=
 =?us-ascii?q?IdViHmBVYF9Ag8BAwENTgECBAEBAwSCDIJ0AoxMAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQ8LDgwCJgICVgYBFAEBgn6CI?=
 =?us-ascii?q?wEGEAEDDycHr1yBMoEBggwBAQbaXx8sIlmBZAmBHC4BhWyCZAGFbDuDQ3onD?=
 =?us-ascii?q?4FVRIE8C4J4PogegmmCJoEOl11SeBwDWSwBVRMXCwcFgSAQMwMgCjQtAhQNI?=
 =?us-ascii?q?g8EFgUtHXMMKBIQHxwTYD0XQINJGwZoDwaBExlJAgICBQIrFzqBaQUBHAYfE?=
 =?us-ascii?q?gIDAQICOlcNgXcCAgSCMYEQggofD4ZBAgELbT03BgMLGwY9kzmdRI4moUU0B?=
 =?us-ascii?q?4I4gWeBZAyfbAYTL4NxAZNgDgaTBS6HZZBzIqkfgWg6gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQzw2JBNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:PSitUqhtMN2YYtiuuaRRJFYz+XBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3AyENWJGvMp9BxB5elAuK945sF6It1dSODxUnJYHW?=
 =?us-ascii?q?5EG9ta52SZQaZ9YZ7xp8=3D?=
X-Talos-MUID: 9a23:QzBytQqsfsc3y0gu2vYezxdSJPhYuL+1M2ciioQLoZDZFwltIyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,238,1754949600"; 
   d="scan'208";a="128570814"
X-MGA-submission: =?us-ascii?q?MDF2683VT1Vcs9tsp8vgRk/1t7wYcd9IMAlkPX?=
 =?us-ascii?q?30dPbwCyZtItEaVcaXbSkzMi5JTAdEuPtkKJDFzVcQcu3WwTdRnPKghI?=
 =?us-ascii?q?jyKhUQE7GTqfUe2yaU/7XNmi+CaTdejbMdbAIQUSlwwdhk24ZWSOUQk0?=
 =?us-ascii?q?rg/hpy/5cy5mKaCSOYwRw8lQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 13:40:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760787647; x=1761392447; i=markus.elfring@web.de;
	bh=rFRibB9Qt7JGgXkVO4Hx93pWdntl56FRy/NNmI1KJYY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RD0oRDFLAVyJeAgEg2Z5lc/gyefM4fY0NPlf0v3UEyDMR0zJn1hktmDx+BuezQPh
	 Ubuz3Y1rcdlGYrpGUVOTlt8KEbS2fmuH/A4Fk4DSJ/DYU5oPXegLpBFyoEoKtSwsY
	 fQsBcyiQD9NQ/rXi4fTJK71hD+EKg8QiiRNhp+srUlZmWcImsiARpUmC7sqXVFi+Z
	 vRCOqEpVevdMoOwMdGtp1p41FrP+edSgAmJbvFyX3T8J637bt7n17nBulMWwVhtoY
	 CqK8MPkIGh+G/yilR1S5FOeD+7Ru33v1O07IvYQwFyytM0bZfREtqMRqTw6KEWbH6
	 m2fKhOpUHdfcq//a1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1um33g2kNr-00Kkq5; Sat, 18
 Oct 2025 13:40:47 +0200
Message-ID: <b39e1a7d-1505-4f26-aa6c-c18a151be8ab@web.de>
Date: Sat, 18 Oct 2025 13:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, cocci@inria.fr,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20251014113234.44418-2-linux.amoon@gmail.com>
 <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:brUrWs3f1wRlvb50xsoJvVd5EaCNX6rLdO+gQJ+rCOePPXiZu9s
 mQzVRW3tHeyUJ8GLTZOHmIVAiBP3LT1soBbrApPJbXg9C9aO26IjY0RdGZLuALcXxfvapQo
 iXhix1wfpm+VcEAHfiYBsG9TmZbmKQ7onDPKdgA3BY4PrF/w1QXQeEYujiTYQGPdYu2bqzJ
 zcqXxxhljGxr3oHGgCZ3A==
UI-OutboundReport: notjunk:1;M01:P0:BcQRwCXMQJQ=;3e10CcDiOryBiF/b1jz+Xz04tYX
 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
 8X2DXg6pFFj0GJklbujzG5O5X+6OEOyVKBQ=
Subject: Re: [cocci] [1/3] PCI: j721e: Propagate dev_err_probe return value
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3075
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/b39e1a7d-1505-4f26-aa6c-c18a151be8ab%40web.de>

>> How do you think about to achieve such a source code variant also with the help of
>> the semantic patch language (Coccinelle software)?
> I do not have any idea about this.

Can another source code search pattern (like the following) trigger further
development considerations?

@display@
expression dev, e, x;
@@
 if (e)
 {
 ... when != e = x
*   dev_err_probe(dev, e, ...);
 ...
 }


Regards,
Markus
