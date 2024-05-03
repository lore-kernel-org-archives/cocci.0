Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6584BC4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 10:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jlNrMFsMV0q0ecJdxAVpLKgO1vh12xy+KV4CEZIoaAk=;
  b=XuqYR1MUkj2lwiYhESgQqvZpu2HUP9BCEK018wEoR3obMKnMjfg3dJaN
   CGfjW2oXbO7kRy3u9aRii+njv1a5ImI/AijgqaUShN7ZqK52NylfJ9PM5
   q1IMuHh/wh9a8MppPt1Pucq6sJNS4E/LPJSrGXOl548kq83cFoeBmAiqq
   c=;
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
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164376256"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 12:41:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6A187E013D; Fri,  3 May 2024 12:41:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C4EFE0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 12:41:03 +0200 (CEST)
IronPort-SDR: 6634bf3f_dm/gYG4ti+w1dyzZ78LUKii3Zf5EbTx33CQFwlkEN8qnl83
 xWheZ53HjymQ3/MuKa+buoAVR0draZBmGtRWumQ==
X-IPAS-Result: =?us-ascii?q?A0HmBgBvvjRmhwwR49RagQmBUYJCfANUMwQLSIRWj0aBd?=
 =?us-ascii?q?TCEO48IiHGDFj4PAQMBDTUMAQIEAQEDBIILgnQCiC4CHgcBBDUFDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXQNgmcRgQ6BJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCGyxCAQEBAgEjHQEBEScPCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgnwBgi8BAw4jBw2zZYEygQGCDAEBBtpZHywiV4FiAwaBGi+ILQGFfIRAJ?=
 =?us-ascii?q?w+BVUSBPAuCeD6EQ4NbgmmaK4xwVH0cA1khEwFVExcLPgkWAhYDGxQEMA8JC?=
 =?us-ascii?q?yYDKgY2AhIMBgYGWSAWCQQjAwgEA0QDIG8RAwQaBAsHdYF8gTUEE0QDgTiJf?=
 =?us-ascii?q?QyDMYF3KYQhCENsFYN2gXgOYoNhglsdQAIBC209NQkLGwYiAR2ga4RygU3GM?=
 =?us-ascii?q?DQHgjaBYIFhDIohlSMGEy+DcpNGDgaSaJhiII1UmxOBfSKBXDMaJIM2TwMZD?=
 =?us-ascii?q?445hBSEJpVCQTU7AgcLAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGzP8+MwBG47LJcjBPHdzaXLU
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ln/eZKNo36bsWMBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:0Qe9Y276sMtivM0RMtss9lUuMM4LI3zk7inqf3CHI2k4TbOoVgrF
X-Talos-MUID: 9a23:Rld/egayLWRcIuBTjA/UlG5gMcVUv5uqKloc0oot48eBDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164376254"
X-MGA-submission: =?us-ascii?q?MDGzaBKQZztOYLpk7eBEMxxmJvzBi021QFfnaq?=
 =?us-ascii?q?eRdHx+TqRQR2rjY2VfjKlc0NwrlzTecVAoHomPmSQZ+02mccszwtFS7O?=
 =?us-ascii?q?U3M5XY3wMOmZkcyXsjLREOlTPC6tARNQtsaaNQuHyszh2kWgNMn9wD15?=
 =?us-ascii?q?OVKW8qW1g/TGOEV8+Dg6b8NQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 12:41:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714732860; x=1715337660; i=markus.elfring@web.de;
	bh=jlNrMFsMV0q0ecJdxAVpLKgO1vh12xy+KV4CEZIoaAk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nma2qDza+lr8RklC8dNZmmh1XtceTeehxH40eYYjcE2CgrawsdFMO6QA/nHtZtzD
	 31XvHMQ7lMSqe3D02m0vUaD7N4SRuX0YQ76PIc+N38cjO1DtAGiI7J144/Df246Rk
	 +dvSXIE8kDCTpBr+Wdc3UFue7OsrBoSrR0WaKtZ9wkJ1kAOJLnx5Tt6L0oRQtPm9D
	 I7n13SSm9fTVxw+wzeZcP8jePJJgC9Xj+uUVV2TXSDKV5RN38IwKNh73w7ek+AbR+
	 Lo11pjtoaDwT29jZC/OqALmqEFrMgAOSOYTSETqkReOUBAh+rZr+37YqLk5vKEBRm
	 WEdt7BNzplSH/mM8ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCqb-1sQYtv1v3f-00p2U5; Fri, 03
 May 2024 12:41:00 +0200
