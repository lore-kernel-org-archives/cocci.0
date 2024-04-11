Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43597C001CC
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2024 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PLSaHY3V2gxigmmyYq85ciAFxOycFY104p8dFlx+/6A=;
  b=aJN7HRNxEZ0kCs3/1aqdJO+kDWPsJyQ/42BGT1WJva6fX8EGJgjoXhpn
   BxStMyMwwC+fl3Bvs3uZzN2MndNjL6r0rZUvMCXOYyClZPy/l0fTmpbXm
   FpwTGYPEbe1G//yYDJ+8Vzaj3/c0NSvEAZFce76/RSEJoxNYrZJSy1A4S
   o=;
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
X-IronPort-AV: E=Sophos;i="6.07,194,1708383600"; 
   d="scan'208,217,223";a="161152593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2024 23:00:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C494FE0AF6; Thu, 11 Apr 2024 23:00:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 02FD7E0131
	for <cocci@sympa.inria.fr>; Thu, 11 Apr 2024 20:44:31 +0200 (CEST)
IronPort-SDR: 66182f8e_QeGTRIAlZqnC1bM4jj97tRouPQpXsBxCVvnzGpBzZGf+Bok
 sDnSHFJied/S5gSiTje+hpcfGY3tTlTbtnqvTWg==
X-IPAS-Result: =?us-ascii?q?A0HKAgBiLhhmf7HQVdFagliCRIFRMwQLSIRWgSOOI4IiA?=
 =?us-ascii?q?4tzkhUUgSw+CAcBAwEIBUQEAQEDBIR/AogXAh4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBCAEBBQEBAQIBAQIEBgECEAEBIhkHDg4phW0NgmcBgR5hAgUDOwEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLFwBAQEBAgESE?=
 =?us-ascii?q?R0BGx0BAwELBgUEBw0qAgICHwERAQUBHAYTGweCXgGCKgEDDiMDpReBBUKKQ?=
 =?us-ascii?q?XqBFQUCFoEBggsG2loKGSgNbAOBVwcCBxSBNIFXgw0lgwYdAYFTAgICh2R6J?=
 =?us-ascii?q?w+BVUSBSoI9OD6EKYN1gmgEgWSUfooyJggHFwMHBwcEBQQJEwYFBQJCCQgPE?=
 =?us-ascii?q?gMEAwQEAQILEwkDAwIOAggDAggGHwE/EgQTCwcJBAIJEQYCAgsCDAYFAQQDA?=
 =?us-ascii?q?gEDAwMCBAICAwECAgICAgMBAgoCAQcCBQMFAgIDAgEBAQECAgQDAQ4HAgMFB?=
 =?us-ascii?q?QIBBQkDAwICBAMBAgIDAgICAwEEBRQDBAIFCgMIAgIHAg4DAQUCAQECAgICA?=
 =?us-ascii?q?QECAgMIAhIEAgECAwICCAICBwEBAgoHAwEBAgQEBAMGAgIFBA0DCAUBAQICB?=
 =?us-ascii?q?AEKAgkPBQICAwMCAwEBAQIKAwkBBQICAQMCAgQEBwEGAwUDAwQEAgMDAgwBB?=
 =?us-ascii?q?QEFAQUBBQQCBgETAhQCAgsFBgMGDgMLBAQBAgIFBAYMCQQCAgIGAQIRAwECA?=
 =?us-ascii?q?QcBAwMCCgEEAQILCAEFCAIMBAIBBAIDBhACCAUGBQICAQECAgIBCAYPAwYHA?=
 =?us-ascii?q?gMCBgMFBQMDAgICBwQEAgECAgIBEwYEBAIDAgMEAQUEBAMCFwgNAgUHAQkKC?=
 =?us-ascii?q?AwBBAYCBAIEBwMGBQUEAgMEBBEHCwMCAwQCAgYDEQIDBAIKAgQEBwIDAQQNB?=
 =?us-ascii?q?gQECgILAwcBAQEBBQMDCQcGAgMDBQQDBgIFAwMDAgMCDQICAgEJAQEBAhQCA?=
 =?us-ascii?q?w4CBAIBAgUFDAQTAgIDAgYIAgICBwMDBAIDBgsDEAMCAgICBQMEAgIUAwkEA?=
 =?us-ascii?q?gQGAgQBBgMDAgQGBQoEAgIFAgEBAgoCAQ8KBAMEAwUDBwkCBQUDAgQCAgcJA?=
 =?us-ascii?q?QECAgIDAwMDAgMCAgMDAgcDAwMHAwUDBAIDBgUHAwUFAwICAhQBBgIFCgYDB?=
 =?us-ascii?q?wYLBQUHAgYCBAgDBQICAwMDAwIGCggDAwMCAQYCAgMDAQIIAw8GAgIDBQYDA?=
 =?us-ascii?q?wMDBggDAwIGAwMCAwIDAgMDAQMCAwICAwICAggCAgMCBQQFAgIDBAIIGgICA?=
 =?us-ascii?q?gIDAwgDAwoEAgIEAQQCBAIEAgYDBAICAQcCBQMCAwIHAgIEAgICAgMCAgYIA?=
 =?us-ascii?q?gIDAwMCAgIBCQIFAQEGAgQDAgMFAwkDBAUCAwgBAQICBwcDAwQDAQIBBQQCA?=
 =?us-ascii?q?gYFAgMCAgQEBAUDAgMCBgYCAQMCCgYDBQMDAwMCAwMCAwMCBQIIAgIEBAUEA?=
 =?us-ascii?q?gUEAgQDAwMBCgIGAwICBQEBAgIFAwIEBAcCAgIHDwMCBwUCBQUFAggBBgUCA?=
 =?us-ascii?q?gMCCAECAgYBBgIEAQICDQEBAgICAwEDAwMHAgQDAggCAwMRAQMDCQYFBAUEA?=
 =?us-ascii?q?wkEDwIEAQgDAQEECAIEAwIMAgIhAgULBAQBEgoIAwEBAwEBAgICAgIOAwIDA?=
 =?us-ascii?q?gIDCgIDAgoDBgQCAgYBAQEEBgEEAgECCQQOCQUICAEDAgEEBgECEgUCDwIJA?=
 =?us-ascii?q?wMGBAIQBgoFAwIDBQECBRUDCAMCCQIEDAMFCAIDAwIGAwYCBgEGAwcLAQEJC?=
 =?us-ascii?q?AUDAwMCFwECAhAIBgYPBwIDAwQEDwMSAgYOAwMCAwIBAgICAwUEBQIHAwMNB?=
 =?us-ascii?q?QICBwMCCAUDBwkECgIIBQECBgMCAgICBQ0BAQEBAgMCBQMHCQgIBAUEAwEBB?=
 =?us-ascii?q?gYMJQICAwQPAwgDAwYLAQUFAQMCAgIOAwUDAgMGBgENBAEFBAkCBQcGBQIBF?=
 =?us-ascii?q?AgPBwYCCgIHAgICAwECCAsIAgMCCgQBDgQaAwUBAgICAwIDCAIDAgIUAwMFB?=
 =?us-ascii?q?AYDAgICAgMCAQoLAwIFAwMDAwUFAwMCGgIDAwIBCgUCDAUEAwQCAgECHgMBB?=
 =?us-ascii?q?QIDCgEFCQMGAgIDAgUCAwYGAgQBCg4BAQEDBgsHBBcCAgIOCAMJBQMBAgFDH?=
 =?us-ascii?q?QIJAyMFCgMLCQgTPQELBzIENAEUFAcnAQEFIV+bQRCDboFOGQgqBg9RRaUnV?=
 =?us-ascii?q?ItulE80B4QWgVsGDIRomnIEL4QFk3iSN5hiqHQRIxKBLzqBXE0jgQGCNk8DG?=
 =?us-ascii?q?Q+OLBaDWJ4tQzI7AgcBCgEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
 hxvzwUnPrtr+zDr7FM6YFHNoXlo+HQ=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Ez8yla/uEhq0S7Geeb1uk+DnI+orL9Y04lQ7vn2ZhyYlC/Bw9v
 re5MjzsCWftN9/YgBEpTntAtjjfZqYz+8X3WBzB9aftWvdyQ+VxehZhOOI/9SjIU3DH4VmpM
 BdmsZFebvN5JtB4foSIjPULz/t+ra6GWmT69vj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3AnfXvT2nApnq+QiEEnBySVtgN6gfXOXzjwC7xHW+?=
 =?us-ascii?q?mMzp4TaGqUXSBw7g5lfM7zg=3D=3D?=
