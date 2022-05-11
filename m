Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564AAC433FE
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Mwr84fOqX0nuSbfzHXJUNjRRmI+Fh3lsy2uh3Wi8Ks8=;
  b=tmwx4XWSl4BjFa4A0iUtwFl66N7s3xmeL3qje4VVvt4MgvZ/+QZIhYNb
   fkblFmAQEer0/zJkcKWDYv7qgGZ71D6fWSQCCQANHx2wyQcmlBZACP7hJ
   QzTjWmdhO+FvU4Y6UL8c6QMtAuxTfv+n4Obaqg8UGUpYI1haDXr5CoJ/+
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208,217";a="35699554"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 09:58:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69CB5E026B; Wed, 11 May 2022 09:58:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B94EDE0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 09:58:31 +0200 (CEST)
IronPort-SDR: 970cE8CRp/GF1z1Mc3d5vXst7KKOAMY4dRqLyLv2upseNeA92NY3v8C9Z50RgSYGhb7/Q6axAg
 c9jsA4LV8CeAjhbAwapGib245CIA3+cktWZMEOORKTG9luXMQwxF0GCdqwzSbMm8g2SuaxL/X6
 Ov2pF9GbFHG4bPb//SEfFDs49k5e8QgWOfjv/4Sny2uznNBro9wCmyqH9wqbd3AalC6L6X0cRI
 0xppOaZGI6BVzqZyZn824CCo7J+TllOTb9K9BgeXmfJ3Imq6W8NkuIM1oZUsGxNhXU+cWr+2dW
 Wb3C6Ua1CHj61rlGGoflhF7j
X-IPAS-Result: =?us-ascii?q?A0DtBAA0bHtify3ZVdFaHQEBPAEFBQECAQkBgWaCIn5UL?=
 =?us-ascii?q?gQLQ4ROgSONQ4IlA4wsiXiIOwsBAwENEgEBJwcEAQGFAgKFPgIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhA?=
 =?us-ascii?q?wFEgU+BdAsDMQ2CNSkBg2MBAQEBAgESER0BGxILAQMBCwYDAgsNKgICIgERA?=
 =?us-ascii?q?QUBHAYTGweCXIJiAQMNJA+QNo8agQRBijh6gRUFF4EBggkGhEsKGSgNZwOBW?=
 =?us-ascii?q?QIBBhKBKgGGFoEkAQGHIycQgVVEgUuCPTc+hHGDKYJlBJMPghQEBwMEBgEGD?=
 =?us-ascii?q?gMDAhAUAQIBDCYkDw8IBRICAzQCAgEBCwIGBgQGAwEBBgMJAgQCEgICBAcYC?=
 =?us-ascii?q?hIIFAMCBgIgBQEHBQEEAxIGDBEBCgYGAQQCCgECAgUFDAMBEQEEAgYCBAQEG?=
 =?us-ascii?q?BQEAgQEBQYCCQgHBRYLBAoCFgEdAgEGDAgCAgICAgQVBwENBQICBA8CBwYDC?=
 =?us-ascii?q?wIDBQcDAwQHDAYMDgEDAQcBBAUDDQQBAQYCCwMFCgIBAgMMAQEHBAgBAQICC?=
 =?us-ascii?q?gIBBAIHAQIFAwIDCAMCAwMCAgEBBBECAwQDBAIDAQYBAQUDAgUBAwMCAQMDA?=
 =?us-ascii?q?wIBBAMGCQoECAEEBAEBARECBwcCBgMDAgICAgUBAg0BAgECBAMIBgIDFQECB?=
 =?us-ascii?q?AEKAQUCAwoCBwMBAQIHBQoCBwUCBwICAwIBBQMNAQMFAgMBAQMDAgQBAgEDA?=
 =?us-ascii?q?wkBAwIDAwICAgIFAgMCAgIJAwQBBwMCAQEEBQEEAwECCgQEAwQCBAIHAgcCB?=
 =?us-ascii?q?AcCAQQGAwcGAQMCAQcBAQQKBAMDAwEBBwECBQICAwIGEgYHAgQBAwQECgICD?=
 =?us-ascii?q?AIHAQECAQEBAQIDAgcFDgEBAQMCAwYCBQICAQEDCAgDAgEEAQUDAQQFAwcCA?=
 =?us-ascii?q?QUJAgkDAwEIAwEBBQEDAQkDAwMCCQMBAgICCwQDCAMDAgMEAgICAgEDAgcFC?=
 =?us-ascii?q?AQBBAoCAgIBAgICBAIBAxoBAgMFAgIJDAEEAgIDAQMBAQIIBAkEAgMEAgEBA?=
 =?us-ascii?q?wIBAgIBBQIDDQYBAQEBAgMDAQIDAQEGBwIIAjMWAQMDAgECAgICBQICAQIDA?=
 =?us-ascii?q?gINAQEBBAIBAgECBgEDAQICAwEDAQICBgIMAwkCAQcBBQMDAgIDAQEFEAIEA?=
 =?us-ascii?q?gEEAgECCQUCAQEBBAEDBAQIAgIBAwMCDgIEAQQBAgEBIwMEAgMCAgMXAQIBA?=
 =?us-ascii?q?gMDAwQGBwYCAQITAQIBAQEFAQIBAQQCBAQHCgMCAgIGAwMFAQECAwIBAQEHD?=
 =?us-ascii?q?AICAhMCBAoJAwEGAQoGBhUDAgQCAgECAgIKAwECAgEDAgkCAQIBBSUDAQEPJ?=
 =?us-ascii?q?AEBAgIBAgIDBAcCAQQHAw0DAgEBAQUGDQMCAwgMAgMLAwIBAwMFAQICAgQBA?=
 =?us-ascii?q?gQMCgECAwECAgQFBQMDAgIIBgYnAQEFZwOUcoF5CDwWOywEHIElGSAhE5Jcj?=
 =?us-ascii?q?gygCjQHg0yBOwYMiUuUbAQtg3WMOpgklmONJZltECMSgUOBfk0jUDGCN04BA?=
 =?us-ascii?q?gEBAQ0BAgEBAwECAQIJAQECkg+KYEIxAjkCBgEKAQEDCY0HAQE?=
