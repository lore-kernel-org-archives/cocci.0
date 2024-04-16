Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6264C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ICGpHm/MlVMTN5tT+yT0ALzoCJj/Nv+iChNyAF6Crfg=;
  b=Sh4PnnKixGbKfIDRBgYV6ad2iaghTtIMAev9T38LJ6Hj+1Hhv0swv9mv
   Uj3DIZTYfEGGtc2giOQ23/MlEBA0e9MHhwiRcbiNv1QC8tme7L1+xZ5AO
   x8YMOtDn+Bnh6UiuzEIbQhVVpw6tD5UdRvgd2iH2+mEb0/IuZXpoMeLv3
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
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161878713"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 16:05:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3279E013D; Tue, 16 Apr 2024 16:05:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E37D7E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 16:05:27 +0200 (CEST)
IronPort-SDR: 661e85a7_G/XmMBCGZVQcy4MOOq5Qlb2l1xg0MlhQnrmQtqm027gWq0K
 ddOFsilk2O+8Y2wTpW5l88nF9KhR9QkQmwCoJpA==
X-IPAS-Result: =?us-ascii?q?A0EHCgBUhB5mhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U8CgkJ8A1MzBAtICCWEKZE7MIQ7jwaEbIQFgxY+DwEDAQ07BgECBAEBAwEDg?=
 =?us-ascii?q?UmCcEYCa4cvAh4HAQQ1BQ0BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBASMTBAcOECeFbQ2CZwEQdxd0MAIBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?g06QgEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgnwBgioBAw4jBw0GtBmBM?=
 =?us-ascii?q?oEBggoBAQbaWR8sIleBYQMGgRouAYgtAYV8g0Z6Jw+BVUSBPAuCeD6CYQSBX?=
 =?us-ascii?q?oNbgmibeoYlVH0cA1kyAVUTIAsEDBoCGxQNJCMCKT4DCQoQAhYDHRQEMBEJC?=
 =?us-ascii?q?yYDKgY2AhIMBgYGWyAWCQQjAwgEA1ADIHARAwQaBAsHdYF8gT0EE0QDEIEyB?=
 =?us-ascii?q?ooPDIF9gQwCBSEEJYFOKYEpgwkIQ3EVgQgCgn2BYQNEHUACAQttPTUGAwsbB?=
 =?us-ascii?q?iMdngkBhDuCdcUINAeCNoFggWEMiiGVJAYTL4NyAZNFDgaSaC6HWJBcII1Ul?=
 =?us-ascii?q?VSFPYF8IoFcMxokgzZPAxkPjiAZg2EzliBBNQIBOAIHAQoBAQMJhUYBAYNag?=
 =?us-ascii?q?UgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0El7LKDYzdBw8XjlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3A6e7nJ2g6cT7gGAf5tSWjTmP9jTJuTGHH5XrqERe?=
 =?us-ascii?q?BGFlWD+23dV7LxPxKqp87?=
X-Talos-MUID: 9a23:gvrijwWwHW1rBvLq/Cbc3D0yBJxu2aeRV2lXjIUskuTaKgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="84962836"
X-MGA-submission: =?us-ascii?q?MDEXBOjAnT6OBvppQxnMWOpFxWmL4dzunyDxg4?=
 =?us-ascii?q?tGW6mkYTCxKNJy7fMkON2QtR3zCKaQk4sK1OCTeVozyaV912l00xikMP?=
 =?us-ascii?q?VqIcssSk3/YBRVi1iwtdjXWnyw0hex4MFefxtcSUGiDK8HM05CpVaKpP?=
 =?us-ascii?q?fHcRSZ6+ZCEaUci3rX/hTZRw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:05:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713276319; x=1713881119; i=markus.elfring@web.de;
	bh=ICGpHm/MlVMTN5tT+yT0ALzoCJj/Nv+iChNyAF6Crfg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BV+rQywqAIdxBH0umDEn8bvGjPmvmzSqAzrxbTbKpM3uXumbe6gcX7CTQWSP5t56
	 1YTSUpLCG0Qkdr5GcTCA8zLZjfpbU6p4mrszRpAZvRYSM9VOYa6+aaGMthQCEfzq1
	 koDp5MNSqr1caICyB/lrzzdxDhdd6AJ66FSmF9Sah7Ukq0q7UR81HR0MRBd8WNzEo
	 gIMMx8Kym/SaK6vj41JHkIPZEe3fEg9mr9PWEQUO6ZymdHSNcktb0sNgMLO2yy5v4
	 RT5Wsby/gtVRlr/I9x7umdiBOZyMHWo/x4B5pcT0C+O7S02wDDOY0ze6WRgX8a/UW
	 Gd/U5HLtEwtpoYY2xQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1sJwDz34d2-00Tmq6; Tue, 16
 Apr 2024 16:05:19 +0200
