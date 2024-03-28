Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C58ECD11DF
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yxMED1Vay6vLBmU80r5k8jVxxeJ8OqQzAZ6JugLngIU=;
  b=pxExoRc8waE3g35RpIcnjVcpcV/ttf5bJnj/n9w+gri9Yxhvh+xeVVm/
   l/HlcrxKfbMWL8qXRP/PmJ2SNcEcc4IwcYFXKZBzcaRnIWIIta0XrMMhs
   uviVLqPRbcvE2Xmz7l3SzF01EX/io5BQfdycwV16m/BLcahl+TSPBmmq1
   4=;
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
X-IronPort-AV: E=Sophos;i="6.07,161,1708383600"; 
   d="scan'208";a="158884535"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 11:00:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 36AE1E0AF6; Thu, 28 Mar 2024 11:00:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E17FE0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 11:00:19 +0100 (CET)
IronPort-SDR: 66053fb2_9VHhyWFaOoX+/NEohNj4Rn5rV3KFSNOHbtjFWUXgcTeZQ3v
 kxG8fSMQQvQNkk05Kd3z3JwuZ4k52n4EE5hI8OA==
X-IPAS-Result: =?us-ascii?q?A0GQAwAVPwVmfyraVdFaHgEBCxIMQIFEC4I5gVEzBAtIh?=
 =?us-ascii?q?FaPRYIiA4ETimCSFBSBLD4PAQMBDUQEAQEDBIR/AogFAh4HAQQxCA4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBIhkHDg4phW0NgmcBgR5hA?=
 =?us-ascii?q?gUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLFwBA?=
 =?us-ascii?q?QEBAgESER0BGx0BAwwGBQsNAgImAgIhAREBBQEcBhMihQkBAw4jA6RtgQVCi?=
 =?us-ascii?q?kF6gRUFAhaBAYILBq9dChkoDWwDgV4CBxSBBi6EYCWDBR0BgVaHYnongWREg?=
 =?us-ascii?q?RU1gj04PoQJOhWDRoJoBIVJg2OcLCYIAQYXAwcHBwQFBAkTBgUFAkMJCAUKE?=
 =?us-ascii?q?gMEAwQGAQIFAwUTAgIEEAUCAQEVARoBAwgECgIHAQIVAwEBAQgBAwQNAgECA?=
 =?us-ascii?q?wMBAQEBBQICAQIJAgIDBQQEAQwDAwIJAQQBAwQBCwIBAwQCAgICAQICAwICB?=
 =?us-ascii?q?gIDAgQBAwMDAwECAQMBAQoDAwIIAwMFAQIDAgICBAICAgICAwYEBQIBAgMCB?=
 =?us-ascii?q?gYDAQMCBQIDBQEBBAgGAQMCAwIHCwIBBgICAQQCEwEEAQECAwUCAgYDAwMCA?=
 =?us-ascii?q?wICBgUIAwIBAQIBBAMBAgEBFwICDAcDAQUCAgMDBwEEAQEDBwEDAwICDgIKB?=
 =?us-ascii?q?QUCBwMCHAICAg8BAgECAQMLAwcCAgECEAICAQIKBwMFBQEFAQQCAQIGAQgCA?=
 =?us-ascii?q?hIFBgYBAQQCCwMCAQECAgILAgUFAwMEAg8HBQIBAgQCAQEDEAgHAQ8GAgMEA?=
 =?us-ascii?q?gIFAgECCwQSAhABBAICAgUBBQIBAQIDBQYCAQMIAgIGAwcBAgUCBQEEBwEHB?=
 =?us-ascii?q?AIMAgkBAQECAQIDAwIDBAIBAwMEEQEMAxsCAQIECwEBBQQCBgIDCAMDGgMIA?=
 =?us-ascii?q?wIBAgMBBQECAQQFBAcDAgMDAwMDAwMIBAEKAwMDAQQBBwMKAQIPCwYBAggFC?=
 =?us-ascii?q?BAEAQQCAgQHAgMEAwMCAgIDAxIBAwMDAgEDAQIFAg8GBwIkAwICAgcDBAUCA?=
 =?us-ascii?q?gIIAgMCBAMCDQMCAwEFAwwFAQYEAgIECgMCAQUDFwkEAgkRBgICDQIMBgUBB?=
 =?us-ascii?q?AMCAQMDAwIEAgIDAQICAgICAwECCgIBBwIFAwUCAgMCAQEBAQICBAMBDgcCA?=
 =?us-ascii?q?wUFAgEFCQMDAgIEAwECAgMCAgIDAQQFFAMEAgUKAwgCAgcCDgMBBQIBAQICA?=
 =?us-ascii?q?gIBAQICAwgCEgQCAQIDAgIIAgIHAQECCgkDAQEEBAQDBgICBQQNAwgFAQECA?=
 =?us-ascii?q?gQBCgIJDwUCAgMDAgMBAQECCgMJAQUCAgEDAgIEBAcBBgMFAwMEBAIDAwIMA?=
 =?us-ascii?q?QUBBQEFAQUEAgYBFAIUAgILBQYDBg4DCwQEAQICBQQGDAkEAgICBgECEQMBA?=
 =?us-ascii?q?gEHAQMDAgoBBAECCwgBBQgCDAQCAQQCAwYQAggFBgUCAgEBAgICAQgGDwMGB?=
 =?us-ascii?q?wIDAgYDBQUDAwICAgcEBAIBAgICARMGBAQCAwIDBAEFBAQDAhcIDQIFBwEJC?=
 =?us-ascii?q?wgMAQQGAgQCBAcDCAUFBAIDBAQRBwsDAgMEAgIGAxECAwQCCgIEBAcCAwEED?=
 =?us-ascii?q?QYEBAoCCwMHAQEBAQUDAwkHBgIDAwUEAwYCBQMDAwIDAg0CAgIBCQEBAQIUA?=
 =?us-ascii?q?gMOAgQCAQIFBQwEEwICAwIGCAICAgcDAwQCAwYLAgEQAwICAgIFAwQCAhQDC?=
 =?us-ascii?q?QQCBAYCBAEGAwMCBAYFCgQCAgUCAQECCgIBDwoEAwQDBQMHCQIFBQMCBAICB?=
 =?us-ascii?q?wkBAQICAgMDAwMCAwICAwMCBwMDAwcDBQMEAgMGBQcDBQUDAgICFAEGAgUKB?=
 =?us-ascii?q?gMHBgsFBQcCBgIECAMFAgIDAwMDAgYKCAMDAwIBBgICAwMBAggDDwYCAgMFB?=
 =?us-ascii?q?gMDAwMGCAMDAgYDAwIDAgMCAwMBAwIDAgIDAgICCAICAwIFBAUCAgMEAggaA?=
 =?us-ascii?q?gICAgMDCAMDCgQCAgQBBAIEAgQCBgMEAQICAQcCBQMCAwIHAgIEAgICAgMCA?=
 =?us-ascii?q?gYIAgIDAwMCAgIBCQIFAQEGAgQDAgMFAwkDBAUCAwgBAQICBwcDAwQDAQIBB?=
 =?us-ascii?q?QQCAgYFAgMCAgQEBAUDAgMCBgYCAQMCCgYDBQMDAwMCAwMCAwMCBQIIAgIEB?=
 =?us-ascii?q?AUEAgcEAgQDAwMBCgIGAwICBQEBAgIFAwIEBAcCAgIHDwMCBwUCBQcCCAEGB?=
 =?us-ascii?q?QICAwIIAQICBgEGAgQBAgINAQECAgIDAQMDAwcCBAMCCAIDAxEBAwMJBgUEB?=
 =?us-ascii?q?QQDCQQPAgQBCAMBAQQIAgQDAgwCAiECBQsEBAESCggDAQEDAQECAgICAg4DA?=
 =?us-ascii?q?gMCAgMKAgMCCgMGBAICBgEBAQQGAQQCAQIJBA4JBQgIAQMCAQQGAQISBQ8CC?=
 =?us-ascii?q?QMDBgQCEAYKBQMCAwUBAgUVAwgDAgkCBAwDBQgCAwMCBgMGAgYBBgMHCwEBC?=
 =?us-ascii?q?QgFAwMDAhYBAgIQCAYGDwcCAwMEBA8DEgIGDgMDAgMCAQICAgMFBAUCBwMDD?=
 =?us-ascii?q?QUCAgcDAggFAwcJBAoCCAUBAgYDAgICAgUNAQEBAQIDAgUDBwkICAQFBAMBA?=
 =?us-ascii?q?QYGDCgCAgMEEAMJAwYLAQUFAQMCAgIOAwUDAgMGBgEQBAEFBAkCBQcGBQIBB?=
 =?us-ascii?q?QECAUMdAgkDIw8DCwkIEz0BCwcyBDQBFBQHJwEBBSEKVqZwgSkxFoEWPXWSQ?=
 =?us-ascii?q?p1xlQEHhBahQzOqMJhiqHIRIxKBMQI2gVwzGiNQMYI2TwMZD44gDBaDWKM+R?=
 =?us-ascii?q?TI7AgcBCgEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vRAI5TzOahdFH1s5Q==
