Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB00FD6553E
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fgW9w4Y36d2TfejjjK0Z8E1/GW3kwkclx+yvwLrq6yE=;
  b=nPgyR1cI8X8cDIpEwu7fU73Kkmh0Ocx67THq+CDOjUnabrly/2XxL8WN
   XimArgn6vj6tNtAS8B64TMucTpeNTkLnHg9re6fUteB6J8/PPI5QLdq94
   8K6MUKqbm+5JOfdL1H+CLK1NttJjvvw+bQTMUuq4fSXugtudi2J1eYeim
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@broadcom.com
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195942336"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 19:10:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1035E0D1D; Tue, 26 Nov 2024 19:10:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2BAA9E00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 19:10:43 +0100 (CET)
IronPort-SDR: 67460f22_3cefV9Fpdq6j5Ma89/xFLgOEhja5BzIZsYjlLF+cPT3WF7r
 D9N0CMgHIhXacW/BdPE12ieVZWe1qkzxgZh4g3A==
X-IPAS-Result: =?us-ascii?q?A0HfAgA7DkZnga3bVdFagQmEF31ZNAQLSIRWj02CJJ9XO?=
 =?us-ascii?q?wMPAQMBDTkLBAEBAwSEfAICAopcAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEiGQcOO4V7DYJiAYEkUVUBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEXAggFXgEfAQEBAxIRHQEBNwEPCwsNAgImAgIhEgEFARwGNYJggmQDE?=
 =?us-ascii?q?aQEgQVCiz6BMoEBggwBAQbcH4FkAwYUgQYuhWqCYgGBbIZ5gQF6Jw+BVUSBE?=
 =?us-ascii?q?zeCdT6CYQKBYBWDRoJpgkR5gW2CFxIlhTaBX4FrhzKUBSYJHQMHBw4NHkkPB?=
 =?us-ascii?q?RwDWTIBVRMXCwcFgSkhLAECAYJGf4E2gVEBgxBKgy6BXgU3R4JKaUs3Ag0CN?=
 =?us-ascii?q?oIkfYJNhReBC4EVgklMhA+GKB1AAwtiCz03FBtMoR1HglVsgRYrgUWkGIIgo?=
 =?us-ascii?q?Ew0B4QdgV0GDIonlUczqlGYe44AlVqFPREjgVsjgVwzGiOBAQaCME8DGQ+SG?=
 =?us-ascii?q?8gjKDILMAIHAQoBAQMJkR6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:pH6r7a9KdOp9RukresvADrUDCXqTJUtcMsCJ2f8bNWPcYEJGY0x3y
 WtJDzvSPfiIYzT1c9txOd6x/UlQ7JGDmNJqHABurC9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWcuWo4ow/jb8k825a6s4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE3dFcC0ZxBZMj6M1VEX1/r
 tsiEi4fR0XW7w626OrTpuhEg80iKIz6NtpatCg/lnfWCvEpRZ2FSKLPjTNa9G1o14YeQLCEP
 ptfMGU0BPjDS0Un1lM/Gps1n6Gym2L+dRVSslWcqaEw5i7YywkZPL3FaYKPJYTTHZUE9qqej
 mXAx0TFQS0+DdmwyHmusU6Vl8/GvQquDer+E5Xjq6cy3wzNroAJMzUdUlCwoNGim0umUpReL
 VYV82wgt8APGFeDS9D8W1ipqifBsEdDAJxfFOo17AzLwa3Ri+qEOoQaZiBlWtsh8/cofi4B9
 E+VrojOPwZxopTAHBpx6YyohT+1PCEUK0oLaikFURYJ7rHfTGcb3kKnojFLQP7dszHlJQwc1
 Qxmu8TXuln+pcsC1qH+7Fqexjz1+cOPQQky6QHaGGmi62uVhbJJhaT5tTA3Dt4Zc+51q2VtW
 lBawKByC8hQVvmweNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBknexwzb5tVJW+4M
 RGD0e+02HO1FCv7BUOQS9LgY/nGMYC5RLwJq9iNMYoePMcrLGdrAgkyOhHLgDGFfLcQfVEXY
 srCKZn9Ux72+Ixoyz25Q+pV0LkggEgDKZD7FPjGI+Cc+ePGPha9EO9bWHPXN7xRxP3e/G39r
 Y0EX+PUkEo3bQELSnOGmWLlBQtSdSBjbX03wuQLHtO+zv1OQjF5VaKMn+h/IuSIXc19z4/1w
 510YWcAoHKXuJENAVzihqlLOeK/D6Vs52k2JzItNluO0n0uK9TnpqQGepd9OfFt+OV/xLQmB
 7MIaueRMMRpEz7nwjU6aYWijYpAcB/wuxmCERD4axcCfrlhZTfzxPnaQiXV+hIjNBGH7fkFn
 +X41yfwY4YyeAB5PcOHNNOt1wyQuFYeqsJTXmzJANhYfRTswqdMNSbK0/09eZkNDT7hxTKq8
 RmcLjlFhOvKoq4zqMLog4LdpaiXMuJOJGhoNEiF0qSHbgzh4XuF/Y9MdM2qbALtfjr414v6b
 NoE0symFuMMmWh7lrZVEpFp/PoY3MTurboL9TZUNizHQHrzA4wxP0Tc+9dEs5BM4bpruQGWf
 Ear0fsCMJWrPPLVKnIgFDAHXM+ii85NwiLz6M4rKnrU/CV0pbqLcXtDNim21RByEuFHD5MH8
 8wA5ugt9A2Nujg7OI2njwdV1Vi2AF4ubqEFjqweUajX0lcF61caepHNKD7E0LfWYfV2D0QaC
 Du1hq3Durdi+nT/Y0cDTUbq4+4MqqkN6TZrzUADLWungtDqpOE69zwP/CUVTjZ69ARm0eVyC
 25JKXxKH6eEpW91tZISQ0GtBABzKxmL8WPhy1YytTP4Tmv5ckfvPWECKeK200RByF1lfx9f5
 +u+2kv+dDTXIPHKwSo5XHB6p8zZTdBe8hPInOalFZ+nG6YWTCXEgKj0Q0Y1sDriXN0MgXPYq
 dlQ/OpfbbPxMQgSqfYZD6iYzbEhdwCWFlddQP1O/LI7Ik+EQWucgQOxEkGWft9BA9fo8kXiU
 sxnGZ9pZiSEjS2LqmgWOL4IL7pKh8UW3dsleI7wBGs4orCa/ytIspXRy3DEv1UVYe5SyOQzF
 oCAUAi5MD20pWBVkGrzvsV7KjKGQd0bVjbdgsGx0ss0Tqwmjs89UHsPwoOVvmqUOjRJ5xi7n
 h3OTI6Iwv1AybZDpZrNEKJCDTqaMdnYDbm58i2vgdZjNvbebMHE7VIToHbaIjUMbKcwWst2p
 5uJotXYzEPIh5docmH7yr2qNbhF2tW2Z8VTavnIFXh9mTCQfePd+D0B8HCcBb0Qt/0F/eihZ
 Q+zSPXoRO4vQ90HmUFkMXlPISgSG4HcT/nGpxrki9+uFxJE8wjMDO3/xE/TdWsBKxM5YczvO
 DTV5cSryMtT9rlXJRk+APpjPZ90DXnjVYYidPzzrTOoNXapsHzTpordkQcc1h+TBkmmCMra5
 bf3dir6fjm2u4DKy4h9mK52tRs1En18oLcRemQwxt1IsA25XVU2dbklDZY7C59qy324kNmyY
 TzWd2ItBBnsRTkOI122/N3nWRzZHeAUfMvwIjsy5U6PdiOqH8W6DaB88jt7qWJDEtc5IDpL9
 flFkpExAvSw/n2tbeMa5/j+kO0+g/2DmSlO9kf6nMj/RR0ZBN3mEZCn8BVlDUT6/wPlzS0n5
 lTZgUhOWkayRUX2FIBrfHs99NQxomb01ztxBcuQ6I+3hmhYpdGsDNX1Ieb63rYEaYIBI7tmq
 bYbgYeSyzj+50H/cpfFdz7kbWGYxB5L8gWHwHffeDAv
