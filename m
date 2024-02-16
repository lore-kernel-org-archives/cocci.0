Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE92CC48260
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 09:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=bjQ58x4r99I+yo2flxOQLcir45aHLqyWdGcmmP9kLz0=;
  b=ra7GLZlnP/SAP9bJU61s9wV7Hcu6331g2rJxmTi2X4jDi2VXslCQp/4R
   XgLc10cuGfVS0Q8QV33h/0dFbjUHbTN3iCQ0ZpMifpaSx/a8+UcOs4A2a
   UsO8wZ8FiLXp/yHgW/oZKzg4HtkFkADzSVBFeqRsR2oxsEFmKb1HFZLUS
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linbit-com.20230601.gappssmtp.com
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152268349"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 10:24:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 70D45E008A; Fri, 16 Feb 2024 10:24:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AE5AAE008A
	for <cocci@sympa.inria.fr>; Fri, 16 Feb 2024 10:24:26 +0100 (CET)
IronPort-SDR: 65cf29c9_7dbX7UoJvcOBzRiaVwPr8tc7gxl8RAF3WNfycmOsrLpoAAp
 VoyfZSImZ3UKZI4j8f2e4vA23JpQ/ziZ66R4XEg==
X-IPAS-Result: =?us-ascii?q?A0HUAgB7KM9lhjPdVdFagQmBT4I5gVIyBFOEU49EgXWEa?=
 =?us-ascii?q?5lLgSUDVg8BAwEMAUQEAQEDBIILgnSHYAIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQgBAQUBAQECAQECBAYBAhABAQEBIBkHDhAnhWwNglWBJoEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQImexEPAQ0BATg0AiYCNQEFATcBAR6CXoJgAwSkXIEFQos7gTKBA?=
 =?us-ascii?q?YIKAQEGgmeueYEfCQkBCoEGLogmAYkxgSGCKIEVJwuHYys4gw6CaIIWgzuZd?=
 =?us-ascii?q?oFTHQOBBW0bEB43ERATDQMIbh0CESI6AwUDBDIKEgwLHwVUA0MGSQsDAhoFA?=
 =?us-ascii?q?wMEgTAFDRoCECwoAwMSSQIQFAM4AwMGAwoxMFVBDFADTRcfGBoJPA8MGgIbG?=
 =?us-ascii?q?w0kIwIsQAMJChACFgMdFgQyEQkLJgMqBjkCEgwGBgZdIwcPCQQlAwgEAyspA?=
 =?us-ascii?q?yF0EQMECgMTBwsHeINGBBNHEIE0iieBRQMZKx1AAgELbT01CQsbBj0CoVVeA?=
 =?us-ascii?q?oIyTh6wYJR+B4QUoSUGDwQvlzAUkl+YWKNkhGoCCgcGECOBQTougS5wgzdPA?=
 =?us-ascii?q?xkPjjmDYY96QjUCOQIHAQoBAQMJgjmGNjOBRgEB?=
IronPort-PHdr: A9a23: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
 FAiPzDBFeo5Z1RIcWFtgg7A/5BIHKwFJZA=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:1y9qZqubl82PWyYBhrLwjoa27skDQdV00zEX/kB9WHVpm7+j5q
 eTdZMgpGXJYVcqKQodcLW7UpVoLkmsl6KdjbNhW4tKPzOW3VdATrsSjrcKqgeIc0afygc078
 ZdmsNFeaXN5DZB/L/HCUWDYrIdKRq8nJxAR92y856gd25XgmhbgTtENg==
X-Talos-CUID: =?us-ascii?q?9a23=3A6biq3Wge4GRRY4sRD3vkyZWwkDJuKFzWkFz1GXS?=
 =?us-ascii?q?EUmc5QbyuFV3T95o/up87?=
X-Talos-MUID: 9a23:pAv5NATpQhQ9/qJXRXTi2yl9Gd5v85/1UlFQk5copvWmKAdvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="79805528"
X-MGA-submission: =?us-ascii?q?MDHRJMYu2Tymw8rXnyDZ64kFRKib6TJanRhPGd?=
 =?us-ascii?q?31+RPJvcQAQwd/boe2SqGB7F09op13flmBbpsz1CzpdjyD0hONiOVqbn?=
 =?us-ascii?q?5NyBukVhPGewwl6xDD/R8ko4fNR2AePGwptaJrwOJCo8T1v7nWPcMYTs?=
 =?us-ascii?q?UQtTeDud4cydGooJfBmujcQg=3D=3D?=
