Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46241C6FD18
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VK3or/Glv5vEKmoy4dreeAMIK7P9q7VGG/1KBdPD0z8=;
  b=Pa8Ir1Kcntl7rqT/nBJBmN2E9oQoPRMZfCIaTLkxxXvxUgY2mHC2VDdA
   bC3oTxy7vD9o4k4tBrO4QAr8W3s/NrTwPTzHjBwR8jxfaS+aJ3s22cDRe
   ro00uYnTIoOqjb/cU8453ZvMw96XqZ9iaXtrI7y8n/MTeusaggWzNARYA
   w=;
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104282516"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 11:45:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30188E0269; Sat, 22 Apr 2023 11:45:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F9DAE019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 11:44:58 +0200 (CEST)
IronPort-SDR: 6443ac99_rT2bQsJwAyBgVDbynvfTSRK//p/M5OnvQxhzQ7Obe04U1Y9
 i7M64h+AsW462th1pZG9gzXijP/R5wKqhDMKB7g==
X-IPAS-Result: =?us-ascii?q?A0EwAADLq0NkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFOPEIIkA4Qwhy6RfoFAPg8BAwENQQECBAEBAwSCC?=
 =?us-ascii?q?4J0AoU8Ah0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICRz4BAgIBIx0BAREmAQQLCxoCJgICVwYNCAEBgnqCKAEDDiMHqxKBMoEBg?=
 =?us-ascii?q?ggBAQacDB8sIlSBXgmBFC0BkFZ6Jw+BVUSBPAyCRzE+hESDW4JnlhiBM3SBJ?=
 =?us-ascii?q?4EygQQCCQIRa4EQCGiBdEACDWQLDnCBRYMXBAIUNA4MFgVCJQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj01CQsfBkQCH4FsBC9YdwoGASUkl3mBFYFxDE5JoTahajQHgiuBVoFZD?=
 =?us-ascii?q?J8NBhMvg32MZoYmDgaSJR6XWagfgWQBOIFcMxokgzZPAxkPjiAMDQkVg26PS?=
 =?us-ascii?q?D80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgRd/hwyFUlvWtAPcs4fYw==
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:wWKKlakaFw67YMUFcMqRdUhOld/pDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3Aqgi8QGrcr+fKAwGS5RHPrIDmUcR9L0b44Cz+Gm2?=
 =?us-ascii?q?DFGFOSICoZXiUwooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AOPXoeg9BmbKp+Ivuw6FJ+wuQf8166IqhLUsdq6k?=
 =?us-ascii?q?94tOUajcgZSawgjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54031606"
X-MGA-submission: =?us-ascii?q?MDEDUoWYHtElW51NT8I2Pu5dbAAaHTzIxFekuj?=
 =?us-ascii?q?hDLrnpew724BVT/OuJTcmQdvuy8XcnQ+FJoH7Wq/lcuO9PcFrNGfPUwh?=
 =?us-ascii?q?q4Zzgl0+fNBp9uoxJCV1ITp5r+0T64oOfFeyb7Th3TxIm/Ub86qQysK5?=
 =?us-ascii?q?kNtpUCzIeOZKuDfUg6M1z70Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 11:44:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682156696; i=markus.elfring@web.de;
	bh=VK3or/Glv5vEKmoy4dreeAMIK7P9q7VGG/1KBdPD0z8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D3C287Lc6ZgaDcRk7eOjXI4gUrjV2ZH17zZ+1EiLCib890M5bzpKzow3Ja80yYJT0
	 aKwwi3C+oDRVsVifPzo0ql1Qr5hQk80sOrOOkNy8DiVLpJRBDo5EFK/oqPukYrcBts
	 NrJP4wWtrK/2Mx+xAx09ii2fTV5qIs2+hWcgvTskNn6RRIN2o2wJ3zvoaLQ7pTh/ju
	 yVzyO57qAlzY6oPKprJomCGIxFQwLPpW8dlg/ggT89bAAGeV+j9dCfy4JS5i1SR/lM
	 kXfM9UIU80B5m4dmgEvh9w6G7v83BTDoD3bOLX1ke/wQH/1a48hGkvpYin/5g9Hp7i
	 p6r3FM150y4jQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1qGS5o3QZM-00zsjU; Sat, 22
 Apr 2023 11:44:56 +0200
