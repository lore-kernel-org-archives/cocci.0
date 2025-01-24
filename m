Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FFCC02191
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pdzsCT8xL6jHZ+tnR3Hwgg863MADe4016kWtdjp4rcw=;
  b=poUakUw+nq2+IMGe3TxSaq2h+wMnZY9QARodYOBAI6JhsDn/S62YbgDf
   1cEGl2n6hGFk3hVH0lZUx4kNcuCc3vVsYgw2KMYEmvOx87B5KWhCf7T97
   LVJudXVsp+9AqtXewIs6v0/QKLL4bR+FqOF1D6ZbnqZjHVM8HdS40Qf1z
   E=;
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
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325281"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CC000E0E27; Tue, 28 Jan 2025 10:13:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E94C4E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 21:50:43 +0100 (CET)
IronPort-SDR: 6793fd22_rH9JUUmsyMe5gmaGw+wmaMJpGCor51xsgYvAF4NBtixzS8Y
 QnRE5JLTHSbwLZIY+5w8ReRc26HsMIXzTnsdZyg==
X-IPAS-Result: =?us-ascii?q?A0EFAwBa/JNnganWVdFagQmBU4FyUn1aMwRTBIRSj06CI?=
 =?us-ascii?q?QOcQoFWgUA+DwEDAQsBATkJAgQBAQMEOIFUgnQCinUCHgcBBDEIDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOO4V7DYJiAYEkYQIFA?=
 =?us-ascii?q?zsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0fXgEBA?=
 =?us-ascii?q?QECARIRHQEbHQEDDAYFCw0CAiYCAiIRAQUBHAYBCwcUDoJggi8BAw4jAwEQr?=
 =?us-ascii?q?C+BBUKKRHqBFQUCFoEBgg0GgmnXcwoZKA1vgWECAQYJAQqBBi6EdClcgjgdA?=
 =?us-ascii?q?YFsg38bIINCeieCKIM9TzM+hEMVg0aCaQSCL0uBKYI0gQyLEoE7gj4WgW2EZ?=
 =?us-ascii?q?4FjiG8IAQYfEgkJEwYKAksLChIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEE?=
 =?us-ascii?q?woNCwcFHwoIDBEKKAMiBA4rDwMrLgUDMQEIBgICBAQCBAIKAgkCAggHAhQDA?=
 =?us-ascii?q?gQEAgEFEgMLAQUGBQEBBAwOAgIDAwICAQgCAgEBAhQBBAMBBwIBBAMFAwoBA?=
 =?us-ascii?q?QECAQQUBgMFAwMHAwQCAwIGAgQFBQICAwMCAwEDAwIBAgMJEA8WAgIDBAIGA?=
 =?us-ascii?q?gIBBCYCARUFAgMEAgIHAgIDAQIBAgICBAIEAgIGAwkIAQICBwECAgIDFQIFA?=
 =?us-ascii?q?QQJAwMFEgwgAwICAgIDBwoDBQIBAQIEAwMDAwkNBwIDAQIBAwUDAQIBAgkDB?=
 =?us-ascii?q?gICAwMEEhkFAwIPAwIBBQQCCBALBwEBDxQFBAkFFQMGAgMDFgsEBQMDAwEMD?=
 =?us-ascii?q?w4CAgsDFwUBAQcBAw0IAwQEAgMDCQIBEAEDBAIJAgQBAgoCAgICAgQBAQUEA?=
 =?us-ascii?q?gQDAgUCAgEIBAMDAw0EAwgIAwUDDBICAgIJAgMBAgMDAwQNCB0FCRELAgkDB?=
 =?us-ascii?q?A0CBAICAQYDBgoGFQECGAICBgwEAwMIAwIDAgIBAgICARECAgkIDQUJBQYCA?=
 =?us-ascii?q?hUDAgMIAQkDDwMCFAEGAggDBwEBBAICChEKAQECAgEGJgMBAQIUEwcDCAICA?=
 =?us-ascii?q?gIGFgwBBQcDBw8FBQQCAhYDAxIEBBACAgMDAgEBFAYVAQUCAwYLAQYBAgUEA?=
 =?us-ascii?q?gMEAhICERUDAwQGAwECChACBAIJCgEFBAMHBQIfAwMCAgULAggCAgUCBQcDC?=
 =?us-ascii?q?Q4BAgUDBAkCFAIQAgICAggWAgICBR4DJgIEAwMDAwsBAgIOCQMEOgYRBAIDA?=
 =?us-ascii?q?wIOAQICCwECAgQCAwEEBwkDAwkKBwEKDQcCAgoICRABAgIPBwMCAgICBgcOA?=
 =?us-ascii?q?wITDwUGBgIKBw0LAgECAhMCAwkGAwUNAwcECg0CFQIWBQMgAggJCwIHEQIFE?=
 =?us-ascii?q?gMOBQMCAhEEAgMGBQMBBwEXAwcIAgIMAgICAgUCBQIFFxEBDQQDAwMCCAEEF?=
 =?us-ascii?q?QYDCQgqGxIBAQEFAQkCAwIDBAgDAwMCAwQMCwIBBwgDAwYLCAkGAwIHCBkDB?=
 =?us-ascii?q?QQDBwULIQIGAwIEBQQBBQIVDQIDGQIGAwYUCQwCBg4HCQMHAQEBAgICCAEFB?=
 =?us-ascii?q?RICAwQCBQQEAQEIAwMEBgIBAwICAgEEAgoBAQECCgIICgEJEwQDCAMDAwMDB?=
 =?us-ascii?q?QECAggEEwUFAgEFDBMMAQoGAwYDBAICAgsHAgMDAwIHAQsaCQIBAwICBQICA?=
 =?us-ascii?q?QUDAgIIBAMCAQEJAgMCCAECAgEBAgICBAEHAQQHBgEBAgQCAjcCAQMJAgUBA?=
 =?us-ascii?q?QEOAgIEAgIDAgICBAIEAQIGCwQFDQEBAgECAgEBAQQBCAMBAQECAgMDBQMFC?=
 =?us-ascii?q?A8QAQEXCxIdAgkDIw8DCwkIEz0MBzIENgEUFAcGJYEAnD4BPIMdggQIEHEgg?=
 =?us-ascii?q?SZAkkAIg0ewAQeCaYE1jBiSJIMkM4QEjQaGOpMPmHwii2mBeZp/AgoHBhEjE?=
 =?us-ascii?q?oE0AjaBXHCBAYI2EzwDGQ+OWYNChRTBGik1AgE5AgcLAQEDCYVpijmBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 mHE3kXSz3hp5KycNHN6BOnJF19MvqowMgz0