X-Talos-MUID: 9a23:iKotVwYDYTXXpuBTixiwhD9tJMlRua2fCl5Tm88Wl+yIKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,193,1708383600"; 
   d="scan'208,217,223";a="161139606"
X-MGA-submission: =?us-ascii?q?MDG0Ji3/Q2LsG5WIPv9GitLWWfwMPw3cwD9hcI?=
 =?us-ascii?q?maR2Ye2k0ldvmFKCSm9hhuO3415/SDoJnczf3PgVFi+XbOThn7GYPrLc?=
 =?us-ascii?q?TT1R0aev0DBW5IF9a6AnbfBx4C9GNGkP/aG+6CSjtLf7Cg6OvpIActpL?=
 =?us-ascii?q?vWFAbC4Y6xQ6m3rDOoD982mg=3D=3D?=
Received: from mail-lj1-f177.google.com ([209.85.208.177])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:44:30 +0200
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2da01cb187cso1073191fa.0;
        Thu, 11 Apr 2024 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712861069; x=1713465869; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLSaHY3V2gxigmmyYq85ciAFxOycFY104p8dFlx+/6A=;
        b=N0sPp3FFx/9hlcVa592CNzCJBDhVLxbvfLgesdVeqy6iruONgUGx4XKKe8YbznVAO8
         TAMpUnoUOLV5v61jNWkgzh/LadXBZHS9+o9oFljxCtLAJdwkkWCETi0IFc8KT9PZq7SO
         VQsVdyXEKaZkGomT/oWZF3tLTgcyDq8fR+w+aF7BwqMC+iqeyGdIvvNfB5y+1fvxRV7N
         O0aMqusmvcH8t8Efbl8EFY6nAiW0ynWqYKFS+YrxkEXZjiZLIZolovz3AoVHNA2g2sGv
         4BOfDuybLfpF8u3g10Tk2KDKrTvduyoSzFYIIXGqRqWD5q7p3yUWEFHK2ZaW9Uhep/5u
         Vk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712861069; x=1713465869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLSaHY3V2gxigmmyYq85ciAFxOycFY104p8dFlx+/6A=;
        b=iRfuvmst3zpKAjK1cvmiSAP+tx2l2F18Q/jsrcrx2d/Wlz8P/Pnfmuet/PT0pgj1XX
         gd4sKgvkmXKtgoWugbw7KOT12PJOvyJbrFT0xDAzVTbPUSfB1svvziLe6ssk1OBF3AdQ
         qY0tbKiq/y/8VhlW3qF5VEXVU6H80b6zchxZaLgccLMoGftxVHw8IKa8IdoQpl/F9cWk
         tW5xeQqV/rR7j3kn8mHBKU6ZJB1K1kn9Cpcfgz6Bk6sRfgdOTkqKF7tLv9mcn5/NFhMp
         VMojyXwX7yuChlRVZYdKiPnE3jyhpgnuSDR1n2h2jGEJpDhuGqB91G9AekEG+Z9vstmg
         ykvg==