Received: from mail-wr1-f51.google.com ([209.85.221.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 10:24:26 +0100
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d18931a94so392314f8f.1
        for <cocci@inria.fr>; Fri, 16 Feb 2024 01:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1708075464; x=1708680264; darn=inria.fr;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjQ58x4r99I+yo2flxOQLcir45aHLqyWdGcmmP9kLz0=;
        b=eCK6T9P2n0bB5TWHhChfrfkrt11KQ2jF5gKttFCB2n787LBb1guGe1C7EGzy8zgkGp
         7THRZFQG2lE4vMYzX6XNK+Wwwo9OEdcvG00/u9FdH85HGbbQ/2H+tTkhdsGLpTB+/qKa
         D9jNfvFB9rY/xnjixJ96p52/7xrFDeQtij0Z8XPaAMMAxni/lq9uffw6e5C6bfWApDaT
         iLOBjTuNfWE17savExB3RS8xsEEJWfSJCM6MB9QuYXWo/kIo1u04r4D6c2l7sursvZY1
         Y8itS/i/4hLrigM+prlbZyR9O5NJBvAL6SNREgznRxyioN/A5TGTgEsD8K1+syInck+w
         AQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708075464; x=1708680264;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bjQ58x4r99I+yo2flxOQLcir45aHLqyWdGcmmP9kLz0=;
        b=W7ojr7irodcbasUiHBbajcmmhn2NRGSib+rGh7EKkdLTcDQH7zpIDNf4UTHOpAgIlv
         OpzjhDRvjeOzA0YqhU0cImbPwP4i1gg+MlD+pxFudZdB96j/FXBUKrWC0d6yB5UlMkWh
         gaEAU3Gn6J3aly0d6n7xiV5jKucNmrDUNRiRXUG6aZsgLAsT51qPwra8zYmAwUDEmSB+
         Rh8TetjlioHR1oMPdQXfplTofFAaMX6FgqjiCjd9+fRJmslDWgYEIl4uluUWy4xbotEK
         2G6Pbpw7a90b5BcCNRnMGe9mkjLIUp3fnuSWHsvMlCLECrP6c+A6c4vuu7inH4bw5n0F
         g/2w==
X-Gm-Message-State: AOJu0YwtJrcwxy2zv7ghiMzmDbRWD4qept0+wK1berzQ04ugW8yXmZiw
	i7WmQBlPkppWbfFdqz/qLIdwAKTsN5grtkNflU+tGBfUdgQT2ARbW+mKH2MQR+m9fokJ342kYiV
	qCL+MYQ==
X-Google-Smtp-Source: AGHT+IE4vsRmsl5AlDhTE7alAVcR9jl3ecrjQYCdj7JqUOj9ePzH3IWkV5zHEm+xe0jHsBAyKs4o8w==
X-Received: by 2002:a5d:4a49:0:b0:33d:11a2:42 with SMTP id v9-20020a5d4a49000000b0033d11a20042mr1971531wrs.47.1708075464540;
        Fri, 16 Feb 2024 01:24:24 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033cf9e35b13sm1691206wrb.72.2024.02.16.01.24.23
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:24:24 -0800 (PST)
Message-ID: <162c5e8c-54c2-4b86-9735-887b8ba26f89@linbit.com>
Date: Fri, 16 Feb 2024 10:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] Spatch 1.1.1 backward incompatibility
Reply-To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
X-Loop: cocci@inria.fr
X-Sequence: 1564
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/162c5e8c-54c2-4b86-9735-887b8ba26f89%40linbit.com>

Hi,

I recently(?) got a new version of coccinelle from Fedora:


$ spatch --version
spatch version 1.1.1 compiled with OCaml version 5.0.1+dev0-2022-12-15
Flags passed to the configure script: --build=x86_64-redhat-linux-gnu
--host=x86_64-redhat-linux-gnu --program-prefix=
--disable-dependency-tracking --prefix=/usr --exec-prefix=/usr
--bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc
--datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64
--libexecdir=/usr/libexec --localstatedir=/var --runstatedir=/run
--sharedstatedir=/var/lib --mandir=/usr/share/man
--infodir=/usr/share/info --with-python=/usr/bin/python3
--with-menhir=/usr/bin/menhir
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE


And it broke a lot of our semantic patches. I now get lots of these
warnings:

warning: rule starting on line 248, node 45:
kunmap_local(...)[1,2,20,21,25] in recv_dless_read may be inconsistently
modified
warning: rule starting on line 248, node 42: decl:mapped[1,2,20,21,22]
in recv_dless_read may be inconsistently modified
warning: rule starting on line 273, node 18: src = ... ;[1,2,8,9,11] in
drbd_csum_bio may be inconsistently modified
warning: rule starting on line 273, node 20:
kunmap_local(...)[1,2,8,9,13] in drbd_csum_bio may be inconsistently
modified

(By the way: these are reported on stdout, I'm not sure that's intended
either)

And the patch output is noticeably different.

This all works fine on 1.1.0, and curiously it also works on the 1.1.1
version in Ubuntu:

$ spatch --version
spatch version 1.1.1 compiled with OCaml version 4.13.1
Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
--libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

I'm trying to come up with a minimal reproducer right now, but just
throwing this out there in case anyone has an idea.

Thanks!

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
