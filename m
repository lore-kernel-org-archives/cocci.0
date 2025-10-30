Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8334DCCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9X4nc7LqhbPCSkQ6M6wo8iFhNhlOAgdihW/7ns75Z6g=;
  b=VtHgi35trSBZMrhvfP1M++qsKEjDuKGpE6pTrL/AT/SXoxXldDdb9ukT
   VEvw97Q9qyTlzfGguDpsvemglyA5gak7lXdmn/Cn0Jf/jq7OsmOTnd4Y5
   sJ5MUBESzT6dWcdIu0J44Pg78nDdzWVJdC1fTs++V6PLYC2Bq+RT8CQSU
   U=;
X-CSE-ConnectionGUID: w8lhu9kwRvaJuXeiWZ671g==
X-CSE-MsgGUID: 4dNLcDBATY+6+8ZpdHf6IQ==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246868857"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 14:58:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C33A8E0C55; Thu, 30 Oct 2025 14:58:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A191CE0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 14:58:46 +0100 (CET)
X-CSE-ConnectionGUID: gpXJxyj0R6+UFBmQndWPmg==
X-CSE-MsgGUID: GK0f9AjjSK+EN+9ddoIH7w==
IronPort-SDR: 69036f16_zswICVJJuHB3JIz2it3vgIytINlwxwC30Gvwxx572HN6VHM
 571VPaFdb7kuVPeyjSSLWWxU58MjBeqRLZ2uHTw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FDAACNbgNpgwsR49RaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRViByHNoIkhDuHPIdSA4h5gVWBfQIPAQMBDU4BAgQBAQMEh?=
 =?us-ascii?q?HYKAoxTAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAToHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdA?=
 =?us-ascii?q?QERJgEECwkCGgImAgJWBgEUAQGCfoIjAQYQAQMPJweUCpxGgTKBAYIMAQEG2?=
 =?us-ascii?q?l8fLCJZgWQJgRwuAYVsgmQBhieDQ3onD4FVRIE8C4JABzE+hEODW4JpgiaBD?=
 =?us-ascii?q?phmUngcA1ksAVUTFwsHBYEgEDMDKjQtIw88BS0dcAwoEhAfGBFgPRdAg0kbB?=
 =?us-ascii?q?mgPBoESGUkCAgIFAkA6gWgFARwGHxICAwECAjpXDYF3AgIEght+gg8PiRACA?=
 =?us-ascii?q?QttPTcGAwsbBj2UM4J7WZlwr2w0B4I4gWeBZAyfbAYTL4NxARKNE4Y7DgaTB?=
 =?us-ascii?q?ZkGIqkfgWg6gVwzGiSDNk8DGQ+OIRklg3XLIUI1PAIHAQoBAQMJhUYBAYxWg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:66o+BqiQf1bCoXkAzKqUM9e8X161CxQKZh0ujC45NGQN5FlHY01je
 htvWm2EaayMMzbxeowiPtiw904GuJXcxoNgSQRqqX1jRHxjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+e6VaidfHgsGGeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWULOf82cc3lk8teTa+XuDgNyo4GlF5wRlPagS1LPjvyB94Kw3dfnZw0TQGdE88t6SH
 47r0Ly/92XFyBYhYvvNuqr7aEADXonJNgGIjHdMM4D66vSVjnFaPg4TbZLwWG8P49m7t4gZJ
 OZl6fRcfTwU0pjkw4zxZfX3/xZWZsWq8JefSZS2XFf6I0fuKxMAyN02ZK060BFxFk+azgii+
 NRBQA3hYCxviMq52IKZWvhu3v59b/TFFoYmvH1f9TTWWKNOrZDrG80m5Pdd2yoswN9DF7DSa
 qL1axI1NU6GOUcQfA5ITstn9AurriGXnzlwjVuPprcspUXXwhZw1rfFL9ffPNCHLSlQthzE+
 DKYrzSlUnn2MvSw6mKLo1uuhNTs3g7dG9MeGLqZ1qF11Qj7Kms7U0FGDQDr/pFVkHWWX9tAI
 kgQ0jgvqKIo/QqqSMP8Vlu2uhastRkXUNt4CPw/8AjLy6zO4g/fCHJsc9JaQNkhqdNwWjEgk
 FOE9z/0OdBxmLKNeVCN57XMl23xBAY/KFYEaRA8SARQtrEPv7oPYgTzosFLPIPdszEYMTT33
 izMsyU0wbke5SLq60lZ1QGa695PjsKTJuLQ2ukxdj/0hu+eTNP0D7FEEXCBsZ59wH+xFzFtR
 kToZPRyHMhVUcHVz3zSKAn8NLCu4fGeeCbR6WNS820a3231oRaLJNgOiBknfRsBGphcJFfBP
 hWP0SsPvsE7FCXxN8dfPdnuY/nGOIC7TLwJoNiPN4IWOvCctWavoElTWKJn9zuyzhR8zvtjY
 snznATFJS9yNJmLBQGeH481uYLHDAhkrY8KbcGlkUaUwvCFaWSLSLwIFlKLY6prpOmHuQjZu
 ZIXfceD1xwVAqW0bzj14LwjCwkADUE6IpTq9O1RVOqIeTR9FE8bVvT+/LIGeq5epZpzqNvmx
 H+Gd3F99EvenlzCcAWDVWBiYujgXLF5tnMKAhYvNleJhVkmOJij3J4Ce8EJfJ0izuhCzOF1f
 dYBac6vEvRCcRWZ2jU/PL3Wjp1uSwSvvi2KZxGaWTkYe4VyYiD44fr2V1LL2AhXKQTvruo4g
 bmr9j2DcKo5Xw44UfrnMqO+/W2+rV02ubxUXXKRBvJxZU+10oxhCxKpv88NO8tWdCnynGqL5
 T23XyUdi/LG+bIu0d/zgquBkYelPs1+EmdeHEjZ9byGDjbbzEXy3b5/VPu0Qh6FWFPW4KmCY
 cBn/8P4OtADn3dItNNYOJRvxqQc+dDuhuF7yiJJIXb1VGmoW4hQeiS+4cpyt6N21uB4vymyU
 Rmx4dV0A+iCF/7kN18zHzAbSNq/+8saoASP0sRtEn7GvHd22JGlTXRtOwK9jX0BDbltb6Ig7
 +QTmO8XzA2d0SgVE8u0oR1V00+uLXUwdbotmb9HIY3siystkkpjZ76FAADIwZi/Ufd+GWh0H
 S2xm4z5mKV6+krOV1ERBEr997NRqrpWsS8b0WJYAUqCn+T0o8Me3TpTwGwRdRtUxBAW6NBDE
 DFnGGMtLJrf4goyotZIWl2tPARzBBe53EjV4HlRnU37S3iYbED8HFcfC82son9Aq3l9ewJF9
 o620GzmCDbmXP/g1xsIBHJKlabRcsxTxCbjxuacAMW3L7sra2HEg4ivR1YyhTnJPMcTvHDD9
 M5WpLteSKujLiMBgbwJO6/D35QqdR20DmhjQ/ZgwaA3IV/haAyCgTijFkTgVf5Odtrr8FC5A
 fNAPshgdQqz/wfQoyE5BZwjGa5Vnvko6IA8e5fuH2onsqSenBVtopn/5ijzv051YtRMwOIWC
 JLdSCKGKUOU3UBrom7qqNJWH0aFevwGWVHM5/+0++A3CJ4ziuFgXkUs2L+SvX/OEg9Y0z+Ln
 QHEPYn68vdDzNlyoo7SDalzPQW4BtftXuCu8grokdBvb8vKAPjepTEutVjrEARHD4Q/A+0tu
 +y2j+f2+0fZsJIdcWPTwcCBHpYUw/SCZrNcN8avIURKmSeHZtTX3CIC3GKFMr1MrsJW45i2Z
 gm/afboT+UvZfVm+CR3ZRRdQjEnMIamXpe48Gn5576JBwMG2APKEMK/+DW7JStHfysPINvlB
 hWyp/+q4ctCoZ9RAAMfQctrGIJ8PESpTJ5OmwcdbtVEJjLAbpK+Vrreed4I7DbWFj+bHcy87
 Z+tqt0SsvitkPmg8T2bm9UaUt4r4LJVnuQ6OE4QkzKzoy7vF3YIdIzxLr1fYqy5UUXOOFXQe
 zzHKmcvYck4sfKobj2kiOnessyj6iDi9zs3yvHFP69ZVstuOL69PQ==
