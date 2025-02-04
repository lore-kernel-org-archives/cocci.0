Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DA5C02194
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ft9wrF+JHfQ64/CVUc4JCrga9V7eVDsJuBfcSqeaH5k=;
  b=TH1K+RjKF1NTOCvsgs1oa/4jdXLNT7gnPcgZq3Fmtj1bdp/qtLE2f+mL
   HAxUynZVRtuWUE6U8bJgBxg70q2Yk/jPqjOHoRfGAnbWwVq3pfDDVPqCH
   ui0NfjptA0lfo/chrUs+w4jpOqYECO/JZjYmdxVpJLjhIADvwIf0Kq+HI
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206514118"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 13:41:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 73F59E0D20; Tue,  4 Feb 2025 13:41:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 78800E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 13:41:48 +0100 (CET)
IronPort-SDR: 67a20b0c_/MxFaThAbwurUIe2miBidyOTteK0B6vcysxSlfJDz8fnmpn
 7xTLI3SjnZF7r9LVKNKsa2rKQpbt9Mh4HxGvxbw==
X-IPAS-Result: =?us-ascii?q?A0GLAACkCqJngTGnVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgVczBFOEVoh8hlOCJKAUDwEDAQwBRAQBAQMEggyCdAKKfQIeB?=
 =?us-ascii?q?wEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw47h?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDEhEdAQE3AQ8LCw0CAiYCA?=
 =?us-ascii?q?iESAQUBHAYTIoURAzEDo2eBBUKLPoEygQGCDAEBBtsmIleBZQkJAQqBBi4Bi?=
 =?us-ascii?q?E0BgWyDfgGDfXonG4INgRU1gkQxPoRDFYNGgmmCM0qBJ4NAhmaHE5RJJgkdA?=
 =?us-ascii?q?wcHDg0eSQ8FHANZLAFVExcLBwVhSEgBAgGBECOBJgU1Cjc6gg1pSToCDQI1g?=
 =?us-ascii?q?h58giuCIYI7ghiCK0YZLwMDAwODNIVeghKBXwMDFhABgXOBMnocg0gdQAMLY?=
 =?us-ascii?q?gs9NxQbTJ4wPIVTgj+xMpURhCWEb5xxM5dEkw+YfKkEAgoHBhEjgVokgVwzG?=
 =?us-ascii?q?ggoCGwGgjBPAxkPjiGJDcNeQjU8AgcBCgEBAwmQM4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:F6m6fKGbCUvDNlnMpLqEZ8eALOsnbusQ8zAXPo5KOGxom6uj5r
 KTdZUgpGzJYVMqMk3I9urwQpVoLUmsjqKdpLNhRYtKPzOW3ldATrsSkrcKqgeIc0aOlJ856U
 4jSdkGNDSZNykYsS+Q2njHLz9P+qj3zImYwcjZ1GlkVgxnZuVN6A1jGh+HHkAefmU2YaYRJd
 6z4o5pqzK8ZW8adK2AdwU4dtmGidmOupyOW3A77t0chzWmvHeH7Lb7Fly/xRcRUzRGxPMH/X
 LemwL0ooWP2svLtyM0FVW/032borrcIxJ4ZL3qtvQo
X-Talos-CUID: =?us-ascii?q?9a23=3AlcQkmmpFOwScldTRUXpLvP3mUZkkdmfilHbrH13?=
 =?us-ascii?q?7MT1oVbqLb1+Rxbwxxg=3D=3D?=
X-Talos-MUID: 9a23:rMY/LghQkCrAiNdrN90mNcMpCIQwupXtFnkxtK5ZtuehMw1Sa26ttWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206514111"
X-MGA-submission: =?us-ascii?q?MDGAMurwOdikYj4ypoGqcL8wsjOcj74TrfQxr0?=
 =?us-ascii?q?taUU7uNMk8RbOMqUwlMmFJp0q2MqpQqQuSN9WJVe/PP1Wy6p6CMY5y0y?=
 =?us-ascii?q?vy2JQ6VkeSlp/LihdmAIM1EAt+F82mwUdAOvykmeJGQtKMqZS7XF9BMX?=
 =?us-ascii?q?zMWnz9CFO+N/LLaNErWLrNqA=3D=3D?=
