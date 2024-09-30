Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4DECE8362
	for <cocci@archiver.kernel.org>; Mon, 30 Sep 2024 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Xne8Bd4nQxR5dYtW8UaBS1QtNunVXhV0RwxEWLvVs1s=;
  b=uNObUCobfxD77LxfswTCJ+xuLpJBQQPGrkDr8TkrDrZjZ1ONwetlYWQv
   0ykj5BREU+bQDMuAGgoUSN8Y6wyLvhUdVlAqikJHh5+7qGkLd+mvl85vE
   KuDRRMsMGPYh+Dvc6KOCF3LCjqMcWzTTG5jAA84JAN3aj49ayLgNHSz4W
   g=;
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
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186040994"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2024 18:19:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B19BBE0141; Mon, 30 Sep 2024 18:19:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 30FEFE0035
	for <cocci@sympa.inria.fr>; Mon, 30 Sep 2024 18:16:10 +0200 (CEST)
IronPort-SDR: 66facec8_URp390bjcJQeRUTvqdda7Q3tZuKQEaTrAlA5Gp7q6mvjsOC
 ezstTbIrMlLmHvl+ni5mwLrXta0UH4iAb9YbD9g==
X-IPAS-Result: =?us-ascii?q?A0F8AwBozfpmfymnVdFagQmBT4JEfVk0BAtILYQpkCAKB?=
 =?us-ascii?q?oE8AwOCPQGJNJBNgVaBQD4PAQMBDTsJBAEBAwEDgUmDNwJ3iRECHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFOwczD?=
 =?us-ascii?q?YJjAYEJG2ECBQMJMAIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAg0fXwEBAQMSER0BGx0BAwwGBQsNAgImAgIhAREBBQEcBhMigmCCL?=
 =?us-ascii?q?wEDMQMRBqMVgQVCizyBFQUCFoEBgg0G2lsKGSgNbAOBYAIBBhSBBi6Ecylbg?=
 =?us-ascii?q?joaAQVteocOaXonG32BEIFKglgdPoJDBxcEgV4Vg0aCaQSSCYdkgVGBPXwlT?=
 =?us-ascii?q?VWIKZBWJggBBhcDBwcJBQQJEwYFBQJCCQYFChIDBAMEBAECCxMJAwMCDgIIA?=
 =?us-ascii?q?wIIBg4CEQE/EgQTCg0LAwYFHwgCBAcMEQoXAgMDAgIDAgUDAwUFBQIDBQMEA?=
 =?us-ascii?q?wUDAwIRAQYCBQ0IBgsFBQcCBgIECAUCAgMDAwIEDwMDAwIFAgIDAwECBg8GA?=
 =?us-ascii?q?gIDBQYDAwMDAwYDAwIGAwMCAgMCAwEDAgMBAgMCAgIIAgIDBQQFAgIECBACA?=
 =?us-ascii?q?gICAwMIAwMKBAICBAEEAgQCBAYCBAICAQYCAwMCAwIHAgIEAgICAgMCBAUCA?=
 =?us-ascii?q?wMDAgICAQkCBQEBBgIDAwIDBQMJAwQFAgMIAQECAgcHAwMEAwECAQUEAgIGB?=
 =?us-ascii?q?QIDAgIEAgQFAwIDBgYCAQMCCgYDBQMDAwMCAwIDAwIFAggCAgQEBQQCBQQCB?=
 =?us-ascii?q?AMDAwEKAgYDAgIFAQECAgQDAgQEBwICBw8DAgcFAgUFBQIHAQYFAgIDAgYBA?=
 =?us-ascii?q?gIGAQYCBAECDQEBAgIDAQMDAwcCBAMCCAIDAw8BAwMJBgUEBQQDCQQPAgQBC?=
 =?us-ascii?q?AMBAQQIAgQDAgwCAiACBQsEBBcIAwEBAwEBAgICAg0DAgMCAgMKAgMCCgYEA?=
 =?us-ascii?q?gQBAQEEBAEEAgECBwQOCQUICAEDAgEEBgECEAUQCQMHBAIQBgoFAwIDBQEFF?=
 =?us-ascii?q?QMIAwkCBAwDBQgCAwIGAwYCBgEGAwcLAQEHCAUDAwMCFQECAg8IBAYOCAIDA?=
 =?us-ascii?q?wMECgMSAgYOAwMCAwIBAgICAwUEBQIHAwMKBQIIAwIIBQMHCQQKAgoCBgMCA?=
 =?us-ascii?q?gICBQwBAQEBAgMCBQMHBwgIBAUEAwEBBgYMHgICAwQPAwkDBgsBBQUBAwICD?=
 =?us-ascii?q?gMGAgMGBgEJBAEFBAkCBQcGBQIBFAcNBwYCCgIHAgICAwECCAkIAgMCCgQBD?=
 =?us-ascii?q?gQZAgUBAgIDBwIDAhMDAwUECAICAgIDAgEKCwMCAgMDAwMFBQMCGQMDAgEKB?=
 =?us-ascii?q?QwFBAMEAgIBHQMBBQIDCgEFCQEGAgIDAgUCAwYEAgQBDgEBAQMGCwkUAgICC?=
 =?us-ascii?q?QgDCAMFDQINAgMFAgILPQsFAQEEAwEIARctAgQCBgwBAQECAwYCAgIVBQUDB?=
 =?us-ascii?q?QMIAQMBAhMIBgIBAwoKAgIEAgYDAwIKAwEIAgICDwMJAgcCDQICAwMMDwQDA?=
 =?us-ascii?q?wMDCAICAhEJCgICAgwECgIJAgIDBgECAwMFAwIBAQEELwIEBwEDBgoDAgICC?=
 =?us-ascii?q?QgKCQMDBQMMAQYEAQIDDAEBAhMECQMCAQIBAQYIAQECBAEEAgcGAgICAgoDB?=
 =?us-ascii?q?QMCAwUTBQQCAhkDBAUDBQMDBAcBAgUECgkCBQMCBAMDAgQEAggFCQQDCwYBA?=
 =?us-ascii?q?QEDBAMBAQgHBwMCAQEDAQEKCwgNCAMIAwYJAwEGAQEFEggCAw4CAgIDAgEKB?=
 =?us-ascii?q?ggFAgMGDQIEAhkBDAMBAwMFDgQUAwQFAgIPDAECAwMEBQMFAgICAwICAgUEA?=
 =?us-ascii?q?QIEAgQBCAQJAQICAgMCAQECBAYFAgICAwIHDAcDBAIGAgYCAwIHCwsCAwYFB?=
 =?us-ascii?q?QMFAh4CAwICBAMDFQEBAwECAQIDAgIDAgMEAQMDAgEBAQMHAgICBAEBAQQGB?=
 =?us-ascii?q?QICAwwCAwMBAQYBAwECDwYFBgQBCgMCFAMDIgIPBQgBJgEEAgIBAjYCAgMED?=
 =?us-ascii?q?QgFAgIHAgQMAgQPBQMDDgYWBgEECAQFBAQMCgMGDgcXEQEBBAQCCAQCAg0HA?=
 =?us-ascii?q?gwCAgYEAgIHIwYDBQkDAgUFEAICCwIEAxUEBBsDAQIKAgIYAgEHAQISAQcCA?=
 =?us-ascii?q?gEUAgoDAgcGBwIcAgIDAwcEBgEJAwQJEQMLAQUGBQEBBBEBAgECAQECAwMOA?=
 =?us-ascii?q?QICAwQCAgEJAgIBAQINCAEEAwEHAgUDBQMKAQEBAgEECQQPBgMFAwMHAwQCA?=
 =?us-ascii?q?wIGAgQEAgIDAwIDAQUDAgECAwkCAQ8RCg8CAgMEAgYCAgEEKwQBFQUCAwQCA?=
 =?us-ascii?q?gcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICAgMWAgUBBAkDAwUSDSMDAwECA?=
 =?us-ascii?q?gIDBwoDBQIBAQIEAwUDAwkNBwIDAQIBAwUDAQIBAgkDBwICAwMFEhkFAwIPA?=
 =?us-ascii?q?wIBBQQCCBILBwEBDxYFBAkFFQMGAgMGFwsEBQMDAwEMBQwOAgILAxcFAQQHA?=
 =?us-ascii?q?QMQCwMEBAIDAxICARIBAwQCCQIEAQIIAgICAgIEAQEFBAIEAwIFAgQBCAQFA?=
 =?us-ascii?q?wMOBAMICQMFAwwUAgICCQIDAQIDAwMEDQgWDQMCDhsKFxMHBwMDBAsCCQMED?=
 =?us-ascii?q?QIEAgIBBgMGCgYWAQIYAgIGDgQDAwgDAgMCAgECAgIBEwICCQgNBQkFBwIWB?=
 =?us-ascii?q?AIDCAEJAxECAwIUAQYCCAMHAQEEAgIaEQoBAQMBAgEHJgILGRobHQIJAyMPA?=
 =?us-ascii?q?wsJCBM9AQsHMgQ0ARQUByshX6p9gVsBR4JJPFEsBIFBgTKiUIIdoQBngzuMF?=
 =?us-ascii?q?pVAM4QFjQGZP5h2jXuVThOFMBEjEoE5CimBXHCBAYI2TwMZD4k2iGW8PD8yA?=
 =?us-ascii?q?gE4AgcBCgEBAwmMCYFLAQE?=