IronPort-PHdr: A9a23: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
 UqJnD4RIAAx
IronPort-Data: A9a23:ccAeL6JVaLPU8mn1FE+RBZMlxSXFcZb7ZxGr2PjKsXjdYENS3z0Am
 DNND2uFb/eDYzDyctogOdm+909QsZPTm4BgT1Ed+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXlrU4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhgcFry
 9tGmYeMZR4meZyXuuMZfUBXDHQrVUFG0OevzXmXtMWSywjYaCKpzakzSk4xOoIc96B8BmQmG
 f4wcmhcKEDewbjvn/TnF4GAhex7RCXvFIobt2p7xDfVF/FgSpnZRqTM7MNZ9Dg1j8FKW/3ZY
 qL1bBI2N0udPE0eZD/7Drp9zdiSmn3VXAdJ9m6ct5Ub6XGN5SBuhe2F3N39I4TWH625hH2wo
 mvZ9mD9KgMbMdaFwHyE9Gitj6nBh0vTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku3WtYaN
 VdNvyRy8O4980ukStS7VBq9yJKZgvICc8RBCe404y2W9obN7EGoXUoDShAYZ8Nz4afaWgcW/
 lOOmtroAxlmv7uUVW+R+9+oQdWaaXl9wYgqNX9scOcV3zXwiNps0U+XH76PBIbw34KlQ2ihq
 9yfhHFm3+17sCId60msEbn6b9+Eo5HISksr/VySUD74qAx+Y4Ghasqj7l2zARd8wGSxHgXpU
 JsswZD2AAUy4XelynflrAIlQuvB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RGO41kJu8MIYSH7Pcebhr5d7ex6nMAM8vy1BpjpgiZmP/CdiSfcoX42OhbOt4wTuBF1yfFnU
 XtkTSpcJS9CVf4PIMueSOAa3rsmrh3SNkuCLa0XOy+PiOLEDFbMEeltGALXMogRsf3ZyC2Ir
 I43H5bbk313DbylCgGKoN57BQ5QcRATW8utw+QJLb7rH+aTMDt+YxMn6ehxJdINcmU8vrugw
 0xRrWcClgWl2S2ceVXih7IKQOqHYKuTZEkTZUQEVWtEEVB6CWp2xKtAJZYxY5c98+lvkax9Q
 /UfKpePB/1OTnLM/DFENcvxq4lrdRKKgwOSPnr9MGJvIcI4HwGZqMX5egbP9TUVCnXluMY7p
 Yqm3FyJTJcGQTNkE8uLOumkyEm8vCRGle8rBxnIL9BfdV/C6o9vLyCt3PY7L9tdexrGzzqek
 Q2RBE5A9+XKpoY09vjPhLyF/9/5SbsgQhICEjCCv7isNCTc8m6y+qN6Ub6FLWLHSWf52KS+f
 uEKnfzxNfswmlwV4YdxFrBcy71nu4niqrpc+QRTHHvRamOtBL49cGKN2tNCt/EUy7JU5Vm2V
 0aI9oUIMLmFIpm+QlsYJQ5gcP/akP9Ix3/d6vM6JEi87yhypeLVXUJXNhiKqSpcMLolb99/k
 Ll54JYbu16llx4nEtealSQIpW6CGXoNDvc8vZYADY631wcmlgNYbZrHBnOk6Z2DcY8XYEwjI
 zvRmrGbwroAmwzNdH08EXWL1u1Y3MxctBdPxV4EBlKIhtuV2aNtjUMJqWw6HlZP0xFK8+NvI
 Ww3ZUd7EqODomVzj89ZUmHwRgxMCXV1IKAqJ4flSYEYc6WpaoAJBGg0OOLI4ltAtmwAI35U+
 7aXzGujWjHvFC00Mu3eRmY9w8EPj/QonuEBpCxjN8uAFpg+JzHih8dCoEIW/gD/D5pZaFLv/
 IFXESUZVUE/HSEVqqw/TYKd0Nz8jfxCyHNqGZlcwU/CIY0QlPxeF9RDx4Bdt/6h/8D3zHI=
