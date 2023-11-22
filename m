Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9787C61D9B
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=GuuqTlhCg5xPiI2CbaSQ0AG9vFaKrq3o4DzvWduHPX0=;
  b=FyXIoK/W2OpbMVc9DJ6pmCNFD8YUt8rMbTuMpqL5SoD0+YSx9ch0JduP
   wdXVpjoPYxwtmbSnQyfnDZQINkmTArpg4qCX3Ow0exstWWA4dvZwdJ1GG
   IvcKXjCkfUy8kFvibYVMIMZxdAImk9cqLWa1LCzISkf9DVLl3xv5Eq4EB
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137955713"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 18:09:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 692BBE0CCE; Wed, 22 Nov 2023 18:09:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 67385E0AF1
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 18:09:12 +0100 (CET)
IronPort-SDR: 655e35b9_SwTFzoIfOFZAdxV/Hd84w8Bf95DeLk1j2XJevziTPU5R4+u
 6m9VnuNqGrI7S+wxPXbmd0MpjChAdVRYwlbxO4g==
X-IPAS-Result: =?us-ascii?q?A0E3HgAPNV5l/wwR49RaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VGBTwJmB4FJDyEEC0iBTwGDA5EyhGuBVYVfh0qIb4MWPg8BAwENFAEHJQECB?=
 =?us-ascii?q?AEBAwQNhGmHNAIeBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECgQYThWgNglUYgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR2sdAQERJzQCJ?=
 =?us-ascii?q?gJ0AQGCfIIqAQMxB65ugTKBAYIJAQEGgmasbx8sIlaBXwmBGiwCAQGHcRoBB?=
 =?us-ascii?q?WOJTQ+BVUSBPIJShX+DDoJog26NEY1QfwVCcBsDBwN/DysHBC0iBgkULSMGU?=
 =?us-ascii?q?QQoIQkTEj4EgzIKgQI/Dw4Rgj5hNhlIglsVDDVKdhAqBBQXgRJuGxMeNxESF?=
 =?us-ascii?q?w0DCHQdAhEjPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIE2BQ0eAhAsJwMDE?=
 =?us-ascii?q?k0CEBQDOwMDBgMLMQMwVUQMTwNrHzYJPA8MHwIbHg0nJQIyQgMJCgUSAhYDJ?=
 =?us-ascii?q?BYENhEJCysDLwY4AhMPBgYJGQQOAxkrHUACAQttPTUJCxsGPgK6fpBXoHs0B?=
 =?us-ascii?q?4IxgV8FgVsMiHOWMAYTL4NuAZMzDgaST5hAowyFSIF6JoFZMxokgzZPAxkPk?=
 =?us-ascii?q?kuPR0A1OwIHCwEBAwmFRgEBg1qBQAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cRhaBK0+bwapnjaIGSgrTwqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A49VPFWju0wgxNfnHb9vvu57eOTJufk3dw0/yOlW?=
 =?us-ascii?q?EB0VuRZC2UG+yyrFCqp87?=
X-Talos-MUID: 9a23:RRZQSgTLFKpidJS0RXTGnx9gEMAr+Ji1M188yKoelMzeLm9ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137955700"
X-MGA-submission: =?us-ascii?q?MDGo61mlfRB/dQ6s4QB1N0yICd4EN64ii7PpL8?=
 =?us-ascii?q?r+D96m6fiHqTl2Xn1L9TbwEgmVwrmsEK7Fowa8TSOC3ZtRglGAH3wY59?=
 =?us-ascii?q?DPN9JmLvMkQZ9wwnPP65DfJVRkY7Xzm+aHBj8esgRWtMusFUTkHe4rab?=
 =?us-ascii?q?JigF7uU5W4FKubpmxtXKQT3g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 18:09:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700672943; x=1701277743; i=markus.elfring@web.de;
	bh=GuuqTlhCg5xPiI2CbaSQ0AG9vFaKrq3o4DzvWduHPX0=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=DK4hX+4+DPUiRnpAnI4BEbZNIQ50YXZSWH4e8cFgmq117QiOXmE2y1uSqGTO/Vqh
	 80yAUN+zjXWRoHsjrpC2SlDpUbtji4BV/I9M+kuTTC5NbCU7nTuJXgn24F82sLbJ/
	 2Lf7zmQBBU2PZbVBdlgTB9K1nR7ykjiFJpLzjkbbP41ac7BcPuCvjxzE/0wg70L5v
	 ExSTYY9AWKbXspeYCaRXk2dyY0GNM4OtIEsXJLzbOlwdbMXuDlw5le3b2dse0kzmT
	 X3YwpX+yMaHrnPYPT9kd6on9QQXSqSpANBXeB8Y4L4DT6A6ASwahB9iK3Qbq6X1hS
	 I6rBbhVgl9fkWPlrFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1rM0C113qg-00seoo for
 <cocci@inria.fr>; Wed, 22 Nov 2023 18:09:03 +0100
