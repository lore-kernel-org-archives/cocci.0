Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9544FC0218A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Pm8oJeBuOFHd6ekxnejy3HEWqUKZZg6N9tys57iCgH8=;
  b=Mdr9rcjhhjokhGJdGdJMrpfIPZTkC+y2wwmmG2n6oeB0YJ1tSHkChLYE
   EIEiSSOvoWmmqfOdk57ZJPu2YTOwsWgMLbVLRISXTbl2MTHqAczvbMTMu
   sTPEo7KOlsaCRMDa3RCV5LrUf15uMfPYWgThZLZw7hFIpkC4IPMMyGVIp
   Q=;
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
   d="scan'208";a="205324634"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7E9DAE0D20; Tue, 28 Jan 2025 10:13:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B28F7E0077
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 06:11:43 +0100 (CET)
IronPort-SDR: 6793210f_kd3wFosQ+bx72l0gxu6U3jhLxxj3wbtmQfSZ0v4FUD2CVOL
 x9txb1eE2ARHbEIWQdBZyTbdlobhFXd1092jldQ==
X-IPAS-Result: =?us-ascii?q?A0GvAgCsH5NnfLLWVdFagQmBU4FyUn1aMwRTBIRSg0+Lf?=
 =?us-ascii?q?4IhA5xCgVaBQBYoDwEDAQsBATQOAgQBAQMBAziEAkICAgKKdQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw4SKYV7DYJiA?=
 =?us-ascii?q?TNxYQIFAzoBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBB?=
 =?us-ascii?q?QIIBR8/AR8BAQEDEhEdARsdAQMMBgULDQICJgICIhEBBQEcBgELBxoIgmCCL?=
 =?us-ascii?q?wEDMQMBEAasQIEFQos+gRUFAhaBAYINBoEJUAMPL0/XcwoZKA1vgWECAQYJA?=
 =?us-ascii?q?QqBBi6EdClcgjgdAYFsg387g0J6J4IogRWCdzM+gmEBAoFfFYNGgmkEgi9Lg?=
 =?us-ascii?q?ScCgVZegQyGZYVpdDuBJYFthGeKQwgBBh8SCQkTBgoCSwsKEgMEAwQEAQILE?=
 =?us-ascii?q?wkDAwIOAggDAggGGQE/EgQTCg0LBwUfCggMEQooAyIEDisPAysuBQMxAQgGA?=
 =?us-ascii?q?gIEBAIEAgoCCQICCAcCFAMCBAQCAQUSAwsBBQYFAQEEDA4CAgMDAgIBCAICA?=
 =?us-ascii?q?QECFAEEAwEHAgEEAwUDCgEBAQIBBBQGAwUDAwcDBAIDAgYCBAUFAgIDAwIDA?=
 =?us-ascii?q?QMDAgECAwkQDxYCAgMEAgYCAgEEJgIBFQUCAwQCAgcCAgMBAgECAgIEAgQCA?=
 =?us-ascii?q?gYDCQgBAgIHAQICAgMVAgUBBAkDAwUSDCADAgICAgMHCgMFAgEBAgQDAwMDC?=
 =?us-ascii?q?Q0HAgMBAgEDBQMBAgECCQMGAgIDAwQSGQUDAg8DAgEFBAIIEAsHAQEPFAUEC?=
 =?us-ascii?q?QUVAwYCAwMWCwQFAwMDAQwPDgICCwMEEwUBAQcBAw0IAwQEAgMDCQIBEAEDB?=
 =?us-ascii?q?AIJAgQBAgoCAgICAgQBAQUEAgQDAgUCAgEIBAMDAw0EAwgIAwUDDBICAgIJA?=
 =?us-ascii?q?gMBAgMDAwQNCB0FCRELAgkDBA0CBAICAQYDBgoGFQECGAICBgwEAwMJAgMCA?=
 =?us-ascii?q?gECAgIBEQICCQgNBQkFBgICFQMCAwgBCQMPAwIUAQYCCAMHAQEEAgIKEQoBA?=
 =?us-ascii?q?QICAQYmAwEBAhQTBwMIAgICAgYWDAEFBwMHDwUFBAICFgMDEgQEEAICAwMCA?=
 =?us-ascii?q?QEUBhUBBQIDBgsBBgECBQQCAwQCEgIRFQMDBAYDAQIKEAIEAgkKAQUEAwcFA?=
 =?us-ascii?q?h8DAwICBQsCCAICBQIFBwMJDgECBQMECQIUAhACAgICCBYCAgIFHgMmAgQDA?=
 =?us-ascii?q?wMDCwECAg4JAwQ8BhEEAgMDAg4BAgILAQICBAIDAQQHCQMDCQoHAQoNBwICC?=
 =?us-ascii?q?ggJEAECAg8HAwICAgIGBw4DAhMPBQYGAgoHDQsCAQICEwIDCQYDBQ0DBwQKD?=
 =?us-ascii?q?QIVAhYFAyACCAkLAgcRAgUSAw4FAwICEQQCAwYFAwEHARcDBwgCAgwCAgICB?=
 =?us-ascii?q?QIFAgUXEQENBAMDAwIIAQQVBgMJCCobEgEBAQUBCQIDAgMECAMDAwIDBAwLA?=
 =?us-ascii?q?gEHCAMDBgsICQYDAgcIGQMFBAMHBQshAgYDAgQFBAEFAhUNAgMZAgYDBhQJD?=
 =?us-ascii?q?AIGDgcJAwcBAQECAgIIAQUFEgIDBAIFBAQBAQgDAwQGAgEDAgICAQQKAQEBA?=
 =?us-ascii?q?goCCAoBCRMEAwgDAwMDAwUBAgIIBBMFBQIBBQwTDAEKBgMGAwQCAgILBwIDA?=
 =?us-ascii?q?wMCBwELGgkCAQMCAgUCAgEFAwICCAQDAgEBCQIDAggBAgIBAQICAgQBBwEEB?=
 =?us-ascii?q?wYBAQIEAgI3AgEDCQIFAQEBDgICBAICAwICAgQCBQECBgsEBQ0BAQIBAgIBA?=
 =?us-ascii?q?QEEAQgDAQEBAgIDAwUDBQgPEAEBFwsdAgkDIw8DCwkIEz0MBzIENgEUFAcGJ?=
 =?us-ascii?q?YEAnDE9gwo+NQE8JC0BEwgOAlAhgSIfCzqSVIM7sAEHgmmBNYwYlUgzhASNB?=
 =?us-ascii?q?oY6kw+YfCKCNokzgXmVUIUvAgoHBhEjEoEyOoFJDAdwgQGCAgEBMhM8AxkPj?=
 =?us-ascii?q?lmDQoUUwAwpNQIBATgCBwEKAQEDCYVpigotBYFLAQE?=