IronPort-HdrOrdr: A9a23:9eM2o62Eu8UpeCWqfOIsjQqjBI0kLtp133Aq2lEZdPWaSL3gqy
 nOpoVi6faQslwssR4b6LW90cW7MBHhHNtOkOos1NSZPTUO2lHYSL2KhLGKq1bd8m/FltK1vp
 0QFJSWZueAa2SSTvyX3OB7KbsdKRW8n5xATN2x80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208,217";a="13757896"
X-MGA-submission: =?us-ascii?q?MDF+uOD5zIt6K/iQStkN7I5BBftDTtXlNE9swy?=
 =?us-ascii?q?7iFgb3Myb+VcxSFM/W0GGfmkGMVEmW0vYHqL30oQi4O4uMGCBGWj1Uj6?=
 =?us-ascii?q?RgQicAEHb4IpOcZGHzTcBhakNx9XsDD6ZEoXu15KBjM3id+qVvq/SgEV?=
 =?us-ascii?q?5wbTLoc2vZq1e3SER8UA9E2w=3D=3D?=
Received: from mail-vs1-f45.google.com ([209.85.217.45])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:58:30 +0200
Received: by mail-vs1-f45.google.com with SMTP id e10so1183152vsr.1;
        Wed, 11 May 2022 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mwr84fOqX0nuSbfzHXJUNjRRmI+Fh3lsy2uh3Wi8Ks8=;
        b=idO1vukNqKYi4A0uurK/f+cU+AWUaEbwYfDc4hKcxaDFTPX80sRyGaPtKmCcZzR5t1
         3Kxi+1Qv/SpPGGE1NYGVqa4TDA5I/R36DJq6lyqA6kljJoS0BGh/c5xLT65MJMKaH4hu
         Krn6Vhnu4sBFJ9D2eU6aROnbjSQOVFMYRXTNrhNl5B+BoMtJbWGq2OqK1jJbWvpPXoup
         dub9YyhmSsa2WRNdQQ0gzhH9Js8F62loT11ux3ffSJMSfdkJALrcxVoPDr2Ng/7rReJQ
         XhIE0qC4AYSFNA7svXePeyWGW7k77t7M5jE07phRk47hM+vI/SZGy9rVM9bO0//piadV
         Gssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mwr84fOqX0nuSbfzHXJUNjRRmI+Fh3lsy2uh3Wi8Ks8=;
        b=F2ik0V63JRXfVHX9ZXeCzwl7HT9zXAZyaYz1n3178moATZDq7ViFMGOeOCnp5rVwza
         /ntdhk2XNZsb04i6P6s2yZFRUWafsjnHT6ZE9AtuXBYi2ZVIPknmX73ycvcNi2dOZWEU
         Opxw03PDJbHE8mJKupvZn875fj62fgInwd2gJzA0QhT3DKprJJ7Q9vgDLuZBY5oLD7oz
         oDoKOm8chQS4soinYxecEMsWNRw7vDh30gay30WGn+qhNKV093Gwmg252rpSG2hN1MWU
         PhOD8SzhHINN/a2UxkVL6JIAIHbHWX3RU4hyzV8D8LgPon9zQeEkArYXT76dNm9foAzo
         XLnA==
