Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AADCC433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wGaj6ZPhuDHmiNZkL2sFm/Up3DbQTbMB9oz3udpBkYc=;
  b=hWEE21EDzW4C6s9YJpQPJbXIRoC0pLO2RTCTMaukyGX0zdg2snYDSkHN
   SKROmseLEMsd7FD8IQprtJRGvmfyzb0KHiGg6dkJbKKS5DrIYa6Sll1iV
   iJ+KrG1uxVmqhl9l1JwkVeg58K0iDobDmtCU4OYHs7ELsyA/fYS/h3KML
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27056297"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 07:47:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4ADD5E01B9; Sun, 20 Mar 2022 07:47:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 84334E0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 07:47:52 +0100 (CET)
IronPort-SDR: S6Kpn97zFvhXP9Lcx8YZJKeMcc3DMIj/QdrposMtg14F4mQuRvTKKroyhEo6h5EIo4klDAX+Ko
 48OkUUjz9ZJSMJDgZVK30AZ2YTjtFrtrCk2bOqO0px3p8ac53LitbcICXgLTKl0HkOQTlfkGUm
 UGfBN/5ilVpuvtCVsfC+rTCPHlDaD04rPPZnuuq/A+ehXv0w5BxerVo6GEIy+5GOTVRd+Xd8Rr
 4UaAbKr3w4PH3LrAnSqkkqn4EfrjNfL1IMsSdcNXxKkncik6ffKM0C1jIT6KobAFb3fwQfwdik
 /wzeJm9Ft/1zFfgCbPuPjFtm
X-IPAS-Result: =?us-ascii?q?A0D0CQDazDZihk7ASNlaHgEBCxIMQIFcgiZ+VysEC0SEV?=
 =?us-ascii?q?IgohkuCKIQfjh2KKIF7CwEDAQ0SAQElBQECBAEBPYFVgnUChDQCHQcBBDgCD?=
 =?us-ascii?q?QECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMCwkHCAoHDhAFN?=
 =?us-ascii?q?gZeBmQEgUsEgXQLNA2CNSKDbAECAgEjHQEBESYBBAsJAg4MAiYCAlcGDQgBA?=
 =?us-ascii?q?YMAAYJkAQMNJQuRV5wMgTGBAYIIAQEGgT8BE0GCNB8sIlKBWwMGgRAtjkgnE?=
 =?us-ascii?q?IFVRIE8glMwPoJjAQECgV6DGoJlmHRZgQWBLMA+NAeCEoE6gUEMiUKUTwYUL?=
 =?us-ascii?q?oNiklsOBpFtHZY+jRWZbYIPgWczGiSDOE4BAgECDQECAgMBAgECCQEBAo4dD?=
 =?us-ascii?q?A0Jg1AzgQuJIUA0AgEILQIGAQoBAQMJhUcBAYwpAQE?=
IronPort-PHdr: A9a23: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
 DTfpJhirgP/+gFu4j9gTQYItTtBwo6G7x0KBA==
