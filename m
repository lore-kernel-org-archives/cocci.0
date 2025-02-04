Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDB2C02197
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ipGjNlPJw2TeYUpHxuqhVzFZ5Pfm4mUEIDC4ZSOWEBw=;
  b=pn8SWBaB5qdQVVVfbH1JAKXeuaxMQsD4rFBnMV0T84X6QHssaSxdxeE0
   5jBgP1niWHEsi7eORMSjoKZjYxAJrSlyssCJ0Z2FgH1LY430u3LaMmPsk
   BbgeHQxNS8ShrNKrUCI6C1VOP9ZbqgWqAPdp0JinCalOdo9blLaeh2XGW
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
   d="scan'208";a="206516031"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 13:50:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A0B4E0D1D; Tue,  4 Feb 2025 13:50:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2640DE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 13:50:00 +0100 (CET)
IronPort-SDR: 67a20cf7_DfSbFZtGpmNrtQxyr2IxPyaaA5wiV65jjqMgLtNVzyhJ4GZ
 4fhCxxNrZtlTW48reRxzSrO2wgjjb6fkU0afalA==
X-IPAS-Result: =?us-ascii?q?A0FEAAChC6JnfDCnVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDfVozBFOEVoh8hlOBfwUgnhaBfg8BAwEMAT0HBAEBAwSCDIJ0A?=
 =?us-ascii?q?op9Ah4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBI?=
 =?us-ascii?q?hkHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBAgESER0BATcBD?=
 =?us-ascii?q?wsLDQICJgICIRIBBQEcBhMIGoJhgjADDiMDEaN2gQVCikR6gTKBAYIMAQEG2?=
 =?us-ascii?q?yYiV4FlAwYJAQqBBi4BiE0BgWyDfgGDfXonG4INgRU1gkQxPoJhAQMYgUYVg?=
 =?us-ascii?q?0aCaYIzSoEng0CGZocTlEkmCR0DBwcODR5JDwUcA1ksAVUTFwsHBWFISAECA?=
 =?us-ascii?q?YEQI4EmBTUKNzqCDWlJOgINAjWCHnyCK4IhgjuCGIIrRhkvAwMDA4M0hV6CE?=
 =?us-ascii?q?oFfAwMWEAGBc4EyehyDSB1AAwtiCz03FBtMni8BPIVKCXyBQwLGQYQlhG+HK?=
 =?us-ascii?q?ZVIM4QEk0CTD5h8gliLLJsAAgoHBhEjgUsJKoFcMxoIKAhsBoIwTwMZD44hi?=
 =?us-ascii?q?Q3DV0I1PAIHAQoBAQMJkDOBSwEB?=
IronPort-PHdr: A9a23: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
 1g9jQ4sOYzFGx/n400wI1vXoW03ikZjwL3Y
IronPort-Data: A9a23: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
 b8biodDD616GpDehEfxh+8UvA==
IronPort-HdrOrdr: A9a23:UV111a4vg62wOUI3cwPXwPHXdLJyesId70hD6qkQc3ZomwKj5q
 STdZUgtCMc7Qx7ZJhOo6HjBEDtexzhHNtOkOws1MmZMjUOyVHJEGgK1+KLrwEIWReOkNK1vp
 0QEJSWZueAamSSi/yW3ODBKadY/OW6
X-Talos-CUID: 9a23:dkR0W2DiUQagG0H6Ey5IzW8RJfocS1vm4k/gO3OZNz9GFbLAHA==
X-Talos-MUID: 9a23:EwUjKgQlqbUU+3XjRXTspBtBC/h6xJ+PFUQHob4rmJetNW9/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206516013"
X-MGA-submission: =?us-ascii?q?MDGaYda7/nNSiWF/kEAi60bUSKkBXXm80ZMBMg?=
 =?us-ascii?q?AnZoUhoCiezW/ZM+Raw1OeWHFiH4i2d30sJ0lV3VCZTgq19czjb8JYPt?=
 =?us-ascii?q?ateY61tMwLdH8Gfsnip9dbPO6Dtdw/921VGSNy+xdUiMV1lVOLn/hWcr?=
 =?us-ascii?q?e+GjATtZxloVKkuc9OspoqEg=3D=3D?=
