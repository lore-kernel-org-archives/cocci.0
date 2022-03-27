Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029DBC433EF
	for <cocci@archiver.kernel.org>; Sun, 27 Mar 2022 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gN9+xBbYl571WW2b9Lz2oBaBFFMTrptRXJvyRTR6/ik=;
  b=lr9nzsljDIjTOMYLcHXa6R+INDpbXRdAbukAyqzOfskFm9Ty4F9CwcZ9
   MTJ37v8FomCzBEBIYugg/8JZbY6jjcnWnm+qEKfY+HqEr35ngw9wdSGWQ
   EKB/NjuuwOB3HkKR5h40hPRrvNUL1c5xQgZ/dRxaMLKmsW831mnFGVZqt
   E=;
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
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="28496788"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2022 14:04:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E660FE4372; Sun, 27 Mar 2022 14:04:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 27280E436E
	for <cocci@sympa.inria.fr>; Sun, 27 Mar 2022 14:04:21 +0200 (CEST)
IronPort-SDR: aUMpb2oEKnQUtJfPIYrUXwMTXN790IrR9TPb9Eja59OIVttFz9qDxStd4hNjpmn4F/afMEtixu
 amUNi9txRAmayLM7FzRhnC7cd9c3JwSagi3cLTuE7cRCI8UnDQwCHXYb8f73YGS8tjz/nOdBIg
 JF9zuz3mHPysTcf7dG2+3i9gII3/aVKfBoFHymM15218rzIgqF4gSNy15AHjySIrmfi1lmPovK
 fMDl4RXoDVzzX7Tzg0Qa2ZmTslliBzjvafCW3rBqYWtFQRBuCtCYJSbQYX6huuPqCv2TBSGTJk
 3Qkqz5Fuu0yE+kj15ySEdnRz
X-IPAS-Result: =?us-ascii?q?A0BlAQBhUkBih07ASNlaHQEBAQEJARIBBQUBQIFagiiBV?=
 =?us-ascii?q?SsEC0SEVI5zgiiLJIcZjCMLAQMBDUABAgQBAYISgmsKAoROAh0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeB?=
 =?us-ascii?q?mQEgUsEgXQLNA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYNCAEBgwCCZ?=
 =?us-ascii?q?QEDDSWuGYExgQGCCAEBBoRIHywiUoFcCYEQLI1QeicQgVVEgTyCUzA+hEWDG?=
 =?us-ascii?q?oJlnFGSHiWtdDQHghKBOoFBDJ4RBhQug2KSYQ4GkW+WXKcEgXiBfjMaJIM4T?=
 =?us-ascii?q?gECAQINAQICAwECAQIJAQECjh0ZhAyKLT80OAIGAQoBAQMJhUcBAYwXAQE?=
IronPort-PHdr: A9a23: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
 p7Qmai1JDoQq7rp
