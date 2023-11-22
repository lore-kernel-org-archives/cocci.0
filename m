Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67790C61D97
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Bpu9Ys8DgVs9GeAROFSfNrLPdKeXIdkeNOHi8U+s79E=;
  b=HFGu+7l8YveEhg1QzKX9hHD4VGKVO0dt/8EyB9xsJ5iXkZVFLypwHa+4
   M+twPXlAOzAidPZA4A28utLRAdXRPoNFeSqvhrbij90EFeFfW+9ku0KzQ
   QRzYYz+NBzKV1QdQNAxAjyio67Y+cMhiH3hi4vz4H6ogKChS65CYQneI3
   c=;
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
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137979440"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 22:24:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8481EE0CCC; Wed, 22 Nov 2023 22:24:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 62DFBE004E
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 22:24:19 +0100 (CET)
IronPort-SDR: 655e7183_N7EdyFKZM70SN/BI/yGUIRkTwH/AqdoRAZAXDjzE4xZpoMX
 HPz5PJC4KNHD+lXbRWfRApcSmiIKfmHfM0Ktydw==
X-IPAS-Result: =?us-ascii?q?A0GrCADMcF5l/wsR49RaHgEBCxIMQIQIB4FJMAQLSIRTk?=
 =?us-ascii?q?TIwVYNmhzSHSohvgxY+DwEDAQ1BAQIEAQEDBIILgmsJAocpAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CXAEQgQyBHgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBEScPCxoCJgICVwYBFAEBgnyCK?=
 =?us-ascii?q?gEDDiMHr0eBMoEBggkBAQavVR8sIlaBXwmBGi6IDQGEOoEfhDUnD4FVRIE8C?=
 =?us-ascii?q?4JHMT6EQ4NbgmiDboMag2IMCZNRXSIFQnAbAwcDfw8rBwQtGwcGCRQYFSMGU?=
 =?us-ascii?q?QQoIQkTEj4EgWGBUQqBAj8PDhGCPis2NhlIglsVDDVKdhAqBBQXgRIEahsTH?=
 =?us-ascii?q?jcREhcNAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBNgUNHgIQG?=
 =?us-ascii?q?gYMJwMDEk0CEBQDOwMDBgMLMQMwVUQMTwNrHzYJPA8MHwIbHg0nJQIyQgMJC?=
 =?us-ascii?q?gUSAhYDJBYENhEJCysDLwY4AhMPBgYJGwQOAxkrHUACAQttPTUJCxsGPgIn7?=
 =?us-ascii?q?Co0B4IxgV+BYAyfIwYTL4NuAZMzDgaST5hAIKg0gXomgVkzGiSDNk8DGQ+OI?=
 =?us-ascii?q?IQrj0dANTsCBwEKAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 pYDGOczvL0dE/QHFgJ6EdZELJolBlsZ
IronPort-Data: A9a23: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
 FhNXBPKMJv5gYsL
IronPort-HdrOrdr: A9a23:ATqMSKOC1PVHNsBcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:ar9s4mCb0cvtJKb6EzQ45k0dO8wFTmP6lnTtenaGLDxsaqLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A/OqpjQ9j/kdlg4OO2siYNqGQf+Q406CWNkMOq68?=
 =?us-ascii?q?P4eCgGyNRBjy2syviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137979434"
X-MGA-submission: =?us-ascii?q?MDHz+KhcIlRJkbVr5Vln8i5BnPIe6vFOffQ7L7?=
 =?us-ascii?q?96cL++34UNQqNH24pAQ4FH+IqC0PVqqiNfzO2JpLHfI163f7OPtjR/dO?=
 =?us-ascii?q?D9fZlfK4Z+mYjWMkz0LxqFd/1NQ2xuQnf2z4AizjZnvjejOT3WTEA3n4?=
 =?us-ascii?q?kqq/llzAUiC6wPD0AY+rliTg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:24:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700688250; x=1701293050; i=markus.elfring@web.de;
	bh=Bpu9Ys8DgVs9GeAROFSfNrLPdKeXIdkeNOHi8U+s79E=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=jIQcVkJLpytNf7ruf0krl9gZvW7YV181UT7WwWUBWo9gcmptmkitj3TTDNcgaW3B
	 +GEJWl6Bv01FCX7y4SE9CP8A99h3Y+pbCjC3s6/LHosyMI4xMqp7CYSHHNn0yOq99
	 +g/abOXXVeo8o/QpMyRj7Pq7wOzP70qZ32BWIOi6xVbdWNJyWSKW51BcN6g24vKsP
	 Cm7+ymOpiCtV8Tw01YGLxEIFTkA7ACelfmoYh7RXo/K/2l2VKTd6WCG8PyC92yePW
	 kWdgQWKL+fXn+gQZw+H5vd+YHul4h1heNw67mXMtX9Cd/7jX9oUIbo63GcODpHBqL
	 YgrRWLqjMEu9qQeCag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N01Zk-1rHWMm0FZW-00xKZs; Wed, 22
 Nov 2023 22:24:10 +0100
