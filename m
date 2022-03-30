Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A37C433F5
	for <cocci@archiver.kernel.org>; Thu, 31 Mar 2022 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=b0i0cluH/A4ssoKeXKqLMuzYYjVRshLdbvm0r5GSUI8=;
  b=QZHc3G3ivrrWFHCaGrrLPVd5uQmLu+srXd7vyZo+xy9ONwfSSWVDtmFl
   4+EJhlLgvCQ0u1PT8N/suFMu+hFx1CJbjWuods5M8HLdg5ikc6IwveyPO
   ShXnyycfoBzUsQoputdkJGmDedW5dvdJuh0BatikiA1EmRiMtBqvgCYEH
   c=;
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
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29209605"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Mar 2022 07:35:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F26C0E0344; Thu, 31 Mar 2022 07:35:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CA73EE7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 23:49:09 +0200 (CEST)
IronPort-SDR: qzFy5KIUYak3bYpfOdACYaR+DrFW7LDZ/Cxoxg8aWY9Bh5fkRjDKtarq190PxdSJQNBjaLU7kY
 ulyUc93rZcfb9a+rxnWAYNG7Ucw0yBw9V9pAUmtgpDaF7hTNPvCLL4/ZHP7lwaPYJaxtF/SbS6
 bYq19Yp7pgj3CET1/EFVoygfSdhacXgfssC0F+r2BFc0WRtxZ8gOBBSjIGi2e2TPgFPcg9vE0d
 t9gc6r/MX6nnVSjjKS44/fj/22dgVK0a9puM31Bzb3xataSaSoy1iGeBayAOKZaH9bvKMiU2/X
 xQVsWG3HtUQtGsgto9AJxAs+
X-IPAS-Result: =?us-ascii?q?A0DEAQDTz0Rif7GnVdFaHQEBAQEJARIBBQUBQIFIBgELA?=
 =?us-ascii?q?YFRVoFVKwRPiy+VZQKBAoYViieBfAsBAwEMAUMEAQGFB4RZAh0HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoCBQ4OBWABY?=
 =?us-ascii?q?QMBRIFPgU8lCwMxDYI1IoNuFhUTBgEbHQEDEhBeEQEFASMLKYVHAQMuAaIug?=
 =?us-ascii?q?QQ9izCBARYFF4EBggkGhEkKGSgNZwOBWQIHCQEIgSqGEoQngxeBIYIphA+LM?=
 =?us-ascii?q?gSZEQFhLYN5Ab8hMQoGAYIhcziBQZ41BS6WRJIIll0gpj8CCgcGECMSgTMIg?=
 =?us-ascii?q?gYzGiOBAW2BS04BAgEBAQ0BAgEBAwECAQIJAQECjh2Dcop4JzQ4AgYLAQEDC?=
 =?us-ascii?q?ZFgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:UEDuwKOPcHXTD8BcTvCjsMiBIKoaSvp037Dk7TEUdfVwSL3iqy
 nOpoVi6faQslwssR4b6LO90cW7MBHhHP1OkPAs1NWZLW/bUQKTRekIjbcKqweAJ8SUzJ876U
 4PSdkaNDQyNzRHZATBjTVQ3+xO/DBPys6Vuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,223,1643670000"; 
   d="scan'208";a="29181593"
X-MGA-submission: =?us-ascii?q?MDGRrVbGtf3tJ5QmJmi2xDvef2dCOJp3QIh8a0?=
 =?us-ascii?q?Km+AJ2qcfLaCdvlztupFQLKOgusn9NfG8ytpS8laUC2BualS+KEEiAl4?=
 =?us-ascii?q?rZg/E1BZ8gdSqCQ+uo6keeQ67g6crFrGtBh1xSraMNZmfpkoe48xCAlG?=
 =?us-ascii?q?cKow2b2701sxMdokG27vdTOA=3D=3D?=
