Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DAAC433FE
	for <cocci@archiver.kernel.org>; Sun, 13 Nov 2022 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CMpw2M2F/lZ9NVLyjonP6Do6B3rqvAzYmUr0+NgvL0A=;
  b=d7+i0hb9FDbq2cUBsoRbIallngYqY/XF3QJmMbLrNWblaoQ3pW90DtG7
   FAwCeZ7q5ym2JH9WZ79gRlRaiqCU5lDXIBodIzEo1U8LldCnq/VbaG42k
   /m1Xx1sTbzAqBTMjuRRjschb8zyFnEw58JsTRFOV82XaouqPgaJ5CojAn
   w=;
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
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="77912429"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2022 13:26:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56566E0236; Sun, 13 Nov 2022 13:26:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E4EFE0092
	for <cocci@sympa.inria.fr>; Sun, 13 Nov 2022 13:26:32 +0100 (CET)
IronPort-SDR: 6370e277_dO4EMMI8ZXHZseQTrnjMUxJjTEHN9kTjzqLSMT/E/LBheUc
 SG7JJc2ZDmTPlKUYavOW6j3qm+m9Hd8A9U5ZlWw==
X-IPAS-Result: =?us-ascii?q?A0ETCwBM4nBjh07ASNlaHgEBCxIMQIFEC4ItgQIDUy4EC?=
 =?us-ascii?q?0WET5BsLgOEKY5QiGGDVA8BAwENPQQBAgQBAQMDAYR+AoR8Ah0HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEXCxcHDhAFIoVoD?=
 =?us-ascii?q?YI1KQF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQINOhg7PQECAgEjHQEBESYBBAsLGgImAgJXBgEMBgIBAYJ5AYJtAQMNI?=
 =?us-ascii?q?wcMrAOBMoEBgggBAQaBQAEDAgwCAkABmW8fLCJTgV4DBoEULAGMX4M2eicQg?=
 =?us-ascii?q?VVEgTyBFYE+MD6CYgECAYFeg1eCZ4w7gjyDEYVZJgQOAxkrHUACAQs7MgMKS?=
 =?us-ascii?q?hsxJw4JHxwKBBcNBQYSAyBsBQo3DygvZyscGweBDCooFQMEBAMCBhMDIgINK?=
 =?us-ascii?q?TEUBCkSDSsnbwkCAyFlBQMDBCgsAwkhHwcWESY8B1Y6AQQDAhAgOAYDCQMCI?=
 =?us-ascii?q?lZxAi4RFQUDCxUlCAVKBAg5BQZTEgIKEQMSDwYmRQ5IPjkWBidCATEODhQDX?=
 =?us-ascii?q?oFpBDVmmkCCFmghNgKBRRWWXqxDNAeCH4FMgU0MiXSUcgYTLpZuDgaSFJZUY?=
 =?us-ascii?q?CCLNIFvmjWBeCSBXDMaJIM2TwMZD44gDA0JhAOBC4NWhUtANAIJMAIHAQoBA?=
 =?us-ascii?q?QMJhUcBAYUgAQE?=
IronPort-PHdr: A9a23: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
 hFOzb6qdewu
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Ej6xTalU7joCv/uTf3Ge1b2MB9zpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,161,1665439200"; 
   d="scan'208";a="77912428"
X-MGA-submission: =?us-ascii?q?MDF3riX0u/KlmHer1jJnV74OxZ5HqjvJ5t5P0m?=
 =?us-ascii?q?tcR7UgrMwISTbZzy3SUoqLVWfFkA82Nn1aKR1Bckei400zlRXnF+9sdb?=
 =?us-ascii?q?vTohO8NUm6ju4mDeQVDBBIT6aquWMnIBu4DJDJykwhXKFoAc0xUImG4M?=
 =?us-ascii?q?JSw3QFWc/qooWRTHZD+ZSZyg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:26:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668342390; bh=iI7F6b73YjSExn4zErtp+MKidnIc9QPL2tWMowoq4U0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=s1+lQgn0uH7GsncuOAEuHWnXnRbhlLMtcwN3seGdPOo8XE6iTGoE/oS9yTHAJA0GH
	 +po41B7+2c26kEJ5Sjh16YgCFHTKoa/1gVUHUwl+MRLSK8TLcy4qh47+GuR6Ycl014
	 ZW7DMYLAqoKhD4ySQVxHITRa3frLGRLA3m5ADwfoPXChPcfCInNtqI2x/3E1JeYa3G
	 /7tsinJXBwyolgAnfv8feA+O59SUjntzKtas6faWQ6bMWgxiRJ61qKk4kJLnx+pwlR
	 Y7vEaAlNrJqx4Uf/kXv04lsu5dFtY0CkY0QvADhhc1Bu2Y/171DyYKdszJZLCpG1L1
	 sIhW2uePpM6kQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1oV4Wx2EkP-00RhqO; Sun, 13
 Nov 2022 13:26:30 +0100
