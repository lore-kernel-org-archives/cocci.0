Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA210C0218A
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 19:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FgpSNPeAjFZp+XVJ99wWjxWH+/lWeKYYdQIoeMWl0ls=;
  b=jsrqTeIdGARC298go8WGXRWAZX7US6+8hB09lQRAuoit1lUAZuyl2RAQ
   o58Fu/WrxQ3ska+eJj2OGrLIf+iDTHh1kK02SAd1YSdsGC/2m3j+Ui8Cw
   vFy7f5DZ2ClhvLGGzmf1G6/AYg8NyWlPY32tXmTi76jMyU3zMPQDC10yv
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.13,239,1732575600"; 
   d="scan'208";a="205264381"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 20:06:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E7966E0D1E; Mon, 27 Jan 2025 20:06:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 53E9EE00A5
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 20:06:00 +0100 (CET)
IronPort-SDR: 6797d917_2k/8tZX9AM8mmQlvL08LgxUUClhv5R8+xerrjPRbdeNbA73
 E7p58f+hSy9bgY33OYanSG7e9Rs8YxtF6v7EgaQ==
X-IPAS-Result: =?us-ascii?q?A0G0AgDo15dndDLYVdFagQmBU4FyUn1aMwRTBIRSg0+MA?=
 =?us-ascii?q?IIhA5FKiniBVoFAFigPAQMBCwEBNA4CBAEBAwEDOIFUgi5CAgICinUCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQASMgDhIphXsNg?=
 =?us-ascii?q?mIBM3FhAgUDOgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEFAggFHz8BHgEBAQECARIRHQEbHQEDDAYFCw0CAiYCAiIRAQUBHAYBCwcUB?=
 =?us-ascii?q?giCYYIvAQMOIwMBEAape4EFQopEeoEVBQIWgQGCDQaBCVADDy9P13MKGSgNb?=
 =?us-ascii?q?4FhAgcJAQqBBi6EdClcgjgdAYFsg387g0J6J4IogRWCdzM+gmEBAgGBXhWDR?=
 =?us-ascii?q?oJpBIIvS3otAoFWXiVnhmaDDYEfgTt0O4ElgW2BXIMLin8IAQYfEgkJEwYKA?=
 =?us-ascii?q?ksLChIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwoNCwcFHwoIDBEKKAMiB?=
 =?us-ascii?q?A4rDwNZBTQBCAYCAgQEAgQCCgIJAgIIBwIUAwIEBAIBBRIDCwEFBgUBAQQMD?=
 =?us-ascii?q?gICAwMCAgEIAgIBAQIUAQQDAQcCAQQDBQMKAQEBAgEEFAYDBQMDBwMEAgMCB?=
 =?us-ascii?q?gIEBQUCAgMDAgMBAwMCAQIDCRAPFgICAwQCBgICAQQmAgEVBQIDBAICBwICA?=
 =?us-ascii?q?wECAQICAgQCBAICBgMJCAECAgcBAgICAxUCBQEECQMDBRIMIAMCAgICAwcKA?=
 =?us-ascii?q?wUCAQECBAMDAwMJDQcCAwECAQMFAwECAQIJAwYCAgMDBBIZBQMCDwMCAQUEA?=
 =?us-ascii?q?ggQCwcBAQ8UBQQJBRUDBgIDAxYLBAUDAwMBDA8OAgILAxcFAQEHAQMNCAMEB?=
 =?us-ascii?q?AIDAwkCARABAwQCCQIEAQIKAgICAgIEAQEFBAIEAwIFAgIBCAQDAwMNBAMIC?=
 =?us-ascii?q?AMFAwwSAgICCQIDAQIDAwMEDQgdBQkRCwIJAwQNAgQCAgEGAwYKBhUBAhgCA?=
 =?us-ascii?q?gYMBAMDCAMCAwICAQICAgERAgIJCA0FCQUGAgIVAwIDCAEJAw8DAhQBBgIIA?=
 =?us-ascii?q?wcBAQQCAgoRCgEBAgIBBiYDAQECFBMHAwgCAgICBhYMAQUHAwcPBQUEAgIWA?=
 =?us-ascii?q?wMSBAQQAgIDAwIBARQGFQEFAgMGCwEGAQIFBAIDBAISAhEVAwMEBgMBAgoQA?=
 =?us-ascii?q?gQCCQoBBQQDBwUCHwMDAgIFCwIIAgIFAgUHAwkOAQIFAwQJAhQCEAICAgIIF?=
 =?us-ascii?q?gICAgUeAyYCBAMDAwMLAQICDgkDBDoGEQQCAwMCDgECAgsBAgIEAgMBBAcJA?=
 =?us-ascii?q?wMJCgcBCg0HAgIKCAkQAQICDwcDAgICAgYHDgMCEw8FBgYCCgcNCgQCAQICE?=
 =?us-ascii?q?wIDCQYDBQ0DBwQKDQIVAhYFAyACCAkLAgcRAgUSAw4FAwICEQQCAwYFAwEHA?=
 =?us-ascii?q?RcDBwgCAgwCAgICBQIFAgUXEQENBAMDAwIIAQQVBgMJCCobEgEBAQUBCQIDA?=
 =?us-ascii?q?gMECAMDAwIDBAwLAgEHCAMDBgsICQYDAgcIGQMFBAMHBQshAgYDAgQFBAEFA?=
 =?us-ascii?q?hUNAgMZAgYDBhQJDAIGDgcJAwcBAQECAgIIAQUFEgIDBAIFBAQBAQgDAwQGA?=
 =?us-ascii?q?gEDAgICAQQCCgEBAQIKAggKAQkTBAMIAwMDAwMFAQICCAQTBQUCAQUMEwwBC?=
 =?us-ascii?q?gYDBgMEAgICCwcCAwMDAgcBCxoJAgEDAgIFAgIBBQMCAggEAwIBAQkCAwIIA?=
 =?us-ascii?q?QICAQECAgIEAQcBBAcGAQECBAICNQIBAwkCBQEBAQ4CAgQCAgMCAgIEAgQBA?=
 =?us-ascii?q?gYLBAUNAQECAQICAQEBBAEIAwEBAQICAwMFAwUDCA8NAQEXCxsFAgQFAgILH?=
 =?us-ascii?q?QIJAyMPAwsJCBM9DAcyBDYBFBQHBiWBAJxTPYMPES00AQE8JC0BEwgOAlAhI?=
 =?us-ascii?q?GwHDx8FBjqSQBSDO4xejhKVEQeCaYE1jBiVSDOEBIFXiy+GOpMPmHwigjaIW?=
 =?us-ascii?q?lmBeZVQC4UkAgoHBhEjEoEyOoErHgwHcIEBggIBATIJCjwDGQ+OWYNChRPDK?=
 =?us-ascii?q?ik1AgEBOAIHAQoBAQMJhWmKDi0FgUsBAQ?=