Received: from mail-oi1-f177.google.com ([209.85.167.177])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:49:08 +0200
Received: by mail-oi1-f177.google.com with SMTP id e4so23443232oif.2;
        Wed, 30 Mar 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=b0i0cluH/A4ssoKeXKqLMuzYYjVRshLdbvm0r5GSUI8=;
        b=jHILTx22Yafv+bS1q6k9rCJzsp5MTUG7AYTq0FCpQbD9cS1T63FfImnVdVLI6S00Jg
         bNRdOYt0SSnBvqjx0FBXpeHos8zXj6+4VfIG3a80MHJInuhfpUe1ehmKOlVcwvDbypwr
         mRhMLRZwpMJzAT8C95oUgpj5PjYI33dzB3mkQOYyzxbUvzlpBCy8e4N442ES40mQvxRm
         4Z6aE6aL2HogZ1MyVJPanoowLllmBjZ1KLYs83P1HBJn4LTMpk40kuR4/49/FyhrRquB
         /Q7uYQwtH8XtW2LMNTTIhieHF9DfAJVkDEbkkoAt8hDO0K8Ww537sQcsGPgYeKn6AOsU
         AShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=b0i0cluH/A4ssoKeXKqLMuzYYjVRshLdbvm0r5GSUI8=;
        b=UQnzWz+eyt+KLdx45WYUqwB07+jdaptMaLFPgKhu6ygLuG5kSjjQCb5QyrszVo+NJ4
         6PzYw5H22mU1y+Cy6Z84OD4ipjVf53prR7jEV65WMnu1U6Cr14/fq1QWsTe7d2DjscOK
         ZKzK1bulbBRGY/noVHBTpXC7B411VcJSqGrJkw7zJVmfDe1RIzj3AzrrCWmRExBFb/L2
         ZQ4B79J8EHUysMt2OQ4J8XxqCCSA3Ug9QUrMdMbeNh376b/K+UTfZa+y3AYjFHU1JPh9
         /G0bIlQ6f2Jb3i3imUGE6gTbPKjjy/hLI1mu+3vfGqEOXCbrqY93U7dXDZovAAjEta7z
         s3ew==
X-Gm-Message-State: AOAM531PJxqK5KksAjpkpj9Ueb3+jdnt9/FLpSccAZ1JhZrxg6RycvIK
	YVLEeBZoMls8isvYutKZE7g=
X-Google-Smtp-Source: ABdhPJy3jQXpJ9gCB6/IK2LSmIYfR24mlHix7Sr0O1n/2dpJvWTwE7PqijX45a4zdov45Ef2TOxxdw==
X-Received: by 2002:a05:6808:1513:b0:2ec:f606:2c9c with SMTP id u19-20020a056808151300b002ecf6062c9cmr1161024oiw.256.1648676947438;
        Wed, 30 Mar 2022 14:49:07 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id bg39-20020a056820082700b00324c8eba341sm9680574oob.18.2022.03.30.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:49:06 -0700 (PDT)
Date: Wed, 30 Mar 2022 18:49:02 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
	davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@oracle.com,
	julia.lawall@inria.fr
Message-ID: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 0/2] Add a section for static analysis tools
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 317
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/cover.1648674305.git.marcelo.schmitt1%40gmail.com>

Hi all,

This is the third patch version in the direction of complementing the
testing guide documentation page with information about static analysis
tools.

Thank you for your suggestions and comments so far.
These docs wouldn't get so helpful without them.

Change log v2 -> v3:
- Changed the paragraph about Sparse to make it sound better (hopefully)
- Minor adjusts to make the considerations about Coccinelle sound better
  and be precise

Change log v1 -> v2:
- New patch adding considerations on when to use each tool
- Brought generic tool characteristics to the intro paragraph
- Made explicit that these tools run at compile time
- Added a note of caution about false positives
- Updated Coccinelle info to make it sound better and be more skimmable


Marcelo Schmitt (2):
  Documentation: dev-tools: Add a section for static analysis tools
  Documentation: dev-tools: Enhance static analysis section with
    discussion

 Documentation/dev-tools/testing-overview.rst | 63 ++++++++++++++++++++
 1 file changed, 63 insertions(+)

-- 
2.35.1