IronPort-PHdr: A9a23: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
 BUxj1kmCdk=
IronPort-Data: A9a23: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
 vRAI5TzOahdFH1s5Q==
IronPort-HdrOrdr: A9a23:FVLSG67GlxEdgmpZ3APXwP3XdLJyesId70hD6qm+c20tTiX+rb
 HUoB17726NtN91YhsdcL+7Scy9qB/nhPxICMwqTNSftWrd2VdATrsSibcKqgeIc0bDH6xmtZ
 uIGJIOb+EYY2IK6/oSIzPVLz/j+rS6GWyT6ts2Bk0CcT1X
X-Talos-CUID: 9a23:IqTq62Cw/RcizqL6Ew97pFA2PdEXTkzynUXvBU29A3s2Y5TAHA==
X-Talos-MUID: 9a23:Xw6Q2wlTLOFZv0U4BkqVdnpvbex285yCK3sLz5wUl8ytZSFgOyyk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="97807742"
X-MGA-submission: =?us-ascii?q?MDGLWgNUA1ybZaIuPAvMYDYLjftPIRz+vMNmbB?=
 =?us-ascii?q?epkxJIIWS4T7SXzh9AAkxjapr+4a8+vBMf9DqzlaZiIqxVhHWp2Yw6on?=
 =?us-ascii?q?TYA85RNKtp4X7QtlN/CxzXaLLJLKNQUDuz76hI+aH/+bxPXC4Y7tncLv?=
 =?us-ascii?q?bWD4BsQZ63b/7AV7C6uRM+rw=3D=3D?=
