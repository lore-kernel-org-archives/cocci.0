Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD57FC83F26
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=duTsmyIZdUUwD8ReuKoPwD/uhBXBvJj/E4PLekoL7a4=;
  b=tjK6SkoFv3wfGZ2P7HoIuG+qmLkKhvAmcGUBJMzkXj/OK+UQlRUiq6i5
   0OsAHXvrdgl1DUOXV8wQ5we3cVa/EjLp3aFNc8eGB7UV2+vGbAsrxdRTm
   HEOhl0CN3uMAfaOQ5NfHobTYL/9T1HQskf+sHLJVqk3V2x87F8TzQK5eR
   0=;
X-CSE-ConnectionGUID: XULC3blTR2GZ+UIU7dMtYw==
X-CSE-MsgGUID: Gamq92LdQ7Ooh6xJqx3WkQ==
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
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233013751"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 17:02:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EAD3EE0C55; Thu, 24 Jul 2025 17:02:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B55CDE0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 17:02:25 +0200 (CEST)
X-CSE-ConnectionGUID: s2RLFQIrT2yUKw7xg4YN8A==
X-CSE-MsgGUID: ED9JFCcnTimvE9Rsx3ygqg==
IronPort-SDR: 68824b01_qCKmVL5f76liF6czAqjPx+RbAJ7mGl0S8NFrx+mZm/g7DFH
 vK2+RWU6UmCP0loRsXQwVC56eCL5kiKK9H+OXuQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FQBgDpSYJogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIEABlQzBAtJCIRNj1CCJIQ7jxGIeYNSAg8BAwENRAoBAgQBAQMEhQACj?=
 =?us-ascii?q?BYCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?TsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjHQEBESYBB?=
 =?us-ascii?q?AsLGgImAgJWBgEUAQGCfgGCIQEGEAEDDiQHDQa1eIEygQGCDAEBBtpeHywiW?=
 =?us-ascii?q?YFkAwaBGy6FbYJkAYYng0J6Jw+BVUSBPIMDPoRDg1uCaYImgRaDZY0GiC9Se?=
 =?us-ascii?q?BwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd9gw2BDoQoK0+CInWBeUEZP4NTH?=
 =?us-ascii?q?gZtDwaBGBpKAgICBQJDRYFFQAIBC209NwkLGwY9kxWDIIEVLFSUaYNRr2w0B?=
 =?us-ascii?q?4I4gWeBZAyKLpU9BhMvl1IOBpMFmQYijWaVc4VGgX8jgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQAM78oQTUCATkCBwEKAQEDCYVGAQGKMYFLAQE?=