X-Gm-Message-State: AOAM531miM58iqYysY47q+Aw91Ma6j36fNGeoP4oV4Sw7sDI7ghKjOtK
	SC6SNNwUQ/YhtXsTLJ0w7eQRpJirzJfN3oIugZuzHqvVXCo=
X-Google-Smtp-Source: ABdhPJx7P62xKTmXwlK5Dd6JMEXPgjStHfWELNYpmmiUj6RG5cHTW7fhTYghQMd4PW+ZiBuAN9qc3Rne2HnI/i1E5qM=
X-Received: by 2002:a05:6102:508b:b0:32d:4378:93c3 with SMTP id
 bl11-20020a056102508b00b0032d437893c3mr12944247vsb.30.1652255908157; Wed, 11
 May 2022 00:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien> <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
 <alpine.DEB.2.22.394.2205110943320.2811@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2205110943320.2811@hadrien>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Wed, 11 May 2022 09:57:52 +0200
Message-ID: <CAPp5cGQeWw59kwDAXaF=PRBA6Jk-KUZTYwMC=qq=d047EG39iA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000007bdd2805deb7ce61"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 380
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGQeWw59kwDAXaF%3DPRBA6Jk-KUZTYwMC%3Dqq%3Dd047EG39iA%40mail.gmail.com>

--0000000000007bdd2805deb7ce61
Content-Type: text/plain; charset="UTF-8"

Sorry for this.
the script is:

```
@excluded@
type T;
identifier i;
position p;
@@

(
 T i@p(...);
|
 extern T i@p;
|
 T i@p(...,......);
)


@r@
type T;
identifier i;
expression E;
position q != excluded.p;
position p : script:python(i) { p[0].current_element == i};
attribute name __randomize_layout;
@@

(
 T i@q@p;
|
 T i@q@p=E;
)

@rr@
type T;
identifier i;
expression E;
attribute name __randomize_layout;
@@

(
 T i;
|
 T i=E;
)

@script:python@
i << r.i;
@@
print (i)
```
the target file is
https://raw.githubusercontent.com/torvalds/linux/master/sound/soc/mediatek/common/mtk-afe-platform-driver.c
and the symbol I'm looking for is mtk_afe_pcm_platform
I introduced the rule rr to attempt to debug the script. It is not meant to
be part of the final script.
Thank you for the help.

Alessandro


Il giorno mer 11 mag 2022 alle ore 09:44 Julia Lawall <julia.lawall@inria.fr>
ha scritto:

>
>
> On Wed, 11 May 2022, Alessandro Carminati wrote:
>
> > I'm planning to stop bugging this mailing list, but before that, please
> allow me a final question. That is related to what I have done so far.
> > My current implementation is the following.
> > ```
> > @excluded@
> > type T;
> > identifier i;
> > position p;
> > @@
> >
> > (
> >  T i@p(...);
> > |
> >  extern T i@p;
> > |
> >  T i@p(...,......);
> > )
> >
> >
> > @r@
> > type T;
> > identifier i;
> > expression E;
> > position q != excluded.p;
> > position p : script:python(i) { p[0].current_element == i};
> > attribute name __randomize_layout;
> > @@
> >
> > (
> >  T i@q@p;
> > |
> >  T i@q@p=E;
> > )
> >
> > @rr@
> > type T;
> > identifier i;
> > expression E;
> > attribute name __randomize_layout;
> > @@
> >
> > (
> >  T i;
> > |
> >  T i=E;
> > )
> >
> > @script:python@
> > i << excluded.i;
> > @@
> > print (i)
> > ```
> > It is a suboptimal version of Julia's last proposition.
> > It happens that in a file a statement I expect to be matched is not
> detected.
> > Troubleshooting the issue, I see a behavior that does not fit the model
> I have in my mind. This suggests to me that things (coccinelle under the
> hood mechanisms) are more complicated than I think.
> > back to the point:
> > Running the script and printing only the rule "rr", which is the same as
> "r" without positions, the results presents a set of entries containing the
> entry I'm interested in.
> > Running the same script but printing only the rule "excluded", I see
> that the result is an empty set.
> > Finally, running the script using only the "r" rule, the entry I'm
> interested in is not there.
> > Surprisingly (for me), removing the position constraints coming from the
> rule "excluded" (position q != excluded.p;) from the rule "r", the entry
> appears.
> > My question then is the following: How can the rule "excluded" that
> presents an empty set influence the rule "r"?
> > Speculating Julia's words on a previous answer I got, I guessed that
> somehow an empty set could be treated differently, so I added a line into
> the target c file to make at least "excluded" match one line. But it didn't
> make any difference.
>
> Sorry, but I can't answer a question at that abstract level.  Please send
> the precise example (semntic patch and code), and I will check on what
> went wrong.
>
> julia
>
> >
> > Alessandro
> >
> >
> >
> > Il giorno mar 10 mag 2022 alle ore 12:39 Julia Lawall <
> julia.lawall@inria.fr> ha scritto:
> >       Here is a suggested solution for all of the problems reported so
> far:
> >
> >       @r@
> >       type T;
> >       identifier i;
> >       expression E;
> >       position p : script:python(i) { p[0].current_element == i };
> >       attribute name __randomize_layout;
> >       @@
> >
> >       (
> >       T i(...);
> >       |
> >       T i(...,......);
> >       |
> >       extern T i;
> >       |
> >       T i@p;
> >       |
> >       T i@p=E;
> >       )
> >
> >       @script:python@
> >       i << r.i;
> >       p << r.p;
> >       @@
> >       print (i)
> >
> >       ----------------------
> >
> >       The problem with __randomize_layout is that the Coccinelle parser
> is not
> >       recognizing it as an attribute.  You can force that by putting a
> >       declaration in the semantic patch.
> >
> >       It seems that ... in a function parameter list does not match the
> ... in C
> >       for a variable list of arguments.  That ... can be matched
> explicitly by
> >       ...... so I have added another case with that.
> >
> >       I als combined all of the patterns into one rule.  By inheriting
> the
> >       position varaible p into the python rule at the end, that python
> rule is
> >       only executed if p is defined, which makes it select the cases of
> interest
> >       and ignore the others.
> >
> >       julia
> >
> >
> >

--0000000000007bdd2805deb7ce61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry for this.<br>the script is:<br><br>```<br>@excluded@=
<br>type T;<br>identifier i;<br>position p;<br>@@<br><br>(<br>=C2=A0T i@p(.=
..);<br>|<br>=C2=A0extern T i@p;<br>|<br>=C2=A0T i@p(...,......);<br>)<br><=
br><br>@r@<br>type T;<br>identifier i;<br>expression E;<br>position q !=3D =
excluded.p;<br>position p : script:python(i) { p[0].current_element =3D=3D =
i};<br>attribute name __randomize_layout;<br>@@<br><br>(<br>=C2=A0T i@q@p;<=
br>|<br>=C2=A0T i@q@p=3DE;<br>)<br><br>@rr@<br>type T;<br>identifier i;<br>=
expression E;<br>attribute name __randomize_layout;<br>@@<br><br>(<br>=C2=
=A0T i;<br>|<br>=C2=A0T i=3DE;<br>)<br><br>@script:python@<br>i &lt;&lt; r.=
i;<br>@@<br>print (i)<br>```<br>the target file is <a href=3D"https://raw.g=
ithubusercontent.com/torvalds/linux/master/sound/soc/mediatek/common/mtk-af=
e-platform-driver.c">https://raw.githubusercontent.com/torvalds/linux/maste=
r/sound/soc/mediatek/common/mtk-afe-platform-driver.c</a><br>and the symbol=
 I&#39;m looking for is mtk_afe_pcm_platform<div>I introduced the rule rr t=
