Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ECAC61D97
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CDKPNmlmYGJH2CMmrImScNofr3mo0SsFy5R6M6sZYQA=;
  b=lhqTuLAQ0XwQvFs2iEgsoBN7GxYTG45VJWHM86+3l89nDMctYSQP4LHl
   y4OpoQcIAbkTX2oV0iXt3/2To3/S4YcbZX1pK83wtRud/FDvmDJA7wwzh
   o/4LzJn7BSCPGVFiQwBLmnniuFbc1qa6EFp/FUIKAdcaYbJyvBdVbKWq5
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138190967"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 18:41:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9A67E0AF1; Thu, 23 Nov 2023 18:41:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9CB44E004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 18:41:07 +0100 (CET)
IronPort-SDR: 655f8eb4_F8SZTope6pAg44zvMr3s4M7Ay3IXIB38FMxdiL/mhvmSmh+
 wNNj961YI7ybW2SGtA0rY+ycmNhvd4w8XLZiuLA==
X-IPAS-Result: =?us-ascii?q?A0FbAACjjV9l/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4B3NWMAQLSIRTjz2BdTCEO45+iG+BVoFAPg8BAwENPQQBAgQBA?=
 =?us-ascii?q?QMDAYR1CgKHKQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAoEGE4VoDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQECR0IBBAEjHQEBEScECwsaAiYCAlcGARQBAYJ8AYIpA?=
 =?us-ascii?q?QMOIwcNBrEUgTKBAYIJAQEGgVdBrT0fLCJWgV8DBoEaLgGIDAGFWYQ1Jw+BV?=
 =?us-ascii?q?USBPIJSMT6CYQEDhTmCaIknB4Yljn1dIgVCcBsDBwN/DysHBC0bBwYJFBgVI?=
 =?us-ascii?q?wZRBCghCRMSPgSBYIFRCn8/Dw4Rgj8rNjYZSIJbFQw0SnYQKgQUF4ESBGobE?=
 =?us-ascii?q?h43ERIXDQMIdB0CESM8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEgTYFDR4CE?=
 =?us-ascii?q?BoGDCcDAxJNAhAUAzsDAwYDCzEDMFVEDE8Dbh82CTwPDB8CGx4NJyUCMkIDE?=
 =?us-ascii?q?QUSAhYDJBYEOBEJCysDLwY4AhMOBgYJHQQOAxkrHUACAQttPTUJCxsGPgInn?=
 =?us-ascii?q?12DfEtZgh+kDKB7NAeCMYFfgWAMihaVDQYTL5ciDgaST5hAII1Hmm2BagE1g?=
 =?us-ascii?q?VkzGiSDNk8DGQ+OIIQrgQuOPEA1AgkwAgcLAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VhAjTIv4H74gQ==
IronPort-HdrOrdr: A9a23:gHAQJqOoZ6Zei8BcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3Aw5qcOWuBhPd8+ReekaS/C7cj6It7XXqCx2jUHHW?=
 =?us-ascii?q?nDDc1UZqPFUCI1ap7xp8=3D?=
X-Talos-MUID: 9a23:llfACQhM55ej/0R6ViRgcMMpLfVMwZu/F142i5ADmYreZRIhKxm+tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138190961"
X-MGA-submission: =?us-ascii?q?MDEIHdsOPEO7mBjS0aoGdZ91fzyOb3JhD/d8co?=
 =?us-ascii?q?4PqKhCP1p9iNidA0fyYAcpdlmjSpKuUtSfNVrQCqQ6Gd9hurLrifA7RV?=
 =?us-ascii?q?niBMqEcMPsbph1DiEMMkbT6VmYXw0YKNmm/sOVenZspnk+jWpGSAin89?=
 =?us-ascii?q?Et0sZ6XlwZHijFNktXeUA5xQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 18:41:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700761258; x=1701366058; i=markus.elfring@web.de;
	bh=CDKPNmlmYGJH2CMmrImScNofr3mo0SsFy5R6M6sZYQA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=N5rGAXJFOg8XYsr7ncE2OrhCCosjHYErfATBDAaMnZ4jR9rgK7MYlu3d5MbVBvZ0
	 gE3253qUo12cTT4XsecXot4/Se+lcGTprVZ9VuXIgq1msL3whgUXc3RB2dJpS+xDi
	 umeSIyriPXAJ3Bm90576KhdmSSyIpH6FE8+doYyNtmhxv7Azx78uPO9sp4OejwUvU
	 MllsjDA4rjcaSck3/qX/OHZG79yw5/VYBsldGngCif4+7B+TXIqK/KL6RDrxr6G/u
	 d1+MK2nEzTAM/RYb2psqAGX0lnWCUkIEv2jjfZD0eVGgV5DnESAU6LxsArsjCGNR1
	 TgMNF2zlsXvUiZVwuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1r0SXX16rl-005VVQ; Thu, 23
 Nov 2023 18:40:58 +0100
