Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CABC76196
	for <cocci@archiver.kernel.org>; Mon,  3 Apr 2023 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=t+IKaffPyYV4avNYkXdPdYZJ/NgLc8mbmUcgNFrItug=;
  b=NBiP9wHQldEWwhBFJm6+6W1lSzDA3ooLYOMj56al2IudOnic/313pmbW
   p+/5FsoapXlY1tU+EncczKleL0ht9EjU+jw0iwAdZHFiIMI5ZYt9nH1Uf
   ZdIrf42fJsg/rmwVWwjJQTjk5hXVDg5PvqhSeoMYpDOtGO3NH4H1CEngb
   U=;
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
X-IronPort-AV: E=Sophos;i="5.98,315,1673910000"; 
   d="scan'208";a="100509376"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2023 18:43:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB01EE00CE; Mon,  3 Apr 2023 18:43:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ACFB1E00CE
	for <cocci@sympa.inria.fr>; Mon,  3 Apr 2023 18:43:48 +0200 (CEST)
IronPort-SDR: 642b0244_cIZUDoltQOWvYqNQyyUz44xpQ/REdxDaPsqMSUjx3bvbOB4
 +ocUNXMQsg1MN/b2s6qK15grkDP0Ftjp360tLKQ==
X-IPAS-Result: =?us-ascii?q?A0HwAgDTACtkhwwR49RagQmBT4IudVYvBAtGhFORAYRgj?=
 =?us-ascii?q?myIaoFWgUA+DwEDAQ05CAECBAEBAwSEOYYEAh0HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjciGWSBCAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBEgINOhg7Zh0BAREnNAImAmwIAQEWgmQBg?=
 =?us-ascii?q?icBAzEHDKp9gTKBAYIIAQEGgmOZJx8sIlSBXgMGgRQth0keWIkgD4FVRIE8D?=
 =?us-ascii?q?IJHg1ACgi2DDoJngQyNIYpOaoE0dYEgDoE9gQQCCQIRa4EQCGaBe0ACDWQLD?=
 =?us-ascii?q?m+BSoJ1JQQOAxkrHUACAQt1PzUJCyAGWGsCLBETBQMLFSpHBAg4BlARAggPE?=
 =?us-ascii?q?g8sRA5CNzQTBoEGCw4RA02BRwSBC3wKUZ4MeSsighs6kkqQEKApNAeCKoFVB?=
 =?us-ascii?q?YFUDIhrgSKVAAYTLoNqAZMeDgaSJZdwjVOVB4VCgWM6gVwzGiSDNk8DGQ+OO?=
 =?us-ascii?q?YNZM49IPzQ8AgcLAQEDCYVGAQGFfAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GpXOPqx6pLBGPu5sYvfHKrPwD71zdoMgy1knxilNoDhuA7Wlfq
 eV7YwmPH7P+VEssR4b9uxoVJPgfZqYz+8W3WBzB8bFYOCFggWVxehZhOOIrlHd8kbFh41gPM
 lbE5SWROeAaGRSvILbxDD9Nc0hztmBmZrY4dv2/jNIdykvUYFYhj0SNu72f3cGPzV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,315,1673910000"; 
   d="scan'208";a="52044184"
X-MGA-submission: =?us-ascii?q?MDHhLwcKYpdvM0XKRWAZwuyiortxBtMcit4q+B?=
 =?us-ascii?q?FrSyoD4Siwimgz7NY0/E0OETFkVfB9SpKU/ycxI9i9qoHp8Gk4v6ARJX?=
 =?us-ascii?q?SstLsBF4jF7su1XtpYOR7Ua42jSjEd9F3G/F2C/Vbm32boUZXRBGQnvP?=
 =?us-ascii?q?m+VHEtEu/2n61ZY/JnD17d6w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 18:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680540227; i=markus.elfring@web.de;
	bh=t+IKaffPyYV4avNYkXdPdYZJ/NgLc8mbmUcgNFrItug=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=dfgmSGH+2phr4ApgkP8pn5k0UXC90iiuojV5ZAM8YirlEEcFhJ31ZWBIrBIH/+2I2
	 ETVS9teEfgmGqt4EZDgw2QcppmJOpj580oqeTxPDRrQ5BkpjJcINsQr37ZUtqa7BtG
	 VMCWAj0XNes3sjAn0VXwOj68fUVgIghb2OiIByo9+qJWt2dqYqp7unFxS/mMQ8QaRw
	 mYWToUybN2IdasD6h7B69Qo7uYipAQVkK8n4d/0tGWMn06YzEeu+AhbBpgMj5EcKgc
	 0On2axouwWaGOM/3lYZ0GEgyvLYoC3VBW4EiJPBiQZFACI5TuZEpua6fF66kU9II/p
	 AcYIjhLB9NUwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc8o-1qKw5z0Vo0-00gFc9 for
 <cocci@inria.fr>; Mon, 03 Apr 2023 18:43:47 +0200
