Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E04C369D9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=acGKhKuDufnk8mRslRlPVbCydGTXG8yqIDiY7ID8y0U=;
  b=AMfpM9JwAmHdLMTK771e83jEQNO4v+LRQ7Wlp/L3bJwaVG1fnVFQCaJ8
   04sWNmOBIRc19WwGuSwcyuxDKS+CbvhujiY1IfJAs/G1EitPRDy5lF1Yj
   X14nmuDoBZm+P9T89w3i+qJEka5HnrthFE9eUxJ725zMwS6YtXjIO/eBz
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220180079"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 15:09:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE75CE0D1E; Wed, 30 Apr 2025 15:09:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E562E007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 15:09:25 +0200 (CEST)
IronPort-SDR: 681220f6_kFfXnurwSba5qhkpl+Pk1PdgHhfLb+fTvjD8ad2r+8hOemL
 49wBM9bLNf7W/KMbtfVqxbZKwUDBl78sfD6T+2g==
X-IPAS-Result: =?us-ascii?q?A0GSBADBIBJoeAwR49RagQmBU4JEfQZUMwQLSIRVj1CBd?=
 =?us-ascii?q?IEZg1KPDoh2gVWBfg8BAwENOwYBAgQBAQMENwGBVIJqBQMCizYCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAUMOCjGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINOkYnHQEBESYBNAImAnECAQGCfgGCLwEDMQcNs?=
 =?us-ascii?q?iqBMoEBggwBAQaCaddzHywiV4FlAwaBGy6FbYJJGgEFbYh3gSEPgVVEgRUng?=
 =?us-ascii?q?lKDOYFAgQaDDoJpgjGBFo05hGSMA4FNHANZLAFVExcLBwWBaQOBDzI8Mx2CE?=
 =?us-ascii?q?YUhghGCBIdqgSOEUC1PhTFOXiNAAgELbT03CQsbBj2WP4NsgTmBAH00k0Wyb?=
 =?us-ascii?q?TQHgjiBZgWBXwyJBYEklTUGEy+XRg4Gkn2YfowNgXmVVoVZgWc6gVwzGiSDN?=
 =?us-ascii?q?h8wAxkPklSEYLYLQTUCOgIHAQoBAQMJhUYBAYo7NIFLAQE?=