IronPort-Data: A9a23:/oAp/6791QxGz0Yv9SXLuQxRtGjBchMFZxGqfqrLsTDasY5as4F+v
 jRJUTqAa/qOYWfzc94jb4i18RkAuMWDydZnSVA6rHpjZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yio+5WGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 PNUr7uaViUQBZfdxOcaeAFDMChjPpQTrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuXicRr
 7pBeWpLMUDra+GemNpXTsFJj94gMdKtEYcRoHBmwhnGAPxgTZ2rr6Div4AAgWlq1pEm8fD2T
 pEyVhFvQQ/5PxBtEHgeFL8Twdq4mSyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjaiz2L/SazieZtG2hjKnDkEsXRb7+CpWe7+RNqkKx/1cpGUEVUnCjutqwl02HDoc3x
 1MvxgIiqq079UqOR9b7XgGlrHPsgiPwS+a8AMVnsVvcm/G8DxKxVzRVF2YphMkO7pduLQHGw
 GNliPvFKFRSXFC9THWA6vGLoDn0NSV9wY4+ic0sHVRtDzrL+tlbYvfzojBLTvTdYjrdR2iY/
 txyhHJi74j/dOZSv0lBwXjJgii3ur/CRRMv6wPcUwqNt10lO9H8O9LwsQOBtp6sybp1qHHe7
 BDofODBvYgz4W2lz3LlrBglQe34ua3fWNEiqQQyRcV9n9hSx5JTVdkNvG8nfRkB3jcsIHGwK
 E7VpQ5L4pJPdHKlBZKbkKrhY/nGOZPITIy/PtiNNoQmSsEoKGevoX8yDWbNgDiFuBV9yckXZ
 MbAGe7xXCZyIfo8l1KeGbxCuYLHMwhlmQs/s7igkkz7uVdfDVbJIYo43KymNblosvnb/F2Lr
 76y9aKikn1ibQE3WQGPmaZ7ELzABSFT6Unep5MFe+idDBBhHW19Wfbdzal/KZNoleJZm76Qr
 H26X0ZZznv5hGHGcFnbNCo8Nem3BZsv/2gmOSEMPEqz3yZxa4iY7JAZK8k9c44h+bEx1vVzV
 fQEJ56ND60XGDTK8jgQd7fnq4lmeEj5jA6CJXT3fzU1OZJtHlSb9tjhdwrp1S8PEivu6Zpg+
 eL9jFuDTMNaFQp4DcvQZPa+9H+LvCAQyLBoQk/FAthPY0GyooJkHCzGiKNlKc87LxielCCR0
 BybAEtDqOTA/901/d3OifzWpoulCbInTE9dAnWd8ru8cyXXpzLxzYhFWeeOXDbcSGKtpPT8P
 7oIlamkPa1VhktOvqp9D61vk/A06ezvkLkGnA5qK3PGMgawAbR6L3jahsRC6v9XyrlCtVfkU
 06D4IADa7COJd+jD1MbYgYoN7zR2fYRkzjUzPI0PESjuH4ppuXaCx0KMknekjFZIZt0LJghn
 7UrtvkW3Arj2BAkBdCL03JP/GOWI31cCKgqu/n22mMwZtbHF72DXXDdNsMyyJSIdskKLUQgZ
 DOZ7EYHa3Kw2WKaG0ff11CUtQaeuXjKkA9HxhkOKjxlX/Lb0+Qv0kQ5HSsfF2xoI9Yu7w63E
 ndmPQt5KM1iOtuuaNdrBwiRJu2KOPFVFoEdBbfEeK01gnREjlDwEVA=
IronPort-HdrOrdr: A9a23:xNiPTKuPhz806lTz4tn+sCKy7skDUtV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27056289"
X-MGA-submission: =?us-ascii?q?MDHTgjj1rBUz0NHBaOUb0xq+SdTKpRwuybUp3T?=
 =?us-ascii?q?UQdlOilCQpxdoIT4+aIs/5LEcxPh++Ndxd4RzIq+5JWe521Gq0l6fWZo?=
 =?us-ascii?q?QabPQSuk9rsEfiK1yG/RI+lsX2ED9Ig7pUL8uhMtuERKYz3gv/6N0HT6?=
 =?us-ascii?q?plXi7IjWrXkMJBdUarDgyOUg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 07:47:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647758871;
	bh=wGaj6ZPhuDHmiNZkL2sFm/Up3DbQTbMB9oz3udpBkYc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=ohkdrjRDXYkd/QzgZX00UOdtUC68QWAWdgC1V3tyDnYbfDWoBjwyaVcA5INhNkZh8
	 L+14AcbwjX+HtPYVjzETqTMNeG0p2ut5ryT5i9LJaUWNWJ4CyiFGQMHuUdt28O16wf
	 ETSO2Z6jbkX2CC/bvmxJkgPwZUFxEkhSVM62Pcxs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.118.49]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWQyX-1nc7pt3Yjb-00Xxq8; Sun, 20
 Mar 2022 07:47:50 +0100
