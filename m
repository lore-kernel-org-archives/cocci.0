Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392CFD5E38A
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TvatjoJ/X2SmqK2gTOLejjp4kfaMDH6qeRFSeZb4aeQ=;
  b=H/e/xB1Cl9VgkkMyZRZ0+GSCaqbI4KGpwAdfpYfIwN8WzXYp9fMaOS5n
   Y0sP0BteFHOsAF/0mSfO/VbyNBU3IAaLsxNT92woIT2PybRgS+7kl5txy
   cHocAcI/OqN3PyZjTMhtzbyBvihlMV6yfAxujmBBBKq3yRp1Qy7vh1JOo
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="193076996"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7339EE0D1F; Sun, 10 Nov 2024 02:37:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1061E00B7
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:06 +0100 (CET)
IronPort-SDR: 67300e42_uxSrCQqf6t5sfVefgX7XYRurGUGtmZfw33Dhq+WKMqw87/0
 pVLjwccwm/691fq0d0TVjTvOhI4e6jUM0W1XnZA==
X-IPAS-Result: =?us-ascii?q?A0EWAACQDTBnhdlUsotaHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kOBVzMEC0iMc1+nCoF+DwEDAQ1EBAEBAwSFAAKKOwIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgIBAzIBDQEBNwEPUVYZgwGCZQOyGIEBggwBAQbcH4FkC?=
 =?us-ascii?q?YFIAYVph1xwg316JxuBSUSCUIIthFg4hXeGbXYliRWYWUiBIQNZIREBVRMNC?=
 =?us-ascii?q?gsHBWCBFwOCVnorgQ6BFzqBfoEiSoUaRj+CSmlNNwINAjaCJH2CT4UdhG9nL?=
 =?us-ascii?q?wMDAwODRYJAQAMLGA1IESw1FBsGPm4HnjhGgy0BexOCQJM9kASCHYE3n0yEJ?=
 =?us-ascii?q?IFjn1waM5c/kw6Yd6Q9hGaBZzqBXDMaMIMqTwMZD44hGYh1wRA0NTsCBwsBA?=
 =?us-ascii?q?QMJjneBSwEB?=
IronPort-PHdr: A9a23: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
 UNg/A==