IronPort-PHdr: A9a23:8fxzFR1OIKTnPjCZsmDO5w4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeFo601xwWXA9qEo9t/yMPo8InYGlY8qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebgtWiDanfb9+M
 Bq6oRvQu8QXg4ZvKLs6xwfUrHdPZ+lZymRkKE6JkRr7+sm+4oNo/T5Ku/Im+c5AUKH6cLo9Q
 LdFEjkoMH076dPyuxXbQgSB+nUTUmMNkhpVGAfF9w31Xo3wsiThqOVw3jSRMNDsQrA1XTSi6
 LprSAPthSwaOTM17H3bh8pth69AvhmvuwJwzJLVYIGNNfpxYKXdfc8BRWFcWspdTjFNDp+gY
 4cKCecKIORWoJTnp1YWrhWwCwajC+3xxDJWhnH4wLE13es6HAHaxQwtBc4CvGjKoNj3MqoZT
 OC7zLPPzTXGd/5Y3i3y6JLLchA8uvGHQL1+cc7fyUk1FgPFiFqQopHiMj2SzOsNqWub7/d7V
 e61hGAnrw9xoiKuxscqhYnEnYwUxU7f+ilj3Yk6O8S1RUhmatGrDJVerTuVN5dqQsw8WWFov
 j43xqEatZC1ciUExpopygLeZvGIc4WG7AzvWfuNLTl3mn9reK6zihSs/UW91ODxSNe43EhIo
 yRLktTBtH8A2hLc5MWBV/Bz8ECh2TOV2ADS7OFJOUM0mrTBK54n3LEwkoAfsUPZHi/5gEn2i
 KyWdkAg+uSy7OTneLrmq5mBPIF3kgHzKroiltGhDegiLAQCQWqW9f6h2LDh50H1XatGguUyn
 6TWqpzXK9kXqrS7DgNJyIou6xKyAjG729kGmXkHMUlFeA6ZgIjzJl/OIfH5Aumnjliwljpg2
 urIMaf7AprXK3jOiLfhcqh5605b0AczyNdf549ICr0bLvP8RFT+uMbFARAnKwC0wuDnB8th1
 o4GR26DH7GVPLnMvVOW5O8jOfSAaY0PtDrgNfQp//vugmU4mV8Zc6mpx5wXaHWgE/phOUqZe
 3nsgsoaEWsQsQQ+SOLqiEeDUT5VaHa/RKw96S8gB468EIjMWJihgLqa0yijBJ1ZenhGCkyQE
 Xfvb4iIRu8AaDiOLc95jjwESb+hRpc92hGpqAD117tnI/HP+iwYsJLjzMJ66/fSlRE07zx0D
 t6S33uDT2FuzSs0QGo926t0oGR8zE2C2O52ma92D9tWstZASAQnLtbxy+JgCtb9Elbkd82KV
 U3gb9GoGzA3QfouztVIb0srSIbqtQzKwyf/W+xdrLeMHpFht/uEhxAZRu54wnfCj+w6ikU+B
 9BILSugj7J+8A7aA8jIlV+YnuCkb/dUxzbDoUGEy2fGp0RESEhoS6yQeHkFZVbN6/n96FnDS
 bCGFrktdAdMmoaZMqUfUtTylh1dQev7ftHXYma/gWC1UDOB3LCRd8zHf2sH3SPSIFcJmUYf8
 CXOLhAwUwGmpW+WFzlyDRTvbkfrpPF5s2++R1Qowhuiakp8y/yq9xRTifH0p+o7+LUCtW9hr
 jx1GA34xNfKE5+boBIneqxAYNQ76VMB1GTDtgU7MIbyZ6ZlzkUTdQh6pSaMn11+F5lAnM42r
 Xgr0Bs6KKSW10lEfi+Z2pa4M6PeK2379hSiI6DM3VSW3NGT86YJoPM2zjer9CSgDEk/6DNK1
 9dP0n2TzorHBkweXNO5U0o68QR7u6CPejM0tMvf0XxhN7XxsyeXgYtzQrF/lVD5IJEGavDhd
 ke6CcARCsmwJfZ/nlGoaklBJ+VO7OsvONvgcfKa2amtNeImnTS8jG0B7poutyDEvyd6VOPM2
 I4Ihv+C2Q7SHRL1llS8qYbanY5eZDcdNnWyw27oCcQCA886NZZOEmqoL8Ctk59bjoTuRmUe2
 VqtHVIA1+e2dBDUY1G3jmgynQwH5HegnyW/1Tl9lTok+7Ge0CL5yOPnbBMbO2RPSQGOlH/UK
 JOvx5AfVUmsNE0ykQe9oF393+5drbh+KG/aRQFJeTL3JidsSPn4ur2Has9JoJQm1EcfGMG1e
 1OHUfjQpxUA0iXsN3RTznY3enmmt474kBpzlG+GZCwq9jyDI542nEiZvYaUTOUZxjccQShkl
 TTbYzr0d8Kk+9mZjdaLs+yzUX6gSowGdCDqyY2asy7orWZuABC5g7Wygoi9SFJ8i3WkkYA1E
 3yS/3OeKsHx2q+3MPxqZBxtDV74sI9hH51m15A3nNcW0GQbgZOc+TwGl33yOJNVw/GbDjJFS
 DgVztrS+AWg1ldkKyfD4ovjVWiGhOZlacO7ZGw+xS83qcxHQvTxjvQMjW5ur1y0oBiEK910h
 DQA0r0D7HAAgucGkBUgxGORD/pBeCsQdTypnBOO4dekqaxRb2v6arm82n11mtW5Ba2DqAVRC
 z7pP40vFihq4oBjIUrBhTftv5r8doCaPrdx/lWE1g3NhO9PJNctm+oW0GB5bHnlsyRtwrw+i
 gFym463ts6LJi1krqe+HwIdJjPyfdwa4D2rkqtU2MqbuuLnVpwzHzIWQN7iSu+uGz9Uqvntc
 QqDWDRur3CGBf/UBgWC7EQg9nvJH8ntPHaSQRtRhdwwQR6AOAlUmwsTRi18x5c/Glnsz8vkO
 FFw4jRbjrLhgj1LzO8gdxz2U2OE4Rytdi9xU5+Hahxf8gBF4U7Rd82Y9ON6WS9CrNWnq0SWJ
 2qXah4tbylBU1GYB13lIril5MXRu+meCO2kKvLSYLKI4eVAXvaMzJir38No5TGJfsmIO3BjC
 bU81C8hFThhHN/FnjwUVyENvyfKctLduxq2vCF674i+/PntRAPz9N6PBr9VYrANs1i9haaOM
 fLVhT4sc28CkMlWmjmRl/5Ghg136WkmbTSmHLUeuDSYSavRnvQSFBsHc2ZoM9MO6asg3w5LM
 Mqdi9Xv17c+gORmbjUNHVHnhMytYtQHZm+nM1aSTmOCLrebPnvmx8/tYKWzYaJdhqNYulfj3
 FTTW1+mJTmFmzTzAlq3NvpQiSiAIBFEkIS6bworFmXpCt7rIE7eUpc/nXg9xrs6gWnPPGgXP
 G1nck9DmbaX6DtRnvR1H2EpBpVNMuSO3SqUvbCwwnM+rvZhRCh5xboyCJUSzrxI8GdbSfYzl
 CaA9rZT
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:kModL6g9rCUKfUjB7kgNm5PbXHBQXgIji2hC6mlwRA09TyVXrb
 HNoB1p726WtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW3VdAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkbNDSfNzhHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNj2CJ5sA0+9jYDzra3GeqTM2fabQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3APopmzWpEg5F4R7Khid5vdIrmUflmdkLn6HD1GhK?=
 =?us-ascii?q?TNXlZZrCMbwGZ9rwxxg=3D=3D?=