IronPort-Data: A9a23:2pjyIqqa7qtBS/JQZMqBJ2Z1+GxeBmJ2YxIvgKrLsJaIsI4StFCzt
 garIBnTb/neNDGgLdlwPI609BkP65/QnIJqGwVsqSAxFC4X+OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0IDR7z+l4
 4uo+ZWEYgD9glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSJSx8JMvDtwd4/Sh95VBl/YvNa2Pz+dC3XXcy7lyUqclPpxOhySl47N8sU946bA0kUr
 KNed2pLN0HZwb3mqF64YrEEasALCcDxP54E/FxkwyvYC/kOXp3JBanHjTNd9GZv3JkSTKe2i
 8wxOB9QfiTQODh0JFInObgdu764pCDUfGgNwL6SjfNqvzaKlVIZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXPSbwCWM9naElO7KlznyHoMUDryxsPBw6GB/3UQWDwAKE0S2q7+1hyZSRu6zN
 WQt+DIOofUTrXaJV9/cGCW5/yCYnl0lDo84//IB1CmBza/d4gC8D2cCTyJcZNFOiPLaVQDGx
 XfUxom4VGcHXKm9GC7Mr+/8QSaaY3BNRVLucxPoWiMpzrHeTGwbixXSUpB8HaTzgtCd9dDML
 9Ki/HdWa1Y715ZjO0CHEbbv3WjESn/hEFdd2+kvdjj5hj6Vnab8D2BS1XDV7OxbMKGSRUSbs
 X4PlqC2tb5SXcrUxXDVGLhSRdlFAspp1hWD0TaD+LF+plyQF4KLJts4DMxWeRs4bJ1eEdMXS
 BWP51gMjHOsAJdaRfYqP9zoUppCIVnITJq8HvHSctdUZJVtPAaIlByClmbAt10BZHMEyPllU
 b/CKZjEJS9DVcxPkWTqL89Aj+5D7n1vnQv7GMGgpzz6gOr2TCDOE98tbgDRBt3VGYvf/W05B
 f4Ea5DVo/ieOcWiChTqHXk7cAlSdCNhVMmswyGVH8baSjdb9KgaI6e56dscl0ZNxsy5T8/Eo
 SOwXFF20l36iSGVIAmGcC4xd77lG5py9CppMSspNFeu+n4ifYf2sPZBLcRqJ+F/+bwx1+NwQ
 tkEZ96EXKZFRAPHzDJBP5Pzm4pvKUawjgWUMiv5OzUyJsYyRwHA9tL+UBHo8S0CUni+ucck/
 e+/2wmdTZdaH1ZuC8PfafSOyVKtvCFBybwoABaSeoFeIRy+/pJrJir9iu4MD/sNcRiTlCGH0
 wu2AAsDobefqYEC8O7P2fKOobCvHrYsBUFdBWTase27OCSGrGquxYhMDLSBcTzHDTqm/aK/e
 aNKwvu6PPBexARGtI91ErBKy6Mi5oKz9uEAkVk+RC3GPwaxF7dtAniaxs0R5KdD8b9uv1fkU
 Ey4/NQHa66CP9noEQJKKQd5PP6P0+oYxmvb4fgveRyo4Shq4PyYXE8UMxTV0H5RK758MYUEx
 +Y9uZdKulLl1Udwao6L3nJO6mCBDn0cSKF55JsUN4/cjFZ5wF91Z5GBWDT954uCaokXP0QnS
 tNOaHEuW1iBKov+n3sP+bzl2O1AmdIRtRoMwFJqy5FlXDbarqdf4fGT2W1fosdpItFvzO95f
 GRmX6GwDbvb5C9m3aCvQEj1czysx3SlFojZ1FYD0mHUJ6VtuqohM0VlUduwEIslH66ws9SVE
 Hx0CIoobNoyQPzM4w==
IronPort-HdrOrdr: A9a23:BksxKa8rcEs0VmY41kluk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="9721499"
X-MGA-submission: =?us-ascii?q?MDE6GE9N/BQCrmNYsejRrh2Qvq/JF/ppveeO9v?=
 =?us-ascii?q?iBzavlm3pl8Bndqgp8iklb/T2YtZ8YApERX/OHbs6/BgpE6FYJx3e5qs?=
 =?us-ascii?q?ZhIbi9fqElhddS1hCGXqcRpphjTEqUwgBo1gtAaOBuMkCpnOU44WQ7RB?=
 =?us-ascii?q?SVi0k26kVaU1Cfw8oj1hfGVQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 14:04:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648382659;
	bh=gN9+xBbYl571WW2b9Lz2oBaBFFMTrptRXJvyRTR6/ik=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=sTs4jjT+6RkqfSZ2t65WXfFu6aS31oCu005ZRg2anfSPSAqAsUWciGW44L5tK6sqP
	 00cqkD0EVJH7WO36bSlyAHCoPS1339/zsVuYs0Yi9pSZpV5DCHtldcrHLiN3qTkrJC
	 rmuSMd+YgrvoqxAiKmaXC6a6EPe7fndPNmh+YC00=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.165.68]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1nieud3gpx-00ARh5; Sun, 27
 Mar 2022 14:04:18 +0200