IronPort-HdrOrdr: A9a23:jagDz6u6mFfjpSAeIVOASGaA7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3ASahcMmmQpAqEPS9bR+HjrZTQl6HXOXLF/FXAMk3?=
 =?us-ascii?q?gMzgqdZO/TGaW9JxclsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ak+iwag/rmAEoeRWiFb2gWPuQf+hLu6r/IUIPqrZ?=
 =?us-ascii?q?Flu/HZCB8PBa90yviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246868848"
X-MGA-submission: =?us-ascii?q?MDHmtIvwSqagwf8yXtUsw8/Ecdx8hG372ccF2v?=
 =?us-ascii?q?a12VtTxoFtF4Q0E7qeZe53Ml6uOoPPJJB8+1SjBwP+XfBV3wFSNYqzrC?=
 =?us-ascii?q?HMr9r7O1RdvdRgjlWBtoDbzaqvebBYFHLklkxF60degx3RqoLC+bbbrx?=
 =?us-ascii?q?WF4CZournCUfAeDWn+z9W1lg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:58:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761832714; x=1762437514; i=markus.elfring@web.de;
	bh=9X4nc7LqhbPCSkQ6M6wo8iFhNhlOAgdihW/7ns75Z6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KQYIhZkpgUdvbos37+Ke8uXPK72MLjokzA8kvJ3kmdZme853XUnwX18td7xws/34
	 lM9grfzSjc+NLC6aRMHdPisU+cbBAKvJ4jCsUjyf0OEoAINNCQXUHR0CJHXLjKx54
	 YvKA6waTASW1fDxQZdpKfHEllis8ietz/FLwWb3CS2DJMiP1J9KVhKmJpG+8TJ/tU
	 EwJX6LcFnKR2AJ3Uz+VURhthqXsQQtJ4kgMyMmoMVcMLvT7eaBMX/BSM4fGe5cyE5
	 lHGgknKA+dUVBh0u0u3kexKwghrwMYFe6S5BlffHpqDQDYhWt55rpTPCHIkl2ffo2
	 IHZDLdwV6EjWxceO9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6tt-1vmydt0Eol-00lE3n; Thu, 30
 Oct 2025 14:58:34 +0100
