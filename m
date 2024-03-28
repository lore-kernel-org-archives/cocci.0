Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C3ECD1283
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RSa0goKin4FlgpiBWmGWdpeuthLheGJ+34rGGgZQ2hs=;
  b=tKpQ2FwdRHfA+uQ7WPA64dPIaumt16yT9bEygaR1nUt6X5sfPf/1ufP+
   A8YUP8Sqn3Dx4cojQg3E8LxaO9cqCPaecK1kJz1drfS3QsEek/KKQ/dFY
   Nn7xyWTdzXT5ZB6LVDqat29/VFKPvsJ+nNtjXYIybEqdGhp06XLTMCPpx
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="158959576"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 15:57:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 76477E0AF6; Thu, 28 Mar 2024 15:57:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4298AE0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 15:57:34 +0100 (CET)
IronPort-SDR: 6605855d_u6qwowdJb9mHZeyGQZr0Dpti+7LHc5XH+MXylfzJfePn9Zr
 yW5TWBUWmWNYn6XoDKFgkc94o0hFoJh9VF0MP5w==
X-IPAS-Result: =?us-ascii?q?A0GNAwBKhAVmfzTaVdFaHgEBCxIMQIFEC4I5gVEzBAtIh?=
 =?us-ascii?q?FaPRYIli3OHTopGgUA+DwEDAQ1EBAEBAwSEfwKIBQIeBwEEMQgOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASIZBw4OKYVtDYJnAYEeYQIFA?=
 =?us-ascii?q?zsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAixdAQEBA?=
 =?us-ascii?q?xIRHQEbHQEDDAYFCw0CAiYCAiEBEQEFARwGExsHhQkBAzEDpROBBUKLO4EVB?=
 =?us-ascii?q?QIWgQGCCwavXQoZKA1sA4FeAgcUgQYuhGAlgwUdAYFWhAODX3ongWREgUqCP?=
 =?us-ascii?q?Tg+hEMVg0aCaASFSaAPJggBBhcDBwcHBAUECRMGBQUCQwkIBQoSAwQDBAYBA?=
 =?us-ascii?q?gUDBRMCAgQQBQIBARUBGgEDCAQKAgcBAhUDAQEBCAEDBA0CAQIDAwEBAQEFA?=
 =?us-ascii?q?gIBAgkCAgMFBAQBDAMDAgkBBAEDBAELAgEDBAICAgIBAgIDAgIGAgMCBAEDA?=
 =?us-ascii?q?wMDAQIBAwEBCgMDAggDAwUBAgMCAgIEAgICAgIDBgQFAgECAwIGBgMBAwIFA?=
 =?us-ascii?q?gMFAQEECAYBAwIDAgcLAgEGAgIBBAITAQQBAQIDBQICBgMDAwIDAgIGBQgDA?=
 =?us-ascii?q?gEBAgEEAwECAQEXAgIMBwMBBQICAwMHAQQBAQMHAQMDAgIOAgoFBQIHAwIcA?=
 =?us-ascii?q?gICDwECAQIBAwsDBwICAQIQAgIBAgoHAwUFAQUBBAIBAgYBCAICEgUGBgEBB?=
 =?us-ascii?q?AILAwIBAQICAgsCBQUDAwQCDwcFAgECBAIBAQMQCAcBDwYCAwQCAgUCAQILB?=
 =?us-ascii?q?BICEAEEAgICBQEFAgEBAgMFBgIBAwgCAgYDBwECBQIFAQQHAQcEAgwCCQEBA?=
 =?us-ascii?q?QIBAgMDAgMEAgEDAwQRAQwDGwIBAgQLAQEFBAIGAgMIAwMaAwgDAgECAwEFA?=
 =?us-ascii?q?QIBBAUEBwMCAwMDAwMDAwgEAQoDAwMBBAEHAwoBAg8LBgECCAUIEAQBBAICB?=
 =?us-ascii?q?AcCAwQDAwICAgMDEgEDAwMCAQMBAgUCDwYHAiQDAgICBwMEBQICAggCAwIEA?=
 =?us-ascii?q?wINAwIDAQUDDAUBBgQCAgQKAwIBBQMXCQQCCREGAgINAgwGBQEEAwIBAwMDA?=
 =?us-ascii?q?gQCAgMBAgICAgIDAQIKAgEHAgUDBQICAwIBAQEBAgIEAwEOBwIDBQUCAQUJA?=
 =?us-ascii?q?wMCAgQDAQICAwICAgMBBAUUAwQCBQoDCAICBwIOAwEFAgEBAgICAgEBAgIDC?=
 =?us-ascii?q?AISBAIBAgMCAggCAgcBAQIKCQMBAQQEBAMGAgIFBA0DCAUBAQICBAEKAgkPB?=
 =?us-ascii?q?QICAwMCAwEBAQIKAwkBBQICAQMCAgQEBwEGAwUDAwQEAgMDAgwBBQEFAQUBB?=
 =?us-ascii?q?QQCBgEUAhQCAgsFBgMGDgMLBAQBAgIFBAYMCQQCAgIGAQIRAwECAQcBAwMCC?=
 =?us-ascii?q?gEEAQILCAEFCAIMBAIBBAIDBhACCAUGBQICAQECAgIBCAYPAwYHAgMCBgMFB?=
 =?us-ascii?q?QMDAgICBwQEAgECAgIBEwYEBAIDAgMEAQUEBAMCFwgNAgUHAQkLCAwBBAYCB?=
 =?us-ascii?q?AIEBwMIBQUEAgMEBBEHCwMCAwQCAgYDEQIDBAIKAgQEBwIDAQQNBgQECgILA?=
 =?us-ascii?q?wcBAQEBBQMDCQcGAgMDBQQDBgIFAwMDAgMCDQICAgEJAQEBAhQCAw4CBAIBA?=
 =?us-ascii?q?gUFDAQTAgIDAgYIAgICBwMDBAIDBgsCARADAgICAgUDBAICFAMJBAIEBgIEA?=
 =?us-ascii?q?QYDAwIEBgUKBAICBQIBAQIKAgEPCgQDBAMFAwcJAgUFAwIEAgIHCQEBAgICA?=
 =?us-ascii?q?wMDAwIDAgIDAwIHAwMDBwMFAwQCAwYFBwMFBQMCAgIUAQYCBQoGAwcGCwUFB?=
 =?us-ascii?q?wIGAgQIAwUCAgMDAwMCBgoIAwMDAgEGAgIDAwECCAMPBgICAwUGAwMDAwYIA?=
 =?us-ascii?q?wMCBgMDAgMCAwIDAwEDAgMCAgMCAgIIAgIDAgUEBQICAwQCCBoCAgICAwMIA?=
 =?us-ascii?q?wMKBAICBAEEAgQCBAIGAwQBAgIBBwIFAwIDAgcCAgQCAgICAwICBggCAgMDA?=
 =?us-ascii?q?wICAgEJAgUBAQYCBAMCAwUDCQMEBQIDCAEBAgIHBwMDBAMBAgEFBAICBgUCA?=
 =?us-ascii?q?wICBAQEBQMCAwIGBgIBAwIKBgMFAwMDAwIDAwIDAwIFAggCAgQEBQQCBwQCB?=
 =?us-ascii?q?AMDAwEKAgYDAgIFAQECAgUDAgQEBwICAgcPAwIHBQIFBwIIAQYFAgIDAggBA?=
 =?us-ascii?q?gIGAQYCBAECAg0BAQICAgMBAwMDBwIEAwIIAgMDEQEDAwkGBQQFBAMJBA8CB?=
 =?us-ascii?q?AEIAwEBBAgCBAMCDAICIQIFCwQEARIKCAMBAQMBAQICAgICDgMCAwICAwoCA?=
 =?us-ascii?q?wIKAwYEAgIGAQEBBAYBBAIBAgkEDgkFCAgBAwIBBAYBAhIFDwIJAwMGBAIQB?=
 =?us-ascii?q?goFAwIDBQECBRUDCAMCCQIEDAMFCAIDAwIGAwYCBgEGAwcLAQEJCAUDAwMCF?=
 =?us-ascii?q?gECAhAIBgYPBwIDAwQEDwMSAgYOAwMCAwIBAgICAwUEBQIHAwMNBQICBwMCC?=
 =?us-ascii?q?AUDBwkECgIIBQECBgMCAgICBQ0BAQEBAgMCBQMHCQgIBAUEAwEBBgYMKAICA?=
 =?us-ascii?q?wQQAwkDBgsBBQUBAwICAg4DBQMCAwYGARAEAQUECQIFBwYFAgEFAQIBQx0CC?=
 =?us-ascii?q?QMjDwMLCQgTPQELBzIENAEUFAcnAQEFIQpWpnCDH7FMlQEHhBahQzODcqY+m?=
 =?us-ascii?q?GKochEjEoExAzWBXDMaI4EBgjZPAxkPjiCDeqM+RTI7AgcBCgEBAwmJIoFIA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 tVgD7XSyqhIxIC9FYB6ETk0xq8=
