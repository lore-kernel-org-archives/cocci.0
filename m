Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1466DC4332F
	for <cocci@archiver.kernel.org>; Sat, 10 Dec 2022 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jyl4oPZX1wWnkDsBxNFj9Uf7wkXT9xU75NQGtlttiWU=;
  b=ftQPemm9rJtwVzJqTmrCiJAOkD5Q1q/3d3aQoHCQYe6yQcu6LfsfQ2NX
   G0PbThjfMshAxVL6vEqZXmTwxDQ61sxfp8CTfnzw/d2me5ILQPLeJubAy
   +buPsik4AXHt9G+TU+xojKxrcEJDbBaURm6oBeF2TJiiksIybA6LzMApa
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.96,234,1665439200"; 
   d="scan'208";a="82758990"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2022 17:26:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CEE92E0141; Sat, 10 Dec 2022 17:26:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A5082E0128
	for <cocci@sympa.inria.fr>; Sat, 10 Dec 2022 17:17:04 +0100 (CET)
IronPort-SDR: 6394b0ff_xMX2rJEBRkvQdANJHeSevzazat2Nzb680TZxObbUjTQNRsS
 oPqVDkR+FB2KRRO/LPQwJYeETuVenQ2AbkiGt1g==
X-IPAS-Result: =?us-ascii?q?A0EsBwC9r5RjfzLZVdFaHQEBPAEFBQECAQkBFYEqJ4FDA?=
 =?us-ascii?q?maBXC8EC0WET5EdA4tOkXyBLD4PAQMBDRQBLwQBAQMEOIFTgm8CAgKFCwIdB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABARkJGQcOD?=
 =?us-ascii?q?gUkhWgNgjgpAXVNAzgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBAJ+OQEeAQEBAQIBEhEdARsSCwEDDAYFCw0CAhEOBwICIgERAQUBH?=
 =?us-ascii?q?AYTIoVKAQMOIwOiToEEQoooEHqBFQUCFoEBggkGnAgKGSgNFVMDgVsCBxKBA?=
 =?us-ascii?q?ioCAQGHNoFVhxl6JxCBVUSBS4EGgTc3PoN9RxUqgxiCZwSBDYoGi2oBAQQCA?=
 =?us-ascii?q?gMCAgMGAQQCAgIFAwMCAQMEAgsFBA4DAQECAgEBAgQIAgIGAwICCBEXAwcCA?=
 =?us-ascii?q?QMDBQEDAQIGBAIIAQsCAgEFAwEKAQIEAQICAgEFCgECAwEDAQwCBAgCAgMFC?=
 =?us-ascii?q?gEDBwMEBgUPAwMCIAECAUMdAgkDIw8DCwkIExcoBgECAQoHOAQ0AQoBDAgFA?=
 =?us-ascii?q?QQBBwMDBQUJDwMEAgEDAwIUCgUBAwYGCAIEBQIFAwIEAgMCAggDAgQDCwMFB?=
 =?us-ascii?q?AIHBA8HAgMCAgUCAgICAgUEAwECAgICAgIFAgMCAQUBAgIBAgICBAECAgcEA?=
 =?us-ascii?q?gMBAwQOBAMCAgIFAQICAQYCBwMBAgEEAwEBBAIEAQIFAgQBAwYCBAMKAgIDA?=
 =?us-ascii?q?gICBgUDAgoIAgMFAgQBAQIHBAICCwEGAgcCAgMQAQMBBAUFAwMDCQICAwIEA?=
 =?us-ascii?q?gIKAQEBAQIBBwIEBw0CAgIEAgICAQMCAQICChEBAQIDBgQGBQMGGAUCAQECA?=
 =?us-ascii?q?gMDAgYCAQIIAgQBBAUCAQICAgIEAQgCAwEBAgECAgMDAgEEAgQDAwECAQICA?=
 =?us-ascii?q?wICAgMCAgENAgYGAQICAgICAgICAgEFAQIBAgQCBwIEAwIBAgIFAgICAwEBB?=
 =?us-ascii?q?gIECwEDAgcIAgcFAgMBBAMEAwMLBQwIAQUBAwERDgMCAggCBwIBBgUBDwMCA?=
 =?us-ascii?q?gMCAgEECgIDBQIEAgEECAcCBAECCQMCBgIGBRgBAgIHBAwKAQICBQYEAQEBA?=
 =?us-ascii?q?QMBAgEBAgMDAgMCBAUBBQIBAgUEAgEBAgUCDAEBBwYCBwICAgMBBAIBAgEDA?=
 =?us-ascii?q?wIDAQEBAwYGAgYEAgMDBgICAgYCAgMCEgYCBgMCBAENCwUEBQgBAgEBBwIEA?=
 =?us-ascii?q?gcJDgIBBAEFAgIDAgIBBQIBBgMBAgICAgUHBQMEBQMGDwMBAQQDAgECAQIDA?=
 =?us-ascii?q?gMHAwIEAgMBAgMEBgYBCQQGBQ0DBAICAQIBAQMEBAQCAgECAgMBBAICAQEDA?=
 =?us-ascii?q?wMCAgIDBAIDAwsECgcDAwIBBQsEAgMCAQMGCQQCAgYBAgQCAgICAgICAwEBA?=
 =?us-ascii?q?woEAgECAwICBgMGAgECAQkFAgEJAwECAQIBBAEDCQECAgQJAgMHBQoCAgICC?=
 =?us-ascii?q?AICDgMDAgEBBAICBAUJAQIHAgUBAQMFBwICAQICAQQDAQkEAQIDAgEBAxIDA?=
 =?us-ascii?q?wEEAgIFAwMNCQYCAgEDAgENAwECAQIDAQUFFwMIBxQDBQICBAQBCAICAwMDA?=
 =?us-ascii?q?gECCQYBAwEFAg4DAgIDAwYBAgEBAgMOBAUBAQEBFwEDBAIDAQQDAQECAQIDA?=
 =?us-ascii?q?g4EAQQFCwMBAh0CBAEICAICAgIDAQMDBQECAwQCAQgKAgICAgoCCgMCAwEDB?=
 =?us-ascii?q?QEDAgkDAQUBAgcCBgEBAQICAgYCCAIDCwEDBQYCAQICAQUCAQICBQMFAgICA?=
 =?us-ascii?q?gIEDQIFAgICBgECBwQCAgIEAQICBgIFAQIHBwQFAgICAwMKBAQCCgQBAgEBB?=
 =?us-ascii?q?gECAQMEAQIEAQIBAgUDBgICAgIBAgIBAgEBCAICAgICAgIDBAIImwOBCCFjY?=
 =?us-ascii?q?SsfFmaSJ5BwnwM0B4NwgUoGDJ8BMqkekgiFOaJQhRsQIxKBRCOBXE0jUDGCN?=
 =?us-ascii?q?k8DGQ+OLBYVgzuKfCYxOwIHAQoBAQMJih8BAQ?=
