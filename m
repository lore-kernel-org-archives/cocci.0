Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926C2CD1296
	for <cocci@archiver.kernel.org>; Wed, 10 Apr 2024 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=/WHHZDmCwJVfbwc2/vjeI1QiFe7ezZOuUuxts7hBDdc=;
  b=REbsS3fEoQ8UDfKo5e+aoI1v4a5vZH8HL9P/EgPLujBoXAofpZ1I2E8M
   tgajM+GV9kfwAsVrwCtXt3SbT/lIuAemRYcLSDTTf/BJ/YHVhhobfg9SE
   ZNqeI5J824w5cTNmJn6s2UIGhy2Onjv4l28wrifsBCpOvdGbdmQewT+Gk
   0=;
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
X-IronPort-AV: E=Sophos;i="6.07,190,1708383600"; 
   d="scan'208";a="160821316"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2024 10:15:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F148E0AF6; Wed, 10 Apr 2024 10:15:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9FC74E0131
	for <cocci@sympa.inria.fr>; Wed, 10 Apr 2024 10:15:37 +0200 (CEST)
IronPort-SDR: 66164a9e_+4s8jZhMLAUQypbiJWh9zJmojS2jvDGgAT9v1BlPpvNJKro
 Yhps83Fk7WI2AiQ8BamBBlAPkDTOugTShxt2q7Q==
X-IPAS-Result: =?us-ascii?q?A0HbCgADShZmhwsR49RagQmEE3wDUzIEC0iEVo9GgXWEa?=
 =?us-ascii?q?48GiHCDFj4PAQMBDT0EAQIEAQEDBIILgi48iCECHgcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjEwQHDhAnhW0NgmAYgQ6BJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCPQprHQEBESc0AiYCcwEBgnwBgioBAzEHDbEVg?=
 =?us-ascii?q?TITboIKAQEGgU4BgRjXcR8sIleBYQMGgRouiBMaAQVniXIPgVVEgTyCUoV/g?=
 =?us-ascii?q?w6CaIlsAY57iAGBURwDWSETAVUVNQk6CwQMGgIbFA0kIwIsPgMJChACFgMdF?=
 =?us-ascii?q?AQwEQkLJgMqBjYCEgwGBgZbIBYJBCMDCAQDUAMgcBEDBBoECwd1gz0EE0QDE?=
 =?us-ascii?q?IEyihaDP4IihDMIRYEGhAwDRB1AAgELbT01CQsbBiIenT4CAYQ2gV9ekyeQe?=
 =?us-ascii?q?aEfNAeCNoFgBYFcDIh9gSSVIgYTL4NyAZNFDgaSZx6YRKM1hVCBeyOBSQwHM?=
 =?us-ascii?q?xokgzZPAxkPjjmDYTOaYUE1OwIHCwEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
 35wfhEVxoA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NFP6IKqkcSMUOvaxb5+rVjMaV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: 9a23:YfUdP29AtJF+Ibo/3ByVv1BKFsp6SEHQ9lbrLRCFTmtsVKWpaFDFrQ==
X-Talos-MUID: 9a23:F7h+Ggv4ObsNmG5NKc2ntWBGHpZFoP+SE38RkJMr4caHLSlhAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,190,1708383600"; 
   d="scan'208";a="84342331"
X-MGA-submission: =?us-ascii?q?MDEfyBiT8yYFmp1WlO/BG1ELqcSSlaTra7Q9NB?=
 =?us-ascii?q?MHbHCcCGtNcK+3XgmRlwchhjrF2KsXSO5z39bMebsV8vqw78XDwKDNZ8?=
 =?us-ascii?q?9QWzHv5X6cnocve6L55YUEahRmKGQbW/5c3Onvxi6+uHIrzImk+9/CEn?=
 =?us-ascii?q?8K5ghWDID0Zk89dRw/u1VjtQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712736925; x=1713341725; i=markus.elfring@web.de;
	bh=/WHHZDmCwJVfbwc2/vjeI1QiFe7ezZOuUuxts7hBDdc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GbLt4tkzgavl85C94BYEmy8l0BO8ZzXGbn94gqlpOFCMOnsytjFYZIG07gEN7vTA
	 mSoRwnga7CQpJmpvq9CG0+8Tw03BLLa8KDfJproei1a+MjXbgX8VQDMvQK1K0JCFR
	 UC6yL+8w6xu+1z16Lj3HG2PK1nHGF7i5wuaIaqsE+mLFZtFasX3iorL4y1DLawEYB
	 N0AyRKGh8DtgB7fTEs9SrLMxvAiqqfo98D+cUZaPW+cdZeAaR8wADR5ymZNUuwCMJ
	 Hvj9X42y7GzF/bNfnI3R+gqJSD/GVj1DNzaxQevKwDfGHypEVFmRz9+s8rpBvDLY2
	 l80uay1dkEcNS6RX4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxQX-1rydyw2sMN-00E2OB for
 <cocci@inria.fr>; Wed, 10 Apr 2024 10:15:25 +0200
