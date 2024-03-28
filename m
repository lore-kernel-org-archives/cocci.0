Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C03C54E67
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zkc85lpOJkjgUAOhpxmEkRcQd8km/4KUyfnPq7yITiI=;
  b=HsOsvLTRWn6dTiUH/j5ij2tz8dN0zSk6C1IvaDDPvlMN7Nx0SWnr1SW+
   XSLGe4SmmZ5FYGYwTRLIxnv2lisBye3b9QcdufYxsOgaB6PjAz8wgTEW5
   kT1QWwt/KKxZe+fTTTt1b3FB7EZnFbKhVAnyVJSjO0LhN4W7pXEVtOapk
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
   d="scan'208";a="158926955"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 14:03:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB1A9E0AF6; Thu, 28 Mar 2024 14:03:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E1A19E0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 14:03:23 +0100 (CET)
IronPort-SDR: 66056a9c_vS0I4/G5+Z3nHHzm8CDSGRa1G/+UDiN2OFeRK83zKV2A4Il
 rXTJ9BBENymzKy09Yuml95sIBbwUo1eofZpjFKQ==
X-IPAS-Result: =?us-ascii?q?A0GVBABUaQVmfzPQVdFagQmDYCiBUTMEC0iEVo9FgiIDg?=
 =?us-ascii?q?ROKYJIogSw+DwEDAQ1EBAEBAwSEfwKIBQIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBCAEBBQEBAQIBAQIEBgECEAEBIhkHDg4phW0NgmcBgR5hAgUDOwEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLF0BAQEDEhEdARsdA?=
 =?us-ascii?q?QMMBgULDQICJgICIQERAQUBHAYTGweFCQEDMQOlGIEFQos7gRUFAhaBAYILB?=
 =?us-ascii?q?q9dChkoDWwDgV4CBxSBBi6EYCWDBR0BgVaHYnongWREgRU1gj04PoQJOhWDR?=
 =?us-ascii?q?oJoBIVJoA8mCAEGFwMHBwcEBQQJEwYFBQJDCQgFChIDBAMEBgECBQMFEwICB?=
 =?us-ascii?q?BAFAgEBFQEaAQMIBAoCBwECFQMBAQEIAQMEDQIBAgMDAQEBAQUCAgECCQICA?=
 =?us-ascii?q?wUEBAEMAwMCCQEEAQMEAQsCAQMEAgICAgECAgMCAgYCAwIEAQMDAwMBAgEDA?=
 =?us-ascii?q?QEKAwMCCAMDBQECAwICAgQCAgICAgMGBAUCAQIDAgYGAwEDAgUCAwUBAQQIB?=
 =?us-ascii?q?gEDAgMCBwsCAQYCAgEEAhMBBAEBAgMFAgIGAwMDAgMCAgYFCAMCAQECAQQDA?=
 =?us-ascii?q?QIBARcCAgwHAwEFAgIDAwcBBAEBAwcBAwMCAg4CCgUFAgcDAhwCAgIPAQIBA?=
 =?us-ascii?q?gEDCwMHAgIBAhACAgECCgcDBQUBBQEEAgECBgEIAgISBQYGAQEEAgsDAgEBA?=
 =?us-ascii?q?gICCwIFBQMDBAIPBwUCAQIEAgEBAxAIBwEPBgIDBAICBQIBAgsEEgIQAQQCA?=
 =?us-ascii?q?gIFAQUCAQECAwUGAgEDCAICBgMHAQIFAgUBBAcBBwQCDAIJAQEBAgECAwMCA?=
 =?us-ascii?q?wQCAQMDBBEBDAMbAgECBAsBAQUEAgYCAwgDAxoDCAMCAQIDAQUBAgEEBQQHA?=
 =?us-ascii?q?wIDAwMDAwMDCAQBCgMDAwEEAQcDCgECDwsGAQIIBQgQBAEEAgIEBwIDBAMDA?=
 =?us-ascii?q?gICAwMSAQMDAwIBAwECBQIPBgcCJAMCAgIHAwQFAgICCAIDAgQDAg0DAgMBB?=
 =?us-ascii?q?QMMBQEGBAICBAoDAgEFAxcJBAIJEQYCAg0CDAYFAQQDAgEDAwMCBAICAwECA?=
 =?us-ascii?q?gICAgMBAgoCAQcCBQMFAgIDAgEBAQECAgQDAQ4HAgMFBQIBBQkDAwICBAMBA?=
 =?us-ascii?q?gIDAgICAwEEBRQDBAIFCgMIAgIHAg4DAQUCAQECAgICAQECAgMIAhIEAgECA?=
 =?us-ascii?q?wICCAICBwEBAgoJAwEBBAQEAwYCAgUEDQMIBQEBAgIEAQoCCQ8FAgIDAwIDA?=
 =?us-ascii?q?QEBAgoDCQEFAgIBAwICBAQHAQYDBQMDBAQCAwMCDAEFAQUBBQEFBAIGARQCF?=
 =?us-ascii?q?AICCwUGAwYOAwsEBAECAgUEBgwJBAICAgYBAhEDAQIBBwEDAwIKAQQBAgsIA?=
 =?us-ascii?q?QUIAgwEAgEEAgMGEAIIBQYFAgIBAQICAgEIBg8DBgcCAwIGAwUFAwMCAgIHB?=
 =?us-ascii?q?AQCAQICAgETBgQEAgMCAwQBBQQEAwIXCA0CBQcBCQsIDAEEBgIEAgQHAwgFB?=
 =?us-ascii?q?QQCAwQEEQcLAwIDBAICBgMRAgMEAgoCBAQHAgMBBA0GBAQKAgsDBwEBAQEFA?=
 =?us-ascii?q?wMJBwYCAwMFBAMGAgUDAwMCAwINAgICAQkBAQECFAIDDgIEAgECBQUMBBMCA?=
 =?us-ascii?q?gMCBggCAgIHAwMEAgMGCwIBEAMCAgICBQMEAgIUAwkEAgQGAgQBBgMDAgQGB?=
 =?us-ascii?q?QoEAgIFAgEBAgoCAQ8KBAMEAwUDBwkCBQUDAgQCAgcJAQECAgIDAwMDAgMCA?=
 =?us-ascii?q?gMDAgcDAwMHAwUDBAIDBgUHAwUFAwICAhQBBgIFCgYDBwYLBQUHAgYCBAgDB?=
 =?us-ascii?q?QICAwMDAwIGCggDAwMCAQYCAgMDAQIIAw8GAgIDBQYDAwMDBggDAwIGAwMCA?=
 =?us-ascii?q?wIDAgMDAQMCAwICAwICAggCAgMCBQQFAgIDBAIIGgICAgIDAwgDAwoEAgIEA?=
 =?us-ascii?q?QQCBAIEAgYDBAECAgEHAgUDAgMCBwICBAICAgIDAgIGCAICAwMDAgICAQkCB?=
 =?us-ascii?q?QEBBgIEAwIDBQMJAwQFAgMIAQECAgcHAwMEAwECAQUEAgIGBQIDAgIEBAQFA?=
 =?us-ascii?q?wIDAgYGAgEDAgoGAwUDAwMDAgMDAgMDAgUCCAICBAQFBAIHBAIEAwMDAQoCB?=
 =?us-ascii?q?gMCAgUBAQICBQMCBAQHAgICBw8DAgcFAgUHAggBBgUCAgMCCAECAgYBBgIEA?=
 =?us-ascii?q?QICDQEBAgICAwEDAwMHAgQDAggCAwMRAQMDCQYFBAUEAwkEDwIEAQgDAQEEC?=
 =?us-ascii?q?AIEAwIMAgIhAgULBAQBEgoIAwEBAwEBAgICAgIOAwIDAgIDCgIDAgoDBgQCA?=
 =?us-ascii?q?gYBAQEEBgEEAgECCQQOCQUICAEDAgEEBgECEgUPAgkDAwYEAhAGCgUDAgMFA?=
 =?us-ascii?q?QIFFQMIAwIJAgQMAwUIAgMDAgYDBgIGAQYDBwsBAQkIBQMDAwIWAQICEAgGB?=
 =?us-ascii?q?g8HAgMDBAQPAxICBg4DAwIDAgECAgIDBQQFAgcDAw0FAgIHAwIIBQMHCQQKA?=
 =?us-ascii?q?ggFAQIGAwICAgIFDQEBAQECAwIFAwcJCAgEBQQDAQEGBgwoAgIDBBADCQMGC?=
 =?us-ascii?q?wEFBQEDAgICDgMFAwIDBgYBEAQBBQQJAgUHBgUCAQUBAgFDHQIJAyMPAwsJC?=
 =?us-ascii?q?BM9AQsHMgQ0ARQUBycBAQUhClamcIEpR4EWGSR1xTQHhBahQzOqMJhiqHIRI?=
 =?us-ascii?q?xKBRiOBXDMaI1AxgjZPAxkPjiwWgQwBDoI9oz5FMjsCBwEKAQEDCYkigUgBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QVAL5Tz6Ipp5ayRNHCrJd01xq9M