IronPort-PHdr: A9a23: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
 Ml+KwybUEcgyLbXHBMMZ5KqFA==
IronPort-Data: A9a23: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
 QVAL5Tz6Ipp5ayRNHCrJd01xq9M
IronPort-HdrOrdr: A9a23:/Z+LgK7ks5rVRhkcMAPXwDPXdLJyesId70hD6qm+c20tTiX+rb
 HToB17726ItN91YhsdcL+7SdG9qB/nhPlICMwqTMyftWrdyRWVxeNZnO7fKlTbckWUh4xgPO
 VbAtJD4bXLfDtHZK3BkW2F+rgbsb+6GeyT9Jjj5kYoYgdwdal64gt1TiqdGFZnXRRLCPMCeK
 a0145oo36Pdx0sAPhTxUNrYwEAnbD2fV7dACLuziRG1DWz
X-Talos-CUID: =?us-ascii?q?9a23=3AVDcRdGmzOmbaB/4Ojgkvk3UK33bXOSTb53fNIkm?=
 =?us-ascii?q?JNWgqROa8dAHLxoZbqdU7zg=3D=3D?=
X-Talos-MUID: 9a23:yG/2OwapcJo5m+BTjgXXizFSLsRUufqwGgdcrbYLuMzfOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,239,1732575600"; 
   d="scan'208";a="205264373"