X-Gm-Message-State: AOJu0YzOcRAvQSgHwJ6b5dMAn/9gbrtM/3j5QR4EmjKXlbl5Mfk9Gw52
	eE7XVegmfAI0OnQIh2T8z820dylVwDt6oxdEwqfVlz7bHUcvpHMCkBRVsBcKW27qcKbFsAjoOc3
	QWpKFifl11c4YQv2Aeh0m9m8soTBy
X-Google-Smtp-Source: AGHT+IFg51bqa/OpfUEk2w5yhnQFGmpali4wSCM5+a4tqyXL9HFXG0tHHAwMVWFU7fP5lu9UY3fkIqAeZvHBUDx/3EM=
X-Received: by 2002:a2e:804f:0:b0:2d6:8868:f1a6 with SMTP id
 p15-20020a2e804f000000b002d68868f1a6mr312793ljg.43.1712861068970; Thu, 11 Apr
 2024 11:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJwHcF57ee4M6P-nzg9=1drDQbpic-4qqbpSCbL1FO7XXsetVw@mail.gmail.com>
 <80e895d-301f-90c6-fe89-e72f7c3ff039@inria.fr>
In-Reply-To: <80e895d-301f-90c6-fe89-e72f7c3ff039@inria.fr>
From: Akos Pasztory <akos.pasztory@gmail.com>
Date: Thu, 11 Apr 2024 21:44:17 +0300
Message-ID: <CAJwHcF6YRniP0C8SMg-iM+SJ1wu61KeLS+gLZ-mkek90OMH6cg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/mixed; boundary="00000000000090e7730615d68bcd"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] type of integer decimal constants
Reply-To: Akos Pasztory <akos.pasztory@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1640
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/CAJwHcF6YRniP0C8SMg-iM%2BSJ1wu61KeLS%2BgLZ-mkek90OMH6cg%40mail.gmail.com>

--00000000000090e7730615d68bcd
Content-Type: multipart/alternative; boundary="00000000000090e7700615d68bcb"

--00000000000090e7700615d68bcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, sorry, didn't read it beforehand.

On Thu, Apr 11, 2024 at 8:52=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:

>
>
> On Thu, 11 Apr 2024, Akos Pasztory wrote:
>
> > Hi,
> >
> > I noticed an issue with how coccinelle determines types of (at least)
> decimal literals.
> > This only happens if --int-bits and/or --long-bits is specified, since
> otherwise everything is treated as "int".
> > The output below was truly puzzling initially:
>
> Thanks!
>
> The patch looks good to me.  Could you resend it with a Signed-off-by (se=
e
> the end of readme.txt).
>
> julia
>
>
> >
> > $ { echo 'void f() {'; printf '%d;\n' $(seq 0 32); echo '}'; } >
> decimals.c
> > $ ./spatch.opt --long-bits 32 --int-bits 32 --type-c decimals.c
> > void f() {
> > 0/*int*/;
> > 1/*int*/;
> > 2/*int*/;
> > 3/*unsigned long*/;
> > 4/*unsigned long*/;
> > 5/*long long*/;
> > 6/*long long*/;
> > 7/*long long*/;
> > 8/*long long*/;
> > 9/*long long*/;
> > 10/*int*/;
> > 11/*int*/;
> > 12/*int*/;
> > 13/*int*/;
> > 14/*int*/;
> > 15/*int*/;
> > 16/*int*/;
> > 17/*int*/;
> > 18/*int*/;
> > 19/*int*/;
> > 20/*int*/;
> > 21/*int*/;
> > 22/*unsigned long*/;
> > 23/*unsigned long*/;
> > 24/*unsigned long*/;
> > 25/*unsigned long*/;
> > 26/*unsigned long*/;
> > 27/*unsigned long*/;
> > 28/*unsigned long*/;
> > 29/*unsigned long*/;
> > 30/*unsigned long*/;
> > 31/*unsigned long*/;
> > 32/*unsigned long*/;
> > }
> >
> > After some investigation, I think the problem was introduced in
> 3c5dc62bae3e38d77044423ecb3575f30ab230fa
> > when a bigint dependency was removed. The commit replaces integer
> thresholds with strings,
> > however in is_long_dec it does the following kind of changes:
> >
> > -      if Big_int.ge_big_int bn ulong_threshold
> > +      if s >=3D ulong_threshold
> >
> > This seems to do a lexicographic comparison on strings instead of
> numeric.
> > One solution that came to my mind is to zero-pad the strings to same
> length,
> > then lexicographic comparison should be also correct.
> >
> > Attached a patch, but note that I'm not an OCaml programmer, so it may
> be not idiomatic.
> > Feel free to solve it another way;)
> >
> >
> >

--00000000000090e7700615d68bcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, sorry, didn&#39;t read it beforehand.<br></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr =
11, 2024 at 8:52=E2=80=AFPM Julia Lawall &lt;<a href=3D"mailto:julia.lawall=
@inria.fr" target=3D"_blank">julia.lawall@inria.fr</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On Thu, 11 Apr 2024, Akos Pasztory wrote:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; I noticed an issue with how coccinelle determines types of (at least) =
decimal literals.<br>
&gt; This only happens if --int-bits and/or --long-bits is specified, since=
 otherwise everything is treated as &quot;int&quot;.<br>
&gt; The output below was truly puzzling initially:<br>
<br>
Thanks!<br>
<br>
The patch looks good to me.=C2=A0 Could you resend it with a Signed-off-by =
(see<br>
the end of readme.txt).<br>
<br>
julia<br>
<br>
<br>
&gt;<br>
&gt; $ { echo &#39;void f() {&#39;; printf &#39;%d;\n&#39; $(seq 0 32); ech=
o &#39;}&#39;; } &gt; decimals.c<br>
&gt; $ ./spatch.opt --long-bits 32 --int-bits 32 --type-c decimals.c<br>
&gt; void f() {<br>
&gt; 0/*int*/;<br>
&gt; 1/*int*/;<br>
&gt; 2/*int*/;<br>
&gt; 3/*unsigned long*/;<br>
&gt; 4/*unsigned long*/;<br>
&gt; 5/*long long*/;<br>
&gt; 6/*long long*/;<br>
&gt; 7/*long long*/;<br>
&gt; 8/*long long*/;<br>
&gt; 9/*long long*/;<br>
&gt; 10/*int*/;<br>
&gt; 11/*int*/;<br>
&gt; 12/*int*/;<br>
&gt; 13/*int*/;<br>
&gt; 14/*int*/;<br>
&gt; 15/*int*/;<br>
&gt; 16/*int*/;<br>
&gt; 17/*int*/;<br>
&gt; 18/*int*/;<br>
&gt; 19/*int*/;<br>
&gt; 20/*int*/;<br>
&gt; 21/*int*/;<br>
&gt; 22/*unsigned long*/;<br>
&gt; 23/*unsigned long*/;<br>
&gt; 24/*unsigned long*/;<br>
&gt; 25/*unsigned long*/;<br>
&gt; 26/*unsigned long*/;<br>
&gt; 27/*unsigned long*/;<br>
&gt; 28/*unsigned long*/;<br>
&gt; 29/*unsigned long*/;<br>
&gt; 30/*unsigned long*/;<br>
&gt; 31/*unsigned long*/;<br>
&gt; 32/*unsigned long*/;<br>
&gt; }<br>
&gt;<br>
&gt; After some investigation, I think the problem was introduced in 3c5dc6=
2bae3e38d77044423ecb3575f30ab230fa<br>
&gt; when a bigint dependency was removed. The commit replaces integer thre=
sholds with strings,=C2=A0<br>
&gt; however in is_long_dec it does the following kind of changes:<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0if Big_int.ge_big_int bn ulong_threshold<br>
&gt; + =C2=A0 =C2=A0 =C2=A0if s &gt;=3D ulong_threshold<br>
&gt;<br>
&gt; This seems to do a lexicographic comparison on strings instead of nume=
ric.<br>
&gt; One solution that came to my mind is to zero-pad the strings to same l=
ength,<br>
&gt; then lexicographic comparison should be also correct.<br>
&gt;<br>
&gt; Attached a patch, but note that I&#39;m not an OCaml programmer, so it=
 may be not idiomatic.<br>
&gt; Feel free to solve it another way;)<br>
&gt;<br>
&gt;<br>
&gt;</blockquote></div>