Message-ID: <2d9f07ce-0c95-4b7a-a21b-eaeb0fc32d0d@web.de>
Date: Wed, 10 Apr 2024 10:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mxP/dFm5aUKC87g4Ym+81Wr2bJF9SGr/O1IKrwTu4i/ctHJvh/c
 5jSN/Z6zZtRZ3EVS2TJlT25rYwBaAC6+sHIp0vHYmguFj6F8sfYJ9r0yEylwz2BpUcWb/GP
 xHoiWvvJlsp+UOkmy3ZCWuDYL7lgNf2ouOnbBxGzu1s/HIMId/oXuaI4mOWi8y79Rtmo1au
 OCPN8JQukimARxXqDH0dw==
UI-OutboundReport: notjunk:1;M01:P0:5yEiTGaW71I=;k/yhOHfiX+Mcef6W8rwLxJuZFdu
 DjDOC5dk/LhtpSJ9g+8fDNA4XBAm4UoRZGBo81HiCXoG1MDSA13HTICCHnuA1mIjEQsUIUdIn
 90yvWmMHe+JcuEX0ZC/M+jBBaviFyvGd4vZEvw7aQuIsP53bvfFyQnHhSdkTUaa5SrZth5eXQ
 xui6iS2zazRYbGfLkiiopmB3CFQjVgm5zMpdPB+Ei9+TWMQkXo/zRpiRuc6h2V/lMEOuNXjrg
 aZIaP5Me27bElXsI3kFqbsFA3negKepA3cZzyLYODC30xnH6vuQ8XWNv+uIbL7a9lDVq3Gi4j
 Oy1tThrD5i4wsZOFjdHHIn7zqeKqH/k+BR6XMS7JuuX++m8x+NxxMwYrbPZtK3osyU45461OQ
 lnKg4iwpQW6wV3OFqw9vyXCWkIfKkMNIB9v561ykM5R8R56ve4sw6tnZ1oQ+Xa6te0kJXcXpc
 /bvLr4VSc+XJ3r2Q2OpKS/MWFfwNM954d0EzTCKUmiGFH1SjQF7PRROOdQ6l089f9tKDYE0zU
 tsBqRa5oRWS4pPHgmwQBxIwMnM4tSglMxIpczY7f5z60AXnVZ6JGJ9EygZGjRgkfSQjSNJv2A
 2T9trVfNqWJBEV1rOIW92EWKuQWdo8eYfI5bB1VDzMOhxrozd6W7SK6OK2BFjZE9xJLCUL8GW
 bKQmkKJrNziO1FDgjrzYXHWErwTUqnsNeb4UXiRlWvlE/1MVx6ghnvmuyG25OStvKVC+SH9dB
 lTG5hxN5L5YtlGrJCGUKnpOarx3jpfrBbzh41dOzPbypFm2xlHJcakuUE015WdO1JX0lJyOWR
 Km4nVUBdJHN17YWEUphLeiCNmXt8y7xHw6K2TUJndgRPg=
Subject: [cocci] Data processing challenges for adjustments of header
 information (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1635
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/2d9f07ce-0c95-4b7a-a21b-eaeb0fc32d0d%40web.de>

Hello,

Some data processing challenges are known also for the handling of header information.
https://softwareengineering.stackexchange.com/questions/379424/detecting-header-inclusion-chains-and-dependencies-in-c

How will the support evolve further by the means of the semantic patch language?

Regards,
Markus