Message-ID: <72b79221-63f7-4095-a5f9-d4502deced43@web.de>
Date: Fri, 3 May 2024 12:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com> <20240502171930.GE30267@redhat.com>
 <20240502173148.GF30267@redhat.com>
 <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
 <20240503073135.GR7636@redhat.com>
 <f353bd20-1821-4112-b12b-bd1a111f7d20@web.de>
 <20240503102404.GG30267@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240503102404.GG30267@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:woqQXbctrb7KDhsy4Z12OgIQcL/u57zt4KOGH6QewCCF0u7x5F3
 flCiOFDdOFY/PK03DqkvgjxWYQWhIMGMZnvZBLJ9LPA9IQK7DrvEuxhO43QFjyFRnkFbgQo
 leNsXQDCmvERHVV2BdSVWKfefrUzQCWsCcTFrIfJGYlfNoxIV5tqvTLRhLUQqaKN0EQxIsc
 ulHjBmMGO9yjeKZVCQTeQ==
UI-OutboundReport: notjunk:1;M01:P0:xfASLU1AKoo=;bdn5Hy4xHkZjHgRZ/ltW7YvOmKu
 DStNTgPvqQ+4oGthr5RvcVzL69phBd+A2gjNGUNt/NOzmopGKyMQUy1CLDONqLPO0BbxZjH5s
 a7pmf2RZOzZy1ns5mdSoSebasxuWlP85Y8skNYZvNsyzpLkjzsBRUuIXJYY5uH8uXaeTFOsJF
 x3v6S0nvkE1Brm/0OX3HV68GU/DbCAMiGw0nMES+xADlb5ATc0jcXbnce1lMtj1bLaRsEm5gN
 pO2uFvNs50wSiKztFiRw2gn2tl/6fOlgUmo3zo1v+coqCl3MEROZFSDr/YNj00laSJlf18YDu
 KXL44J3iSGzpZWpXEUIX00p9XTGGCgLj9tHkJtc9AwkrC5bq9dUXwyFptTn9QTh4xKYN0ronB
 fVpVjM1h+rGB/iYTx+lBFKT2vYFxEVJyoLmqO61u0wLj6H13usfk5+BmxsjSRsAqedCLsvBO9
 dgRB4tOvwbZ/es17uTCzRrUaXL2R2VLE7k8cGVNlIxJTvgTSGKtgpnSEPxySQr7HthbV7X2+F
 XV89YjcpQ+KGPUhyq8EWV0ng7+JRFUFi+QT7toxF8+4t2gufkCBUmc1HiLUku7ZCYbpPIhmUb
 KWCE4jIoJ7eRCjU30kpFjsCCmr/rYCusgUMx4LDvW4fh3/yhPg66E74iQyaex8uNKX5IchI7t
 23W0WCbm/LImdiMjdRfIOPAiSur00rxT0cKLpFeAXNkOznZOSOKrZRDwiNYfW+C3fvPWPG+af
 nXMumMMaVwFD8n8Yucybd3VytZAeiGzyPv9JMl+QrQehS940Nfqjlw2exFqr9Say8gfmi/AMW
 Q5rLNul7k1G+3CZrqQXyj1Xe+HGUe8nx96n1TH1kz41Y9858mvWiZ/s4lzmwa+6Zry
Subject: Re: [cocci] Analysing software build processes
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1692
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/72b79221-63f7-4095-a5f9-d4502deced43%40web.de>

>> Can the analysis become easier anyhow according to questionable softwar=
e run time characteristics?
>
> I don't understand what this means.

Do you know further profiling tools?

Example:
https://bashdb.sourceforge.net/remake/


You managed to generate a flamegraph with a special software build process=
.
Can we benefit any more from such data representations?


Would you like to help to achieve out of source builds
for affected programs?

Regards,
Markus
