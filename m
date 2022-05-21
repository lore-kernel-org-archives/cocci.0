Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFDFC433EF
	for <cocci@archiver.kernel.org>; Sat, 21 May 2022 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:reply-to:references:
   cc:in-reply-to:content-transfer-encoding:subject:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=niWSyGUpTeux2C9Q9VdmWQ0rZe1U2WOBE/+GIWJ5D04=;
  b=DBA3C1qNVjv6Pu0xfcrs5AIL4AczvC04wTjT1cB69nOzYxsnEfOO+TJC
   nVuJHoM6Cn3MrYJllTySmurcsJUm0Hpa0Y2UglnkXILz7cOStBQHTfB+3
   zXQLVqnndKXh7SEqqFvfIeGJA2/7AolEMlwu8DXtLeBfJr2WHg1V1VJxs
   c=;
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
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="37459289"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2022 16:05:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 823B2E0096; Sat, 21 May 2022 16:05:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A3EDAE0094
	for <cocci@sympa.inria.fr>; Sat, 21 May 2022 16:05:44 +0200 (CEST)
IronPort-SDR: /SDsVjYMxemd6Tf83v/syOj1jnn+s52/ngwhg/tYc9/hfqkCFGRNDb9EsSWzsaFMxOOYEQwUir
 nK4EvGhoQAW6nthvU8dr4sNTyxPSX0VlPV+0W1lXJ2mmZmMo3uMAhO7RGPpa/uWOWCqiaVg+Kr
 RXCqnwlSLZm+k8ucfIA1hw15CCtAcgqaz+pAlXPiCBl2fBbbr1z1wc8sSgVg60Q/2CLQJCCBl8
 i/INO2tEpqIALe57A1nEh2T+amif8UIb8ZWZtBjwdu9Avk82CHYjIjvwhwCDIiB8vuypW6WwH9
 GG6pWeQcgka35ls/Wes5yjM3
X-IPAS-Result: =?us-ascii?q?A0A4AgBH8Yhihw4P49RaHgEBCxIMQIFECwKCIoFTLQQLQ?=
 =?us-ascii?q?4QRPY5ogiiLJ4cbjB4LAQMBDT8BAgQBAYIOgnQChT8CHQcBBDMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEOCwkFCAoHDhAFNgZeBmQEg?=
 =?us-ascii?q?UsEXAaBEgwzDUABEAGBYykBg2QBAgIBDBcdAQERJgEECwkCGgImAgJXBgEMC?=
 =?us-ascii?q?AEBgnmCYwEBAg0oj1WcEYExgQGCCAEBBoJJFYFsHwgfBSJSgVwJgRAsAYpHh?=
 =?us-ascii?q?BsnEIFVRIE8DIJ3PoREg1aCZZVTBBsoBA8DHBoYNRKBIUUsAQgGAwMHCgUyB?=
 =?us-ascii?q?gIMGBQEAhMSUx0CEwUHChwOFBwkGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjC?=
 =?us-ascii?q?wIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEB?=
 =?us-ascii?q?gMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBRsMBwMhBwsmDQ0EHAcdAwMFJgMCA?=
 =?us-ascii?q?hsHAgIDAgYXBgICcQooDQgECAQcHiUTBQIHMQUELwIeBAUGEQkCFgIGBAUCB?=
 =?us-ascii?q?AQWAgISCAIIJxsHFhkdGQEFNicGCwkiHAkBIgsGBQYWAyR4BQohBiIBGwI/D?=
 =?us-ascii?q?5YckXaFMIMiiwigETQHghOBPYFDDJc9hmwGEy2WUA4GkXWWZyCnEIF3gX8zG?=
 =?us-ascii?q?iRPgU6BGk4BAgECDQECAgMBAgECCQEBAgIBAgKOFhmEDIotPzQ7AgYBCgEBA?=
 =?us-ascii?q?wmFRwEBhUSFGV4BAQ?=
IronPort-PHdr: A9a23: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
 JdcEteztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
 77s
IronPort-HdrOrdr: A9a23:Ts1/KKijmNQlPpcUqPImVZetOnBQXgAji2hC6mlwRA09TyVXrb
 HJoB1p726WtN93YgBapTngAtj5fZq4z/VICOYqUotKMDOW2ldAabsSlLcKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+d2njdLz9K+rm6Gc6T9ILjJjtWLD2DcMtbnn1E4+ugYzBLrDAtP+tEKH
 IWi/Asmwad
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14732988"
X-MGA-submission: =?us-ascii?q?MDFUyOO/NcmKMW3BGfmhbsfHFZmJhcG9gSKbpC?=
 =?us-ascii?q?mNZh7ltWTomVj6r5ngacwjNiWVCSCyzaWVZ7VCFxyyQCoHr3g/RObPKK?=
 =?us-ascii?q?TtPhczfzZEobUEIs8Ekdvg8mN8fgvLvcvJTHNExW/5LXu+Kc8eEeTGkV?=
 =?us-ascii?q?VpbTUNFLHqfA8jNU0PcAK+xw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 16:05:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1653141942;
	bh=niWSyGUpTeux2C9Q9VdmWQ0rZe1U2WOBE/+GIWJ5D04=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Reply-To:References:Cc:
	 In-Reply-To;
	b=ll/3rUG++ok2tjD/ALqPWIoNvpcLF8qfkCePJA///CCLiPz+LC21OfhQ+ZJycoayX
	 MqUb9Sg3pZZfSqh2Hl+OWVWklKZt5raA/+tx5ItACeG3neaWwpmZnqvh07yBOPsK0O
	 2qduVwJ9vnVsrwd+MFI+ImvZR5nR+H6s/2wd2adA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.75.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDe2F-1o36pt01sF-00AwoP; Sat, 21
 May 2022 16:05:42 +0200