Message-ID: <dd9ec04c-123d-6e7d-27d9-cfce04db4f24@web.de>
Date: Sun, 20 Mar 2022 07:47:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
 <alpine.DEB.2.22.394.2203192038220.3204@hadrien>
 <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XlDqwXl8LYajxNILxRLLXAdkeSEoaC+XFRs4Xw9t6qUcrkUMels
 2AHSDTIlWAoSHikF/r5OYj7/rLnFo6Iwym5Fnv/8jR6coLMcPZP359nVXvwkINNgv/S9TRh
 N8kGPmZ8brpXLGWBBYrtOygwmJL2U2UiZFZrtv+okHfr3w+Sq5nCLQBTkhQQNJnwc8ifm2p
 f2lZo8W1bRMAJaMQ50bDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHjE+/aEXp8=:ocW/0Q3/BgiV9Yaj+x7LOC
 ZQwH33fIt53vZLykthvu6D3I9MY0TkKtWKnjEtnzoyrhEDysLjiQetHbEsq5b3HYNkiyF/J6C
 ypsOUa0mik4WpGpbGNt8nKmZM1wNLcsRx7XwmY6DGFVAM3Lji02EBJ/GJ6RmTbcFfmFo7HhPB
 tguhbuhxOku5nufIKIXahT5Vzig0XBV4JnwIuNdJZGv6/FjeTRNfzBSMsAiriukVrrd13hJ7g
 JliC6b60fVj6aGSVACvGE/t5IKPcQ/gHySWpeiSEBj1y1ykQxWXMn3u1JKN8lCM4WWugOMZsk
 Zazw5UjrXoA1rssdZThYJnUlnBqOnfaj7TrvTf/LTnytPN5sdOkBaFu/H7Vy0JcGx5Upz2KIz
 jTWazu617DOxSXnIpZN5um1ThtGX40KgckukFrptuJCxnkHWhVuFazpFVq7bETyjw0pTYZ0Gq
 84EeNcBA7zJefK6tl95ddecv0fACSKwDnSW0L2adxC19qcRzQkv4S8xNdiE3Kq0HFzD35n5OV
 NTor7T//g/izJGwGhBpQ2VX90s+Rkhs9WSCCT3fHO0ndoMBdfLWiftKIb0kBaWq5ODYGCSHto
 wW7HjYPPKeznKJC0mMvYnZ4Unbm3W0SLyQCCa9CC7pxYkFWmKDK5aUHJP1Kw06QczjeVzHCkm
 kRZS4KK/+fIkOUaN60otEuDBtAjlqF3RTMMZginbPxzL9s0JuqmzWP4+GY7ERnWgucQPuqXpf
 M4q31jpcc/iGwH2PcTU00fvd40acHOmZTIsQjWGb8CNBjaGn8sPBORXvX51aQKXmTKLIJwaKs
 KeWn9bZOrPUPa+bwSEmldBbJ18HX6GARSQQ99gqLVojeYOYBdt1HNprR+4THE5IVAr01lINQN
 yT4/5q4BUNlEG+93Fi/IFVKTANIAZTB5d99wYXswCJlWL7r/Ld+aHFGpWwOy/z4ShsPXDy0Lv
 nrvnfHNp4KcyEHSIR3h5qekSe+/oGUZcOput5d8APSMjutCa5zo37KouzT2s+ZWecsLQ0JXWn
 M3grMu1s9xtygoiXrXzNi5uuCUkFHjjx4CEFQ+YhQCQjsqec+DfA0bnH6u9E9o9ctjec+/FKp
 blndRuPJh0LRJk=
Subject: Re: [cocci] Parallel data processing for selected SmPL scripts
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 259
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/dd9ec04c-123d-6e7d-27d9-cfce04db4f24%40web.de>


> I don't see -j in the `spatch --help` output.


Did you overlook the following information?

* concurrency

* --jobs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the number =
of processes to be used


Would you like to achieve any improvements for the affected software docum=
entation?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f2223=
37e13091115884cf6bb/docs/spatch.1.in#L453
https://github.com/coccinelle/coccinelle/blob/7e6bf1fb99c80521b83740e81c95=
dc417ae6a621/docs/spatch.1.in#L453

Regards,
Markus