Message-ID: <531d1abc-1023-a5ae-2a58-06dd52b26643@web.de>
Date: Sat, 22 Apr 2023 11:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <1f0089f3-3c8f-60e3-5520-f7813093076a@web.de>
 <alpine.DEB.2.22.394.2304221104340.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221104340.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NMG6WoL1O6lTiFJXe4OlYHPqVxjmg/SZ1T4hDfxqfY4LxB4dCaC
 9aqnmH/QCibxDor4sVPUyzxTgErKx+mbsweiuPLWHZRnZZNFwl5N4wNx6aWGV0kkW7jPcJA
 jzk0in57e9Sz2gGmvhyhN7HDanB3HXltBh3gkgu4e9P+kZSuOJRTQ2eEPuxlwKO4Y/9pLGn
 E38yxNmeD0hgc02ZUusVA==
UI-OutboundReport: notjunk:1;M01:P0:e3e93F2dsfc=;f0oSPdAU4VX1wZETgR3LNlTMBlD
 hpQS5CxA3m7RtxiPpUAmY9cJ2KAl/AjNNInKyUEh9rUoV4sskiS56e7k5Enb811iKgevfoFfA
 QUgnsV21/tsnJLPivijjQL2LWe61OMvW9Dy9Ra4GqbIDw+0/hxskFKRb9dC0gGat9hcmSbu66
 QDoPQwYee3TVovEvAfuO9dGdbtkJAmalBNGNbgWqwv5KdPfgMcULiIxE0TdNGeTi/TaI9Aydd
 MMmxsXISzcBQeOeZbF99Vwmeq1KGfDwTyRsR9jD6wtLFiQhc9VLd9sz8yQYQOSmzUfCitZ5Wq
 AOJOO2+9YlcQTG8ZmrOAcPQE07r7rkQ2zcjKUVATeKu4sswSmnsCPsbgt4EtKT78IFOv2936A
 FLpjZUNqIxfNbaHQS4TFq1kaz7gGR6LdkbBF7gZ2g+vLshbb78becnuFgpPPVosakCUQAS3nS
 CVMp814WYl73mZEHzVas7ri6QFcdWUXrAu67TzNo8rtOUfyF298IkDT8NGSxBuFvzEeyQa8nx
 DtfHlDD8RIgHo3jUUUdgy+u4J/zfi+cCopi00lZauzGwKja2ih/hDLUeEypKgfD5GnmN78yZ1
 xONUXfZ41b3TSrTBctXuYmxsk9iYjGB6Vp8EP++hF/JY8P3eaCnQqq1aaEZrOzaqAvXkZt/vN
 0cpT/AwQh4jGqU5Wz8CLSY/dUnMhrS17ButCkdfCaVyHpjqcJ+iMpDqibo9jl0CkrbYC71WR3
 pJpxpyAaZ6PMmSRZ9FIp0Fp/CJ395l6925yFQhmXfF94PamII3tSOGDq9l1NdQH5halN+RBYl
 5+/hHztOyiFYyz05YE0w1cajj7rtm/rYrOHD1E93xpr8prRJNsu6vrFxTjibx8j9HhbiSzf1Z
 fgVKLfVRWjFMwSqZJtEzrdGLziDxMIYuO14KGJaHHMljCRaPRVfjGWLEQ
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1113
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/531d1abc-1023-a5ae-2a58-06dd52b26643%40web.de>

>> Please take another look at the provided source file example.
>
> OK, it was strange to put the expected results before the .c file input.

The first SmPL script example should not need an extra source file because
the relevant data processing is actually performed by a bit of Python code=
.
(The Coccinelle software insists to get another file name for the program =
=E2=80=9Cspatch=E2=80=9D,
doesn't it?)


>>> If you want a response, greatly simplify your semantic patch
>>> to the minimum necessary to show the problem,
>>
>> I did that for this bug report.
>
> This is clearly not the case.

I suggest to reconsider this view.


> As a trivial example, your semantic patches don't contain any rules
> after the python code.

This is intended because further clarification should happen for the evalu=
ation
of regular expressions in different application contexts.


> But the python code contains cocci.include_match(False).
> What is the point of that?

This statement should indicate another bit of intended data processing.


> For another example, is your concern what is printed with text in the fi=
rst
> rule and with param in the second rule?

Yes.

Such debug output should demonstrate questionable control flows.


> Ask about only one thing at a time.

Under which circumstances would you understand the presented data mismatch=
 better?

I got the impression that the usage of an SmPL rule like =E2=80=9Cselectio=
n2=E2=80=9D
influences the control flow in an unexpected way.

Regards,
Markus