X-MGA-submission: =?us-ascii?q?MDHUkC2K3Nnv2Grf6rKCtUq8GpuXI7HfCl054/?=
 =?us-ascii?q?MaYlQ5xD98CCyIsgCJujMgVE+9qG58fWA2jZySdKvGJQrZVvhWD4LVoy?=
 =?us-ascii?q?bePQvszWb4sY2IiCjDkxTgsC2JfBJs4+PC8S7m6RiuYdnVTJegcOmdiT?=
 =?us-ascii?q?zc2Vct1RiWjga/j1HclWLEGQ=3D=3D?=
Received: from mail-pj1-f50.google.com ([209.85.216.50])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 20:05:59 +0100
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso6445557a91.0;
        Mon, 27 Jan 2025 11:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004758; x=1738609558; darn=inria.fr;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FgpSNPeAjFZp+XVJ99wWjxWH+/lWeKYYdQIoeMWl0ls=;
        b=nYcVcFAmRTBWEtUn3vm0A4BwDWPhLDA2NGwQqeCcecwTg1h2PLBItgNQtpaEwyitNZ
         ecKyuXyI+dlj2MnFHUI8zW2wnKFszMmKOnSKZgzNIjqWsJ4NjK73v0jB+jLMwVuDzG7O
         a/dBlIYbvkkHAf2VpoQXgB8L1R0KhRFyxkpXmMce3omjifZGnZImD7LcMP5bNFXLCmR0
         ZyunI4sSnHUbQNsfttlcWOsnWFx2mizc2hlB3CJicokTIOwWRw7yTR+gWq1zSd3SBUyC
         aL2bSgec2z6J1BT9N16InYKviwjUmAHbYzTfhpZJIHUELm7XG/HRTIj/MuflHK848ncJ
         SqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004758; x=1738609558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgpSNPeAjFZp+XVJ99wWjxWH+/lWeKYYdQIoeMWl0ls=;
        b=rG1omQwkg3/Lp/inX94DGA9kYEzmyUk0jfA7nr+WqvI+HRiewsqNNbuJh3GlHf0RDi
         7JAj4QYMjjDQRi6JXSzWTppL3o1LBusBlJU/JIi/rKecR6KDz63dDiejrsFIbjNPcHf6
         mcy/083e0UK0ha7ZA4l7K2XKOloxBmc0cOPvXVSndmBk731xaLT/va4o4e6QZAMbzpmC
         p1z9z1AyXibjTU2LZWuzSNZ87lZYWLaFQkbwS8b2EtyuUSKoZxT0oiJlrv1bmTqymdzq
         QOeMdxXI9I26GqouNAvZZGY661D8KkgkfH+2j14vbqtYZA3BWoMKjSxJyLA97mMiN1vX
         eRyw==
X-Forwarded-Encrypted: i=1; AJvYcCUdj2ay+jftk6TRgm7qc5h9cZURGn7J2hIEtlQWCqUgcIVgxGG8M3XvdOM06gUJMZocj6NaGhzZ/4CjVSY=@inria.fr, AJvYcCUkO9BJZG5GoRcSBK66wvGCTUxil257IKRJ41sjKFtqI19KnKMoFrzop7yVWDoYYmfcsEgoWCA=@inria.fr
X-Gm-Message-State: AOJu0YzhVoJVQVCDMVj39Ks9sW2UgepZhUddOKFEPd8Lu5XAj3SrEx2p
	7IohgCwuKCS80CVFYSgJWglUSj+0LNKICWi8xdHU1YPT5Y8gkPlw