IronPort-HdrOrdr: A9a23:vzJYsqkvC1ioXxPiurXLXRNXmKTpDfLX3DAbv31ZSRFFG/FwWf
 re5cjzsiWE9Ar5OUtQ5OxoXZPrfZqyz+8M3WB8B8bEYOCighrSEGgA1/qd/9SDIVyaygc178
 4JGNkdNDSzNykBsS+T2njaLz9K+qjizEnHv5a5854gd3AUV4hQqyh+ERiSCUB7SU1rApAjBI
 OA6scvnVadUEVSQMD+KHdtZYb+Th7w+64OoyRqO/fq0mizZPqTiILHLw==
X-Talos-CUID: 9a23:+Qok2W9evP7Pl2CwGUyVvxRFH/0qLVPZ9kvRD2PoAmd2E6yMVFDFrQ==
X-Talos-MUID: 9a23:Ct2+PQWY16dKJJHq/BTy2ilwJcRT2IOvKFsHkpI0hNKACRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,232,1732575600"; 
   d="scan'208";a="107314151"
X-MGA-submission: =?us-ascii?q?MDFSP76XnRMIqwSRrn7Sax6aqkBV65Xmoke4EZ?=
 =?us-ascii?q?vy+QXKSY+mJHYktUiR/1vBwksQgicfq7TIkWnws/BDVVtNVR0CNK663J?=
 =?us-ascii?q?Vtr7Za30e9ShXFL2Vc+t8iRu3dpyWCDcoVDJOnqgriidou1lXWa/WDgr?=
 =?us-ascii?q?PZk887niMF1+aAxQbuwT7+Aw=3D=3D?=
Received: from mail-pl1-f169.google.com ([209.85.214.169])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 21:50:42 +0100
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so48224525ad.0;
        Fri, 24 Jan 2025 12:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737751840; x=1738356640; darn=inria.fr;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pdzsCT8xL6jHZ+tnR3Hwgg863MADe4016kWtdjp4rcw=;
        b=AIqkhmSBmOlU725ZMGuJ9eMx9ZHOtAbZPmrzb6KGZGejwQeWEF+umSuTXPMxQqc5Lx
         O7l0q7G5TP7U8qPUhNGCAaC4Sk59H1OtR8SwYv+m3eZ9CpbnUVI+BPEPDS2s0eefHmBz
         v1lu/OEZNFKd3TRolix74FKfg7ihX7eEcUNrFOGqDPevgTjUAjuBFsqx4za7vbRFPZ/W
         VRaRHjsNoDl0il9O0RCMufjzgRHL0Hq+Akd1K1DzukFw6IQC1Np65rJHjJROvhyxCNCc
         ZZyO2n9LJqm3Vg5lor1IY3HUFAGgmExW+zpNdUMTgAhrc/slkb6cfgLm0xk0sLC6/Et3
         Jp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737751840; x=1738356640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdzsCT8xL6jHZ+tnR3Hwgg863MADe4016kWtdjp4rcw=;
        b=PpB42UXOJOISgJpIRfKUsQCGtrmYZUR5fy621coU6ufpxgY10MpPl1Be/eo7gwSvSq
         Lscufj4k8BolIRAUF1ajY/KFt6m+H+EdlkQqEybk+riEti4+rkt1SqjYzuESdAg5cQ88
         36ij5M/4RQuVATENvesICY5Ay16J0NBUGAjhHAadmp6u4FOMtVvX+RzzpszJgO3hPq1d
         HD/DHlpcEBe7yDzTI0/lkVqsAFS+FAENBoiMVCjH2InAhkcNkulBW0GDlRZarc15X2QP
         HPXNE8hu/M/blJ0dXG5KImCu4aErzdRr2ONWIuvs1YZ/dk1G4NZbZLLKpf3ak5+mZo8a
         wp2A==