--00000000000090e7700615d68bcb--
--00000000000090e7730615d68bcd
Content-Type: application/x-patch; 
	name="0001-fix-type-deduction-of-decimal-constants.patch"
Content-Disposition: attachment; 
	filename="0001-fix-type-deduction-of-decimal-constants.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_luvl7hlb0>
X-Attachment-Id: f_luvl7hlb0

RnJvbSBkY2I2Y2E5NTIzYjhjY2I0ZTEwNjM2YWZhYjYzNmJlMGE0ZDZkNTE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ZGNiNmNhOTUyM2I4Y2NiNGUxMDYzNmFmYWI2MzZi
ZTBhNGQ2ZDUxOS4xNzEyODYwOTU5LmdpdC5ha29zLnBhc3p0b3J5QGdtYWlsLmNvbT4KRnJvbTog
QWtvcyBQYXN6dG9yeSA8YWtvcy5wYXN6dG9yeUBnbWFpbC5jb20+CkRhdGU6IFRodSwgMTEgQXBy
IDIwMjQgMDk6NTI6NDYgKzAzMDAKU3ViamVjdDogW1BBVENIXSBmaXggdHlwZSBkZWR1Y3Rpb24g
b2YgZGVjaW1hbCBjb25zdGFudHMKCkluIGEgcHJldmlvdXMgY29tbWl0ICdpc19sb25nX2RlYycg
Y2hhbmdlZCB0byBsZXhpY29ncmFwaGljYWwKY29tcGFyaXNvbiBvZiBzdHJpbmdzLCB3aGljaCB3
aWxsIGdpdmUgaW5jb3JyZWN0IHJlc3VsdHMuIEl0IG9ubHkKaGFwcGVucyBpZiBlaXRoZXIgLS1p
bnQtYml0cyBvciAtLWxvbmctYml0cyBvcHRpb24gaXMgZ2l2ZW4sIG90aGVyd2lzZQpldmVyeXRo
aW5nIGlzIHRyZWF0ZWQgYXMgImludCIuCgpNYXkgc3RpbGwgbm90IGJlIGVudGlyZWx5IGNvcnJl
Y3QsIHRoZSBzdGFuZGFyZCBzYXlzIHVuc3VmZml4ZWQKZGVjaW1hbCBjb25zdGFudHMgYXJlIG9u
ZSBvZiAiaW50IiwgImxvbmciLCBvciAibG9uZyBsb25nIiwgYW5kIG5vdyBpdApzdGlsbCBhc3Np
Z25zIHVuc2lnbmVkIHZhcmlhbnRzLgoKU2lnbmVkLW9mZi1ieTogQWtvcyBQYXN6dG9yeSA8YWtv
cy5wYXN6dG9yeUBnbWFpbC5jb20+Ci0tLQogcGFyc2luZ19jL2xleGVyX2MubWxsICAgICAgICAg
IHwgMTkgKysrKysrKysrKy0tLQogdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LmMgICAgIHwgNDkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvdHlwZW9mY29uc3RfaTMy
bDY0LmNvY2NpIHwgMjkgKysrKysrKysrKysrKysrKysrKysKIHRlc3RzL3R5cGVvZmNvbnN0X2kz
Mmw2NC5yZXMgICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3Rz
L3R5cGVvZmNvbnN0X2lsMzIuYyAgICAgICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIHRlc3RzL3R5cGVvZmNvbnN0X2lsMzIuY29jY2kgICB8IDI5ICsrKysrKysrKysr
KysrKysrKysrCiB0ZXN0cy90eXBlb2Zjb25zdF9pbDMyLnJlcyAgICAgfCA0OSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCiA3IGZpbGVzIGNoYW5nZWQsIDI2OSBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3R5cGVvZmNvbnN0
X2kzMmw2NC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LmNv
Y2NpCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LnJlcwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3R5cGVvZmNvbnN0X2lsMzIuYwogY3JlYXRlIG1vZGUgMTAw
NjQ0IHRlc3RzL3R5cGVvZmNvbnN0X2lsMzIuY29jY2kKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy90eXBlb2Zjb25zdF9pbDMyLnJlcwoKZGlmZiAtLWdpdCBhL3BhcnNpbmdfYy9sZXhlcl9jLm1s
bCBiL3BhcnNpbmdfYy9sZXhlcl9jLm1sbAppbmRleCA1Mzc5Yzg0MS4uYTU2YzFiYzcgMTAwNjQ0
Ci0tLSBhL3BhcnNpbmdfYy9sZXhlcl9jLm1sbAorKysgYi9wYXJzaW5nX2MvbGV4ZXJfYy5tbGwK
QEAgLTI4MSwyMCArMjgxLDMxIEBAIGxldCBlcnJvcl9yYWRpeCBzID0KIAogKCoganVsaWE6IGZ1
bmN0aW9ucyBmb3IgZmlndXJpbmcgb3V0IHRoZSB0eXBlIG9mIGludGVnZXJzICopCiAKKworKCog
Q29tcGFyZSB0d28gbnVtYmVycyBpbiBzdHJpbmcgZm9ybSBieSB6ZXJvIHBhZGRpbmcgdG8gdGhl
IHNhbWUKKyAgIGxlbmd0aC4gKikKK2xldCBnZV9zdHIgYSBiID0KKyAgbGV0IGFsZW4gPSBTdHJp
bmcubGVuZ3RoIGEgaW4KKyAgbGV0IGJsZW4gPSBTdHJpbmcubGVuZ3RoIGIgaW4KKyAgbGV0IG4g
PSBtYXggYWxlbiBibGVuIGluCisgIGxldCBhcGFkID0gKFN0cmluZy5tYWtlIChuIC0gYWxlbikg
JzAnKSBeIGEgaW4KKyAgbGV0IGJwYWQgPSAoU3RyaW5nLm1ha2UgKG4gLSBibGVuKSAnMCcpIF4g
YiBpbgorICBhcGFkID49IGJwYWQKKwogbGV0IGlzX2xvbmdfZGVjIHMgaW50IHVpbnQgbG9uZyB1
bG9uZyBsb25nbG9uZyB1bG9uZ2xvbmcgPQogICBtYXRjaCAhRmxhZ19wYXJzaW5nX2MuaW50X3Ro
cmVzaG9sZHMgd2l0aAogICAgIE5vbmUgLT4gaW50CiAgIHwgU29tZSAoXyxfLGludF90aHJlc2hv
bGQsIHVpbnRfdGhyZXNob2xkLGxvbmdfdGhyZXNob2xkLHVsb25nX3RocmVzaG9sZCkgLT4KLSAg
ICAgIGlmIHMgPj0gdWxvbmdfdGhyZXNob2xkCisgICAgICBpZiBnZV9zdHIgcyB1bG9uZ190aHJl
c2hvbGQKICAgICAgIHRoZW4gbG9uZ2xvbmcKICAgICAgIGVsc2UKLQlpZiBzID49IGxvbmdfdGhy
ZXNob2xkCisJaWYgZ2Vfc3RyIHMgbG9uZ190aHJlc2hvbGQKIAl0aGVuIHVsb25nCiAJZWxzZQot
CSAgaWYgcyA+PSB1aW50X3RocmVzaG9sZAorCSAgaWYgZ2Vfc3RyIHMgdWludF90aHJlc2hvbGQK
IAkgIHRoZW4gbG9uZwogCSAgZWxzZQotCSAgICBpZiBzID49IGludF90aHJlc2hvbGQKKwkgICAg
aWYgZ2Vfc3RyIHMgaW50X3RocmVzaG9sZAogCSAgICB0aGVuIHVpbnQKIAkgICAgZWxzZSBpbnQK
IApkaWZmIC0tZ2l0IGEvdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LmMgYi90ZXN0cy90eXBlb2Zj
b25zdF9pMzJsNjQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMC4uMWM1ODRm
ZWEKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0cy90eXBlb2Zjb25zdF9pMzJsNjQuYwpAQCAtMCww
ICsxLDQ5IEBACit2b2lkIGYoKSB7CiswOworMTsKKzI7CiszOworNDsKKzU7Cis2OworNzsKKzg7
Cis5OworMTA7CisxMTsKKzEyOworMTM7CisxNDsKKzE1OworMTY7CisxNzsKKzE4OworMTk7Cisy
MDsKKzIxOworMjI7CisyMzsKKzI0OworMjU7CisyNjsKKzI3OworMjg7CisyOTsKKzMwOworMzE7
CiszMjsKKworMjE0NzQ4MzY0NzsgLy8gMioqMzEgLSAxCisyMTQ3NDgzNjQ4OyAvLyAyKiozMQor
MjE0NzQ4MzY0OTsgLy8gMioqMzEgKyAxCisKKzQyOTQ5NjcyOTU7IC8vIDIqKjMyIC0gMQorNDI5
NDk2NzI5NjsgLy8gMioqMzIKKzQyOTQ5NjcyOTc7IC8vIDIqKjMyICsgMQorCis5MjIzMzcyMDM2
ODU0Nzc1ODA3OyAvLyAyKio2MyAtIDEKKzkyMjMzNzIwMzY4NTQ3NzU4MDg7IC8vIDIqKjYzCis5
MjIzMzcyMDM2ODU0Nzc1ODA5OyAvLyAyKio2MyArMQorCisxODQ0Njc0NDA3MzcwOTU1MTYxNTsg
Ly8gMioqNjQgLSAxCit9CmRpZmYgLS1naXQgYS90ZXN0cy90eXBlb2Zjb25zdF9pMzJsNjQuY29j
Y2kgYi90ZXN0cy90eXBlb2Zjb25zdF9pMzJsNjQuY29jY2kKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAuLjNiYzdiOWZlCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvdHlwZW9m
Y29uc3RfaTMybDY0LmNvY2NpCkBAIC0wLDAgKzEsMjkgQEAKKyNzcGF0Y2ggLS1pbnQtYml0cyAz
MiAtLWxvbmctYml0cyA2NAorQEAKK2ludCBzaTsKK2xvbmcgc2w7Citsb25nIGxvbmcgc2xsOwor
dW5zaWduZWQgaW50IHVpOwordW5zaWduZWQgbG9uZyB1bDsKK3Vuc2lnbmVkIGxvbmcgbG9uZyB1
bGw7CitAQAorCisoCistIHNpCisrIElOVChzaSkKK3wKKy0gc2wKKysgTE9ORyhzbCkKK3wKKy0g
c2xsCisrIExPTkdMT05HKHNsbCkKK3wKKy0gdWkKKysgVUlOVCh1aSkKK3wKKy0gdWwKKysgVUxP
TkcodWwpCit8CistIHVsbAorKyBVTE9OR0xPTkcodWxsKQorKQpkaWZmIC0tZ2l0IGEvdGVzdHMv
dHlwZW9mY29uc3RfaTMybDY0LnJlcyBiL3Rlc3RzL3R5cGVvZmNvbnN0X2kzMmw2NC5yZXMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAuLmI2NWJlYzJiCi0tLSAvZGV2L251bGwK
KysrIGIvdGVzdHMvdHlwZW9mY29uc3RfaTMybDY0LnJlcwpAQCAtMCwwICsxLDQ5IEBACit2b2lk
IGYoKSB7CitJTlQoMCk7CitJTlQoMSk7CitJTlQoMik7CitJTlQoMyk7CitJTlQoNCk7CitJTlQo
NSk7CitJTlQoNik7CitJTlQoNyk7CitJTlQoOCk7CitJTlQoOSk7CitJTlQoMTApOworSU5UKDEx
KTsKK0lOVCgxMik7CitJTlQoMTMpOworSU5UKDE0KTsKK0lOVCgxNSk7CitJTlQoMTYpOworSU5U
KDE3KTsKK0lOVCgxOCk7CitJTlQoMTkpOworSU5UKDIwKTsKK0lOVCgyMSk7CitJTlQoMjIpOwor
SU5UKDIzKTsKK0lOVCgyNCk7CitJTlQoMjUpOworSU5UKDI2KTsKK0lOVCgyNyk7CitJTlQoMjgp
OworSU5UKDI5KTsKK0lOVCgzMCk7CitJTlQoMzEpOworSU5UKDMyKTsKKworSU5UKDIxNDc0ODM2
NDcpOyAvLyAyKiozMSAtIDEKK0xPTkcoMjE0NzQ4MzY0OCk7IC8vIDIqKjMxCitMT05HKDIxNDc0
ODM2NDkpOyAvLyAyKiozMSArIDEKKworTE9ORyg0Mjk0OTY3Mjk1KTsgLy8gMioqMzIgLSAxCitM
T05HKDQyOTQ5NjcyOTYpOyAvLyAyKiozMgorTE9ORyg0Mjk0OTY3Mjk3KTsgLy8gMioqMzIgKyAx
CisKK0xPTkcoOTIyMzM3MjAzNjg1NDc3NTgwNyk7IC8vIDIqKjYzIC0gMQorVUxPTkcoOTIyMzM3
MjAzNjg1NDc3NTgwOCk7IC8vIDIqKjYzCitVTE9ORyg5MjIzMzcyMDM2ODU0Nzc1ODA5KTsgLy8g
MioqNjMgKzEKKworVUxPTkcoMTg0NDY3NDQwNzM3MDk1NTE2MTUpOyAvLyAyKio2NCAtIDEKK30K
ZGlmZiAtLWdpdCBhL3Rlc3RzL3R5cGVvZmNvbnN0X2lsMzIuYyBiL3Rlc3RzL3R5cGVvZmNvbnN0
X2lsMzIuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMC4uMWM1ODRmZWEKLS0t
IC9kZXYvbnVsbAorKysgYi90ZXN0cy90eXBlb2Zjb25zdF9pbDMyLmMKQEAgLTAsMCArMSw0OSBA
QAordm9pZCBmKCkgeworMDsKKzE7CisyOworMzsKKzQ7Cis1OworNjsKKzc7Cis4OworOTsKKzEw
OworMTE7CisxMjsKKzEzOworMTQ7CisxNTsKKzE2OworMTc7CisxODsKKzE5OworMjA7CisyMTsK
KzIyOworMjM7CisyNDsKKzI1OworMjY7CisyNzsKKzI4OworMjk7CiszMDsKKzMxOworMzI7CisK
KzIxNDc0ODM2NDc7IC8vIDIqKjMxIC0gMQorMjE0NzQ4MzY0ODsgLy8gMioqMzEKKzIxNDc0ODM2
NDk7IC8vIDIqKjMxICsgMQorCis0Mjk0OTY3Mjk1OyAvLyAyKiozMiAtIDEKKzQyOTQ5NjcyOTY7
IC8vIDIqKjMyCis0Mjk0OTY3Mjk3OyAvLyAyKiozMiArIDEKKworOTIyMzM3MjAzNjg1NDc3NTgw
NzsgLy8gMioqNjMgLSAxCis5MjIzMzcyMDM2ODU0Nzc1ODA4OyAvLyAyKio2MworOTIyMzM3MjAz
Njg1NDc3NTgwOTsgLy8gMioqNjMgKzEKKworMTg0NDY3NDQwNzM3MDk1NTE2MTU7IC8vIDIqKjY0
IC0gMQorfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdHlwZW9mY29uc3RfaWwzMi5jb2NjaSBiL3Rlc3Rz
L3R5cGVvZmNvbnN0X2lsMzIuY29jY2kKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAuLmI0N2U0YWU2Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvdHlwZW9mY29uc3RfaWwzMi5j
b2NjaQpAQCAtMCwwICsxLDI5IEBACisjc3BhdGNoIC0taW50LWJpdHMgMzIgLS1sb25nLWJpdHMg
MzIKK0BACitpbnQgc2k7Citsb25nIHNsOworbG9uZyBsb25nIHNsbDsKK3Vuc2lnbmVkIGludCB1
aTsKK3Vuc2lnbmVkIGxvbmcgdWw7Cit1bnNpZ25lZCBsb25nIGxvbmcgdWxsOworQEAKKworKAor
LSBzaQorKyBJTlQoc2kpCit8CistIHNsCisrIExPTkcoc2wpCit8CistIHNsbAorKyBMT05HTE9O
RyhzbGwpCit8CistIHVpCisrIFVJTlQodWkpCit8CistIHVsCisrIFVMT05HKHVsKQorfAorLSB1
bGwKKysgVUxPTkdMT05HKHVsbCkKKykKZGlmZiAtLWdpdCBhL3Rlc3RzL3R5cGVvZmNvbnN0X2ls
MzIucmVzIGIvdGVzdHMvdHlwZW9mY29uc3RfaWwzMi5yZXMKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAuLmY3NDUxM2NmCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvdHlwZW9m
Y29uc3RfaWwzMi5yZXMKQEAgLTAsMCArMSw0OSBAQAordm9pZCBmKCkgeworSU5UKDApOworSU5U
KDEpOworSU5UKDIpOworSU5UKDMpOworSU5UKDQpOworSU5UKDUpOworSU5UKDYpOworSU5UKDcp
OworSU5UKDgpOworSU5UKDkpOworSU5UKDEwKTsKK0lOVCgxMSk7CitJTlQoMTIpOworSU5UKDEz
KTsKK0lOVCgxNCk7CitJTlQoMTUpOworSU5UKDE2KTsKK0lOVCgxNyk7CitJTlQoMTgpOworSU5U
KDE5KTsKK0lOVCgyMCk7CitJTlQoMjEpOworSU5UKDIyKTsKK0lOVCgyMyk7CitJTlQoMjQpOwor
SU5UKDI1KTsKK0lOVCgyNik7CitJTlQoMjcpOworSU5UKDI4KTsKK0lOVCgyOSk7CitJTlQoMzAp
OworSU5UKDMxKTsKK0lOVCgzMik7CisKK0lOVCgyMTQ3NDgzNjQ3KTsgLy8gMioqMzEgLSAxCitV
TE9ORygyMTQ3NDgzNjQ4KTsgLy8gMioqMzEKK1VMT05HKDIxNDc0ODM2NDkpOyAvLyAyKiozMSAr
IDEKKworVUxPTkcoNDI5NDk2NzI5NSk7IC8vIDIqKjMyIC0gMQorTE9OR0xPTkcoNDI5NDk2NzI5
Nik7IC8vIDIqKjMyCitMT05HTE9ORyg0Mjk0OTY3Mjk3KTsgLy8gMioqMzIgKyAxCisKK0xPTkdM
T05HKDkyMjMzNzIwMzY4NTQ3NzU4MDcpOyAvLyAyKio2MyAtIDEKK0xPTkdMT05HKDkyMjMzNzIw
MzY4NTQ3NzU4MDgpOyAvLyAyKio2MworTE9OR0xPTkcoOTIyMzM3MjAzNjg1NDc3NTgwOSk7IC8v
IDIqKjYzICsxCisKK0xPTkdMT05HKDE4NDQ2NzQ0MDczNzA5NTUxNjE1KTsgLy8gMioqNjQgLSAx
Cit9Ci0tIAoyLjM5LjIKCg==
--00000000000090e7730615d68bcd--