IronPort-HdrOrdr: A9a23:Sbx9OKguy7lftigA2VAdCNzeinBQXu8ji2hC6mlwRA09TyVXrb
 HWoB19726OtN9xYgBZpTnkAsO9qBznhPtICOUqTNWftUzdyQiVxeJZjLcKoQeQfxEWn9Q1vc
 xdmupFaOEYZmIK6voSjjPIderIA+PqzElrv4rjJrtWIj2CopsP0ztE
X-Talos-CUID: 9a23:av8swmyfMsaUysQSyxexBgUIGJsZNX/enU7TeUiYG1l5S5CHF2KfrfY=
X-Talos-MUID: 9a23:gXfLUgv4+HJmNx6wb82nvhp/C9Y1+IWXKn8omKVd4e+GKRV9JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="158959558"
X-MGA-submission: =?us-ascii?q?MDFftR6pd/PLNBwWStTTiXcGkCuqYrw0Q1LEcO?=
 =?us-ascii?q?MPGuk2m4reqUQ4vg1NOP7frVlDhbEnRd2edty1nQpCzDnGOeCGdSxduY?=
 =?us-ascii?q?eIU+tSp0TuCM/+H+AO05yAmRvWV0tAUQ4+WjuSoG5PfpShHMuR7zykiM?=
 =?us-ascii?q?gYFg50ScriHghDkRV2X5092g=3D=3D?=
