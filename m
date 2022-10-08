Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61688C433F5
	for <cocci@archiver.kernel.org>; Sat,  8 Oct 2022 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qLjzU9tHE24/kUmkblj0Pm27Wr/L2KF2P3oi0BovJXQ=;
  b=groRxxYNYi1NyB/59kNavr1tvLKifoMX/jDMrMGYfiXuy3mVGuVA8s0y
   jXIONNZ01V2FjEE3XotzX7j6nsIRWaDvk84xwbeyo2WcgReZ6ptDb17hA
   R3XbzUWCNAjcLdBspGVrEAitFGJdMko4H+4nLivVLdmWcUA9nvXw151r9
   8=;
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
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56597974"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2022 10:55:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54006E02CA; Sat,  8 Oct 2022 10:55:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7BFEEE0121
	for <cocci@sympa.inria.fr>; Sat,  8 Oct 2022 10:55:30 +0200 (CEST)
IronPort-SDR: 63413b02_6mU4h7MCcZ03ZEf3m66FvDjdLJhDP22ovZQfZTN7+meu1N7
 kWhnAozFVimlFvZrdH/AWTiTm04AKHJ2nVdQ9FA==
X-IPAS-Result: =?us-ascii?q?A0AvAgCOOUFjhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIFXLgQLRYROkGcxhCiHGIcljCwLAQMBDT8BAgQBAYISgnMChHQCHQcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUih?=
 =?us-ascii?q?WgNgjUpAYNkAQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCeYJtAQMNIwerF?=
 =?us-ascii?q?oEygQGCCAEBBoROHywiU4FcCYERLItPNoQpJxCBVUSBPAyCdz6IG4JmlHGFT?=
 =?us-ascii?q?CYEDgMZKx1BAgELQjUDFQMUAwUhBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hMFAgIXNjQIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXB?=
 =?us-ascii?q?xMYGxkBBTInDgkhFgYKBBoNBQYTAyBJJgUKOA8oL2krHRsHgQwqCR8VAwQEA?=
 =?us-ascii?q?wIGEwMiAg0pMRQEKRMPLQcpcQkCAyJmBQMDBCgsAwkhHwcoJDwHWBIoAQQDA?=
 =?us-ascii?q?hAiPQYDCQMCIlh2AgsmERUFAw0ZJggFNxsECDwCBQZTEwIKEgMSDwYnSg9KQ?=
 =?us-ascii?q?D2bNW6DNwWjDp8XNAeCG4FGgUkMnlIGEy6WaA4GkgqXECCnT4F4I4FbMxokg?=
 =?us-ascii?q?zZOAxkPjiAZhAyKLT80OwIGCwEBAwmFRwEBhUwBAQ?=
IronPort-PHdr: A9a23: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
 sJmdw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4BqR+qjLfsPx3y9sz3Ah/cQhm3BQXv4ji2hC6mlwRA09TyVXrb
 HIoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW3FdAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56597973"
X-MGA-submission: =?us-ascii?q?MDEKv5YtupVzfffhct7k5IISV7rZwXLGjJ4hLJ?=
 =?us-ascii?q?Zsiwc9uMXw1x0wt1HIGzhzFF89fRs3A+qznPq/KlhbXNqmebt9ROb75P?=
 =?us-ascii?q?F4ynT/U7HJkSYbK6bCOIhTdnPi4zSOmiWXmUG/ZtrxIWOVrwFHAkJr6C?=
 =?us-ascii?q?Lfos5HaAYeWhtXkYow7D51kA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 10:55:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665219328; bh=Alyt2cTddl5tn/ZVdWAWkVgq45/7a6ScqkAr+t9r9e4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=UO937bpVrxGUGG3temRvl82QufilVUV02x65PhCpRIS4INatk2WPoGMgxpSUzjtZy
	 a9mYMlJICqg0PmD7qZRGDTd4415aNHv+LKJw7BeWmYY9kJha6ua550ttTLL2nZsffQ
	 zl1/IsIOH66JojRhEYQAxy/QScLRVkwTyLeBltG0WC3czHy5FlYDc6QY/BXdKRVW1Q
	 jTl74Lq/ozTTxx5ycL+zvp92p2I7c9QRWCZkWsnFxyOWoliqrdrSZx0Ir7KrhofvXZ
	 TUWFoRjRMfR4A/1RSh8KZJX/jfCaoTXOavFUGjjMou4YhbddP1TQQaq1/mfrTnR0Qh
	 eLucUhVWWHT/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1oumkE2ECY-00E0Ce; Sat, 08
 Oct 2022 10:55:28 +0200