IronPort-HdrOrdr: A9a23:6KMWV6xtbftQ32qbjJgQKrPwDr1zdoMgy1knxilNoNJuA7Slfq
 eV7Y4mPH7P+U0ssRQb8+xoV5PwJU80maQFhLX5eI3SPjUO21HJEGgB1/qE/9SIIUSXndK1l5
 0QEJSWY+eAa2SS4/yKmTWQIpIPxJ2o/smT6ts2DE0AceipUcxdBstCZDpz23cWeDV7
X-Talos-CUID: 9a23:vRkvz2yH/h38OFauckUZBgUKPvIidTrl0kzCCG2oFVcyb4evV025rfY=
X-Talos-MUID: 9a23:iZDyzArofkNeLwVA344ezzZkDOdUoJiKMUUikNYt+PW9JAx5Gx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="102701089"
X-MGA-submission: =?us-ascii?q?MDGIeyXtZV30QZNyvCUgikzW+UAA9Q27T/4WYF?=
 =?us-ascii?q?6jNajFZn5/4yxa4g8n6zJrxvrXf29c1K7wkWGYDjs9jw7rSFs9YOyMKe?=
 =?us-ascii?q?V6HAueH8SF4vpAk4L7tzSuC8Pc3gtie61EeUuLROw/IMQatfe1cETPep?=
 =?us-ascii?q?DfizW4W7Qn6/e90ihIqen2fA=3D=3D?=