Received: from mail-lf1-f48.google.com ([209.85.167.48])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:49:59 +0100
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-540215984f0so6084934e87.1
        for <cocci@inria.fr>; Tue, 04 Feb 2025 04:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738673399; x=1739278199; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipGjNlPJw2TeYUpHxuqhVzFZ5Pfm4mUEIDC4ZSOWEBw=;
        b=n/mVtINNbFWc8GrBUyA3D2Of2dOxqjY4RpfZWsOkXK38BfXTTc5wRJ2Uo4wkmHJum5
         EoAB40D8b0CtWZWb/SwAl1MBDEv20zvJC2JVBpmit/1eTnEH5W25vX5LQw1df3XjsA4/
         HRdRn1eD4LZsWTj5ROaQoo/hZwo9Rm7+vnxP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673399; x=1739278199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipGjNlPJw2TeYUpHxuqhVzFZ5Pfm4mUEIDC4ZSOWEBw=;
        b=Vo2xkMKbcPe5SqkPjWZ7gZPGYdkHG7JrhC0tBW4dS2jkah6orIZZp0SO6nev7usQdw
         CFXBJ35AiDMLqYa0baA89IPYmY8lq6iFNqnfzrxTYF5fg/8BTVfyXv5pxCRvJaCWXHE9
         RXRdGs4juiqiNLVeEC7/MujYsO91st2QSjhUVcvB8U5j64XBRSRn3iskFypgjLFr4S3J
         3ll1lPAFhQaXGxzgVRlEEoZ9/82xCEnPwdtFF54m8elD8SOAVR92ysfd5RnGlyj9mJgS
         P4vv+KydhtgsZ71J40NAYXofYCbFMiItieoL/9XmdeTPrZ+f41YXSjkO+v1e9VQZ0+NF
         K3oA==
X-Forwarded-Encrypted: i=1; AJvYcCWUeHnAazq/Ln3O5c0xSdsYNwicmI6XaNztpGRWBO+zGyHujS/eZ7hR3aq44bhXzRZVMbnZcA==@inria.fr
X-Gm-Message-State: AOJu0Yxz99J747Z6svZM8fJnJGP/haIAajUTVrM0dJx2YESx1LbIeaAH
	m3ZwgvsDYRWSFr28WBwhFEVD21H0cE3QpD3HeRye59GFSNKJG1yvzQ8PmEFpcQNfk/2B6M7JoEw
	=
X-Gm-Gg: ASbGnct+gyWWxSISU6lwwCYaX5fuP1FKYxstZhmFCbIXIX+1EiLYYJ/C/mybbldtEuP
	e2AEtAEc/+cjWJO+Cd77uwgc9iq5cBrSZfbWs7dfjeZDI+jdoj0Sf9fo2DZaa+VfHLoaQC4dL+p
	TEcoWI1WF2bkiHdHmW8DMMKDbuqp17nuuQn0uX1gCNvMxDdHT+/nMRmnUJeTF1aCA72B84llmDZ
	uz53web9qxMg8ZcsERFcvuU51hDbHB42o22zJEf/1Emv2tv3MTIQlbNwIyjIyhca/VCnkoT6Dl4
	IPpOQJmXTpJ8kW3V/htRjbJdmOFGiyB/SbsrIbDfF2B6i3Td5r1oHA==
X-Google-Smtp-Source: AGHT+IHIl8Kt6oLo0jMLdmLlYP3rYW7V9TnAmwmRDHslDBF24uExG86nO9NbNB9REdH+YT3TeXcsrw==
X-Received: by 2002:ac2:4943:0:b0:543:bb21:4255 with SMTP id 2adb3069b0e04-543e4c417e6mr7747942e87.49.1738673398758;
        Tue, 04 Feb 2025 04:49:58 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb0a74sm1567997e87.109.2025.02.04.04.49.57
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:49:58 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401c52000fso5348233e87.2
        for <cocci@inria.fr>; Tue, 04 Feb 2025 04:49:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQJjLk1RoeBn4PDCpnmMvfecr1Yw/2Nft0uR5J5XyPvGAOxSA+A5qJ4e5B5Qk9i9C/Wjiqmw==@inria.fr