IronPort-PHdr: A9a23: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
 59LTg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gkOG+qpOpwZ6s2DwqrSgKXYaV5rQeYIsimQD101hICG9vPbo7v
 xG+85rqSMc6QxhJU3I/OrrBEDuewKlyXcY2/h3AV7mZnichILKFvAd0WKB+UyEJ8SWzIc0vt
 YDT0E9MqyLMbETt7eY3ODSKadF/DDoytHPuQ6T9QYTcShaL45n9BlwEQuWHwlbQwNcFYMlGJ
 f03KZ6jgvlV3BSQMrTPBc4tiv4yOEjVqiKXffLPX8aAcC17Q+V1A==
X-Talos-CUID: =?us-ascii?q?9a23=3Ap4E+uWumD/qjiIdMg3Yxneix6ItiUiLNnDD5OXa?=
 =?us-ascii?q?3BEhuGYWccGOL/ZJ7xp8=3D?=
X-Talos-MUID: 9a23:OUyb2grlacyzAEQgj+kezw1uBshw3LuANHJTipsc6uXcCCx0MjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,230,1732575600"; 
   d="scan'208";a="204767133"
X-MGA-submission: =?us-ascii?q?MDE9m5UVI1JY9iamV8HrYIIq/an6AqAY0jDJpu?=
 =?us-ascii?q?UhmxPJM4gGH7QSQAV6eSl49GPZ7Mo3wgxUpwl9cDANiJIqWLKjgXP9eS?=
 =?us-ascii?q?W9b45JfLO7UYT3JQAarO2ahoq1WmlbajaOgLiSQLfZaKTpqixFmtrJ2q?=
 =?us-ascii?q?06Fgmo9OWoQJyaSoTLdQWu1g=3D=3D?=