IronPort-Data: A9a23:Q8uArasSK4u0dEQ6vj04kxzejufnVLpaMUV32f8akzHdYApBsoF/q
 tZmKW2BM62KNjP9etFzO4SzpkNVvZOBmIdrSVZkrSlgRilHgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNscpvlDs15K6u4WpA7wRlDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEV1DIwhpbwrOzhp3
 u4bGT0TZy+Nv+3jldpXSsE07igiBMXlI8UEvWx6xjyfDvs8R53HBaLQ6re03h9p3ZEIRKmOI
 ZpFL2A2M3wsYDUXUrsTIJc3h+6oh2P4YhVbpUiTqK5x5HLcpOB0+OG1aYCNIoHaGq25mG6xl
 nDY/D+mGCsbKfef2BuO41aeg/XmyHaTtIU6T+DgqK412TV/3Fc7AxodXlqTuui8kkf4WtRFK
 kVS9DBGkEQp3EClUZ/mWACiq3PCvRMGXddUVeog52lh15Y4/S6dRVkFd2EbNOZ/k+QkRg0ny
 Fa2kevmUGkHXKKudVqR8bKdrDWXMCcTLHMfaSJscefjy4e4yG3UpkyRJuuPAJKIYsvJ9SYcK
 g1mQQAyiapVlskWza62u1PKmTShot7OVAFdCuTrsoCNsVwRiG2NPt3ABb3nARBod9nxor6p4
 CVspiRmxLpSZaxhbQTUKAn3IJmn5uyeLBrXikN1Ep8q+lyFoiH4JNkPv2kudB01a67onAMFh
 meN5Gu9A7cNYxOXgVNfOtPpYyjX5fm6TIq9PhwqRoMSO8AZmPC7ENFGPhPIgTCyySDAYIkyI
 Iqad8e8RW0XE7pmxzetD+Yb2vlD+8zN7T27eHwP9Dz+ieD2TCfMGd8tbgDUBshnt/zsnekg2
 40EXyd8404ECLWmCsQWmKZPRW03wY8TWcqp8ZINLbDacmKL2ggJUpfs/F/oQKQ994w9qwsC1
 ijVtpZwmQqh107UYx6HcG5iY77JVJNy5yBzdy81MFrinzBpbY+z5e1NP9E6bJs2xtxFlPRUd
 vgif9nfI/JtTj+cxS8RQ6Ogp6NfdTOqpzm0AQybXBYFcaVNeSn16/7/Xw629CAxHiu97sQ/h
 Lu71zLke5kIRiU8LcPsbf6+kkG75kYMqbhPQkKSHMhZfXv31I07Oh7gr+QWJvsUIk7p3Qqq1
 AexADYZq9LSooQzzsL7uKCco6qtEMp8BkB8HWLLyZqXbA70pnGCx61EW8a2JQHtbnv+ovieV
 L8E3sPCP+0it3cUlYhFSpJA7780vvnrrJ9kljVUJm3BNQmXO+kxM0u9/Jd9s4NWzeVkoiqwY
 EWE/+daNZivOM/IFF0wJhIvXt+c1MM7yyXj0vAoHHrUvCNH3qKLcUF3DSm+jCZwKLhUMoR85
 cwDvMUQyRK0izt0E9Kgox1XyV+xLS07Y/16jq0ZPY7lsRp061dgZZeHNDT6zqvSYPpxM24rA
 ASuuoz8u5pmyHD/LkUDTUr24bIFhLAlmgx781sZFlHYxvvHnqAW2TNSwxQWTyNU7A9148BuC
 Fd0KkcuB6Ov/ihptudHTWuDCwFMPzzH203Tmn8itnzVcFmsbUPJdFYCAOeq+FtD1XBxZR1Zw
 e2o83nkWjPUY83B5Cs+dkp7ofjFT9Yq1An9tO24PsaCRb8WXCHEh/KwWG82tBfXO8M9q0nZr
 +1M/uwrS6naNzYVkpIrGbuhyrUcZxCVFlNsGcg70vsyIljdXzWu1RylCUO7IJpNLsOX136IM
 ZVlI8YXWimu0CqLkCsgOpcNBL1Jh98s2ssJf+L6BGwBsobHlAFTjrDrynHcilMoEvJUquRsD
 qPKdjmHLH6cumsMpU/Js/t/GzSZZfsqWVTC+d6bocQzObANiuVOSX0J86CVuiyVOTR3/hjPs
 wLkYbTX/tNYyo9tvtXNF7lHDADpLdnYCfqD9Quyl/9sbtr/F9jEmC1Ii1vgPiVQZaAwXfYun
 5uzkdfH5mH3l5dobHLowLy6CLhv2cW+eMF1I/DHBiBWsgXaUfC9/iZZ3X6zLKJ4te905+6ld
 lOeU9Sxf9tEYOVt7iRZRAYGGilMFpmtSLnroB68iPG+ChI99wjjB/H//F/LaVBrTAM5C6fcO
 CTV5cn3vst5qb5SDiAqH/tlWp90AGHyUJscKuHei2OqMXmKsHij5J3ZihsS2RPaACKlEeH7w
 67/aDrQSRCQgJzMnfZl69FcnxtOAHhE1Lx6OgpX/tNtkDm1AVIXNelXY91MFphQlTe0z53iI
 i3EaGw5EyjmQDBYalPG7c/+WhuETPk7UjsjyufFI2vPA8t3OG+BPFel3itu/DFtfSb5x+zhK
 twE/HD0eB+rzfmFgArVCuOT2Y9aKjHynxrkOnwRV+TxDgwYDLFM02ZudOaIfTKSCNnDzS0nO
 kBsLV2pgyiHpYrZEst6fXNRXhYDs1sDCtnugTinmL7ihmlQ8AGMJDAT9Q0+Pn3vofnm/IIze
 E4=
