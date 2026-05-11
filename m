Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5EECD4851
	for <cocci@archiver.kernel.org>; Fri, 15 May 2026 06:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WZM7ZvXYBjg/Uhg4sZA2KNlOrJW6847IO8ryL198gSY=;
  b=CPNeq+TFYejiN1VycnyxYLiHRzFQvXzwP1GHkf4Pi7fIm26uUYdZ7Re2
   Bhs34ZPQKeF/CNPUfh5XRl9NP8S2h/PV6rbcxum/LC52dfBmQfcxh0CPw
   1zCKYhIX6Rz8al+3b7SG8wYokHSPTpFlEYu8PtjJG741S9HeVE94pP7xg
   Y=;
X-CSE-ConnectionGUID: vXMoecaRRu6dRFXHnS7M0g==
X-CSE-MsgGUID: mWiAn+UyQHKVUyQWK4a4Ag==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,236,1770591600"; 
   d="scan'208";a="276751661"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 May 2026 08:54:37 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AB34080580; Fri, 15 May 2026 08:54:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7BD5A824F4
	for <cocci@sympa.inria.fr>; Mon, 11 May 2026 17:33:50 +0200 (CEST)
X-CSE-ConnectionGUID: uI+EAL/cQ/qEYRwqbeD62Q==
X-CSE-MsgGUID: 1+MOLjhkRVCc+Va2Ltpp2Q==
IronPort-SDR: 6a01f6de_MdtEqcIqkrbuBPiXfR1uKoNEACI2w0G0JyyRa7KlBEKmS/t
 8SszXAPhmfaQUx4/egNQLdWtxexWvM30skNwo2g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FMAwBa9gFqgwsR49RahRqBCF40BAtJhFiPU4F0hGuPE?=
 =?us-ascii?q?Yh5gxU9Ag8BAwENSgQBAgQBAQECAwGCC4JqCgKNMwIeBwEENBMBAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBOgcOO4ZPDYJiAYEkZ?=
 =?us-ascii?q?Qk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECP?=
 =?us-ascii?q?QpEAgEDIx0BAREnDwsaAhgOAgJWBgEUAQGCfgGCIgEGEAEDNgcNBrVugTKBA?=
 =?us-ascii?q?YIMAQEGgUYC2R4fLCJagWcDBoEfLoVygmcBhjGEQCcPgVVEgTwLgkcxPoJhA?=
 =?us-ascii?q?QECAYFdg1uCaYImgQ6OXlJ4HANZLAFVExcLBwWBI0MDKi8tI0sFLR2BIyEdF?=
 =?us-ascii?q?xUeWBsHBRIhKm5KPCxcGgMDDSE1WUE4CgFGBYFwAoIeGV8jLwNOgQYCAQttP?=
 =?us-ascii?q?TcJCxsEPYsiHQ+Dash6NAeCOIFngWQMii6VPwYTL4Nxk2EOkwsemGgijWebO?=
 =?us-ascii?q?IF/I4FcMxokgzZQAxkPjjqEHIELg1XALUUyAgkyAgcCBw0DC4VEAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:FCVI6KxxOQtOSAd/uKp4KrPwBb1zdoMgy1knxilNoH1uA7Wlf6
 LHppgmPHrP5wr5N0tBpTntAtjifZq+z+8S3WByB8bHYOCOggLBR+sOg+rfKhLbak/DH4VmpM
 Bdmt1FeabN5C9B/LzHCWeDYrMdKaG8gdiVbDjlvgpQpdADUdAd0ztE
X-Talos-CUID: =?us-ascii?q?9a23=3Ac3w4DmlzcBZ76FTRoW4d+AxiH/3XOWD8j1r5Bwi?=
 =?us-ascii?q?zMCFwZYyvVkaa9Y86yfM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Axd9ifQ5LK8sVSaU4NB+uKNvsxowxoIGJLEINkq8?=
 =?us-ascii?q?4kMLHCyUqHyuFlG6OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,229,1770591600"; 
   d="scan'208";a="276224195"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHgMTjeF5FBoSC8XOXt7llEJQo9DHkDn9bSvu?=
 =?us-ascii?q?Jj2D2EtTktt3bcgj/LHX7GXGWNpMfN0eoHId881HEZwnQHObvQSpJ7R0?=
 =?us-ascii?q?EilExaBatBgUY0awnXQlejjPwy4Ku0NP/w9bCFlzhPYRikINt8w9AyyX?=
 =?us-ascii?q?BWBXNRBrRsdxW8GBsQY7W8ag=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 17:33:50 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1x40nk1LxB-00ZS43; Mon, 11
 May 2026 17:33:49 +0200
Message-ID: <1ad7629e-3081-445d-aefa-6d618111427a@web.de>
Date: Mon, 11 May 2026 17:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
 <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
 <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bI6RBiLzfNySMODhrhQ2JPP0v6R6zNXQF1O5EXzyVWIteWZR02y
 vbyffafPY+MGWu0FTL1V2ZvO3GW9Ca+Ow8uSiQ751TnzYmy+npRMmGS425Iw/S6YGocKPGi
 V11psogQi4rDASOM7qZEkKul9PPAqq3JnEmpKQqTliGrrUrIhbfG3z1ZOWenwW6DphP3J+3
 3Dj3uCjR7kLoJJeAmJn6g==
UI-OutboundReport: notjunk:1;M01:P0:2SyzMCPmhVE=;u3LCKMhe6Hh5kdNqy5VRlPHHIbl
 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
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3501
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/2iqgFk63yHCvkGCcOF8H_w>

=E2=80=A6
> It's true that the above tests are overly simplistic.  Maybe
> tests/names.cocci would be a better example.=E2=80=A6

Under which circumstances will the chances grow to explain an information =
context
like =E2=80=9Cmerge=E2=80=9D better (also according to the mentioned SmPL =
script)?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d=
827b8b9627a841c85c9/tests/names.cocci#L25-31

https://en.wikipedia.org/wiki/Test_case_(software)#Typical_written_test_ca=
se_format

Regards,
Markus