IronPort-HdrOrdr: A9a23:OXov9Kjhypi04SihB8z34xxYMXBQXu8ji2hC6mlwRA09TyVXrb
 HWoB19726OtN9xYgBZpTnkAsO9qBznhPtICOUqTNWftUzdyQiVxeJZjLcKoQeQfxEWn9Q1vc
 xdmupFaOEYZmIK6voSjjPIderIA+PqzElrv4rjJrtWIj2CopsP0ztE
X-Talos-CUID: 9a23:l4f0P2yYNrgNfCeex2GiBgU6Oe98W3aFl03xGEi4OH1la6LKWEe5rfY=
X-Talos-MUID: 9a23:Amqn1wRIzqlcIUOrRXT9325bKOAvuJ2OM0EDurs/n82aCTxvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,161,1708383600"; 
   d="scan'208";a="158926931"
X-MGA-submission: =?us-ascii?q?MDFcdHyZ/g0Kn5NRLUbiJCfGWbqDUPc6osmUAr?=
 =?us-ascii?q?rqvkS3E+9R7Azl8IXwAyoQxXVoTP0HtXreceOnQ5uhvngquouJX3+3aw?=
 =?us-ascii?q?tAZtiVDOAqR0LDhfVPSxYPRMNG7pWivBxF3KGVZaTKr10/hbOUtzU6ip?=
 =?us-ascii?q?/RPxxyTTphqX/GSqdNDDbY9g=3D=3D?=