IronPort-PHdr: A9a23:+H5Lfx/N7YqZmf9uWUu1ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 wqHvr491A6VFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEzIjt4A9sjdkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFijSwbaluI
 Bi4ognctdUajI9tJ60s1hbHv3xEdvhZym9vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68PlrRbMQRKR63UTT2saihVHDRTL4xH8RZfxrzD1tvFh1ymAPM35Vq47VDK/5
 Kp2UhDoiSMHNzkk8GHLj8F7kaxWrA69qxF53oXZe5+eOuZgcazBfNMaXWtBUdhXVyxdGYO3c
 o8DA/McMepEs4Xxol0Dpga8CwaxHuPi0jxGiHH50qI0zuovDx/L3AIgEd0MrHvao874NLsLU
 e2v0KXE0SvPYvFQ1Dzg6IbIaBchofSUULx3a8XR00ovFx7ejl6NpoLlOz2V1v4Ms2id4OprS
 OWihWk9pAFroTiv29wshpPGiIIRxFDE7yR5wIA6JdCjRk90f8WrHIFNuC6ELoZ7RN4pTG50t
 igg0LIGpYK7czYQyJQh3xPSaf6Kf5WU7x//SeqdPDR1iXJqdr+9mhq8/lStx/DiWsS1zFtGs
 yRInsTSu34CyhDf9MeJR/l+80mu1jiDyQLe5+dZKk46kqrbLoQuwr82lpcLqkvDGSj2mFnyj
 K+XcEUo4PSn6+PiYrjgu5SSNJd0hxngPqgzhMCzG/o0PhYMUmSB5Oix1qfv8VDnTLlSivA7n
 bPVvZ7HKcgBoqO1HRVZ3pgj5hqjCTqtzc4WkmMdLF1ffRKKl4jpNE/KIPD/Ffq/hlOskCp3x
 /zcMLzuHI7CImLen7j/Zbp96khcxxQvzd1H+Z5YF68NLOjtVkPvttHUFAI1Pg6uz+r6Ftlxz
 oYeVniOAq+dPqPSq1iI5uc3LueLfoAVojX9K+U+5/L0gnE5nVEdfbOo3ZsRZ3C1BfpnLFuCb
 nb2n9gOD38GvhAiQ+zylF2CTTlTam62X60m6DA0EoamDYPYS4GsgbyB2Ty0HodMaWxcC1CMF
 23od4SeVPsWZiKSONdtkiYYWri5V48hyRauuRfmxLpgMuXb5iwYuIn41Nl14u3TjQs9+SZ1D
 8SbyWGNTnt7knkGRz8sxKx/p1dyxU+Z0adkm/xYCcBT5/RRXwskLZLcwPJ1C9fxVAzbZtqHR
 lmoTs28AT4vUNI/wMUAbl54G9WlkxDDwzCmArELmLOQHpA777zT02DsKMZ+ynbG0bEsgUEpT
 MRBK2OomrJy+Q7LC4HUlkWWjbyqergE0SDV7WmN1WWAsFlDUA5oX6XIRWoRa1fLo9rk/k/CV
 KeuCbo/PQtB18GCLqxKZ8Xxg1tfXPntN4eWX2XkuXq0BB/A4rqTZY7uMzEfwSHcAQ4Amh8a+
 XKuNA4kBy7nrXiISHRlElnkYmvt9/N/oTW1VBwa1QaPOmhozbmo4VY4gfKGSvUcluYhsT0it
 i4yMVKzxdPQBPKfqgAncKgKMoB120tOyW+M7181BZenNa03wwdGK2yf3mvr3hRzUcBblNQy6
 Wgt1Ex0IL6Z11VIc3WZ24rxM/vZMDq65wihPojR3FyWy9OK4uEX8v1tjlz5vxyyUGcm/W9m1
 dZ9zHaWoJnHX0IJSZykak8s7FBhoq3CJCw05ofaz3ppZIy9qDzfwJQEAOU/yxCvV8hSOuWIG
 Vy6CNUUUu6pLuFigF21dlQEMeRVobYzJN+jfuCa1bSDOeF9gHS5gG4B7I0VPluk0S16R6aI2
 p8Ex6rdxQ6bT3Lni0/ntMnrmIdCbDVUH2ylyCGiCpQDLqt1NZ0GD2ujOajVjp13moLtVnhE9
 VWiG0JO2cmnfgCXZkD82gsY3FoeoHiuky+1hzJulDRhoq2a1S3Ii+PsEXhPcktCXmp/lhHBJ
 YaujtYVdFelZU4lmVrt5Er3wbRauLUqN3PaEg9Deyn7KX0nU7Pl7OPYJZQVt9Vx7mMOCrfZA
 xjSULP2rhoE3jm2GmJfwGt+bDS2otDimAQ8jmuBLXF1pX6feMdqxB6Z6saPIJwZljcAWiR8j
 iHaQ1amONz8t/CdjZTeqaaTU2y7V5tcWTbmx8WMuWHogA8iSQ36hP21ltD9REIf2DX4ysIse
 CHGthf6baH02q78Pe8tLSwKTBfsrsF9HI95iI45gpodjGMbipui9n0CiW7vMN9f1MoSdVI1T
 CUQi57Q6Qnhgwh4K26Rgpn+TjOby9dgYN+zZiUX3Dg85oZEEvXc4LtBlCpz6l22yGCZKd10h
 DQA0r0D7HAAgucGkBUgxGORD/geEFJZMirlixmTp4rn9uMNPjnpKOf2jRA2lMvpFLyYpwBAR
 Hv1H/VqVTR96MlyKhOE0XH+7J3lZMiFaNsSshOOlBKTx+NRKZ83ir8LnX89YDi75yd6jbdky
 0U0jvTY9MCdJm5g/by0GEtdPzzxPIYI/y31yL1ZhoCQ1pyuGZNoHnMKWoHpRLSmCmF317yvO
 gCQHTk7snreF6DYGFrVzU58rG/UVb2vOWuWInYx0thoAhWQbh864khcTHAhk5g1Gxr/junoa
 kRk/XY84lDiqx1D4v1lPV/zXy2MwWXgIidxQ5+ZIh1M6whE7EqAKs2S4NV4GCRA94GgpgiAe
 SSLIh5FBmYTVgmYFkjua/OwsMLY/bHSVY/cZ7PeJK+DoutEW7KUyIKzh8F4qi2UOJzHNytnC
 OAnnFVOVzZ1FozQyTAIVjBShyzKddGSvhv65SB96MyylZajEAu94IySF/5YNshp8B3wnqqJc
 eKdzC8rLDFFytYH3nXVzLtZhVcUh3gofD6odNZI/SefSaXNhupcFBUccTs1bcJO4/t61Q5Ic
 djSjte/vlJhptgyDVoNFVnom8XyINcPP3n4L1TfQkCCKLWBIzTPhcDxe6K1D7NK3q1SsFWrt
 DCXHlWGXHzLniT1Vx2pLeBHjT2KdB1Ytoandx9xCG/lBNv4Yxy/OdVzgHU427oxzn/NMGcdN
 3B7fSYv5vWI6jhEh/xkB2Fbxn9iMPXChCuTqeXVa94XvfZtHiVohrda7XA9mN43pGlPQP14n
 jeXr8Y7+Qj81LPVlXw+D1wX8GUu5srDp0hpNKTH+4MVXH/F+ElI9mCME1ERoMMjDNTzuqdWw
 9yJlaTpKT4E/ciHmKlUT8XSNs+DN2IsdBTzHzuBRi4MVz22Lifyg0JHkfed3mKYpN42p9K//
 fhGAq8eT1EzGv4AXw59G8ceJZ5sQj4+ubuckdJO+ne06hXcDpY/3NiPRreZBvPhLyychL9Pa
 k4TwL/2Go8UM5Xyx01oblQSdGXiHk3NQZZSrycnYgJm+C2lFVBhQ2d110+3MmtFD1cMGPTyk
 hNk02ND
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZJ1LxqCwYC5ob17lHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AlLzzFGmumV8XAOoIzSbqaOgeuEzXOWaH9lP+Gm6?=
 =?us-ascii?q?iNTx4dZ6KFk+fpJJCw+M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AVFYSjQzBx3ABC9WCvm90UiLc1VKaqImCWWIjup4?=
 =?us-ascii?q?Ah8iBKwEhASyN1yW4W4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="122129739"