X-Talos-MUID: 9a23:8wa8EAYMwIpobuBT6jbIxxE6FMZSxb2BU0QOv4Qkkpe2Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="115573061"
X-MGA-submission: =?us-ascii?q?MDForS1do+y65RTQEtYCsqaKOIluS2bq47UpAT?=
 =?us-ascii?q?lVa21cqZmrLQHZxFimHvdftRTgDFeCanormWWCYuWiI/xIu55yL1PLw1?=
 =?us-ascii?q?VuprTER6Ff65mRz6cwNCUdqgyTS9XXBICaCycjtkjuRLDBVYYBCxIxMm?=
 =?us-ascii?q?gIy/4ESbkow9PmFCuBR31Biw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:09:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746018546; x=1746623346; i=markus.elfring@web.de;
	bh=acGKhKuDufnk8mRslRlPVbCydGTXG8yqIDiY7ID8y0U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rREOFeW2tUUyyhIHjidw9QaoMYnNDAo1MgIoLzmUrWT6Af9DBq2dmXzBNxlAA3aT
	 n9DAAysC7iBg+F5sKsSi1VaZAxuuBCXF0TBVgEsyfBtxzCc4l1264vIA6WATV8nas
	 BglbC9GnvbHhqZS4fpjMXo5StXvc2SMqWkCA7hXZUY5CUU0dHMqpDCzMj6ZU15egL
	 iW74w/l5yDQu7P8bhVB0pbyGVS1zRXTfBdGKi5JwQVCKwZtmWiA8nt6xHoSHHrYN5
	 c1RtcmVQ8urCs9GqcF4Nrop/HNL9LvHC0suENCDAlZAmtxlvBRZKvXB6LNDBFfC8U
	 mzJ92c+4GlDwpW/NOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.59]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1uQAGK2H4o-00IlKs; Wed, 30
 Apr 2025 15:09:06 +0200
Message-ID: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de>
Date: Wed, 30 Apr 2025 15:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: Dan Carpenter <dan.carpenter@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SXXvA/VmjVfHvr4leVpZngkbQ1QCCLXddZr/Ga9EJSz4Nm1cBJ1
 pKCeZDHacq76hThkEDh7H5FDJtAWq0txay7mOK7ALngAhLl2WqxacEyC0oAMV5z3zEmCpRD
 RCp9yO5dFxoZRb1sYQalJ3t7ffGgcktJTzTh54nzWnZH3t0iHSPb+jYJ8U/5r/ockkRCi6b
 G47WhqGjxUfdyOX3up+4A==
UI-OutboundReport: notjunk:1;M01:P0:GOfcYKPLmE4=;nj3xNQ7IyDzxXGJ8efjPibkSHjV
 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
 IILao1LJAVPEWJ3hAyQEbzzdo
Subject: [cocci] How to delete selected redundant null pointer checks with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2726
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/09b11b9c-21af-4c9d-b818-b0029bca5b9d%40web.de>

Hello,

I noticed also the contribution =E2=80=9C[PATCH] drm/amdgpu/userq: remove =
unnecessary NULL check=E2=80=9D
by Dan Carpenter.
https://lore.kernel.org/kernel-janitors/aBHZuejTTKkdnGaZ@stanley.mountain/
https://lkml.org/lkml/2025/4/30/389

I got into the mood to convert the source code adjustment approach into an=
other
script variant for the semantic patch language.

@deletion@
identifier member, object, pointer;
expression e;
@@
 pointer =3D &object.member;
 <+... when !=3D pointer =3D e
 (
-pointer &&
 ...
 )
 ...+>


Questionable test result (also with the software combination =E2=80=9CCocc=
inelle 1.3-00083-g4093aad2d=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> git checkout nex=
t-20250430 && spatch =E2=80=A6/Projekte/Coccinelle/janitor/delete_redundan=
t_check.cocci drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
=E2=80=A6
deletion: position variables or mixed modifs interfere with comm_assoc iso
bool (pointer && ...)
=E2=80=A6


Unfortunately, the known patch is not generated at the moment.
How will development interests evolve further?

Regards,
Markus