Received: from mail-ed1-f51.google.com ([209.85.208.51])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:03:24 +0100
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso1169964a12.2;
        Thu, 28 Mar 2024 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711631002; x=1712235802; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkc85lpOJkjgUAOhpxmEkRcQd8km/4KUyfnPq7yITiI=;
        b=UlU4I1cbXCn0/5xQO7iXvYW1n5V/mhqyRech4+4wQNE32RM975uYPNzlJ0KbX49DcB
         7RZpcDnYxFWWAL7j+HF+I2UtWJ4NkS8qg1sIg3ZuTIxtWp6A7odZa4ZP6MeLY1wqaex0
         sFzaSCUDxwDBrWuXr/jX+Th1BHu4ariXAKv7l3GrzlRcJtA8/HM3HdtluuQuj1WqnZ0k
         W2Vojs10x0CzXkrhgVTsCKvoSmauwJDFbXB0XgSsw0iTHXVmAngRaSyPmi+cNdJTdony
         O9C3HfXUDXNY4ubCZfjVPH4e2Gc6if7hJgDGk0zAXo5JsJartjvQFhjM6UT1AiPmMD1D
         ps/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711631002; x=1712235802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkc85lpOJkjgUAOhpxmEkRcQd8km/4KUyfnPq7yITiI=;
        b=wcWvMS4cxmA2PgvfhD2AY8Fi6j3T4d9bp74aRMb7m5TCeHn0/zc+VbaYnJvOhQcbK9
         wT0/iMDOcv1KuXMXLSsl300daLYJuNAbmEUu/UsUe2jWOlNfxuX0nbT8l9Bt/Xb8oCcd
         pxmjyJ23zt37Pok+FmyYFqcMzhHSHt+tlFa1jbz7VgBje3jiBrqQG4Clo2P4FwRV4qTe
         FX2aYL8OEH3ikfAJzmsAyBmfxwcaOrk/mlbdAPStK9vIsH/9R96VZyd7dnDkx8PVdlir
         MEcVjxqtuIeCSJxJIpuGaLLCQt87lZ15ahRgofcDp4xkz6BJWCSsCA94qa+IS0TO1C5R
         VjjQ==
X-Gm-Message-State: AOJu0YxBla2yfNtYn9p41bt7O2IIekJYOTmWXaHnAfxBRxTZoAor2Qwq
	IFG/BTb8OKCgEJ4rjdB4z+f6h243fVPdB0m/1KgqAmWYKmxdwkJyp93fTFF/Uh9jOldvGTAIAL5
	8lnn7xwceGWyQP7cGq216mpSxjCoJC8dzE0U=