X-MGA-submission: =?us-ascii?q?MDG2jUMeI6qTzdoqhOUSTt0XhDqsx6Hy6M9xtH?=
 =?us-ascii?q?asNUu1KlXkctSPLJecNXq3tzJu4KWaWkYEudw/IuoBuQ/02jhfY7eLAV?=
 =?us-ascii?q?9geOEpYCss5v2xE/hqrMf+IGmAZnr3QR6UEwrkVcYtFYrn/9JyjlOGt4?=
 =?us-ascii?q?rywGec0g5IdK0o7GY3BW3nNg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:02:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753369344; x=1753974144; i=markus.elfring@web.de;
	bh=duTsmyIZdUUwD8ReuKoPwD/uhBXBvJj/E4PLekoL7a4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hTvzEmIrDeCp6JhnhS97Evxy/ttNNDGvS8paNypURivQZflu/uXSXW190+LJ0Ht1
	 6KzwHbLWCgEQAsMCNvPeC/0akC/6YGwxnf5l/bXjP+pKL/LuZoaMNsZtuBFvDOE++
	 rCmdYUA84klHSflS5X4ASn/4wMrIMfh7/eKqCXawxMdFfQOM8WBFQasmGDHvNZzOx
	 w51QZzz86IoSqwFf9xAfbhiA4ehIeiD8xVe7A7C/8S/qWHaKhfY80WCA6hCmsz9xt
	 iFHx8kfzWTrYdTPzHNJTVl97F47QPEWf2+zfekTdqj2yBnsWWVZZmyDdXnVW+JWz6
	 G54IwGQEStSmsySCHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1uGvKC026i-00dXg6; Thu, 24
 Jul 2025 17:02:24 +0200
Message-ID: <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
Date: Thu, 24 Jul 2025 17:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2a3npEvDA6w56y3CteCArBegAWsjK5OMQq9lk2NIP6qvq+B+8Rn
 fsoY0r+eZXCEJd4lsiQ9MRsTZaT/sElsgCNmTfubik38qnSBuZBayI7F8AYgO0in+t1HxTi
 wikqba0n33KE++ss525WcUQjzPkQzmtEOURUOMSGrYSkgRyM95+5vv1mtU5zZdmz9D9Fh8V
 QUdPV0XAt9OYDci8XKfeA==
UI-OutboundReport: notjunk:1;M01:P0:2P6mDH01P+c=;qvOhbNBbp6tgdR9bHJf8CPEJAga
 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
 b/GcMSYVXxE6xuo+074W2wY=
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2909
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/b0a5a727-c972-4cd5-baef-adf5dda72992%40web.de>

>> @display@
>> expression x, y;
>> @@
>> *mutex_lock(x);
>>  ...
>> *mutex_lock(y);
>>  <+...
>> *mutex_unlock(x);
>>  ...
>> *mutex_unlock(y);
>>  ...+>
> * just highlights lines when there is a match.  Theer can be several
> possible matches.

This is actually the case for a known source file.
https://elixir.bootlin.com/linux/v6.16-rc7/source/sound/usb/qcom/qc_audio_=
offload.c


>                    In that case, the union of the relevant lines will be=
 highlighted.

I am still looking for further possibilities to avoid false positives.

* The source code search pattern can be simplified a bit
  by omitting two SmPL ellipses.
  (But the search approach should be more advanced, shouldn't it?)

* Why is the diff marking missing for the first lock call so far
  (within the implementation of the function =E2=80=9Chandle_uaudio_stream=
_req=E2=80=9D)?


I would appreciate further advices.

Regards,
Markus