IronPort-HdrOrdr: A9a23:yxDDqKqtXzZ3nZWCDrSPoLcaV5oeeYIsimQD101hICG9vPbo7v
 xG+85rriMc6QxhIE3I/OrrBEDuewK4yXcY2/hyAV7mZniEhILKFuBfBOnZslnd8kTFn4Y36U
 4jSchD4bbLfD9HZKjBkW+F+hUbrOVvMprEuQ4T9RhQpMhRBZ1d0w==
X-Talos-CUID: 9a23:+U5pu20ZshbsWY4noTsANbxfEewOcGz6y3zpEgyVAmRGVbuEFF2AwfYx
X-Talos-MUID: 9a23:olZWAQYjfXp1puBThzP9mThECYBTzJu8UHoOg84DtMu6HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,161,1708383600"; 
   d="scan'208";a="158884486"
X-MGA-submission: =?us-ascii?q?MDEbtU1267fGdefBUrrZRUuJhMp1lMjnvGDR2c?=
 =?us-ascii?q?he+1EGUC6zrOzIyMl6qS2WZURUyGS6Te6adlLp3+Rfl53JczZfhYc+6b?=
 =?us-ascii?q?ZAFsW5b73Zl1csdQzkKZyZtGwvBt3PNDiMfAlLqwCd7xttCo1C2C1bUf?=
 =?us-ascii?q?60geGlOhVnruO0UZCEl5pChQ=3D=3D?=
