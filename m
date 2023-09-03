Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2116FC83F2C
	for <cocci@archiver.kernel.org>; Sun,  3 Sep 2023 07:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tq0aVMXYvpeYRqh0R9mmAZcjN/uJdmnMF7F5s73AITE=;
  b=Xd1b8R24Nd9slmq4NQ78m5bpVCtMqkm1LwtItdyeI3MryQ536ury1uAj
   9skXlsGtbhdwnqZlkU6w15szvxUluOrllAaliXH4R5mtWmE98fsYbchn5
   mTJNov1mCN5fmdf/Bu+jCpHFV0CevqZoqT1pbJlI5vlJcryI8vCBG0LUg
   4=;
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
X-IronPort-AV: E=Sophos;i="6.02,224,1688421600"; 
   d="scan'208";a="124058834"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Sep 2023 09:56:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D0F5AE0AF1; Sun,  3 Sep 2023 09:56:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 630F2E004E
	for <cocci@sympa.inria.fr>; Sun,  3 Sep 2023 09:56:44 +0200 (CEST)
IronPort-SDR: 64f43c3c_VdGHSoNpfU7vOuvZmjoqZpZc/VdT35jz8UIFQIHAsEuWVDf
 gRo8fZsywbH0a76pYXJeXz1Q86kuhxA7Ya5vjjA==
X-IPAS-Result: =?us-ascii?q?A0HwGwCPO/Rk/wMP49RaHgEBCxIMQIFEC4I3B28DUzAEC?=
 =?us-ascii?q?0cIhEqRMzCEPI59iG2BVoFAPg8BAwENPQQBAgQBAQMEOIFTgnQChm4CHQcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CNykBE?=
 =?us-ascii?q?WSBCAEBAQEBAQEBAQEBAQEBAQEBARcCDTo/AQQBIwQZAQERJgEECwsaAiYCA?=
 =?us-ascii?q?lcGARQBAYJ6AYIpAQMOIwcNBqdAfzOBAYIJAQEGr1QfLCJVgV8DBoEXLYgIA?=
 =?us-ascii?q?YVKgzt6Jw+BVUSBFSeCUzE+gksXAQEChTmCZ4lhhUWGQYkbKoEICF6Baj0CD?=
 =?us-ascii?q?VQLC2WBFYJHAgIRJxMTBUVxGwMHA4ECECsHBDIbBwYJFxgVJQZRBC0kCRMSP?=
 =?us-ascii?q?gSBcYFTCoEGPxEOEYJHKzY2GUuCZgkVDDROdhArBBQYgRQEah8VHjcREhkNA?=
 =?us-ascii?q?wh2HQIRIzwDBQMENgoVDQshBVcDSAZMCwMCHAUDAwSBNgUPHwIQGgYOKgQOA?=
 =?us-ascii?q?xkrHUACAQttPTUJCxsGQAInoDtwgxJ9gUWkRKBvNAeCMYFdgV4MihWVCgYTL?=
 =?us-ascii?q?5cXDgaSNJgsII1BmmSBYz2BWTMaJIM2TwMZD44gN4NAM49IPzULMAIHCwEBA?=
 =?us-ascii?q?wmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23: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
 k49ud5P/qx8SEa4Q1PwkfQ=
IronPort-HdrOrdr: A9a23:tvlCtq03MWCdO0+ZS+oeSAqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:Qm0pEGDOfF5ARy/6Eyl8y1MtH+97Tl3YlGfbJxWDE0hnTaLAHA==
X-Talos-MUID: 9a23:vVtp9Ag1u9aQ8MQ909bMnMMpON5Y7Y6LIlk2vaoBnfbHNAJ+KheGpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,224,1688421600"; 
   d="scan'208";a="124058826"
X-MGA-submission: =?us-ascii?q?MDHISYdFbOj28Hti+OnxmgHY2jLxiWUy4AMJSv?=
 =?us-ascii?q?HnlEpdR6fs67oMyLKQ20Nof1KYNoiF8yHBJB/A4mmBzxDAxA4MpVJusX?=
 =?us-ascii?q?41e0VsLaK8OEBGCYvgaUxGk0bvJp4b+2Izsq8ADCbEoKaUv5VCGb8EXQ?=
 =?us-ascii?q?8TdU/W9/az9SV48xiyGm/7jQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 09:56:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693727786; x=1694332586; i=markus.elfring@web.de;
 bh=Lxv4GW/wXBFtETtGAIcehasHEWD/PdrJ/wy96ZtM5iE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lgKdEovGhVGzN40m07F1Ew1pFx/AI/Q/9WULUXEdHfFf+fWkbKvoewarsag7rLCLWl9O/2r
 xYTBryvGYGLiTjw3eAjhMFzwinQiouUOh1vz4b/Hd5VLhkgA9gWBHHWTh0Ea4ocbl98RAxRbV
 pAGh9DNkoJEhj9Z/wo/JagQaxMgCsE/L044M+IPDCNzcDBECXkiJVrpS4gEqDxN3LJcO5ispB
 Yjno+aXAcKCxgzIInO/AeD92t9WWlueXbK81r4klSuelrIckuWKqmWjslvuQESMm+PCT0OFXC
 aw7CPdGGfqiOMMEMymxgQm4Pdhff5YN8NWynnJVd6AgOGlSpk9jw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ux4-1qYqM42sLq-005IHn; Sun, 03
 Sep 2023 09:56:26 +0200
