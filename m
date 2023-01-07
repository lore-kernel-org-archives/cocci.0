Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52483C46467
	for <cocci@archiver.kernel.org>; Sat,  7 Jan 2023 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PTCp6Div+PUDxj31o7hWni2m1EnUHWxypUPXUFtj6UY=;
  b=aK9jtdbaC3vkefA/3aXlkcP5ttum+0FCJcZK+rdlVOzPOXF5ShwFfzhR
   vBbI4W5kYkArCuxcPmhcDZpI00RWtnmrnaiB7++do2mfFSkC3qd8PVwGQ
   9duGDUGJ2XOGJwGWDvnXxA8chvtU3mRsWT7fqKrG3hAc56BcCcQ3w40l5
   s=;
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
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="86416834"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2023 14:56:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9B103E5A72; Sat,  7 Jan 2023 14:56:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E493FE5A70
	for <cocci@sympa.inria.fr>; Sat,  7 Jan 2023 14:56:24 +0100 (CET)
IronPort-SDR: 63b97a08_R2OLdnFfbvLprEvGB8YHhid57ny9X6wf+bNADqV7FInwp+C
 ruzV1sv8Qmc9fDeitTx9g2GRyxkyDsJgdxiDDOg==
X-IPAS-Result: =?us-ascii?q?A0GtEQAueLljhwMP49RaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?SoBAQEkgUMCAQEBY4FdLgQLRYRPkSKEK4clhzGLeD4PAQMBDRQBLAECBAEBA?=
 =?us-ascii?q?wSEfgKFEgIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoU7CCUNgjgpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AQICASMdAQERJgEPCxoCJgICVwYNCAEBgnqCbgEDDiMHsFOBM?=
 =?us-ascii?q?oEBgggBAQacCB8sIlOBXgmBFCoCAQEBAQGQInonEIFVRIE8DIJ3PoQuL4M+g?=
 =?us-ascii?q?mePFYpECoE9fIEnDoFJJQQOAxkrHUACAQs7MgpANQkCC0srGhsHgQoqKBUDB?=
 =?us-ascii?q?AQDAgYTAyACDSgxFAQpEw0nJmsJAgMiYQUDAwQoLQkhHwcVESQ8B1Y3AQQDA?=
 =?us-ascii?q?g8fNwYDCQMCH1BwAi4REwUDCxUqRwQINgUGGzYSAggPEg8GJkQOQjc2EwZcA?=
 =?us-ascii?q?SoLDhMDUIFOBC9efwoGKSidVIJGf6F8gTOfdDQHgiOBT4FQDJ5xBhMug2YBk?=
 =?us-ascii?q?w8OBpIbHZcsqAKBeSOBXDMaJE+CZ08DGQ+NQ3aEDIosQDQ7AgcLAQEDCYVHA?=
 =?us-ascii?q?QGEAoJYAQE?=
IronPort-PHdr: A9a23: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
 4qX/J8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:F5BZGa1AH/fMeUaeXMZDLAqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="44405935"
X-MGA-submission: =?us-ascii?q?MDFklI2FwztNfTNgfMiSj5a4soEtyOb7NWaEPw?=
 =?us-ascii?q?7pg9q/pAMFZuDd8lFuvOzxhipF+KNemEX6uVvleWbi/YW1RTF/BH4BTG?=
 =?us-ascii?q?I7HrxM7JZvU0TTgwGnZz+Rfz+J1PGk6m4AohjPpS+JyI+D/EBe457to/?=
 =?us-ascii?q?ju+9uGUyfhZ/2JCHtb04PMmQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 14:56:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1673099783; bh=EUY63fSrQ8lIhKgy6VJH3eJxG9ogxJRZelbBBK+FBvk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZYmiuAItoMrrMqU1z8Xt4f7iCgM/bb8LfKbGAHv85fwHdIOSFKlP4+93kxN5ZAhDU
	 XxMllxfQHe4yCZg+wHaTzLzYA7kNSFAtXYloGJpOuJ/EKYEpELSwwn23kVQRatIEJ3
	 n+pdCcKZuRiFvH7K5m2KSGCXT/1OJWnaC94cZNgTu++hU2OglACr2neM6vbHRftBjr
	 e/i6hun7DBi+9LcI7zYgGorfAJdk/q3gYHWzOnV+Gs3q53+PT96BIWjyAVI2jDg+Nf
	 J8HnVVqQB8HsoJJpfb3I4reaHM+9a7qLjz9J2A39NqkwxaYna7naKbOuf3ESojVyj9
	 9t3xmbWC5HlZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDQZ-1ogTQG2cb9-00bINj; Sat, 07
 Jan 2023 14:56:23 +0100