Received: from mail-ej1-f42.google.com ([209.85.218.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 11:00:18 +0100
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44665605f3so81508366b.2;
        Thu, 28 Mar 2024 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711620018; x=1712224818; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxMED1Vay6vLBmU80r5k8jVxxeJ8OqQzAZ6JugLngIU=;
        b=Cgi2kaCaEY00VM76Onjw/Gao9sQqyhqBpLkvHXed1Tjd9uM/K5GCc77qFf4pqBmQyf
         1PCSVwXI/b36yDDX/aRGP1MJgOSIhYU9b5pCH9Rt+4G5/v4IBrzMilcMqrz/1tyjpUtf
         pHDzGVgqlTrS/KNYUF/3SrB3kgNL12yPiwTCMIiDz/gIEVVnNOpirJ5CzmMIdMklix/d
         r4iEftGQS2W98kMwRxE6b4gDvhGtBT2fcWd0O2A3or51/R8K3i1FCdQgJv0ic8BnSed3
         K0VcxXQ/cUi4eth9UykADNOJNtwMkACOToeKJRf0f/Jktp0awJXe0E95lZVEQQhmslSU
         Xzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620018; x=1712224818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxMED1Vay6vLBmU80r5k8jVxxeJ8OqQzAZ6JugLngIU=;
        b=wt+MCz1A9Nkdy7jiXoIfDvndEd9X5bfJPxMuaokH27IZV5jEklthskTikMLHRxQWxI
         A0bPwtnBzDToTrlwGPtkaz/0WClb3Rz7IycOugs0CtWtMKIN9L2E5scOQstpV1dDI/zc
         RLonGRrn6/RH/xIbKLF8sWvl+DVHRsMhykoCQKjKXewKvV6Zyubp5dFYbZMD53f/Lobn
         +Vgz/fdOjKzbz8PhgAeWPQFT95RKGinbFYFHvjX6A/VDpENUhAGNPnZw5mzxZHq4D0T3
         9mbC6yGk5wFhOgOSNlD5YEhUtJPsa74fPwNyvSFjKX+/wwpo/klNvQM5kHq0wIHwaJGH
         dbYA==
X-Gm-Message-State: AOJu0YyTEmhvwNdvF0JKXAWSM9BFTTP4pOhPOfpS0qw2DIGsrN3Mzg/T
	M8CHy9XVltKgZ3gL46nVcuC60VrnKzp7F2yck2bBrYlF7jjJ5wxPd/loZnyy2vvk5gJB5cNvU2K
	wmiLdocqT877xniv/lbuG8c1Bh65wT7EJD7w=
X-Google-Smtp-Source: AGHT+IHDOGY9qEvLYOoAdYYzM01x+sF3y5N3oe4T7c+yWOyYhtNny7BZ+ggpxDPA++em3fFTLtzrrN1t1O/gGQ7tZXo=
X-Received: by 2002:a17:906:b7c8:b0:a46:f279:8f77 with SMTP id
 fy8-20020a170906b7c800b00a46f2798f77mr1330083ejb.43.1711620017335; Thu, 28
 Mar 2024 03:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+MoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow@mail.gmail.com>
 <ffb475dd-496c-2ae-6329-86d6163b2bb6@inria.fr>
In-Reply-To: <ffb475dd-496c-2ae-6329-86d6163b2bb6@inria.fr>
From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Thu, 28 Mar 2024 11:00:05 +0100
Message-ID: <CA+MoWDoScx-d3bj+niNbPYjrujb+pO0fyrhkSDZHxkcntDLimg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Returning statically allocated nested structs
Reply-To: Peter Senna Tschudin <peter.senna@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1625
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/CA%2BMoWDoScx-d3bj%2BniNbPYjrujb%2BpO0fyrhkSDZHxkcntDLimg%40mail.gmail.com>

Hi Julia,

Thanks for the reply!

On Thu, Mar 28, 2024 at 10:08=E2=80=AFAM Julia Lawall <julia.lawall@inria.f=
r> wrote:
>
>
>
> On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:
>
> > Dear list,
> >
> > I am trying to come up with a semantic patch to detect uses of nested
> > structs, more specifically:
> >  - the nested struct is statically allocated
> >  - the statically allocated nested struct is returned by a function.
> >
> > Here is an example:
> >
> > struct inner {
> >
> >     /* some inner struct stuff*/
> >
> > } inner;
> >
> > struct outer  {
> >
> >     /* some outer struct stuff*/
> >
> >     struct inner i; // The kind of nesting I care about
> >     struct inner is[SOME_MAGIC_NUMBER]; // The kind of nesting I care a=
bout too
> >
> >     struct inner *ip; // Nah, this is boring. I don't care about boring
> > } outer;
> >
> > void sillyfu() {
Argh, that was a typo!

struct outer sillyfu() {
> >     struct outer ou =3D { }; // initialization does not matter.
> >     struct outer *oup =3D NULL; // Nah, this is boring. I don't care ab=
out boring
> >
> >     /* some serious silly stuff */
> >
> >     return ou;
>
> Not sure to understand.  The return type of the function is void.  Was
> that a typo?
>
> Returning a structure in general seems like something to be concerned
> about.  Does it matter that another structure is nested inside?

I am not sure if it matters, but it may. The compiler seems to be the
arbiter who decides what happens when returning a local struct. It may
work, it may not. One theory for not working is variable scope.
Returning a local struct may not work due to the local nature of the
struct. In this case the compiler would free the memory used by the
struct when the function returns, causing undefined behavior. In this
scenario the nested struct simply adds another layer of the same
problem.

Another theory says that the compiler may decide based on the struct
size. The compiler may tolerate returning certain struct sizes, but
not others.





>
> julia
>
> > }
> >
> > I remember that there are some details for detecting structs
> > effectively, and as I am investigating a code base with over 1.2M
> > lines of code, I would like to ask for pointers of where to start.
> >
> > Thank you!
> >
> > Peter
> >
> > --
> >                          Peter
> >



--=20
                         Peter