Received: from mail-lf1-f41.google.com ([209.85.167.41])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 18:16:09 +0200
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so2060012e87.1;
        Mon, 30 Sep 2024 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727712967; x=1728317767; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xne8Bd4nQxR5dYtW8UaBS1QtNunVXhV0RwxEWLvVs1s=;
        b=Ow8qtYzYtHVYYT8Rq/lErzQ0Rcq8uujlh4038pOkuC16nH6rfG+Ishkl6zQjsBzbRC
         6QEkZ7lkmjV/aoR6qvE24W79mayOq1bNGeO1mhvyjugolTFs4sI9Ovsn61OmfDlmqGVC
         lEa43eUdynh1eROGQ9TvGMtVq9j5JtDeSAqJoooKzY3GSqPPQ6X4d4IxMWAJ72GZObHi
         eLRdKa0TmOwC+EejFR9KyrfllNX1k386ETJiNh44lEYPKvAIinK+sDmDe6/3lbInv50W
         Xa9qoCenH9eNXH52XM8p2+P7W7dnnpf95GgtzqumCiZ8hsyfm/R/bMfPvLON9BQ8brmn
         kBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727712967; x=1728317767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xne8Bd4nQxR5dYtW8UaBS1QtNunVXhV0RwxEWLvVs1s=;
        b=fR6yQ3dgooi461gCKwLY9OIu1gGASLzAyZLL0mJo/JWJ0bphvJxFdWpVObZktwr5yB
         Hjx93Ts+xvO8721W9DX4E7UlLs/ToXLV4bKDSQ/JKqR93pcQ90HfOMPAh1fnXGnMtVy5
         /4NsdtLe8vLFEfnCrG/tgtk5u9GwQfeUbDaVeKftBHs1aeDytBE2KkXUpd/R9fPxgfKZ
         +msZ3U5h5dRBySk75EcNX/b3dEX04Fc/JxyWhz42fCBLBkwuEgQk3T+Bsur/hOsiFVQk
         3AWRgCZQviZ6TVRrJ2uazUhMlUgq8saowIQ+fscbBbvuGH3XfEn91wW+K64PV0Ty9pwL
         fNDQ==