Message-ID: <09a9b132-5cbc-44df-b445-d8adcac7571e@web.de>
Date: Thu, 23 Nov 2023 18:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9/TKnpPeA6FeYS4P6H+QNwayuMiw1vVRALuI2r45klG8QUR5hhx
 4d8eNEK5FD2alAmsFAg1v3yYKlJU2TDGm0Gpr15qcGVcVLV8vOX+C4fyRU9lQJ/AfXSW+c+
 FOaSFPh/2KlpkIp/XkcsGn+F96765CuVGLmBYBbxyjXJ4rZBA+sE1YaNdxIRUNGVZC4rS1+
 ezv6skT7zwXWppoq9Houg==
UI-OutboundReport: notjunk:1;M01:P0:aDABlZA/qEM=;IoGPx1B5chuVUMIyCoe7Vmamtaj
 gCmk+St0Oz32a8OyqZ1Hyl8l06unijWmha52mh16N9A9sEGr62tzIixR1LesgvTIQSe5uwD2J
 Njh3QNgyGolIG3GRMBXkylmvVbaEaA3r2ZuLnpLg6n9PhjzTaaDkdSiC/NaWG4Jq0i+10OyPv
 d7SwFNVzLFI5P0mooMZ7rdxaD8Tcfby8f/+C+4yFANWwtk1H3xYucgPbklwCW0IeEgetaUQxm
 vNz/wlEGjWiEOCyHkFYO0IJDUko/KdIVYhsrEIKjmUwKg4CO6vqbgn+4EQVxMhHUUNSZwq1wx
 A1VfVInI4uH0YP+TfC+jVMkA27PE/G0gjLQvCKPfnWYHHvLyj1fuPXLM1O+4fZbbGAIRVm5w2
 6Aa2tt+EO6NiSqr9fd2ycC0gMUlObNdKN3LQTf2dnQ9XMTZryW2IxAEczYAOgQ3Y4OGo7NBYN
 9Wnm3pXHn5/7Y/9hL5zpMObtN2yuZCW8cjMuPWGfKNbSDb/Rldy7o7YPfepC6HX5RKBQLCNor
 Q5ViUDGRiJRHv2P1+at4b+iSVn/Vf/1WgglE1yfYKEBlepnlDCJaAyzmvUxAamyUKtF/bWYKr
 NcA3taWCu6YzMARP2bXU8Xt0HPPV6G8fr252Suiv/bqGJ8Q01V8RtMFPkvRTogBXT5XMkMd/+
 8vTeZqYuSOYvV+GZMxXB4QvKbuhLBBUaVmNDoDmjgMdB/cFXc4/V9BpLiKTuwVbUPi5TAWuyI
 imR216iwSEX5QecM692iEAtilV0kChdjxwmywvXbR9xsktB3U0Z6e/EftuOjGh0oRPT/lxoqx
 KnX6+HwZa8Z4dJEtBAJzUvcUXpSd0qfhvidcBiR8L7mchJl+3XbSv7lk45LHh1ZtZZKqR2fKf
 IDrBMMggEqINUrgI0KFJNSb55LWP998dh/PUH8YG1bu1gWNimWH1GfIqa3UNXVDhKcNnrgPv9
 u+amcg==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1316
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/09a9b132-5cbc-44df-b445-d8adcac7571e%40web.de>

> You can put a position variable on a matched if (if@p) and then use python
> code to add the length of p to some variable.

I would like to point another challenge out for the development of the discussed
control flow analysis algorithm.
I got the impression that script rules are evaluated as often as
some source code matches according to a previous SmPL rule.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c21b60d41938d32321b1a/docs/manual/cocci_syntax.tex#L655

I imagine then that it would occasionally be more helpful to execute a special
script rule only once while it got complete position information.
How will ideas evolve further here?

Regards,
Markus