Message-ID: <e7757758-6882-9f3e-749e-276a0e972a5d@web.de>
Date: Sat, 8 Oct 2022 10:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
To: Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 cocci@inria.fr
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:s+Odf/ZL8vcUReXNbtpNBfomlCbf1XE5BnCM9psvuEIA5UReRt3
 y0Hz4wDVk/N4l1lSeeaKSNdLMxyzND5dTt68tfkYlZ3UT0g+pTlnuNlG9blpXh+6nh5u+Ft
 QuMlG89tb5ToHz4MmrC9i0+M9NGGjOUNRsVKJCLOl6s7xwi/ncwk9oXcjzj/iji5w088m35
 qxjV5n+cZTyPhNxh7daPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Wcr0eA3btU=:TwZBzVJNC5xW3ECKU04l3y
 dqW6D/eJwkci3iAylF5JvbsSRMsb1NsOzkmKbgjMcbqWy11W9Jz24C+QBYdObfI5Fg7QU544O
 mmxMW3z0pTUkdGNxHM6YGytptuBmCS8S1Dx4FLoNSb4eXIeM3jqBKq5YeAYQhbgM+/W8ti0wS
 D2uDKiD0KkJdbesg57H73evfSJ42/z7mkFtMePMBs5FkCLxAJ0RSIXoLwm5AubS5boltUgmsn
 x6TAmGkSvXmoTC5QhIbmAltVUeBYigdmGQRfdMowxNoPoxFTDlpCzfMtvQyiRDNIiGQPq5pNC
 /geZik9UcpjZvUoww9KiUul10zYiSb72ZKMWOlAa2SKTfRmLHqF9S0RTJCv/92Qxu05o2HsdB
 vkX+5udRSwj8GO4eZdWEr6CHOGzWQYB/0ruHNz+WBxFfifZvw20uMQjPH3SvLOM6HwVC8bm12
 EUbBFgLdv3jj5hBcN4A/4Dhnq+E266UHoa7ybUieAqjG6sAiaJ4FvRj19o+HU1Ie4WhkvdVEb
 SU5gZRdd8mLOreXIFjz5vA7vjYDjTgHU3LPNgAC1w3SAiKQpTOPXYJEjerzZaFimPaE8LkWNi
 gv//SaoSjWKBj5mLeMI2OjDnsqsfDDjltDVs6X0uZfTxUCcC3hRXB+eQ5SP56loPjhTVfeNOb
 I4Q9twjjvcGYdb+XRpd0kGVx6CPDY2xkaiW2iPLglN53aZS4FiF7g08Emx25UAprtLxMysmj3
 Etw3smmiOcT5WqROu9xqHBQKZ/rXNAFx+nD3j5sDYSX+irMeGatsXhTX/KzxsweaNMzeFNyXo
 oJp2qEmtnsSFyJzUtZkbjb87FfQCuArAHjtTkYDiplffsLOjnBjZqCaO2Stqe8DJKrfW1DgR0
 vuyc9z0wGdwxfdbrpgZtEKX+awfjo/u6e9ksPkrpHkFqzo6ovs9M+l1BaI1Z+3RwS2Eh+uMwk
 Burf/IjX0L/3LodMaExbhu2+Xl7mi3j7Wh7KZbiDHJsbX74l+751Ruw7bXS5jnzNLQU+Alxd3
 fSX1/3y6vFhkKdxpspBFV8wNK82uaxQZfYa3L3zkDM6G9JuVNQM47VuvnkluEggi/8GRWAAlA
 GZRlIDkwKSW59MCmcbYw/G6gD5+NC8DFmB27l2R6spUrGRCe+ELra4rXdQZeVaQGfE92aK5d1
 8Elqm74Dx3jmOk/LjKDiwZ+q+dAaeo9edAoE31s4nv9S29fqHOvJn00zRY/7l8tGiImOCqQHv
 ddGzHParS3ShZGFuwJDyIe7RgiU8/tgtLG47PtmbIP589Ye/IJSawdN0ShuKq7Ogq3WGOQZGe
 JoaREGKNTOsozEjzoh4o25Ci6wTClunYdBOA0NIMWdyNca/ImZwBfwQsjnTSNCqpPiQNwZqOh
 FXWMaJIUV0WGTiO5dAvxf/TGuaFKuHsL5E4A6XTWiSLGQVdY8E0geRPsc+mbCP8fY+6fDWqLn
 myz4289PQ5uvHwvChtWgd/WsJUPCPHyokfsdEge1Yp/hJFpSAFwrL7tAseysaegJqN4oT3KQI
 JcC1xBpEGf9D4Np1Sld3N3Qp6XHbgQzJezk0pAE6Rix8r
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 619
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/e7757758-6882-9f3e-749e-276a0e972a5d%40web.de>

>> I was looking at doing some conversions for this[1], and I wasn't sure
>> how to check for removing a variable assignment if there was either no
>> more uses or the next use was an assignment itself.
>>
>> i.e.:
>>
>> 	var = 1;
>> 	other = func(var);
>>
>> turns into:
>>
>> 	other = func(1);
>>
>> but this would not:
>>
>> 	var = 1;
>> 	other = func(var);
>> 	report(var);
>>
>> without getting confused by:
>>
>> 	var = 1;
>> 	other = func(var);
>> 	var = 5;
> - x = e;
>   ... when != x
> ? x = e';
>
> The ? will stop the match if the thing is found,


Does such an SmPL code indicate a need for a double check of the affected C source code?


> but won't require the presence of that thing for the match to be successful.

Can such an advice trigger further improvements for the software documentation?

Regards,
Markus
