Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD418C4828F
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=b0ivMQnOTq0anV9xbaEaHzekK4PzqPjGAYhogDYwprM=;
  b=JcMWsAwdkJ4+A5Q0wgDoTix3OOyb27wnvzI4DFbfl8meuWlUAhq+AdG6
   B4wTeuU8n6OVu69HTxshozFVx9bLKNQgBSNPGfsfYLMwSBjyg843wREgC
   Lqr6/C5WOAfsyeIMpIOkIh7dJuIcU8bkWInCJ2HESlVG8DUf9I2mHOP3Y
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="151007981"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 16:33:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F23EAE0CD7; Thu,  8 Feb 2024 16:33:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 662A1E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 16:33:39 +0100 (CET)
IronPort-SDR: 65c4f453_pYKPn86Q2BynadMbmq5RnGPMZWwWabR/MVVW7UkT9fhlfGd
 sHlaM80hrwGbnlVHngkdNNqe4LyBpqxx90mGe5g==
X-IPAS-Result: =?us-ascii?q?A0EfAwAQ88RlhwwR49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FOROjCEO4c3h06IcIFWgUA+DwEDAQ1BAQIEAQEDBIR/AodXAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJcA?=
 =?us-ascii?q?RCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBEScECwsaAh8HA?=
 =?us-ascii?q?gJWBgEUAQGCfIIrAQMOIwe3aYEygQGCCgEBBq9aHywiVoFhCYEaLogmAYVuC?=
 =?us-ascii?q?YQyJw+BVUSBPIMDPogegmidEFR/HQOBBQRaDRsQHjcREAUODQMIbh0CMToDB?=
 =?us-ascii?q?QMEMgoSDAsfBVUDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDB?=
 =?us-ascii?q?gMKMTBVQQxQA2QfMgk8DwwaAhsbDScjAixAAxEQAhYDHRYEMhEJCyYDKgY2A?=
 =?us-ascii?q?hIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iCCYE+BBNEAxCBNIU+g?=
 =?us-ascii?q?xcDGSsdQAIBC209NQkLGwY9Ap5egVVqfKVHoRg0B4I0gWCBYQyfNwYTL4Nyk?=
 =?us-ascii?q?zwOBpJemFcgqFeBZAE4gVwzGiSDNk8DGQ+OIBkfg3WPR0I1OwIHCwEBAwmFR?=
 =?us-ascii?q?gEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:nCMm8q6Vy72OsOtMbAPXwBbXdLJyesId70hD6qkDc203TiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmsl6KdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ846U
 4KSchD4bPLfD1HpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:Uz0mR2EX1e3koebKqmJiykkxFc4+Q0fAj2XxfhXiSndDVeWaHAo=
X-Talos-MUID: 9a23:9LNTKgq2XiPvXcpni3kezxw8FtdR0ZnzMnsQtpBfmMiiGhB/GA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="151007967"
X-MGA-submission: =?us-ascii?q?MDEKENwlB/DVAzC+BHhjxGVloYzdYBWjBfD77A?=
 =?us-ascii?q?HqNV2trrU4WdD10xSQw+14uAWqVMatg8ax7x6BrY5HO558zY+vzqfAwX?=
 =?us-ascii?q?LTO41g2rgg9gEVIZv5+2iTjWAF5fcEavM2U9ILD/w7UE20UIuAqqJlki?=
 =?us-ascii?q?P91ltL/2rz0le/M2MxP497CQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:33:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707406418; x=1708011218; i=markus.elfring@web.de;
	bh=2Ef5y0Do53S/43eDozoKsNg4Gq76RIiyoJOEgWQ9DZw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=p62QAZOKUFTMNDp+9wuTl/k17F4TIBUTOKjlMrCnhoC2ZW/otCmew1iSJ/x1FkGv
	 4YMXqxUSwAoXPvApG4Ap5i1zbTFUVoewrlbBBQYMVuZEv7N+gjXfwd4YRjBp4s8Rt
	 MR0zTi0Zw+wFZYXok2wIGN4RDt3X7cLFSxdAJBrVE1wVCYAkK/+bjfBSHcvdHKoE/
	 8SmCElnaqkdNEfwu7BIygjBpaExNQz264M0HJiHXPogA+vsFxiyc+iZgvD8OCmaTt
	 iXyKh4mrBIJInOEcIsAvUlMMw2f0nTdJWE/31hM8mw2RDBOff8PYYN21SVMLlfh+5
	 Mu6c5ICYFyyElwaqhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1rlWfz0mpN-00Dc7g; Thu, 08
 Feb 2024 16:33:38 +0100