IronPort-HdrOrdr: A9a23:TK2pMKnHLZWhYEy7qY+Za0R5VOHpDfIj3DAbv31ZSRFFG/FwWf
 rBoB19726TtN91YhwdcL+7WJVoLUmxyXcx2/h1AV7AZniAhILLFvAA0WKK+VSJcEfDH6xmpM
 NdmsNFaeEYY2IUsS+D2njbL+od
X-Talos-CUID: =?us-ascii?q?9a23=3Aahet12rqb4Yac6cViAtnc5XmUcRmQ3zkky2MGRa?=
 =?us-ascii?q?fInRqebCLQGCewKwxxg=3D=3D?=
X-Talos-MUID: 9a23:EtgcTAvmNI1KfUyaAc2nrQFwKsQzvL6UCV0mkYQnsNigBylqEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200587"
X-MGA-submission: =?us-ascii?q?MDFvwjaFl/mi7gNHc8SZHIxYS1it0aE7Kwz+Gl?=
 =?us-ascii?q?DFhwIoNDRk+EeWs5JHTKCly+j45QDW+IBIPcwEhXkaEYqXcUCKE69WTh?=
 =?us-ascii?q?5b3FyTlhPiCU6QmBJLGUxE8VnXR3xWiq4vOzyS2Sm31fkxBeuIHh0S0d?=
 =?us-ascii?q?oxfsmIsmiPImfZoeBS5N9xfA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:05 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 723AD5C5651;
	Sun, 10 Nov 2024 01:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B35C4CECE;
	Sun, 10 Nov 2024 01:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202624;
	bh=4+lPEWVcZF6MP4lqk4tN8WFRUEgGMvVQurcrEWRHgtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvF7QobBQqDTettWvOayNRcLsy9jjZBQiENvg66pi2Oxfa8Y9pHRF3u1DNVz9dLPp
	 KQm4EZ8ON3K1KsirtFtw0HXcGxBY92FIieCYsMF+7f3MKVxGW7IU8cN9tqVnm9JOud
	 Dv5fFMwhNT7s/iuHMzboXeNcR3/aG5hLBlcON2JBuIhfQYsqnyWxJxOdNrRLQi8MQx
	 NPndGurbb44z6An+viiTYhNMGSPAlt9CfEujkpeC5Q21vD1B2hi65DXI1V5X7SYX79
	 J/LBuOCLX3R0/VNjAdNCIAkIJKRA5e4lUWL/LVs+2d/4JT1ycqkOVdVxgefoNW7XWb
	 VM4OU/SHm7yUQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:32 +0900
Message-ID: <20241110013649.34903-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 04/11] kbuild: use 'output' variable to create
 the output directory
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1979
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-5-masahiroy%40kernel.org>

$(KBUILD_OUTPUT) specifies the output directory of kernel builds.

Use a more generic name, 'output', to better reflect this code hunk in
the context of external module builds.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v1)

 Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index deb3f01863f8..cf1d55560ae2 100644
--- a/Makefile
+++ b/Makefile
@@ -176,18 +176,20 @@ export KBUILD_EXTRA_WARN
 # The O= assignment takes precedence over the KBUILD_OUTPUT environment
 # variable.
 
-# Do we want to change the working directory?
 ifeq ("$(origin O)", "command line")
   KBUILD_OUTPUT := $(O)
 endif
 
-ifneq ($(KBUILD_OUTPUT),)
+output := $(KBUILD_OUTPUT)
+
+# Do we want to change the working directory?
+ifneq ($(output),)
 # $(realpath ...) gets empty if the path does not exist. Run 'mkdir -p' first.
-$(shell mkdir -p "$(KBUILD_OUTPUT)")
+$(shell mkdir -p "$(output)")
 # $(realpath ...) resolves symlinks
-abs_output := $(realpath $(KBUILD_OUTPUT))
-$(if $(abs_output),,$(error failed to create output directory "$(KBUILD_OUTPUT)"))
-endif # ifneq ($(KBUILD_OUTPUT),)
+abs_output := $(realpath $(output))
+$(if $(abs_output),,$(error failed to create output directory "$(output)"))
+endif
 
 ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
 $(error source directory cannot contain spaces or colons)
-- 
2.43.0