Message-ID: <414793e8-6961-40b6-8721-cb1aab30bbd8@web.de>
Date: Thu, 30 Oct 2025 14:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
 <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J2hSSGA3HEIAAJzQ4kq27hOw4yTlyx0MtxaC1dZwQb3TMS2g5Dx
 VzpVydgGNJJBqXmY4NDZFdBPVg2qYTi+DTiks+MeIHNe1rmmhGFW2C55/KaCWluQ8Z1qjur
 B/CgcBLjNK4qLMvKF5SbKXk6FvRmE6MlEa70WFtI7ojScoGYR4naFszH2AgQojNYuqpD+db
 l9ju61B9CURYzXqaXp+sg==
UI-OutboundReport: notjunk:1;M01:P0:eKfcuK35uEY=;InZEmrwqW3YLxPLwf203UzWBP95
 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
 BMqMgu6Ag7jtrbmi0mGAPJl8S4=
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3123
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/414793e8-6961-40b6-8721-cb1aab30bbd8%40web.de>

>> - target =3D object; memcpy(target, source, size);
+ target =3D memcpy(object, source, size);


> No one will thank you for making these changes...  =F0=9F=99=81

Will any more contributors dare to try adjustments out at such source code=
 places?


>                                                        Please don't do i=
t.

How will change tolerance evolve further?

Regards,
Markus