Message-ID: <2dd76fcc-0f76-e99b-80a1-2ade40e65380@web.de>
Date: Sun, 13 Nov 2022 13:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Elia Pinto <gitter.spiros@gmail.com>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
 <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
 <0a1acdf8-64be-6e43-6fc1-9160781bc7e0@web.de>
 <b48551e5-3792-e563-469-57f2b17164@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b48551e5-3792-e563-469-57f2b17164@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PnQSdjdEJortsS/3ulv+EN2sJPLsbVVxU/o9w7OdTU3RAxO7ZAl
 9Og23FRb448tXsQk+69f5hGeyypvTwMpD/eH7xqU0i3UDJJd6AcgWt97otwKzmNEzzYXX0Z
 4YGuEbsr6vQjBgr0rmFmTy6yABHxXVT4aUUqUIt5IdZIBxkGwLiVMQL5ogGcH6l/SWzOrH8
 Spsi0EmbzE4EdBw/H/EfA==
UI-OutboundReport: notjunk:1;M01:P0:Y5QtUuBNuDs=;HmQKsPoawwWPVlh0kZiX2opQ+06
 6Hp5YIW1uGRoIyBuEKA3ATJTbJqM/Y/gzs/K281nitT9WCECtmoXaAANPzZMhfuTXDlNw4n7i
 wdCIoRoXzCWQfqngWBa6w2pv43e5j0XEg9IzKqxpl97khYGV2riWTcQvt9MdTctB/CM6A3MS8
 qo7pTgehctQig02MItGxJ8iNpg4TGkduFHZLorMoRFwIa2cXL2vmUIzNiiu5TdiJojy+urUJH
 pBcoanaHv3rX1oUatCidsxxqpGF83+DsEdGzr0Do+kAXEZoeFlr+JwP0lGPhMK/u8+Kqpyxhd
 AT/gbiBZ3KMqkhJSRVzsQNGrTRoLB1wBvX3qmPKBNIWanam72mWAsYyraGu+IJyDQsE3uNbu3
 ihL//4bW+D1F0Y1jrlG7FEVepaw04yGJnl5LiRe8/SwUaUj2QbzSPVg1lEsRe2MwW8z+90KqR
 r+BuJgtiGutFN02qCCGeUaCc9oNRuvkACY+CPl9qUjv/kyKpFt5zbf6YR1S8uV1PkdipHuvj+
 QbvBer9Z2Weg5fnDTj97NMGhZIxyPzr13sKh8+HzJ56OhoxJZCdrEW4AkZbW4vNCtjaqTy3La
 o/ADCH27uaT5pCWmxuneoZKQstGCnuv8GRjqo2CeQ3MHlAkf5c37nYpUVCB/cTtLqk4ZHbF2A
 zisH1TR4HT5fBfTiytIvGWgFpjeyENnFDlFdxoBMGK6IU8X5PGT9VXrqkA+is2pO9tHTKjuPU
 7v6huDPMRUUT2ODjQ60ZOsWyQB6/GOVhmNxCT6P3yQtNijlZSQoGkWAbETwXHAQbRWGnM75Xi
 FcoKUBQMBmvdun5gcDNs5aktTQqxnOCA8fqj9CU4ZTNh1XUXVkqV4hIb1yOMdJwtTvZ6PCx5L
 2XKfZY7t+FGsQ4oRt9s8OdVGTA8IeKfoyG30G7r5ah1GK1pJ0jwklxeQ0Ng+l5MirjR0HPXca
 r8APrQ==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 741
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/2dd76fcc-0f76-e99b-80a1-2ade40e65380%40web.de>

> What is the problem with this semantic patch?

It tried to express a reduced transformation approach also according to
a clarification attempt by Elia Pinto.



> You didn't have the thoughfulness to provide a test case,

I published one yesterday.
https://lore.kernel.org/cocci/b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2022-11/msg00040.html


> but I tried one and it worked fine.
>
> int main () {
>   int x;
>   x =3D 'x';
> }

I can get a related test result.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch move_a_va=
riable_declaration-20221112.cocci test_for_declarators2.c
=E2=80=A6
@@ -1,5 +1,5 @@
=C2=A0void my_test_for_one_declaration(void)
=C2=A0{
- char o;
+ char
=C2=A0 o =3D 'x';
=C2=A0}


Does it also mean that information from code deletions can generally be ca=
ptured
for subsequent code additions?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/768bd6eb0a2cbede8f139=
0009cc997ff57c339a4/docs/manual/cocci_syntax.tex#L1022

Why do I observe test results which are different in comparison to
the previously mentioned SmPL code variant =E2=80=9C-T I;=E2=80=9D?

Regards,
Markus