IronPort-PHdr: A9a23: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
 BUxj1knCdk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OIRa1qsp4ggYTLTWL3jqAlRb7skDQ9V00zEX/kB9WHVpmwKj5r
 mTdZMgpGTJYVcqKQkdcLW7UpVoLkmskKKdjbNhX4tKGTOW21dAT7sC0WKB+UyFJ8SWzIc0vp
 uIMZIfNDSaNykcsS+V2njfLz/i+rW6GWKT6Ns2A00DceiiUc9d0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,234,1665439200"; 
   d="scan'208";a="42296031"
X-MGA-submission: =?us-ascii?q?MDEuZZq6TC939e/jG7HbxLQKSRnPpIpTeI3FiH?=
 =?us-ascii?q?5ZUEaERlxBcDX4wKfYH1X9mWIkPwyu7bDaneyXBrHFJpDLrMEtyjBu4X?=
 =?us-ascii?q?zegZOLPxF09E9u4KTKC+M6a31zYYL7y0jxceTF6eSkXzUgspgHeD9OVw?=
 =?us-ascii?q?3CpY5iVzxQJhQfhNiGiqj7gw=3D=3D?=
Received: from mail-vs1-f50.google.com ([209.85.217.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 17:17:03 +0100
Received: by mail-vs1-f50.google.com with SMTP id h26so7268163vsr.5
        for <cocci@inria.fr>; Sat, 10 Dec 2022 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jyl4oPZX1wWnkDsBxNFj9Uf7wkXT9xU75NQGtlttiWU=;
        b=BnT7OH55gyhTieGknOp+IY2q4NjKq4F1GuVrNGPSs3x8datozZPkaPZuIi0OvgPF2E
         soOILUZA72g8sF6KERBKdZZt6G3LxyOuvfSqb+HC/U2/nLwRzby/YOGRp+edGhEnUfPC
         zMfKWPOtNTUAVi6BrU/Xulz2LT7yZMVlOHjbveWU6Us+kDvWbU9VC3i8SdnJ+N16EE0j
         fzgVqv2XGot2G2cmXEliwCnUj0ZEUAoSDXZgoVm9FgqpILLc3UsncJhDbrLlwYx4afC5
         d5VYfKJs/fn3+2LCUJSmNXea3NDrYK0+eE4qQNPHh02Ro7sR2vBmyVhuFWHdP1khSb8q
         t0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jyl4oPZX1wWnkDsBxNFj9Uf7wkXT9xU75NQGtlttiWU=;
        b=42fB673Lm13+NByHT8rcsOUkESX7NH/1q96OY/8uG9lWh/njcTSCtIrPd2e82zoj4u
         zVpeam5QVojljuqiC7VWUH9iPsPi0tHRQb9pUgEiyfaq7+4vPSiFByvvEB+rMLNhhQah
         2JV4Q6xrvHJC2CnFqN1QGA9RhiUOGpqCpyNqa3cp8LeQZaVm4iXa3ECHwmjixRiyAv1L
         HTT26iqs04TnMpNVNrWLIF7DNjV4s0wB+3ioprEpRy6mlwnhta1kHLQR9Bf3eij2o26M
         UfFhiMMfxHA1wc6F8pyEJlRzDtuRhqoK1kDuS2pLUhqCIyww0FcUT1zbqvuZY18Mj69B
         N7oQ==
X-Gm-Message-State: ANoB5pnc+NFK2mtEwjqYpU+gBbzqAky6rBWnGL1uinfuHjHZsjPiyr+L
	pObRltI12a7cHXls6+YuY1cW7hTAPk46Cb3e/do=
X-Google-Smtp-Source: AA0mqf50PYsYv0JnPhFGK1cyT6Al8yBifmGACktG1xbJCv17ZXLFj6VwCF3C/GrLphie36XwoJTYEUA46J+7oat6pvc=
X-Received: by 2002:a67:e916:0:b0:3b0:6e00:ab57 with SMTP id
 c22-20020a67e916000000b003b06e00ab57mr41483783vso.73.1670689021823; Sat, 10
 Dec 2022 08:17:01 -0800 (PST)
MIME-Version: 1.0
References: <CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu+ujJcZYCcdg@mail.gmail.com>
 <833178e5-29f9-5e7f-6ec7-8ac028dffdc3@web.de>
In-Reply-To: <833178e5-29f9-5e7f-6ec7-8ac028dffdc3@web.de>
From: Jonathon Reinhart <jonathon.reinhart@gmail.com>
Date: Sat, 10 Dec 2022 11:16:35 -0500
Message-ID: <CAPFHKzeapJcz_LNYajjsKPefeCfO3ZgtYprtVBWLunk8=YgNMw@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Converting strncmp() to strcmp(): constraint on
 variable cannot be evaluated due to disjunction
Reply-To: Jonathon Reinhart <jonathon.reinhart@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 775
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/CAPFHKzeapJcz_LNYajjsKPefeCfO3ZgtYprtVBWLunk8%3DYgNMw%40mail.gmail.com>

On Sat, Dec 10, 2022, 07:20 Markus Elfring <Markus.Elfring@web.de> wrote:
> >     @initialize:python@
> >     @@
> >     def string_literal_len(sl):
> >         if not (sl.startswith('"') and sl.endswith('"')):
> >             raise Exception('String literal not enclosed with double qu=
otes')
> >         return len(sl) - 2
> >
> >
> >     @@
> >     expression x;
> >     constant char[] literal;
> >     constant int n : script:python(literal) { string_literal_len(litera=
l) > 0 };
>
> I imagine that you would like to use the condition check =E2=80=9Cstring_=
literal_len(literal) =3D=3D n=E2=80=9D.

Doh! Yes, that's exactly what I mean to write. I'm not sure why I wrote > 0=
.

> >     - strncmp(x, literal, n)
> >     + strcmp(x, literal)
>
> I suggest to take the following SmPL code variant also into account.
>
> -strncmp
> +strcmp
>  (x, literal
> -           , n
>  )

Thanks for the suggestion. I did see that variant, and I like it for
removing a parameter, but I feel it is less clear in this situation.

> > Can someone let me know if I'm on the right path here?
>
> Your transformation approach looks promising.

Good to know that I'm not missing some other easier approach.

> > Examples with constraints are scarce,
>
> I know that such examples were published.
>
>
> > and I haven't found any examples of using Python script constraints
> > on a normal (non-position) metavariable.
>
> It seems to be very challenging to find similar demonstrations for
> the semantic patch language.
>
> The software documentation can be improved considerably.

You're right. I shouldn't have said the examples with constraints are
scarce -- I should have said they are difficult to locate amongst all
of the examples that exist.

Then again, I'm brand new to Coccinelle, so I imagine locating the
right information gets easier.

> > I also have some other patches to handle arguments like strlen("foo") a=
nd
> > sizeof("foo") (which is wrong).
>
> Would you like to point any source code places out where you observed
> false positives?

Sorry, I wasn't clear. When I said "wrong", I meant the targeted code
used both of these patterns (in addition to 0. the integer literal
pattern discussed earlier in this thread):

1. strncmp(foo, "bar", strlen("bar"))
2. strncmp(foo, "bar", sizeof("bar"))

Neither is "wrong", per se, but the behavior is different because
sizeof("bar") includes the NUL terminator, and thus sizeof("bar") =3D=3D
strlen("bar")+1. So:

1. effectively means (foo starts with "bar")
2. effectively means (foo matches "bar" exactly)

So when I said 2 was "wrong", it's actually more "correct" (or safe)
when considering replacing it with strcmp().

A semantic patch that handles cases 0. and 1. need to be reviewed
manually to decide if the prefix-matching ("starts with") behavior is
intentional or accidental.

I'll try to post some example target code and my final patch when I
get approval to do so.

Thanks for the feedback! Your previous questions on the mailing list
on the topic of string lengths helped me :-)