Received: from mail-pl1-f178.google.com ([209.85.214.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 06:11:42 +0100
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21654fdd5daso28840945ad.1;
        Thu, 23 Jan 2025 21:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737695501; x=1738300301; darn=inria.fr;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pm8oJeBuOFHd6ekxnejy3HEWqUKZZg6N9tys57iCgH8=;
        b=YtScOPohDiiq6ngkEMWENO7mscMnNFgFD51d6P0ngOKDlhDBKcPD4kNpAKQkZwQZX1
         CFB2/u2eaBjhGdp/SgliYkJ6dUYR6+ladJP2qh/3YwcKgov4dg8XJsUHyV2h63txMgyD
         qLHb1P5xvrDAiuPIQeE16NdwY7hQaX3gHHT+WL3biSttADZBOH+ihuo4zIpaFRD2N8qA
         oP2M/CtI3J2vAhXkYncm3ShbCf2Yylm0QDXpCyPnHOIKArpqQphaPs3Snr3Xkze0vKAw
         M/wWlrb4dR6E1Biy6TAkSJRj4nhbuwGR9JopT6BUyRmrrMS80wzkd8J0NlFyI+HO4gtS
         2/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737695501; x=1738300301;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm8oJeBuOFHd6ekxnejy3HEWqUKZZg6N9tys57iCgH8=;
        b=KEojuLQmAZkdIgOnNwAuEUISSYHIhAicR1qlTEdQOfGQNqY1heZr+Q1I2Bsul3z9B3
         RyKalzPmaIsfwOZh/hBDRM2aVUbmJCAuaxrc9mlZG70Kanp4ahGAdRd0Q/pJDALs71xT
         UNIJlmfjNV/0iJ+7UiemvI0KAk+5DBEeZqYTcOwnwrz9Tv93xV70oDZl/HZEX3gfbyxC
         mZ5wYX3D0jjcYT0QQG09TQ4eDI5fkaRWCgCnmihAu8dUvVjgeK4hgJI+FkiMQfLlq/e8
         bZ6xP9bR87ne+0e/PChRAG684Y022XH/8vi1+onG82J4D9BhzjVpw3dUFUl7aFN8eM/+
         umKw==
X-Forwarded-Encrypted: i=1; AJvYcCVOmssu7FTWOiNNJ9+quie1AkQBZq3uXlCs8csk0G+QMdhRM/u5iCljhCcsrY5Wjeg2IVeykSGcTA5UR3Y=@inria.fr, AJvYcCX7Ut2jcMFpZRqX9CM34zjxdG9Zp8/e73FC5F4nD3o22xi9QMRFlUinVEQxopZsuT33Z33FxNQ=@inria.fr
X-Gm-Message-State: AOJu0YzNBkE/RtyYK4jG8WNRMkoUTyXHG27rXCqxngu+bAw4Rnvs7aZf
	y1XcCVYbj0aHWSAg3whc44VvQqxnQSbZ8sIpJgE+nS0YLtlMUyFr
X-Gm-Gg: ASbGncvnn0e0RgzxJpJ7OcheBbVLbus34FPWiIjmvQHwbI1BsWjJhtnPnizePRoj7gR
	/YB8oT+drVTADQXZ7BygGatCqExX5QXXuIeS+G1IUfWz3cniYWbImYfWkW1lIvFgCiQO1oSCFaN
	Oqy5LuXQvbtdq39gl6fbdvIm4sWr4c3ypC8T30/7w8iZrKf5LCRyQzQCb/B/3CHecoSv8mKxZyT
	sDWFbnN+Ql5QRGOxTCYk7OWoL4EpotKBZ7ehk/kOKhl5BgUqnAcd/YB1L4m2LtKqGSibAz8pwRs
	e+lpIN+CEnlE3pRRhV19uyojrksuXDsxgZ0+ysZdpGAfGc0UWxA=
X-Google-Smtp-Source: AGHT+IEu34cEqyV0xw9hfuRNjxOhke8sLDPtu8jUlbl+4jeWRLNMy3Ms4sWiV94JmApPoJ9ZFKf+5g==
X-Received: by 2002:a17:903:2312:b0:216:36ff:ba33 with SMTP id d9443c01a7336-21c355589ddmr413044785ad.26.1737695500948;
        Thu, 23 Jan 2025 21:11:40 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:16c4:23da:a93c:e00a:1229? ([2804:1b3:a801:16c4:23da:a93c:e00a:1229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e151sm7636555ad.186.2025.01.23.21.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:11:40 -0800 (PST)
Message-ID: <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
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
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com,
 laurent.pinchart@ideasonboard.com, broonie@kernel.org, 	groeck@google.com,
 rdunlap@infradead.org, geert@linux-m68k.org, 	michel.daenzer@mailbox.org,
 sakari.ailus@iki.fi, jarkko@kernel.org
Date: Fri, 24 Jan 2025 02:11:26 -0300
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2241
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/f779c9af4133629f724e366241fab7421d13d227.camel%40gmail.com>

On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
> This patch series introduces "kci-gitlab," a GitLab CI pipeline
> specifically designed for kernel testing. It provides kernel
> developers with an integrated, efficient, and flexible testing
> framework using GitLab's CI/CD capabilities. This patch includes
> a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
> additional YAML and script files, to define a basic test pipeline
> triggered by code pushes to a GitLab-CI instance.
> The initial version implements:
>    =20
> - Static checks: Includes checkpatch and smatch for code validation.
> - Build tests: Covers various architectures and configurations.
> - Boot tests: Utilizes virtme for basic boot testing.
>=20
> Additionally, it introduces a flexible "scenarios" mechanism to
> support subsystem-specific extensions.
>=20
> This series also introduces a drm scenario that adds a job to run IGT
> tests for vkms. This scenario includes helper scripts to build deqp-runne=
r
> and IGT, leveraging approaches from the drm-ci/mesa-ci project.
>=20
> We are working towards creating a generic, upstream GitLab-CI pipeline
> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipelin=
e
> is designed with a distributed infrastructure model, making it possible
> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> integration.
>=20
> For an example of a fully executed pipeline with drm scenario set,
> including documentation generation,
> see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/13502=
62
>=20
> Please refer to the documentation included in the patch, or check the
> rendered version, here:=20
> https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artif=
acts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
>=20
> Differences from v1 to v2:
> - moved to tools/ci as suggested by Linus on the previous version
> - add arm64 containers for native compilation
> - added boot tests using virtme: this is the base structure for boot test=
s,
>   next steps would be adding other tests such as kselftests/kunit tests
> - added DRM scenario testing on vkms: this should replace current vkms te=
st
>   in drm-ci. This work shows how a test scenario can be used by different
>   subsystems to add their tests.
> - update documentation
>=20
> For more details on the motivation behind this work, please refer to the
> cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/=
cover/20240228225527.1052240-1-helen.koike@collabora.com/
>=20
> [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitl=
ab-ci-pipeline-for-linux-kernel-testing/
> [2] https://kernelci.org/
> [3] https://docs.kernelci.org/kcidb/
>=20
> Helen Koike (3):
>   kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
>   kci-gitlab: Add documentation
>   kci-gitlab: docs: Add images
>=20
> Vignesh Raman (2):
>   MAINTAINERS: Add an entry for ci automated testing
>   kci-gitlab: Add drm scenario

Hi Vignesh Raman,
I am very happy to see this project going forward :)

It's been a few years since I first thought on finding a good way of helpin=
g
kernel developers testing their patches, while making use of the free runne=
r
minutes Gitlab offers. It can greatly simplify the testing for people who a=
re
new to kernel development, or students trying to understand it better.

And this patchset allows that to happen :)

Actually, I spoke to Helen last year, and to enable it to run on the free
Gitlab-CI runners, there is a small extra patch which is needed:

https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/

Could you please apply it on top of your tree?
Some stuff changed places, but I can send a v2 with that fix if you want.


While I have yet to review this v2 patchset, I applied it on my repo for
testing,=C2=A0and cherry-picked the patch on above link, triggering a Pipel=
ine:

https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600

It seems to be working fine, please check it, as you may be more used to th=
e
results.

Thanks!
Leo