Message-ID: <6e059bc4-6677-a985-a107-328531a0891d@web.de>
Date: Sat, 21 May 2022 16:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Reply-To: Markus Elfring <Markus.Elfring@web.de>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien>
 <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
 <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
 <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
 <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
 <3cb75ef2-5fd4-462b-7e95-bdd25a3482d2@web.de>
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>
In-Reply-To: <3cb75ef2-5fd4-462b-7e95-bdd25a3482d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ghf1EKfA9p3AF9NCXMcPNb5aYDbFNkuH/hHRCuVMrlJw2j+nqVy
 5LfiIwunUmfilrROOzJl2DvAYIzBMS6UpxblswYHxC+GenTbJW54zpgGtxOK4ICrszW7fxn
 57PcwZkxx9e1FoTd7GWjWjdenC6V4FrpiS4lxB7oPYGI25TVK/Oup9ZWHXtVFHxbEDWRIgH
 Lne0XWum3wtbFZtOLQZfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/LXl7NRnUPM=:Ozhe63cMHpigJCeqYY7o2l
 58vwQ9dxi0G6rSkUUuUepzE6fCMii5Es/X39tGzNR+eucwL4DdyerbPXWX0WPKN6yP7c4HKBE
 07h0AJ3O7Q1yaWGWu8aBljLQBgOLUgH9NrVplcLFao4f9qbh+OuEObRpcf6P8QXMDmQzeCR9X
 IXyrIc8HVegsyJwa8lz36OmZtCuqpDSCPfA91v1IRjIMCyXoEFeF4LfBnehPcHJ38qLmd80m1
 JDdXa+4ZA7w08y1EzWlPwRqQadS0dSLCd9yseATSmRm34c/k6nbHEdoqwH12zPAnsiy5niD7m
 Ik6E+hNY0THeKO/t948Cy3fGnCZ3uojQBc7OgDOB3MZHUp8/pL146XZA0Brr4YbC2aqk37kG5
 kq4Mies7aHR74JdC3A6wgZfzP2U6BnycVJuumUxy9DSXhjknys5POago1oznJfyfwh/AqaUes
 rx7Wt2iT2K3FKBK7F7zw42uGaMUgVKtvgGMUFe+KnbzwKQiGKQNZ1AKRswNT/c6ghpkGpnXdo
 Y0bUSPthLBdT/4rBDiNCBvvVQTKjpF5kuko0wJoKcXwi52KYreF7PDbHAgJgncsK9SvB4Uvv8
 +EJ9MR+M69b1E/32g6FrrpMss1s8OwdsMo+926mYuhyy3WXbEYGz+mFeCMDmyQI1Mojd+6ubc
 DsodcLNn1xu86j/MoGky6A4t3C1/DwQR+HBjjLgNV3CHoFiWyuhLvtD7xqR4oM6WyAqr5EJW7
 F+cg60/X6+qzC38USkCPywKKQs2RJiIcd+c/rsNT6fORq3G6OpIjXyJwZ6AocT/dRB44nHXZJ
 /dea8Fb5jH4Mzx23wlyExEvWsbGuQk5B50vJ8kb+AIe3k6GoNck55TDSRAdGk4/lypUew3QW9
 1jJxqpSip1UtByHVFNZputXjs/bXuIWPzhSuvxxeAz+P7kCsIHsqLENfFR3gmAq3r1KeAEY6s
 xaYTQxk8TsIfD6Wi+gSitKF+Rf+R/Lto90FYq4KXTq2QsRYyetjWgXp49lVkf/uESkuHAXzMo
 iwo9uucGozoLht0lAz3clnsJ3gUhG7B5kbXYfYkQTcz94PEZ5NfCiKiMaGQzP8DbLggLbkTGm
 YBmk0qAK+2Bqd93174DWtHhfvZ+Kb1MIRmrwMJcmuN2E4mWo4PMZuk9NQ==
Subject: Re: [cocci] List global variables with SmPL
X-Loop: cocci@inria.fr
X-Sequence: 409
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/6e059bc4-6677-a985-a107-328531a0891d%40web.de>

> The information =E2=80=9C=E2=80=A6 current_element is the name of the fu=
nction containing the matched position; =E2=80=A6=E2=80=9D
> is provided by the manual for the Coccilib module.
>
> * How can a function name be referenced if data should be determined for
> =C2=A0 the global scope?
>
> * Why is a comparison attempted in the scripted constraint at all
> =C2=A0 if the passed identifier would refer to a variable name according=
 to the metavariable =E2=80=9Ci=E2=80=9D?


Would you get into the mood to clarify affected technical details any more=
?

Will the handling of source code within the global scope get additional de=
velopment attention
together with further evolution of the semantic patch language (Coccinelle=
 software)?


Regards,
Markus