Message-ID: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
Date: Wed, 22 Nov 2023 18:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QqBoXM65ryqbxH+VeRefKekcrB2faMY6LTAIfU5JQJfeF0qzqcl
 Vl13GpiN8hQN8rgKMAVPB+pkTXLMRfraEdiufZw3WX3oDTlpTw/EFyU3LKx7CtiscE1CwiK
 SpgiZXk45trMYc5bwGWaNXbD4ilA6seu7RFB9Kn+wS9cZMqA0sAspmVvQ3/RD/FQMC2CMsf
 zDuxze9AWKc4J36dKSDNw==
UI-OutboundReport: notjunk:1;M01:P0:7jZ/KNOpEik=;NKgOV6TWIa7IrRMga+oCBRIiqc2
 lEVmHcOdEtwyDqXAHxiHVspNUTQN4sky1yzuInrwEV6weN/3jm7giAk6sLHg9qAUs20Ad7IpX
 6A4SG7xoG1Z0afjwTkEX4tvwiKJHxtXDyFkwwolRpIvrNh4naTdQqWei9xPcAFKYkrf5/rtUG
 r3n89gzm/Fa6z5wehkuf/Fe2GoBuUSUYoZ2ekanYEMX1rLlN9krWN8lS9yEF6dspmsxXomY05
 ctp5udRr6HloWy+QcHptFJOws9QKZflJLORVYncPuBzjFUE4ImZtJROOVvKc6iNgNybANsJzQ
 WyxgnKya00A/iQadNk5jgFAdmVbXZ4sT6ouInrQ3HIm6PEL/Fc17Xvg5TS+ftJeMdw4UuSYaV
 vIH0OuePetx5KjpsY4g8AdA+0l98mY73g0xqXf3TX8Nw06GMP4S+FWRowaLBuHT1rbbhsFgyB
 gS6jW+9V9Nk+M0IOzAZvjdUIg0c12p3a5smFwRjd41baOsjBf/7iP4PtrnyD1i1vTYsMKj68X
 74JPqe7+Ft4hk3WHyZW0eWQuLEhcZ+LFD8Ume3BYOu6qF64nhrVzzDT486E2lgamFGxnq+FYL
 CYak7FeHABa58HcU0OUnQwKoQNm15ERxiEMvbwpDN6y8eaCuilRfNwU26jUnML2+pMqL39ZVI
 EyXfRO72sSNWzEu4L6zUAoXusDSyoXBVSVn3dPvTJmLiEKyrWj/fCUVSYEsLYABWJnJj1UmHu
 3jU0uIwLucdMII9eUAvilzXVO5PhADew4jAKbjK3+22bmhwAa3ToYI+OxPCtpMEJmMrimT8PA
 eBDoQyen8xNG522fK8eG1q9zOBYbaVjAixUNdQ6Tf++OXrZh02m7hJMnHtlki1kt/7YbjR7S0
 eSuukpkb067x528tLIDXSSnMmt7PK2DzZAWgn3SEd0wrakbz+U82zaFLWN1bz/ZdNQFUJpSvn
 sgBF2UyVmG5VQKwjRIvdxFTy7UU=
Subject: [cocci] Detecting statements from the last if branch (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1306
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/83e9ceda-9f18-4bb5-a945-261e2c03a427%40web.de>

Hello,

Some statements in if branches correspond to exception handling approaches.
Would you become interested to detect a few statements from the last if branch
in a generic way (with the means of the semantic patch language)?

Regards,
Markus