Message-ID: <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
Date: Thu, 8 Feb 2024 16:33:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
 <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
 <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
 <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de>
In-Reply-To: <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:517NrWWTRogmW6Swi79lCdxKyG6ehRQUW4GP3+wJuKWENUVVsCY
 K8XuXoMBfvenrhW0bv0+a0Vz4KqKwIpus8ZJhXqWRYFn1x7ShdFz80AqzUb9gZN/gkjcCT+
 kTSwKmWy5I8awODwwzSS8ClkOqk3IApLE+w2zUtfADeKNWgCyG3ILtAHpn1WJYLkDUYu1Gr
 uWf8uwlBy9Jw6lDIqZeCA==
UI-OutboundReport: notjunk:1;M01:P0:6LR+IMefHsA=;IQ9FPaj9GUfu2ju6HW2NWBg0tUJ
 01i3Z6QjssmK0QEa1JaeE0tT9otPB0vJdjQ1eQM3juJz06pdNdj+R0Y3zs+NmYp/qlIf4lnKa
 ABdN2MjwKP2/U4HFsPku/WACPskrkfrHBaSDz2eZdaVEhAx+fE1F72SCp3x0c5Su739LR0NME
 hGiV6alT+oVSZyseFGo/IqsUxXaDOYoZJ87vZQkOflHn2WsAydt9pauKOlnDRrzjDUoGQtv31
 4wYF4AObCGzLp1aO4/zA1WGd7UKTj/2TXwRjOSCrNMlPuwvQ7AfldI/rAiteJFEib1J7Hx5Gx
 SFZ1O8PhG7PC+wW4g/XMEFA56zpxlOeXbI/dwfwUGBrW61wZut73Iaa+r8eWjstFb+GKTUXvB
 ADlVXKbtS8x7hJCVfNrp/AuCXivjU03IYz5gfXcDSuLEVsmUVtjcOf0fKp5QCNqrvQbh1Fq8w
 OrUTpVccXipCdLGa5iRlDIkpHrHtFhOYG/pP6VLrCGqVBWnyb4XmexMCppsab6U6RAZT56cHm
 BRkO7ILGFGJVKFHjlAMgTn//ok/PfayltfPRewfcsu2nIXruY6/JPVDY/GDqAIpiM7F/0GENU
 9kvMU4NIEa+efiwZxOi4tOjzifFHWsvXuSyNBykgoEqn9KEXeRSE8Mcgkycrf33zjAXL3oREP
 xsKaAgcHJ75nUWyza5zl/VLhvJtf6I/GhYqhvilLkbZfYBglpcA8ZYiWnqQfWPNWN7jsmPiuu
 U0teZtZoWPQkJrEPpwsxK/ICQMD4w4eGrSrp9qqVxkU9jfyAflX0v5kCouFtOCBW2bAy0Az3s
 AuxPylrZRSwN8sF6KU1UPJ4wa1/REnodXzkqHMaWLj7Cw=
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1524
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/51feebc2-751d-4e1b-bf72-28dc8ed975c9%40web.de>

> Will the understanding improve also together with a script variant
> (like the following) for the semantic patch language?
@selection disable decl_init@
expression action;
identifier var;
position call_pos, declaration_pos;
type t;
@@
(t * var@declaration_pos;
 ... when != var
     when any
 action@call_pos(..., &var, ...)
 ... when exists
 var
|
*t * var@declaration_pos;
 ... when != var
     when any
*action@call_pos(..., &var, ...)
)


Are there any opportunities left over to increase the avoidance of duplicate
data processing also together with the application of SmPL disjunctions?

Regards,
Markus