o attempt to debug the script. It is not meant to be part of the final scri=
pt.=C2=A0<br>Thank you for the help.<br clear=3D"all"><div><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
Alessandro<br><div style=3D"display:inline"></div></div></div></div></div><=
/div></div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">Il giorno mer 11 mag 2022 alle ore 09:44 Julia L=
awall &lt;<a href=3D"mailto:julia.lawall@inria.fr">julia.lawall@inria.fr</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br>
<br>
On Wed, 11 May 2022, Alessandro Carminati wrote:<br>
<br>
&gt; I&#39;m planning to stop bugging this mailing list, but before that, p=
lease allow me a final question. That is related to what I have done so far=
.<br>
&gt; My current implementation is the following.<br>
&gt; ```<br>
&gt; @excluded@<br>
&gt; type T;<br>
&gt; identifier i;<br>
&gt; position p;<br>
&gt; @@<br>
&gt;<br>
&gt; (<br>
&gt; =C2=A0T i@p(...);<br>
&gt; |<br>
&gt; =C2=A0extern T i@p;<br>
&gt; |<br>
&gt; =C2=A0T i@p(...,......);<br>
&gt; )<br>
&gt;<br>
&gt;<br>
&gt; @r@<br>
&gt; type T;<br>
&gt; identifier i;<br>
&gt; expression E;<br>
&gt; position q !=3D excluded.p;<br>
&gt; position p : script:python(i) { p[0].current_element =3D=3D i};<br>
&gt; attribute name __randomize_layout;<br>
&gt; @@<br>
&gt;<br>
&gt; (<br>
&gt; =C2=A0T i@q@p;<br>
&gt; |<br>
&gt; =C2=A0T i@q@p=3DE;<br>
&gt; )<br>
&gt;<br>
&gt; @rr@<br>
&gt; type T;<br>
&gt; identifier i;<br>
&gt; expression E;<br>
&gt; attribute name __randomize_layout;<br>
&gt; @@<br>
&gt;<br>
&gt; (<br>
&gt; =C2=A0T i;<br>
&gt; |<br>
&gt; =C2=A0T i=3DE;<br>
&gt; )<br>
&gt;<br>
&gt; @script:python@<br>
&gt; i &lt;&lt; excluded.i;<br>
&gt; @@<br>
&gt; print (i)<br>
&gt; ```<br>
&gt; It is a suboptimal version of Julia&#39;s last proposition.<br>
&gt; It happens that in a file a statement=C2=A0I expect to be matched is n=
ot detected.<br>
&gt; Troubleshooting the issue, I see a behavior that does not fit the mode=
l I have in my mind. This suggests to me that things (coccinelle under the =
hood mechanisms) are more complicated than I think.<br>
&gt; back to the point:<br>
&gt; Running the script and printing only the rule &quot;rr&quot;, which is=
 the same as &quot;r&quot; without positions, the results presents a set of=
 entries containing the entry I&#39;m interested in.<br>
&gt; Running the same script but printing only the rule &quot;excluded&quot=
;, I see that the result is an empty set.<br>
&gt; Finally, running the script using only the &quot;r&quot; rule, the ent=
ry I&#39;m interested in is not there.<br>
&gt; Surprisingly (for me), removing the position constraints coming from t=
he rule &quot;excluded&quot; (position q !=3D excluded.p;) from the rule &q=
uot;r&quot;, the entry appears.<br>
&gt; My question then is the following: How can the rule &quot;excluded&quo=
t; that presents an empty set influence the rule &quot;r&quot;?<br>
&gt; Speculating Julia&#39;s words on a previous answer I got, I guessed th=
at somehow an empty set could be treated differently, so I added a line int=
o the target c file to make at least &quot;excluded&quot; match one line. B=
ut it didn&#39;t make any difference.<br>
<br>
Sorry, but I can&#39;t answer a question at that abstract level.=C2=A0 Plea=
se send<br>
the precise example (semntic patch and code), and I will check on what<br>
went wrong.<br>
<br>
julia<br>
<br>
&gt;<br>
&gt; Alessandro=C2=A0<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Il giorno mar 10 mag 2022 alle ore 12:39 Julia Lawall &lt;<a href=3D"m=
ailto:julia.lawall@inria.fr" target=3D"_blank">julia.lawall@inria.fr</a>&gt=
; ha scritto:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Here is a suggested solution for all of the =
problems reported so far:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@r@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type T;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0identifier i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0expression E;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0position p : script:python(i) { p[0].current=
_element =3D=3D i };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0attribute name __randomize_layout;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0T i(...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0T i(...,......);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0extern T i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0T i@p;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0T i@p=3DE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@script:python@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i &lt;&lt; r.i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0p &lt;&lt; r.p;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0print (i)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0----------------------<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The problem with __randomize_layout is that =
the Coccinelle parser is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0recognizing it as an attribute.=C2=A0 You ca=
n force that by putting a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0declaration in the semantic patch.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0It seems that ... in a function parameter li=
st does not match the ... in C<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for a variable list of arguments.=C2=A0 That=
 ... can be matched explicitly by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0...... so I have added another case with tha=
t.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0I als combined all of the patterns into one =
rule.=C2=A0 By inheriting the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0position varaible p into the python rule at =
the end, that python rule is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0only executed if p is defined, which makes i=
t select the cases of interest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0and ignore the others.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0julia<br>
&gt;<br>
&gt;<br>
&gt;</blockquote></div>

--0000000000007bdd2805deb7ce61--