Received: from mail-ej1-f52.google.com ([209.85.218.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 15:57:33 +0100
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a47385a4379so387701966b.0;
        Thu, 28 Mar 2024 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711637853; x=1712242653; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSa0goKin4FlgpiBWmGWdpeuthLheGJ+34rGGgZQ2hs=;
        b=B18fLUut0gMGp8FKr8cGHQDyaKPOs1qfpj80hHM+advt99j5/hMfGE6vfNx2Af9+vK
         4spVMFJsfq7938+NU1cLrJIiokTJi70iiNutyVA/0yTRVZdcxHWZv1MKUckfYoMtvQo0
         Lg8UrZTZRN+stwLyiTlZsYorxRFYvjn3M1SI5YOQObwrm9WZo2GiviVAQGxT1sx0fmLn
         6bX60cyqGVoKeAhT7qj4pio74WgkJwtjs0es20JVk9/PnleFlzuoFlYlhBd9AmVfZGhG
         H8nwwm/6CNZGjWmJm3j1CqSr/w7fBvmZhSpVW4O19z0NvNuSWNUDzQCeL7GIznMvOpL5
         0U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637853; x=1712242653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSa0goKin4FlgpiBWmGWdpeuthLheGJ+34rGGgZQ2hs=;
        b=AO44uwa8OjMf8pj6IEzcrEdD67aw5oggDnRm2EJnKfZUSuC2cd3ZbXygvwXpEUT6E7
         T3SIIeGjjrpMpEIe1uuQFI//FgfUu8mTR7Yz0qO2HblFFiMTlQ0ldxB+B7uILk+aPTw9
         TnvX787NOkbIdsHuSvT23b2+LZsg/AYhOGDLPJ8nTzOFC+0MSGbwOxEJIuAPQwjfO/lc
         /AV1EcINUTCoa1HkfOE2hMmD1syFjcafHehZeaUg47YYn4V5sxjQy60j8BM3oGauydLV
         7tgzoma+g41g8R3jzpILRimKkE2Iu/EOojYG+EuukF94/lFXbw10A6KsbHIt4bfBIMhD
         5K4Q==
X-Gm-Message-State: AOJu0YxJJA+F9SzQltKUALE4wLuZc1lWjrm7e0fHyWDYPNMdd8ZS7FmH
	dGo9oNHKAkXkG5Q/EaFf24rXRiG24g8N+RrtEGDNr/pcGsHiGUGBOHiW2N5ihNmogGejYjgTcH7
	DLBGroKT3/2VUAqXNV48PQOiVYzUfG5j1N6M=
X-Google-Smtp-Source: AGHT+IHJyaEQ+4Z0FCris5dTsg/HozZvKaFubIqHConUefrSKncRBj969R1XaxItAgTtjahH7cXKjLEUqFk0NRp9X4c=
X-Received: by 2002:a17:906:3748:b0:a4e:88e:362a with SMTP id
 e8-20020a170906374800b00a4e088e362amr2398598ejc.22.1711637852619; Thu, 28 Mar
 2024 07:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+MoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow@mail.gmail.com>
 <ffb475dd-496c-2ae-6329-86d6163b2bb6@inria.fr> <CA+MoWDoScx-d3bj+niNbPYjrujb+pO0fyrhkSDZHxkcntDLimg@mail.gmail.com>
 <23254a95-222e-494-3f0-508a2790753@inria.fr> <CA+MoWDo-DJKq1jjC7Sr41c3+7G=P_wGsQHJrGaxMNyB+UOsjwg@mail.gmail.com>
 <e669e126-f627-646e-d069-baca9c3e0eb@inria.fr>
In-Reply-To: <e669e126-f627-646e-d069-baca9c3e0eb@inria.fr>
From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Thu, 28 Mar 2024 15:57:20 +0100
Message-ID: <CA+MoWDqmRhSKF-T9o_XjseBtCGcqibMVCQ2KukZwn=x13ofaZg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Returning statically allocated nested structs
Reply-To: Peter Senna Tschudin <peter.senna@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1629
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/CA%2BMoWDqmRhSKF-T9o_XjseBtCGcqibMVCQ2KukZwn%3Dx13ofaZg%40mail.gmail.com>

On Thu, Mar 28, 2024 at 3:49=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:
>
>
>
> On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:
>
> > Thanks Julia,
> >
> > Your question about nesting inspired me to a simpler solution:
> >
> > @rule1@
>
> You could add the word exists after rule1, in case some other returns do
> something different.

Oh thanks, Coccinelle found 36 instead of 35 occurrences after adding exist=
s.

Thanks!

[...]


--=20
                         Peter