Message-ID: <852c86a4-403b-49f5-b307-c47fcf6da68a@web.de>
Date: Sun, 3 Sep 2023 09:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thomas Adam <thomas@fvwm.org>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
 <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
 <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
 <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
 <1326a929-8a48-4113-981c-df6dc3220474@web.de>
 <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QoovP4GjvsFBLGD4gwyVE1moRqEwyfuV7O2hcx/O8tiERmaFcRz
 +kp16XAxpCpoRRwW5R0UGVqdGsyH0OtrZOeVhiTVds73T1Ka18+zSmn7fzZgnsVcnWkkfhw
 OP1lfPKkaU0ZD2KedvP7b7T7McvR/W2B41w6fwBp3/NyrgylAHe8oiWj7OUw8kbCQNT5HZs
 58HUAith6yTO3u1OvDhrg==
UI-OutboundReport: notjunk:1;M01:P0:WRvSetHkGVQ=;3EevQLTZklGCqnv/Vg6CUi5uqcO
 UrQjUdpqoiA1BQfM7W++0CETd504xJe0SUp3ad5r2gZct9gahCWKbhKBhF4q11Ew+6Bu0e7S6
 AohXRiJneyyR8PewwAmzQ81Rjq3POz/zmShiOJOapetQEp46VLQwLo1ifomuEzPoMU0rhkCIm
 ahZ3f9IyN2WpO1Rt8m6zwuyRv13CXqgKJVr1tXKBlNUPU1Nl41snpsuyxcYS6dtFdLYLnhpgd
 dkbyFUKNbxS5L3MzEwjwiv8ctAiPGvKjSzrR5JYbGaTxpFmpG+HZ1tysNUIDn2DkABM59g23E
 q9rJ63LjMOzxxvIU0o5x7sKkNYANT/Tgv9/h9l+bQClG9xsZkULidnHcdJz8V2mOZD7zKpbqZ
 TDrCmQSBgIJ062193AdiXGFrXBVuO+4uf7P7Cd+s1XSNgxBoFU5mbnfte9OEW6uM4rG7UCbSA
 HsMwzsl8sLB6N4o76lnsK29obYFj9tQ2ep/1ZdHpMhthHk80fYuGIBgNGtEJ2OklUI9DkvbGb
 L/Htb0fBnqUWMGoPNsRCGKOrhcQrm4xte7PHlrJ7unciAc2EeA49OhGUJM8Bo1Az/XsoUAdLB
 oSS8SaRf7OLEQOqvowbGRbRRoStDG1e15z1R+jEw3r30KLyppLdhtGQy0JRBCGt7bwIHhpbBu
 nLTQZM5pSXLbYfsxUoUz3JhtuGiWH7hEG1Z4Jkxq8VxILXv0MbXE8DgZkuUUtNxfjmYd27B7h
 W/QSCXlnYflLmTjU09dH5599zMGIUI3xXRJOycfVzf8zvgWieOoP9wpWOeipHFfm7xTUjlFT2
 W9Tjbw8br18Vl7NEnOgJd9ZWIn3O3nYrO2P6gW2xSjNnsdNiiEks19H9zEttcf3eD41uC+tm3
 pSHled2t+wKyI6gC+xzNPSj+s6Vd+8VBRFKYNrkB2Bd2T/EJCNFFERpl/vnxwtFanQkILTXF/
 8oixusf/VEFgsySHugEgoWbh0Zg=
Subject: Re: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1236
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/852c86a4-403b-49f5-b307-c47fcf6da68a%40web.de>

> OK the problem seems to be related to s2 matching an if.  I will look into it.

How will the chances evolve for the clarification of the test result
that the following SmPL script variant does also not find known source code.

https://github.com/fvwmorg/fvwm3/blob/c9d00184ac3ab534e0f0ba5683106879a35857f6/fvwm/colorset.c#L955-L975

@display@
declaration d;
statement s1, s2;
@@
*if (tint != NULL)
*{
* d
* s1
* cs->tint = GetColor(tint);
* s2
*}
*else if (tint == NULL)
*{
* d
* s1
* cs->tint = GetColor(black);
* s2
*}


Would you like to point any debug approaches out for the observed behaviour
of the current Coccinelle software?

Regards,
Markus