X-Forwarded-Encrypted: i=1; AJvYcCW0yOD0jqlbQpT68gjtVzDCfo35+mamkEs9ek3KJPWPP9qgxbd5Wwu0jLFXIIAnQqir5zmOlBClkaouwwA=@inria.fr, AJvYcCXUnsJbX/YrTusC7B+h+w0+WIua5rl2aiBa4rwNE1o1ZYSmv1btJVyQJma2/Np1eWyVE03VHeU=@inria.fr
X-Gm-Message-State: AOJu0YybfzvRoZkLpsYlym7KZislVMGf823itv3i3TsQhdsQwkByWv+M
	wdOhCNGTRn5jSh+99E1t6pAWEVsaPsWXQmGiTIvRvf9NuGCgYPFi
X-Gm-Gg: ASbGncuLoShFkObiyFmEHQWfNXmU0xyEMhlkMbOiG0K7k+EtO/cd7ki054Rr8pREZTU
	TXAmHgoLt3zLddcW1EqEGR0So9sw/yT/dmuwJNwgC3CJvctX4hhaeUwJeFp+3oV7wzy+ohL2J9r
	E0NXevkxOE4SrYMDOZJIlp168wJK/JDJrnS3RCviOBMoXHkAPTlm+Q1OlA1xjjdv5sldN+IeeJj
	a9pAJ7MNQ0MDMHK2EWcJ2eanl/tbYUVfxFtWq2OyOm0pCVy67H+n6VWJRwj84yBlp98ckKRrtiu
	tHQBWCva5LqetG2+JSuTOjHxAtp8A+EPlzEDP6hQ9Xf0aO8pyVA=
X-Google-Smtp-Source: AGHT+IGwvSer+unLlVc6WTlhBYxGObsMsLAI7zUMsLtcBkSVhBWiPYvxWe7dxKBqk+OHgzBCgn4BNg==
X-Received: by 2002:a17:903:2449:b0:211:7156:4283 with SMTP id d9443c01a7336-21c355fcb7emr524423085ad.43.1737751840090;
        Fri, 24 Jan 2025 12:50:40 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb? ([2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da555a428sm18349685ad.84.2025.01.24.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 12:50:39 -0800 (PST)
Message-ID: <5acfbe92315d93aceb467fec1d239d6a7a7ba499.camel@gmail.com>
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com, 
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, 	nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, 	Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, 	torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com, 
	helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, 	nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, 	hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, 	geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, 	jarkko@kernel.org
Date: Fri, 24 Jan 2025 17:50:29 -0300
In-Reply-To: <20250124135203.040d0852@foz.lan>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
		<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
		<20250124081250.GA24731@pendragon.ideasonboard.com>
	 <20250124135203.040d0852@foz.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2261
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/5acfbe92315d93aceb467fec1d239d6a7a7ba499.camel%40gmail.com>

On Fri, 2025-01-24 at 13:52 +0100, Mauro Carvalho Chehab wrote:
> Em Fri, 24 Jan 2025 10:12:50 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
>=20
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
> > >=20
> > > Actually, I spoke to Helen last year, and to enable it to run on the =
free
> > > Gitlab-CI runners, there is a small extra patch which is needed:
> > >=20
> > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.co=
m/ =20
>=20
> Sounds interesting!

Thanks! :)

>=20
> > Gitlab as an open-source software project (the community edition) is on=
e
> > thing, but can we please avoid advertising specific proprietary service=
s
> > in the kernel documentation ?
>=20
> Every time Gitlab is mentioned, the brand of the company that
> developed it and has been providing proprietary services is also
> advertised. If you're not happy with that, you should move to use
> a git forge developed by some open source community.
>=20
> The way I see, the best would be if the CI integration could work
> with more than one type of forge and being able to use any
> free Git??b-CI runners that would be available for developers to
> use, as this would allow testing more subsystems with CI, thus
> increasing code quality.

Completely agree!
I think that this Gitlab contribution will set a base for implementing othe=
r
forges / CI systems as well, and allow us to make use of those resources fo=
r
better kernel testing.=20

Thanks!
Leo

>=20
> Thanks,
> Mauro