Message-ID: <46702ad9-17f2-9be2-d985-c89e207786d6@web.de>
Date: Sun, 27 Mar 2022 14:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
 <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
 <243b180b-6fc3-1003-a592-1fc01bb198ad@web.de>
 <alpine.DEB.2.22.394.2203271352240.3119@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203271352240.3119@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zpzt5/dZv1VDq1Qq434DyfMw2gTt0drr2UWt2ti5kg/b0/uHRyY
 e3tNnDPL7FGRnKdDAoITYZZHMfzYMsm3rReyBjwRTKIR5/BiJN05Q4WHorT9O1fUgdl6Fzr
 Zj6v+4Cgk/DbYIzp6O96dC6bH2r+tKfrk2td5NT/65ehPQw/r+a/nzEWY74L2PPFVllcdCs
 EogskAdTYdM4zH6zerXzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vzknd2pmrk4=:i5vS1CR9vKFQpvLBpKEDul
 z9myqRnyI7JYrYTsey8xeuAuMfQuYlargGqSj1IlnBacEjro6Mrj/vnZtR2qMJXFdwjnivRod
 l7l8C+VdQFHAgTilnX0JavxvguiOvRN+CzahsdMXgTLTmG3Mg98IFd4CFyN826enc/i3pn5Ek
 dWHCFr2yYAABk+dmnDtZWzoxtxUzllLyBU6SQtJzbV0ZWolPP6MljVbFQFjHRuuH9UzMcG/tx
 8zRHlH0sd0svy2m1LpDFQAu1arnfLQhTOi7dze4NbHcZEcACjpZ9B7VYqBDPm2ocf1Dl5IXPP
 cLUWrWQM4Mf8TRuKWN8Uq0G+uU6pYteUBBXngoi5oh+iXyMCeWk+qCxwRJn0oO0djtzUZ2I1u
 trAqj4gJ9T/N1fKRkFx6SrNJsHJ3pd9eKQXeUhFiw/SUmGKQ2rGJi3LmYm0qjLMVkj0F6PtWL
 B1m+tX52z7bPJ9Mn75ROAzUcqjH6mNczyFeXvPjAuwfbW000wMDccdgFGu4iNi0trI6zdyZs4
 8mj9qBpwhOuG0zjLSFUdKuqEaEy41a6cwjO0WZVq5xahDou9Hlml7ZUsekmKhBUNJOIwwCMlo
 QFez0CN8JRaFgk/NuRFzyl3qc0QsQ/fYYMLTxgs58FFW+hiMD/xSnQjqkU9yQlKL0V35F0E9G
 M+TA06YMnaKsFE36quDlTxc2V2NDOLJWWb3keLBk2tLfto5BTHuaU7M7l2gfipelflO0ADdRN
 6VCcyCnxqnMQbrhEN55vPlb4nFVkJPlNz9coNmiMjV3djF7t427lkM5SVqyXDlZoYnwZvL7rs
 DX6YoUY4PQ6/avoIl+C+QBLeGFitX02bUG7v2EMIsKuX/+Ib2Dn32nSg7UCunl2qobP+SIEmR
 VM6lBwOmYn0B3r1n4KXaVBJHGx2w49rVqmDP3JZrtJ59OXL5Q0XtblySB4LJ+1jFWKBdclyBb
 4RH0/xtN2DwAYIdOGyO1FA0XppwZRnXtENT31xO0U3cEXcju3jOKrKJvPkX/qErYXaLVkhKj0
 d6Gq05jDK6mKtm1n+sJguzma2JzdeDARanZa5K/QQ7k6dChTZn5NzcsA2YZosaSBNvhVMHf34
 O2mEdzsYPezqbE=
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 296
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/46702ad9-17f2-9be2-d985-c89e207786d6%40web.de>

>> @display@
>> constant char[] text1, text2;
>> @@
>> *text1 text2
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --pars=
e-cocci show_string_literal_usage3.cocci
> SmPL doesn't support that.


I hope that the affected software can be improved further somehow.



> If you just match text1, it will match the whole thing,


I would occasionally like to match only a single string literal
so that subsequent string literals can be handled separately.



> and you can use python to extract the pieces.


I am still looking for ways to avoid undesirable side effects
in this data processing area.

Regards,
Markus