Received: from mail-lf1-f49.google.com ([209.85.167.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:41:48 +0100
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c52000dso6027812e87.3
        for <cocci@inria.fr>; Tue, 04 Feb 2025 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738672907; x=1739277707; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9wrF+JHfQ64/CVUc4JCrga9V7eVDsJuBfcSqeaH5k=;
        b=Gac3iTIUFqdqrZl0CCeJQBu6N7U8ILbUs7h+ll+Z/fkwRBXmS/SdbUwhL3RSZuR3Nw
         ejnsW8ws41uqS8jOCNhOCnxGTrpAO0+YLiVsTt1jVb792apvESlSNM0BvVaZG1GTnWeT
         7MJ2C5SeeoM56nTzC3hs01XcfZpLKu0WvPZfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738672907; x=1739277707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft9wrF+JHfQ64/CVUc4JCrga9V7eVDsJuBfcSqeaH5k=;
        b=nLZLt7rt7f+FMEWtC+30n96w9hCisudQNIfA1l1jGUVEV6eh81naBnAWKx9QS9NBKJ
         Uc2uRncPwlTDKCSS5zDPnNcH7n/Qnuw4WTGyNg2rpJwhFhSApWScndLkpDrDS5Grr+RW
         eioVfZw73Dg0uqHzYZl2YIY3iL0hCUP0yacmZ5uLGx/2EnUnDObYcBxuI6Fem2u3a013
         /07nsEFQyVt3PX73MkZebrJO2T6Yf+CAbMegH8OxDbSj5mK/O1SeGGyHw7G2nn92Uhht
         t4+sFng2Pac7zF0J6Msbtw3Q28bmN8KSlcPNdkCw/oeSIllIkSAyWnWEgDYxf6GaknNZ
         uDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhnz+yKhUzF2etBahw2iW8KOKMvDU/PYZGCkc6yR7PqQI9RVPA02YR+fwLd2ESmDpoFQSw4w==@inria.fr
X-Gm-Message-State: AOJu0YzsNM9o7S+07gVlQ67EUJkFPNDjZn+fDc9k3tq15m79L9C3wuvq
	pcOiUKn9A5j5eIrwMqXrrqPbTGrzetf35CQ8r3f9c7luJxZw/6tVAkX51RvC1Q/IwuIYnq+RQ+o
	=
X-Gm-Gg: ASbGnctBVA6Q27C5pea+ZWFkmyaDREs61kTrgkyYrYD69NyL1pbfBTVbceCOwDHarAy
	LDwkY6pzGL0GSNcEJENbnR50W4dNJPwAxGgKNyVY9qZ4J1EJ3lPLkkQIOlxq8QA5Z8bV/6jI7eC
	OpJEwQMNmBuf4VXukElJxNJhV1i//ID8avD47F3RZlZiXo+qzpYLDTyrn01DFLQz7plw/BaIoLz
	LQfNBR3iqS3g73LU7cJOIqFCMzpKXSaqbvwJiYtnrvFlH9H4Tryj5dwPOdhn+1xyD+fTRvi9QGS
	FblgIBbvHGK2XBo4s7zTuE+VDnX9QaVdjKPa60b5mOM4s9fkkMNDIg==
X-Google-Smtp-Source: AGHT+IEOddNzU7EHal8UlukudvIUd6/6Ni2fJfnr6CmgTETWtcxCvpSESaiFAf31/noaem0H7Dr23A==
X-Received: by 2002:a05:6512:3d21:b0:540:1fae:b355 with SMTP id 2adb3069b0e04-543e4c37a94mr7934805e87.52.1738672906920;
        Tue, 04 Feb 2025 04:41:46 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebebeb3esm1579141e87.220.2025.02.04.04.41.45
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:41:46 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401c52000dso6027784e87.3
        for <cocci@inria.fr>; Tue, 04 Feb 2025 04:41:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFIVVklKHwWjgePCtspbIQAK1PwFkEcAADbMRhM9OjVesRM5S5NNW8m+LnkIoiPqkmz3eTow==@inria.fr
X-Received: by 2002:ac2:4359:0:b0:542:63a8:3939 with SMTP id
 2adb3069b0e04-543e4bda7f7mr6374855e87.8.1738672905464; Tue, 04 Feb 2025
 04:41:45 -0800 (PST)
MIME-Version: 1.0
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de> <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr>
In-Reply-To: <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 4 Feb 2025 13:41:31 +0100
X-Gmail-Original-Message-ID: <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
X-Gm-Features: AWEUYZmIwRYUGbbWHs-UmlEDoWAdsnJ-hCMIBSjLEKhUBfyL-0G5YN1Jf5dPiBo
Message-ID: <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 2336
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/CANiDSCvsBCrpwOFbwf93ighoMm%2Bca%3DjpHs6NAp9AHaEJj9neRg%40mail.gmail.com>

Hi Julia

Just FYI, In media-ci tried again with Debian's 1.3.0 and it is better
than  1.2 but still much slower than 1.1.1.

Regards!

On Mon, 5 Aug 2024 at 14:12, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Mon, 5 Aug 2024, Ricardo Ribalda wrote:
>
> > On Mon, 5 Aug 2024 at 13:27, Markus Elfring <Markus.Elfring@web.de> wro=
te:
> > >
> > > > It seems to be related to the cocci version, and not the kernel ver=
sion.
> > > >
> > > > Debian updated it recently from 1.1.1 to 1.2.
> > >
> > > Thanks for such background information.
> > >
> > >
> > > > These are my results for the same kernel code:
> > > >
> > > >
> > > > root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/media/
> > > > MODE=3Dreport V=3D1  > 1.1.1.txt
> > > >
> > > > real    1m59.021s
> > > > user    53m53.038s
> > > > sys     2m17.171s
> > > =E2=80=A6
> > > > root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/media/
> > > > MODE=3Dreport V=3D1  > 1.2.txt
> > > >
> > > > real    15m0.552s
> > > > user    371m28.976s
> > > > sys     3m32.884s
> > >
> > > Are there any possibilities to increase the measurement granularity f=
or
> > > affected SmPL scripts?
> > > Would you like to compare software run time characteristics in more d=
etail
> > > (in parallel) also according to each SmPL script?
> >
> > Let me know if this is enough:
> >  time make coccicheck M=3Ddrivers/media/ MODE=3Dreport V=3D1 | ts -i > =
1.2.ts.txt
>
> Yes, that's helpful, thanks!
>
> julia



--=20
Ricardo Ribalda