X-Google-Smtp-Source: AGHT+IHBq/Qn26MGgvtcfSpAItElPXUCFuhy68rjLva7LiOfHA9B+rf8opOOVtsIc8g8ffQ3amjDujHjgrt1nOI0lEA=
X-Received: by 2002:a17:906:fb9b:b0:a47:2036:dbc4 with SMTP id
 lr27-20020a170906fb9b00b00a472036dbc4mr1708744ejb.25.1711631001829; Thu, 28
 Mar 2024 06:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+MoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow@mail.gmail.com>
 <ffb475dd-496c-2ae-6329-86d6163b2bb6@inria.fr> <CA+MoWDoScx-d3bj+niNbPYjrujb+pO0fyrhkSDZHxkcntDLimg@mail.gmail.com>
 <23254a95-222e-494-3f0-508a2790753@inria.fr>
In-Reply-To: <23254a95-222e-494-3f0-508a2790753@inria.fr>
From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Thu, 28 Mar 2024 14:03:09 +0100
Message-ID: <CA+MoWDo-DJKq1jjC7Sr41c3+7G=P_wGsQHJrGaxMNyB+UOsjwg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Returning statically allocated nested structs
Reply-To: Peter Senna Tschudin <peter.senna@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1627
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/CA%2BMoWDo-DJKq1jjC7Sr41c3%2B7G%3DP_wGsQHJrGaxMNyB%2BUOsjwg%40mail.gmail.com>

Thanks Julia,

Your question about nesting inspired me to a simpler solution:

@rule1@
identifier i, s;
position p;
@@
struct i s;
...
return@p s;

@script:python@
p << rule1.p;
s << rule1.s;
@@
cocci.print_main(s, p)

Do I need to worry about calling cocci.print_secs() after the print_main()?

On Thu, Mar 28, 2024 at 11:10=E2=80=AFAM Julia Lawall <julia.lawall@inria.f=
r> wrote:
>
>
>
> On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:
>
> > Hi Julia,
> >
> > Thanks for the reply!
> >
> > On Thu, Mar 28, 2024 at 10:08=E2=80=AFAM Julia Lawall <julia.lawall@inr=
ia.fr> wrote:
> > >
> > >
> > >
> > > On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:
> > >
> > > > Dear list,
> > > >
> > > > I am trying to come up with a semantic patch to detect uses of nest=
ed
> > > > structs, more specifically:
> > > >  - the nested struct is statically allocated
> > > >  - the statically allocated nested struct is returned by a function=
.
> > > >
> > > > Here is an example:
> > > >
> > > > struct inner {
> > > >
> > > >     /* some inner struct stuff*/
> > > >
> > > > } inner;
> > > >
> > > > struct outer  {
> > > >
> > > >     /* some outer struct stuff*/
> > > >
> > > >     struct inner i; // The kind of nesting I care about
> > > >     struct inner is[SOME_MAGIC_NUMBER]; // The kind of nesting I ca=
re about too
> > > >
> > > >     struct inner *ip; // Nah, this is boring. I don't care about bo=
ring
> > > > } outer;
> > > >
> > > > void sillyfu() {
> > Argh, that was a typo!
> >
> > struct outer sillyfu() {
> > > >     struct outer ou =3D { }; // initialization does not matter.
> > > >     struct outer *oup =3D NULL; // Nah, this is boring. I don't car=
e about boring
> > > >
> > > >     /* some serious silly stuff */
> > > >
> > > >     return ou;
> > >
> > > Not sure to understand.  The return type of the function is void.  Wa=
s
> > > that a typo?
> > >
> > > Returning a structure in general seems like something to be concerned
> > > about.  Does it matter that another structure is nested inside?
> >
> > I am not sure if it matters, but it may. The compiler seems to be the
> > arbiter who decides what happens when returning a local struct. It may
> > work, it may not. One theory for not working is variable scope.
> > Returning a local struct may not work due to the local nature of the
> > struct. In this case the compiler would free the memory used by the
> > struct when the function returns, causing undefined behavior. In this
> > scenario the nested struct simply adds another layer of the same
> > problem.
> >
> > Another theory says that the compiler may decide based on the struct
> > size. The compiler may tolerate returning certain struct sizes, but
> > not others.
>
> The following is not tested, but seems like it should be sufficient.
>
> @r@
> identifier i, j, k;
> @@
>
> struct i { ...
>   struct j k;
>   ...
> };
>
> @@
> identifier r.i;
> identifier f,x;
> @@
>
> f(...) {
>   struct i x =3D ...;
>   ...
> * return x;
> }
>
> julia



--=20
                         Peter
