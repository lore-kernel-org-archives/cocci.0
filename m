Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39BAC282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iW5b83paZREK6dh/CqOmNo+3hj5sQKcKK6HESVWAfH4=;
  b=XU1KhIPCpmT7NZo2dvpXdKOKL+FtkATMpwWK2WI9EVmkpryJjA7PKvX6
   CM3JTLxuoFMNcNvNe3YVivwkuhjfk0k6OljXSrBrRLCRoRJYgRjoI/O2d
   Fc6tJe2cBIlfp95OD8WKC0uHOoDNflDB6EhCOw3PlvIbZ9vRfHCtF1J2Y
   k=;
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
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213319940"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 17:18:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAD4EE0D1E; Mon, 17 Mar 2025 17:18:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 28E58E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 17:17:59 +0100 (CET)
IronPort-SDR: 67d84b36_iAQgGn4bHVO+06AdntYcFDgFMjY6lTWOiBCFt6mJnPbtdFN
 +phV71SNQHF1zOCcHm6pW1LKkoFJJxk0OBIgA3w==
X-IPAS-Result: =?us-ascii?q?A0HAAgDGSthngAMP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDYnUzBAtIhFaPUIF0hGuHO4dTiHWDVA8BAwENQQECBAEBAwSCDIJ0AoseA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOC?=
 =?us-ascii?q?jGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJw8LGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfoIwAQMxB607gTKBAYIMAQEG2lwfLCJXgWUJgRouAYVsgmMBhWsBO?=
 =?us-ascii?q?4Q8Jw+BVUSBPIMDPoRDg1uCaYIzhEBnmXaPfFJ7HANZLAFVExcLBwWBKUMDK?=
 =?us-ascii?q?jQxI4EiBTQKNziCC2lJOgINAjWCGyRYgihqBAWBJII2hDyEP4VQghGBXQMDI?=
 =?us-ascii?q?gGDH3Ucg0h2PYRhLVCBIx1AAgELbT03CQsbBj2jLIRCgxUEX8YiNAeCOIFmg?=
 =?us-ascii?q?WMMn14GEy+DcAGTVQ4Gkn2YfiKpEYF9JIFcMxokgzZPAxkPjiGELb5VQjU8A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:l0cKgKzND9Nq5uWRi7PQKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: =?us-ascii?q?9a23=3Atv4xZ2hNks7Woyinu58zf0zY3TJuSCf31EvZAn6?=
 =?us-ascii?q?BIHdUGLCYQw+JwLtqqp87?=
X-Talos-MUID: 9a23:4TTPLAY2CUJKGeBThibstT48NetT0qWrIUQWv8pBm+2cHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="111808452"
X-MGA-submission: =?us-ascii?q?MDHnDLWk3jCjzu+Iq1ZdDMopQiX85Cx0Fa36vO?=
 =?us-ascii?q?O/yPptfQngUVxMLuK3K+DXOehAGXTAnePds5R6gMZKfGqpiQbIWQ6+eR?=
 =?us-ascii?q?ykYUkG7uvn4TSZBpV8xdhZbnshjKTBOekcYPX2Lw8Zb4ZDvsonBq2trz?=
 =?us-ascii?q?5exMLeJJdELDA41NcWo3FWOg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 17:17:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742228277; x=1742833077; i=markus.elfring@web.de;
	bh=iW5b83paZREK6dh/CqOmNo+3hj5sQKcKK6HESVWAfH4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p4B20AraX4hOcTlhA4TDz/pb5isaRdDBHEA33DP2/pASISp7gutYCyqXbHMBpvZT
	 n5a7p9knWKQo9oc6k5bnvARy6IQ4KEEFf0YnFc+LZ1HyYIdV+85mhXj/q822kYMpY
	 5/0RQP8yaUpVVj3bwVqJR3Qo5MY/sslreTNTW02rg9Ig2jOf3vSa1Z0vkImyGPXb4
	 FayzwIjHTunyxQVodi+NFwJbSXd4zr+4v7OWC44rX9Px9h4m8wDXzrhMmLNtk5P0M
	 PuxqEwXsWdq+tpQSb/xd42/ce7pB0gOobNQyhvxjh9FjBkcxvu1XyxkwOMuPDBewV
	 ioxcvoIicGd/Coxpcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.74]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4eGJ-1tEFBC2CiV-012fbT; Mon, 17
 Mar 2025 17:17:57 +0100