Message-ID: <23cf5d41-8219-17db-1526-e5c7025a4621@web.de>
Date: Sat, 7 Jan 2023 14:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
 <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
 <alpine.DEB.2.22.394.2301071354000.2795@hadrien>
 <cfa05a5d-1835-c58b-dc28-4b017cebe2f2@web.de>
 <alpine.DEB.2.22.394.2301071423590.2774@hadrien>
 <38da3db5-0aea-e05b-b105-d4943b64ffc5@web.de>
 <alpine.DEB.2.22.394.2301071444420.2774@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2301071444420.2774@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8QuQsOIeoeJJT709hX4t3Bamlx1vDXw8Di0Wks+gfaPKRfpoYz1
 rLJP8f9qN81svKhnoLf6wq7c3D0nJHuuGu1MvJepRrNvDOKX/dyTNiGSme6XPIxgCrPf2cW
 zTVDKGDhDwq2/LrkAUqysV3hhwCCe+CbG9M7X2DBl6WQAVnmK2Qw6CgNxeZtWy3MVDmI0bJ
 RYJc6ktE1syJ+jjH8hvQw==
UI-OutboundReport: notjunk:1;M01:P0:pewAoHtTOQQ=;YYPvyrXBTAplSOAQj+HHmgDvRMF
 gkOEFXEiaoRQZt8eHcXJC35BISLsVeRRUWxyz7WUmWgjdz6KlHGQsQg6XbpCLoCl+IxkzY2z4
 dkZI1rA6T+FOyDosHI87v5oybtqroR3ZG57qaQMMFr9IPKMvCMn4bxl29/t9rS14APauYAuZS
 EPGCtihIJewrebLQJeel/19FPGt3FyZRhwyqJbDp6PHKz83BuHiq+OsMmqx+aX1FI8e0OdI4B
 CaQ1r8RnjMYtfWPz3oq7M3f0oqYsk0ak5vMOTNJg5y2ttVaMdZw4QNVaeFHXTkF0I3I95MJB2
 ZLw6ReuJFqcDd/L+w30KRpZaXkIoOX5ZNTPVd3A1CqrRZ/kAG7L363zg50z30zyQQJZh/bro2
 Tv2GBcBcKUaXmAk819L/Ch7yJBrIP8jHc3wkX0B88BSlkrhXpaFOi9sp9E91xrx7rH2JTr8ub
 ZnwjTZ5fpAEgh/oBoOCapFYHU0jt5ggOLjkfdMcVm9R1Z6rg0+FjrQ1SbRlEDQuKs3GJdyAZp
 JPpIsoxiPnVzl3oFFQpifAGYB1/R4cb9pOUqac9fk1ERGctNKreArE5wQ3wGgshKzSQGaRFLy
 hvLdHn47idMiFCjtbJ4NvwA3GzsIMrZ9oDZjlVRkFF73bvelBqS9bazDujDC9lZWblVnD46pc
 FRZLLGAtPDKevjUvmlqY0BH7jf97B1h4MWWiB/3d6EaT/8Kg3f2zzlyvFLTLUqu2LscWyuVz/
 CKXTriasz8PPUqiv+s9K1glDGlg+P8iGapEpuucWZi6tVpvDdwEDXDtvih7WgeEOKJsr4akWq
 N/4u3ogb9lvoZvkajzRLJ+NjcS1b7f7V/luM+01JYstCaoMV+TL5sHxSH7o/G3GpDFb3FdoaU
 eD/3RYGvsl/Bwn9i0mto6nGwAMDblezQ1DNJLVEmHhG+c6wqFJmvAbF3aIPMN/6WU+LLf+EuP
 mL+N6g==
Subject: Re: [cocci] Working with filled data structures
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 812
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/23cf5d41-8219-17db-1526-e5c7025a4621%40web.de>

>> Which data type name would you find more appropriate for the ordered storage
>> of a varying number of items?
> We already have list for that.  With constraints, as illustrated in the
> previous message, that is sufficient.

This design approach has got the side effect that pairs of metavariables
are required for the discussed use case.

Regards,
Markus