X-Gm-Gg: ASbGncsK+Hi+RDbeyJx1BhoctHGHTypMmYFtU7vqfrcjJhXWMED7Pl+YbU17DqZGaGn
	mEZHZD0hoaJNqC3CUAU2t4M7xjpPwE4wS+CjlWvBS8asbv7VjYjOKpaIFfY21PxLUFC7HjqLkEm
	Q6flVDdf6F26F8aozP08CLLKOEV5vpzhUEoLMNicWRf0jgyptWxIj3iFXh2T4uZZMdLo46KCzmF
	FJQliH3BZPFWm779yc3WegscoMQ+ETEwBfTamcPgA6ogWX53K04nYyuwytpBUwLj/4gerDSyJqa
	tISvTU13hVEaSzDMzMk+t3UdJvNLvVcLj6r3Yqc5RJMTABuOah0=
X-Google-Smtp-Source: AGHT+IGV7gPf93QQO1WJVtV/nW0FDXYUQssyR5CStDGifbGwwzQP3dnpV8mOxs8Y4y2sm2ikFERqIA==
X-Received: by 2002:a17:90a:d648:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2f782d8c178mr8304612a91.29.1738004757474;
        Mon, 27 Jan 2025 11:05:57 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb? ([2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffaf8f03sm7546423a91.39.2025.01.27.11.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:05:57 -0800 (PST)
Message-ID: <a6816a68e5e9aeb1d330b68f6a73decd2233c164.camel@gmail.com>
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Vignesh Raman <vignesh.raman@collabora.com>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, 	mripard@kernel.org,
 linux-kernel@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, 	gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, 	tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, 	daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com, 
	denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, 	hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, 	geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, 	jarkko@kernel.org
Date: Mon, 27 Jan 2025 16:05:47 -0300
In-Reply-To: <6ebd1551-017f-4b31-b235-829b2735d78f@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	 <20250124081250.GA24731@pendragon.ideasonboard.com>
	 <6ebd1551-017f-4b31-b235-829b2735d78f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2238
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/a6816a68e5e9aeb1d330b68f6a73decd2233c164.camel%40gmail.com>

On Mon, 2025-01-27 at 13:02 +0530, Vignesh Raman wrote:
> Hi Leo,
>=20
> On 24/01/25 13:42, Laurent Pinchart wrote:
> > On Fri, Jan 24, 2025 at 02:11:26AM -0300, Leonardo Br=C3=A1s wrote:
> > > On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
> > > > This patch series introduces "kci-gitlab," a GitLab CI pipeline
> > > > specifically designed for kernel testing. It provides kernel
> > > > developers with an integrated, efficient, and flexible testing
> > > > framework using GitLab's CI/CD capabilities. This patch includes
> > > > a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
> > > > additional YAML and script files, to define a basic test pipeline
> > > > triggered by code pushes to a GitLab-CI instance.
> > > > The initial version implements:
> > > >     =20
> > > > - Static checks: Includes checkpatch and smatch for code validation=
.
> > > > - Build tests: Covers various architectures and configurations.
> > > > - Boot tests: Utilizes virtme for basic boot testing.
> > > >=20
> > > > Additionally, it introduces a flexible "scenarios" mechanism to
> > > > support subsystem-specific extensions.
> > > >=20
> > > > This series also introduces a drm scenario that adds a job to run I=
GT
> > > > tests for vkms. This scenario includes helper scripts to build deqp=
-runner
> > > > and IGT, leveraging approaches from the drm-ci/mesa-ci project.
> > > >=20
> > > > We are working towards creating a generic, upstream GitLab-CI pipel=
ine
> > > > (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI p=
ipeline
> > > > is designed with a distributed infrastructure model, making it poss=
ible
> > > > to run on any gitLab instance. We plan to leverage KernelCI [2] as =
the
> > > > backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> > > > integration.
> > > >=20
> > > > For an example of a fully executed pipeline with drm scenario set,
> > > > including documentation generation,
> > > > see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines=
/1350262
> > > >=20
> > > > Please refer to the documentation included in the patch, or check t=
he
> > > > rendered version, here:
> > > > https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927=
/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
> > > >=20
> > > > Differences from v1 to v2:
> > > > - moved to tools/ci as suggested by Linus on the previous version
> > > > - add arm64 containers for native compilation
> > > > - added boot tests using virtme: this is the base structure for boo=
t tests,
> > > >    next steps would be adding other tests such as kselftests/kunit =
tests
> > > > - added DRM scenario testing on vkms: this should replace current v=
kms test
> > > >    in drm-ci. This work shows how a test scenario can be used by di=
fferent
> > > >    subsystems to add their tests.
> > > > - update documentation
> > > >=20
> > > > For more details on the motivation behind this work, please refer t=
o the
> > > > cover letter of v1: https://patchwork.kernel.org/project/linux-ksel=
ftest/cover/20240228225527.1052240-1-helen.koike@collabora.com/
> > > >=20
> > > > [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-=
a-gitlab-ci-pipeline-for-linux-kernel-testing/
> > > > [2] https://kernelci.org/
> > > > [3] https://docs.kernelci.org/kcidb/
> > > >=20
> > > > Helen Koike (3):
> > > >    kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
> > > >    kci-gitlab: Add documentation
> > > >    kci-gitlab: docs: Add images
> > > >=20
> > > > Vignesh Raman (2):
> > > >    MAINTAINERS: Add an entry for ci automated testing
> > > >    kci-gitlab: Add drm scenario
> > >=20
> > > Hi Vignesh Raman,
> > > I am very happy to see this project going forward :)
> > >=20
> > > It's been a few years since I first thought on finding a good way of =
helping
> > > kernel developers testing their patches, while making use of the free=
 runner
> > > minutes Gitlab offers. It can greatly simplify the testing for people=
 who are
> > > new to kernel development, or students trying to understand it better=
.
> > >=20
> > > And this patchset allows that to happen :)
>=20
> Thanks for testing the patch and providing feedback.

:)

>=20
> > >=20
> > > Actually, I spoke to Helen last year, and to enable it to run on the =
free
> > > Gitlab-CI runners, there is a small extra patch which is needed:
> > >=20
> > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.co=
m/
>=20
> Thanks for the patch.

Thank you for most of the work, it sure will be useful :)