Message-ID: <df0d18d9-d549-4495-96ac-bb3e4969b4f3@web.de>
Date: Wed, 22 Nov 2023 22:24:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
 <d01a8b90-23cd-4058-b400-bc2c7fee1639@web.de>
 <alpine.DEB.2.22.394.2311222220380.3262@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311222220380.3262@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Ezz0wupBAwTobYcovyWgpknGNDtB8+CLl10DkXwjiD90d/NfHx
 9T8ZmpWObTT0sb61TfToIHl6pCkzvzIOJz8n23LF7COvUSdlTPkohNS4bKWVE8uhWAOKAtF
 LDANnZoLaEW4qp+r38K8DH2MqS5kepT/nw/UxnpLCngWM+PvBg7agNd+F49gHsvbO/1mHjn
 g3VdzFeyorddM3VVONzWQ==
UI-OutboundReport: notjunk:1;M01:P0:gZ2ITebWpjk=;dOI5BQLukxMJWJaDXJO5cGmQwQ5
 HbFtIIxG4ziTxcB7LiJP4d+loGRyayLP308VYVUDMj96s6TODPmrDiC1glk8tctB/ZxqCyfML
 Su3J7+3UwSqblPq2UK9GQOPg5v76EYPzsPcZcyCz5dSAmJLiO3oqiNx93Iw+WDm0RXwI62i9R
 yPmhesBufJp7OtwjVPszDOTlqDRU1guYoaIrk+WK/aTCOu+WJaIpYjHxpzJW/FZKYV6fWkX5S
 Mg1N/lIyIM2g/SRyZv7moDBNF++AvhHvVXMzt2tThf/QEAtVGI2iaZfiNSZyODee2krnKs7fA
 kC+JyYV2fNrGvg7M2man1rbwCkl2uziRarVTDyxTsQtY1eMrkQU+rm6+zj8WKkKN4mxXz7se1
 BmnRGM0nb9pNyKq2hvlDQ221HBtspaZ80ZsqHVAvxJI5PCfJsfWXmTCdbA671PEBHL0YKlmMF
 4LOpaT5+IOIXSrgNIid2wsDwZ4fo5UTH542GlD72ndGTXbsUJlJtIF5STrslrivw2vmzrBkxs
 7VHDgEYFq6guYPG2B31ejMpmmdIdCGJ/TBPEUfFDB6BDeEf5dIXu3R/FsD6zhMB/QFGtJrh60
 tCZ8BkpgZxqs50x5km6qDf/tC7dwTzL2mcqA1XrQufHR7NsErnRNOZykoaFTAbfnDjX1wVSBP
 TS+P9bZIf9+Ris1hLACoEa3gCg8h3s9CDNjfqXI2pBGlg2ey+0zBkyu7N+p722d4CmZgWnVcN
 SXmuxcpqXzQiDVGt1/gUhHCxazQRsvr0SyFnbfDGkwVaXNRSdoJg5ufs1gBdnSN14ziUhtHaG
 61ON/JWtUUFWkjxdNBWdVAncZgOq5T96Fr/TiNuaJsQ7PjWvZceYFlZwtgjLjhboOW/dUDnPR
 rS9qjFja2/v/VLdCfrWbifGISnWCbeqwsFtp/i9iw/FTEN+Qvgccxr/bIDHMRAfaBZwDkI8wX
 hu2/Aw==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1314
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/df0d18d9-d549-4495-96ac-bb3e4969b4f3%40web.de>

>> Would you like to explain your development idea a bit more for the usag=
e of =E2=80=9Cthe length=E2=80=9D
>> from a position variable?
>
> A position variable is an array.

Can such information trigger any adjustments for the software documentatio=
n?

Regards,
Markus