X-Received: by 2002:a05:6512:3ca4:b0:543:e469:cd42 with SMTP id
 2adb3069b0e04-543e4c37a21mr8981168e87.32.1738673395192; Tue, 04 Feb 2025
 04:49:55 -0800 (PST)
MIME-Version: 1.0
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de> <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr> <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
 <1c92f6ab-9992-1f5-d911-f8cd52991c66@inria.fr>
In-Reply-To: <1c92f6ab-9992-1f5-d911-f8cd52991c66@inria.fr>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 4 Feb 2025 13:49:42 +0100
X-Gmail-Original-Message-ID: <CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ@mail.gmail.com>
X-Gm-Features: AWEUYZn7pmPoywsEDzcuuXSQWLuHVQMcbLw9jVBjsrVDq5txFq5DAgPH7nhzbCw
Message-ID: <CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 2338
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ%40mail.gmail.com>

On Tue, 4 Feb 2025 at 13:46, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 4 Feb 2025, Ricardo Ribalda wrote:
>
> > Hi Julia
> >
> > Just FYI, In media-ci tried again with Debian's 1.3.0 and it is better
> > than  1.2 but still much slower than 1.1.1.
>
> Thanks for the update.  Do you have a number?

5m35s vs 20m56s

https://gitlab.freedesktop.org/linux-media/users/ci/-/pipelines/1357625/tes=
t_report?job_name=3Dstatic-upstream
https://gitlab.freedesktop.org/linux-media/users/ci/-/jobs/70476750


https://gitlab.freedesktop.org/linux-media/users/ci/-/pipelines/1357095/tes=
t_report?job_name=3Dstatic-upstream
https://gitlab.freedesktop.org/linux-media/users/ci/-/jobs/70427995

>
> julia
>
> >
> > Regards!
> >
> > On Mon, 5 Aug 2024 at 14:12, Julia Lawall <julia.lawall@inria.fr> wrote=
:
> > >
> > >
> > >
> > > On Mon, 5 Aug 2024, Ricardo Ribalda wrote:
> > >
> > > > On Mon, 5 Aug 2024 at 13:27, Markus Elfring <Markus.Elfring@web.de>=
 wrote:
> > > > >
> > > > > > It seems to be related to the cocci version, and not the kernel=
 version.
> > > > > >
> > > > > > Debian updated it recently from 1.1.1 to 1.2.
> > > > >
> > > > > Thanks for such background information.
> > > > >
> > > > >
> > > > > > These are my results for the same kernel code:
> > > > > >
> > > > > >
> > > > > > root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/me=
dia/
> > > > > > MODE=3Dreport V=3D1  > 1.1.1.txt
> > > > > >
> > > > > > real    1m59.021s
> > > > > > user    53m53.038s
> > > > > > sys     2m17.171s
> > > > > =E2=80=A6
> > > > > > root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/me=
dia/
> > > > > > MODE=3Dreport V=3D1  > 1.2.txt
> > > > > >
> > > > > > real    15m0.552s
> > > > > > user    371m28.976s
> > > > > > sys     3m32.884s
> > > > >
> > > > > Are there any possibilities to increase the measurement granulari=
ty for
> > > > > affected SmPL scripts?
> > > > > Would you like to compare software run time characteristics in mo=
re detail
> > > > > (in parallel) also according to each SmPL script?
> > > >
> > > > Let me know if this is enough:
> > > >  time make coccicheck M=3Ddrivers/media/ MODE=3Dreport V=3D1 | ts -=
i > 1.2.ts.txt
> > >
> > > Yes, that's helpful, thanks!
> > >
> > > julia
> >
> >
> >
> > --
> > Ricardo Ribalda
> >



--=20
Ricardo Ribalda