Message-ID: <57d5ead5-eabe-447a-b00e-1d9781e776af@web.de>
Date: Mon, 17 Mar 2025 17:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250317150941.32415-1-olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317150941.32415-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iIwGIoXb0yr8PvDBQDJ5S5Ybyo6oMIcys+0RIkLuorHZG2w5BUt
 NyYnS6WkKXZiseouy5yTRdOeYp999C7ljiWA0aoOfadr2vN8jDv5nYKfD5G9pVnXQ/EOrls
 4/lFgcVpzPZq6EtujAknkbxguAxwGneKCnddTCiAvhin9/3ZQ49lqF8F1XrI+RiiQFLHBU5
 3ZO/9gP9sNAbCV1XXI01g==
UI-OutboundReport: notjunk:1;M01:P0:R4HUnqYpxdg=;pa7rx8D+LD//Da2CUFVQbhWR8BS
 ePiIY22mdH1X47/UYFG86y0amydywR/HVH7sm/ZqzyDGObGVqtPJwVoVXU63ZK76zANemTJ7R
 zu9AzVyeS74BVRm/jPFhieelSENu5DYLmzfykLL6fegYxxe68LhhZIAc6lBisF02LQrbYWcT0
 j5Wh5K8ctGjC0+dnfrjl8PNk6Nn9x6A5YnJX8Dhp7Ovtk1E0GHbj1/Jbw0ETFFrMjKRWWJod6
 ct6hFYfrDSj4MO1kMrTpaQMg0vRkTjPWRDpz+PCDNTWjCmxVUUOTBKqGCgCh+zzQDJFDYeNHY
 szakHY/Yx3aaOWBmbqEO7E3n6am4NcmAcx7Usz+THfUQLx36QNuwjhe0kboYJ/SXpMmAKHgA3
 HqOIeH0/+I8s/QcpQ5hMut3MMg8PuN61LXW3ekYPoENui34jrhROFakIP2gtsTYaklIhZr0LR
 LTjFX8csAMc3HoK5cP2ceVHai0gb0PuHQdlA2m5SuXoDNyr/Za+6hoSJrSVPtKrQRrOII5dMM
 YTJG5yhiQpAN6r8QOyDdScEdnea6FDPG2yVtC4fL+lsZyV4GAhK9W7Pp3b86eeOeH6HLiv+2/
 6158YkAjB44dwjiskdqwByBfJaExlvqWyRh234f4RQFXkjsJwqMmbxWPRrHBQapqLTC7BaR57
 40cm2QkXggBoJqka0Ma3Q3hIzuX2ixltjVC2Z4NLj5OvokUT+RI4w5NQNUblDCFhKTKmiW6aE
 aJNpls616ZxDhFHDhxyaKKT9SjBs6j720ixFAJzbhT5htAzlMa4OQCO1Vq3A70F/6ZoZ15U9J
 YqzisxqVnkRGHPM+Zq2SFKPcIlOW8pbi1u+e/luCY8ivZddjVFrWw9kCLd3pOXsak0K/VRhL0
 v45Hg7OZ8ZoQBopM/mX3P6UA5hzV31IDv/JlkJN2uQ3nq/Ww7psMZyVJxlxsZJLYAjon1ahub
 jPoS5qVmxZN+DeMxQrE9hKnuFtY2/Rj7bin+akPxgjB5f/+PiuJsJM4E6XTLnnBv1MJcBrdU3
 xr7X3k/XSvkTKQcnEHAIbACfzcZX9BbsuJqYqWgtBZoNMpkTjy8UFFrXInu5d47Ut/NAM99ua
 wrublY+4iaiOe8CRnPVjy8m1pHrqHSsl4NLSOUd91+k8RSwsMBkiSgMdGh7bUqVm+siehnkqN
 jjXjrwE2t4j3VfXkzxB5Zd4a//pI8Z6pnaqlxPMXyIFVaOMIspRE7tAZzmtD2vj+cbd26K7Io
 gxW4+NKkNw8lS2lc9Iw4y2Cwx3GoD2f/9VAJ+25rcF+sfsqaJKlq8yVDGTRLoAzOaGGIr/HG2
 CJgWt1rRfiVoBmTQ+XKcYzLpCmcq6JO8porMpJSwEuki2gJr+o2WJhajfDYkClGqsuXQk3ZCm
 VK5bcpryP/331T4AQ65lTZKoRo5fqgli4VAxESpTcX4rhcWIY9gQ3mPeWdgEveMo3ACMbSyK+
 L3SOw9OtseY9ZQdcI6W0ZOr9OV+eBVtXYAx4s3F39nvBXOWCl
Subject: Re: [cocci] [PATCH] replace pcre with pcre2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2588
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/57d5ead5-eabe-447a-b00e-1d9781e776af%40web.de>

>                                           =E2=80=A6 Would there be some =
benefit to
> support all five in a single binary, for correctness and/or performance
> comparison?

I guess that this question can be reconsidered any more for a better chang=
e description.
We usually hope that maintained software versions provide more desirable
functionality (and corresponding run time characteristics).

Regards,
Markus