>=20
> We can keep the variable name as KCI_CI_TAGS (like other variables) and=
=20
> add it in variables with default empty string.

Just tested, if it's an empty string, it will just be ignored, as it won't =
match
anything (that is not an empty string)

>=20
> >=20
> > Gitlab as an open-source software project (the community edition) is on=
e
> > thing, but can we please avoid advertising specific proprietary service=
s
> > in the kernel documentation ?
>=20
> Agree. We could remove the lines which mentions gitlab.com SaaS in
> commit message and documentation.

Done :)
Added a generic reason for needing better instance

>=20
> >=20
> > > Could you please apply it on top of your tree?
> > > Some stuff changed places, but I can send a v2 with that fix if you w=
ant.
>=20
> I will test your patch and we can add this for v3.

Thanks!
That's the v2 with the required changes:

https://lore.kernel.org/all/20250127185849.34131-1-leobras@redhat.com/T/#u

Please let me know if any further change is needed.

Thanks!
Leo

>=20
> Regards,
> Vignesh
>=20
> > >=20
> > >=20
> > > While I have yet to review this v2 patchset, I applied it on my repo =
for
> > > testing,=C2=A0and cherry-picked the patch on above link, triggering a=
 Pipeline:
> > >=20
> > > https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600
> > >=20
> > > It seems to be working fine, please check it, as you may be more used=
 to the
> > > results.
> > >=20
> > > Thanks!
> > > Leo
> >=20