Message-ID: <4bd84094-5838-c630-d1ec-d2d6bd0380ea@web.de>
Date: Mon, 3 Apr 2023 18:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WgUa4bu2HCJG0Ubey+uQM5cY8BrjUMP3DvF5tiejAbIaWUzO2sR
 ao1ykFdNAls3gm3U5AWe0XrN1H80CwMjywBNjyy1hr8t1nR5Wtic2GTYYZiOWhkWlk1x/Fc
 oqk9kBsZR+BEJymCSry2GRkmbRspdU3xqxXu+sgARqB1skIeYbwxZnI0BP5Xlq7C/w0hAHj
 sDCASIunf5YDb7quJkUYA==
UI-OutboundReport: notjunk:1;M01:P0:PE79tFwPcyo=;RF9dEfC6P7v8KRgIRH9iZ04OX9f
 8n0oYu/ePTCF8XEiv+JiRLmWBXNmhMRw8KHWzEOYzU3VwImbYLnl1ybSG2ICwxECvf/yetHQK
 xcPM6nZ9EKz0+0zIhSp8HGXQj4nP5yc2fCo8r8jsI3CusT8SI1Px6q/OETLzMhEGH6XapFv/j
 prQsPSPJcnQXlXvmGNxgjb01ar12Ws+AjqYcvFyJofETjurYfcvwD98tUHBj2Ruf+uZdTFTjF
 pDE68cxhsrgIEZJuHsmur73r0D/iDsfDjfm09y8oRhzA3qCAqG4zq7rGWBQRg2jLIzqf9QF4V
 tPA58Fw2U7CpxSvrrb3p0d2OZspIfHv1b1Rkwxgqw9DdVIX8LZU8/V2dtvwVdINndUN+BiATZ
 QCVi+qoKoWmlBbkRTX9dtYj9n7J30HKYTLEBtMi1U/8/Yq0Ra6FyMO/uaVvXL2DDhor5PVz3H
 zgLgbeRJeVIHsOl1n4R0Kg20xyQUFlV/4eHeOwXgFDtULER3E5JIILpKz2IcuudJjXVkVZCfH
 yIeBdi9ZOZ1hkuLgLfqDtZt/BfQDhszLan7jdPgi35APGyFzGV6abuGEmsCmMF3W0a1wpJ0jv
 jiPI648gD55aTt/y1zhowUbKtvA7bwQjq1uuaH0tvbqqyjnR0wksoSYDeFLdsLdEBgc5poNZJ
 ZiD1uS/blKNAafMMlL6TUi99mS2pPqrt3EK0l+QBrSrHr2HWQa72UrA7s95aogbS9Yfr1EQ8G
 2+bl/wv4TNZE0isHb2yXJKXe24gZsNdQF/cQf1xDaPoW7FwpZQd9i1kS7c3CYWCq1VpY/pu4s
 aK5eoR/B0Sk9efnmg7HGTctWsLSIiJAwVdj6aJf34DzwSaGxu4EpUBGO+icT3GY5Wo+bcq9sV
 q20GTdA6uPQon6UcPfSyt+LSRcf7R39KKoKcDBQuIxaehnS6B4n4woHd8
Subject: [cocci] Completing support for fork-join work flows
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 998
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/4bd84094-5838-c630-d1ec-d2d6bd0380ea%40web.de>

Hello,

I would appreciate news for a known topic.

Complete support for fork-join work flows
https://github.com/coccinelle/coccinelle/issues/50

Will the chances grow to benefit any more from parallel data processing
also by the means of ordinary output into different files of tasks
(or background processes)?

Regards,
Markus