Message-ID: <d5304d62-0472-4d04-8727-9e9c88eb0533@web.de>
Date: Tue, 16 Apr 2024 16:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
 <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORHzTV9JjHAw4zTbjE/EZ77vq6Kp7tJZyO1LnF5YwH3Wm4B8mFK
 9CDJOEyKMNgNsdIz/BIs81MLc1apFVK4NmG3Y3ATeJNBaNil7jjERn3Fa5wqGOqCl1KyLRz
 1VhgPaKUTJApamxerdglA5aKQf9MO0QMuQ4vq3mqg8TxdzwYK6lbYLIy5HkG2L7U1m1IqfH
 DufMlLVpDYZJHAnW7MGgA==
UI-OutboundReport: notjunk:1;M01:P0:8bmhXE821EU=;0UoJ/5dv4u3lZzMfraFWbbkbMm4
 yeLO+yOeHL8YDFVOoNZgpij7RieJG+s7gkXK8aVZl/ACsMiPzoWF6m9Q6p4yZIYALncj1ACJr
 b/jCDP5O7arA/0kWG1R9vkkk+gJJgnU4PdAAtF05ygVx2jVuAFLupnLWpWIs0Pz3Ao1rSp8kK
 +dhuc3Avvp3hGe0AVp8cWXSPE7MOs7Ena1oB+RQuqcVNmNOHGhfMb1l1FVxNr7wya02Cqyb7+
 tHblnwm2E4tKis7qlwrWw/ykWxA7kK2DdLkFBMSKdI47fVaVe1HQ0Q4QUxSmPEHmkfmsCEEiV
 rARvo0HpbOeLpB0vDIICHwyNXizQosGq7K6VTECIL6CWWqgfs2CAVnWbDkJyA+SYscuxwqZmp
 khLfnIKB47aF5iKpcA0/QKUv7cD1L+m6khtXn+2Ku0A6pAiiabNBg6u7DpevsGtIrwtJsnayT
 X0EN0pXxEKg9zWZUXbKEDtD+N5WszzdTahq3di3KRZM6xyO4XTJrzb2MGzQpFzLJuR3VT8MqS
 k7kOszx53xL+KRmWWHPShcZCA+CXucKeJ45bPcQmmYIOgN4Lrb8nG06tr/CJj0W+4sn2HJt7m
 Lb6LxrVFzUuEMV6X8npgq3XiT+TpFx81Ub+gGIW1hRtRuorQ6s4vcrYGM8bvDb5jaDcVnCOb0
 82Gpb0XwbudgMefEwunIqKhZhjhCN4CAHXStzYnZbDVjrlTD67B1YnQC8bQM8wsxBNKJ58Orm
 S4/VaoolUyjHNln2SBzYY905yLLKLXGztuakPb0Oe82JLKIADcaOrKFiA7AQhBHJ6Zp9ZCmS9
 f0GMV4Ue3Od0b5P/OxGxRmcyWbD9US4g/kmJvGmMjsI5E=
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for
 map_paste_region()?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1669
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/d5304d62-0472-4d04-8727-9e9c88eb0533%40web.de>

> Looking at that function, I however see a missing region release when
> ioremap_cache() fails.

Under which circumstances will the exception handling be completed also fo=
r
the implementation of the function =E2=80=9Cmap_paste_region=E2=80=9D?
https://elixir.bootlin.com/linux/v6.9-rc4/source/arch/powerpc/platforms/po=
wernv/vas-window.c#L67

Regards,
Markus