X-Gm-Message-State: AOJu0YyW6yXd9SM96Eu4e1NDvujjtbybC8BbwMpszSx5qvoGt4UhUmG6
	8rnXchdWePELYR68CXEo60JjLqv/TAXKJhq6x09aHZ8q8mSfK1liLv567CDlbL3qZ+P6DaLDLwN
	UdMwkxgPXfwUft1DMYHlKMkA4PyAXl5C7JoW5jRCL
X-Google-Smtp-Source: AGHT+IF2ALy2y5mbyp69xSK95smjrYY8Y2frXz1saKKkuTuirDj93wqfVNYuyJHcmJK7JEqElp5PSO3aToWXC6v057c=
X-Received: by 2002:a05:6512:b81:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-5389fc468f0mr6521315e87.25.1727712966406; Mon, 30 Sep 2024
 09:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com>
 <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr>
In-Reply-To: <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 30 Sep 2024 21:16:47 +0500
Message-ID: <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, efremov@linux.com, nicolas.palix@univ-grenoble-alpes.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Assistance in Coccinelle script
Reply-To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1900
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/CACzwLxiaXLLSZH%3DrufJkkyr07u45W40ENd%3DBXqU4B1NoyS1iag%40mail.gmail.com>

On Mon, Sep 30, 2024 at 8:41=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:
>
> Hello,
>
> I haven't studied it in detail, but I have the impression you want:
>
> position p !=3D {r1.p,r2.p};
>
> and not depends on !r1 && !r2.  The depends on will check that the rules
> r1 and r2 match nowhere in the file.  The fact that the position variable=
s
> are all called p doesn't mean there is any connection between them.

Thanks. It solves the current problem, though it false-positively matches
https://elixir.bootlin.com/linux/v6.11/source/arch/x86/kvm/svm/sev.c#L1161

$ spatch --sp-file copy_from_user.cocci arch/x86/kvm/svm/sev.c
....
arch/x86/kvm/svm/sev.c:1161:6-20: match !!!
arch/x86/kvm/svm/sev.c:1199:7-21: match !!!
arch/x86/kvm/svm/sev.c:1393:5-19: match !!!
arch/x86/kvm/svm/sev.c:2293:7-21: match !!!

I expected to cover #L1161 in @r1@ to ignore it via position p !=3D {r1.p, =
r2.p};

Will try to work with these rules and @missing@ against them. If you spot
the obvious problem, please let me know. Thanks.

Here is the modified script:

// __user exists in parent function parameter.
@r1@
identifier f, param;
attribute name __user;
expression E2;
position p;
type T;
@@
f(..., T __user *param, ...)
{
...
(
copy_from_user@p(..., param, ...)
|
copy_from_user@p(..., param + E2, ...)
)
...
}

// __user exists inline copy_from_user() casting.
@r2 exists@
identifier f, ptr;
position p;
type T;
@@
f(...)
{
...
(
T __user *ptr =3D ...;
...
copy_from_user@p(..., ptr, ...)
|
copy_from_user@p(..., u64_to_user_ptr(...), ...)
)
...
}

@missing@
position p !=3D {r1.p, r2.p};
@@
copy_from_user@p(...)

@script:python@
p << missing.p;
@@
msg =3D "match !!!"
coccilib.report.print_report(p[0], msg)