Received: from mail-yb1-f173.google.com ([209.85.219.173])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 19:10:42 +0100
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e38b425ce60so21790276.1
        for <cocci@inria.fr>; Tue, 26 Nov 2024 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732644640; x=1733249440; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgW9w4Y36d2TfejjjK0Z8E1/GW3kwkclx+yvwLrq6yE=;
        b=V6HYVyn2/C3gh9PJeDyrVxvsqrqcyRjhCIQeGHF9euEZz4fo+MXE5UnN4y4MHKXZhP
         Y/qjtoos2x/7oc6+agdDYA0NKqcOJYQLiTNIpWJkTtnY1qn/fgvLF7fG1IaLkpBu8VIp
         bQsgc85zVRXcF4UqWaa2jvOqbQoyercRYvYto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644640; x=1733249440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgW9w4Y36d2TfejjjK0Z8E1/GW3kwkclx+yvwLrq6yE=;
        b=iYfUoaS8YiV3tqt8pqJ75uExQHox9gAYfhunJYxtlAaNcZAFFHs0/liStwq01kGbmX
         +p5zT4SoSNWVmJ//HKpUCFWNjERpB5jPUeC8IpJ1GyZCc4obh/Qd74d7ZAaoKS84fiun
         D4qYmM78y/Z+kzb55h8SDdTrVxoNfhA+yBjWBkNPequBSFzo/54JZoUl45MdH/ob5zx6
         /Uz/5ldiMNq5YY8ar96AdrvrFUcUR3VOHy1/HzZkWUbSLOJqus9Sjq+nErRREfKhVvl4
         xsm7Qk+K3pHeU1VjITU5jxU7SfzcFlKnJMbKktXVPxJh4OqQ19njny12iYebnbD4nURR
         4grA==
X-Gm-Message-State: AOJu0YxwO2mTxKzast2i41MBAso15jvO3DrOGlXojMKBFpRyCYHlSdNB
	/zZ7mZ0iaw0NdH9pz4Q5lvXYjvDq7HVj06hGCw/mouQArnAN698J4IPk38oarCIEWWYdklM2xY0
	SNg6ZrqVd7paY62Hbs2BysMnVq8yIC0h1GBRN241aYimlp0KWFw==
X-Gm-Gg: ASbGncun+Jc7BozKso+cygToFy8972YyZQ7MG1KbPu0ypnYYeJleQL+iW0rdmJOyBCw
	x90vaeOPilm850+f0zUq35/GCXA9WM5tM
X-Google-Smtp-Source: AGHT+IGJhgq380zNb7310oT/sNhbqgK3RIMEay4VSflvFzbKynnZqVzterW1rqgUNua38dnzH799j+s4iy2CWS15Yw4=
X-Received: by 2002:a05:6902:1243:b0:e30:c850:b77e with SMTP id
 3f1490d57ef6-e395ae2f3d1mr325590276.3.1732644640401; Tue, 26 Nov 2024
 10:10:40 -0800 (PST)
MIME-Version: 1.0
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <81d0c6e4-0d7e-4f40-99e5-d4229613348d@web.de>
In-Reply-To: <81d0c6e4-0d7e-4f40-99e5-d4229613348d@web.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 26 Nov 2024 13:10:28 -0500
Message-ID: <CABQX2QPEz7ukgtt3GS-t_UYcGJTuetkhWS=nf=7r9sz+wCDopA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Replacing type names
Reply-To: Zack Rusin <zack.rusin@broadcom.com>
X-Loop: cocci@inria.fr
X-Sequence: 2132
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/CABQX2QPEz7ukgtt3GS-t_UYcGJTuetkhWS%3Dnf%3D7r9sz%2BwCDopA%40mail.gmail.com>

On Tue, Nov 26, 2024 at 12:50=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> =E2=80=A6
> > My input script is:
> > https://gist.github.com/zackr/198db11e5e5243adbdc59b9844d8eb6b
> =E2=80=A6
> > Plus is there any way to transform arbitrary function names? =E2=80=A6
> I suggest to take another look at corresponding case distinctions.
> How would you usually recognise that a name belongs to a relevant functio=
n?
>
> * Would you like to search for function implementations so that their ide=
ntifiers
>   can be adjusted?
>
> * Are you looking for any additional metavariable types?

I think in general I'm just wondering whether it's currently possible
and your thoughts on doing this. In general it would seem like if we
could get "fresh" modifier on type and function that would solve the
problem, i.e.:
@replace_types@
type t;
fresh type renamed =3D script:python(t) { camel_to_snake(t) };
position p : script:python(t) { needs_rename(t) };
@@

-t@p
+renamed

@replace_functions@
function f;
fresh function renamed =3D script:python(f) { camel_to_snake(f) };
position p : script:python(f) { needs_rename(f) };
@@

-f@p
+renamed

but I'm not sure if this is a task that Coccinelle was meant for in
the first place.

The use case is rather trivial: we have a lot of source files that are
both autogenerated and written by hand that are used in a lot of
projects. Internally our style and builtin macros/functions have
specific requirements. Sometimes those files need to be added to Linux
kernel for some driver so I'm using Coccinelle to transform those
files (convert some function names, macros, types to ones that are
native to the kernel), I was thinking of also doing the camel case to
snake case conversion with Coccinelle to keep the transformation
pipeline within a single tool, but it seems like just a regex
replacement over the text using python/perl might be an easier
project.

z
