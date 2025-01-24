Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E37BC0218D
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CwCjKtkWjurQ27tVXLgtG8PRmNueDAYnar25Ci0Tj/w=;
  b=UZ+5XIVWNH+mJ/Hp/Lt4yP3PO1sYrSETpgG0RGfjIoI2DrODbRe3kNDU
   mNuDmrGT6i405pea1T4QVSvLBzX3yoElmwjlyd19jh9aEQk2mxMthefZ/
   mDS5vO/kQZk14ciAbunjTQEOmpXO89tcUXR8uh/3rHH83nLcwLmZ3MWzK
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324951"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69693E0D3E; Tue, 28 Jan 2025 10:13:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 03AB3E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 15:26:41 +0100 (CET)
IronPort-SDR: 6793a320_dZlUhfohP+k0+CMfGtGme6edvKPJ9BDjkbmAkEB6nzGQGYK
 6znTU+WrPeXtElKu/BL4nKVgy94LxiE/yzsGHbA==
X-IPAS-Result: =?us-ascii?q?A0HcAgCyoZNnhcNp+5RagQmBUwKBcFKBVzMEC0iEVo9Og?=
 =?us-ascii?q?iScQoFWgX4PAQMBDUEBAgQBAQMBA4IMgnQCinUCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNSQEQAYIHATOCFiwIY?=
 =?us-ascii?q?wEfAQEBAyMPAQ0BATcBDwsYAgImAgJWBgEmgm2CZQMBBLkcgTKBAYIMAQEGg?=
 =?us-ascii?q?mjZN4FkCYEaLoVrgmMBgWyDfzuDQnonD4FVRIQ/PogegmmCHBeBdII0gQyLE?=
 =?us-ascii?q?YE9hEGEZz6KBQlJexwDWSwBVRMXCwcFgSkQOAMgCzYxAhQNJRBxBTUKNzqCD?=
 =?us-ascii?q?WlJNwINAjWCHiRYgiuCH4I7hEWEU4JDVIJEghR6awMDFhABgjVyex+BKB1AA?=
 =?us-ascii?q?wttPTcGDhsGnhOGSIEOGASSfINPjF6CIKBPNAeEHoFdBgygJIQEjQaZSZh8I?=
 =?us-ascii?q?qhaMYFnOi6BLk0jgzdPAxkPjjofg0LGAyU1PAIHAQoBAQMJhUUBAQGHfIJfg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 8wkd06dXUc1xbeUFhISc8HFLFMNB/c=
IronPort-Data: A9a23:eNoyfKorxA3IxbciI8FoadyAycxeBmKVYRIvgKrLsJaIsI4StFCzt
 garIBmDOamPMDTyKoglOo218ENUu5bWmNcyQFc4rig0RihB+OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvnrRC9H5qyo5WtB5ABmP5ingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kkZIwzvd0qLl1qr
 +QRKCAcNUmCt/KPlefTpulE3qzPLeHhNYce/HpnyTXQB/E8SJzGQqPRo9Rf2V/chOgXQaaYP
 ZdAL2M3MVKZMkAn1lQ/UPrSmM+uh3L4dzRD7l6Iq7A6+G7e5Ad21LzkOt3Pc5qBQsA9ckOw/
 zqZpTSoWk9FXDCZ4Wrf3FWxg9Tsphv2V7AOP+fj3fRuj0LGkwT/DzVPCwXn/5FVkHWWX9tAI
 kgQ0jgvqKIo/QqqSMP8Vlu2uhastRkXUNt4CPw/8AjLy6zO4g/fCHJsc9JaQNYvsM5wTjsu0
 laDmMngCTlutqbTQnWYnluJkd+sETpMLERFXnIrcS9f+9DjsJBo1xP/Xu82RcZZkebJMT33x
 jmLqg03iLMSkdMH2s2HEbbv02jESn/hHlRd2+nHYl9J+D+Vc6aJSuSVBbXz5/9ELcCSSV2Ft
 XIDgcGS6eEIFteGkynlrAQx8FOBuqft3N702AAH83wdG9KFpybLkWd4u24WGauRGpxYEQIFm
 WeK0e+r2LddPWGxcYh8aJ+rBsIhwMDITIu+Ca6JMYMSO8YhLGdrGR2Cg2bAhAgBd2B8yskC1
 WuzKJ/3XCZy5VlPl2PmGLZDgdfHOAhnnDOJH8+TI+ubPUq2PSDLFelt3Kqmbu0l/qWJuk3S9
 dJeMcbCwho3bQENSnm/zGLnFnhTdSJTLc6t8aR/KLXcSjeK7Ul6UJc9N5t6INQ9x8y4V47go
 hmAZ6Ov4ASm2iCZclrTOhiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43JsRrL4o0vvdu1+B1R
 PQjcsCNSKYHADfe9jhXKdG3oIV+fV75zUiDLgi0UggZJpRAfg3u/sO7Xw3N8CJVMDG7m/Fjq
 JKd1yTaY6E5eSJcMOjsZsmC8XaNrFkGuecrX0L3MthZI0rt145xKh3OtPw8IuBSCBDhxjG11
 BunW0YDr8bjooVu0tn7qvmcpYGMDtokT1Z7Hnba35myJyL17mqu+q4eceeqLBT2dnL4x7WmX
 spRl8rDCfwgmEpGl6FeAoRb5/syyPW3roAL0zk+OmvAamqaL49JI16E7JFpjbJMzLoIgjmGc
 BuD1fcCMIrYJf6/NkAaITckSeGx1fs0vD32xtZtKWXY4B5Hxpa2YX9wDTKt1hMEdKBUNbk7y
 9gPoMQVsgyzqiQ7O+a80xx7yT6+EWwiYY4G6LchH47Zuig6wApjYLvdKBPMzrOhVtFuCnQuc
 xio3PfsprIE3UfTUWsBJV6U18pnuJk+khRrzlgDGle3puT4lsIHhCN2zzBmYTlWnzNm0v1yM
 FdFL0daB7uD1BY2idlhX1KDIRBgBhqYyxag0FEmumzTFGuocmnrMmcGGP2s+XoB+Dl2ZQlr/
 7C/yUfkXw31fcr34DAAZE59p9HnTv1z7gfnmv37L/+aHpI/XyXpspWuaUUMtRHjJ8E732/Dm
 sVH48dybvfdGRMLgqhmFbSf66sceCqEKENGX/tl2qEDRkPYWTOq3AmxO1KDQdxMK9PK4H2HJ
 ZRXfOwXbCuH1QGKsjw/LowPKeUtnPcWufwzSomyLmsC67aivj5ltazLzRfHhUgpfs5PlPgsI
 YaAZhOAFW2t3UFvoVHvl/UdGGSEYogjXjbejcSV6+QCEqwRvN58KX8S1qSGhFTLEQ9F0S/Ng
 ib9Sf739cJAx75ovbPQKYRYJgDtKdrMROWCqw+ylNJVbOLwC8TFtiJLi1zBIQ55LbsgXoVmp
 I/QstSthELhl5Q1WlD/hJOuOfRo58KzfewPKePxDiBQshWjUf/WwSko2j6HO70Qt/0F/eihZ
 Q+zSPXoRO4vQ90HmUFkMXlPISgSG4HcT/nGpxrki9+uFxJE8wjMDO3/xE/TdWsBKxM5YczvO
 DTV5cSryMtT9rlXJRk+APpjPZ90DXnjVYYidPzzrTOoNXapsHzTpordkQcc1h+TBkmmCMra5
 bf3dir6fjm2u4DKy4h9mK52tRs1En18oLcRemQwxt1IsA25XVU2dbklDZY7C59qy324kNmyY
 TzWd2ItBBnsRTkOI122/N3nWRzZHeAUfMvwIjsy5U6PdiOqH8W6DaB88jt7qWJDEtc5IDpL9
 flFkpExAvSw/n2tbewa4v39iuBjwvrQwWgB9UX8lde0CBEbaVnPOLqNAyIVPREr0emU/KkIG
 YTxbWtDREWyQ0nrGIBrfHs99NQxomb01ztxBcuQ6I+3hmhYpdGsDNX0POX327cEds1ML7kLL
 Z8yq61h/EjOskEuVWAVVx7FTEO65T9n3iR3EUM7eTAvog==
IronPort-HdrOrdr: A9a23:aJUhL6/oLFPWscOw9sduk+FNdb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQkdcdDpAtjifZquz+8P3WBxB8bqYOCCggeVxe5ZnO3fKlHbehEWldQtnZ
 uIEZIOceEYZGIS5amV3OEgeOxQp+Vvm5rY59s2uk0dKT2CHJsQijuRZDz6LmRGAC19QbYpHp
 uV4cRK4xC6f24MU8i9Dn4ZG8DeutzijvvdEFQ7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl55+kr+qwxnbnpiLuBtVt6ZfcI+l4dYKxY/suW3TRY8GTFcRcsoi5zX8ISSeUmRUXeZ
 f30lUd1o9ImgnslymO0GbQMk/boX0TAjbZuCOlqGqmrsrjSD0gDc1dwYpfbxvC8kIl+Mpxya
 RRwguixu5q5D777VbADuLzJmRXv1vxpWBnnf8YjnRZX4dbYLhNrZYH9EcQFJsbBir15I0uDe
 ErVajnlYBrWELfa2qcsnhkwdSqUHh2FhCaQlIassjQ1zRNhnh2w0YR2cRalHYd85A2TYVC+o
 3/Q9NVvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXOljjHLFvAQO/l3c22sRE2AiHQu148HJpou
 W/bLpxjx9NR37T
X-Talos-CUID: 9a23:Pf9SL2BYZApRdhz6Ezs+9WVTIZ0KTlmH1H7QM17jUGdZWITAHA==
X-Talos-MUID: 9a23:mzfoqQiBNCG6A4BFEK+Ja8MpZJ1GxLmrM2M2qZgJidWvb3dbMTOSk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="107289067"
X-MGA-submission: =?us-ascii?q?MDFPcVGKSEKZaLJ3kz+4SMUNWzxoqic2dSW7ql?=
 =?us-ascii?q?iAJmj16vad1C5JZjk+2aVHcYzu9hTqysrJzt3lg9GcR6dqlXAS0Q8Z0L?=
 =?us-ascii?q?Qdbpym51hF6ftS8dtP1a+ShWP3SLAsTQWK0Rqbj7VmFwwdLqiw31yvYL?=
 =?us-ascii?q?VbRyCA9Mz0g6NLT1TWsT7+Uw=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 15:26:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737728799;
	bh=Fn7sVn0NbYZhm7JxknrOZwVFg9G9cMFFUTYJo64GgPo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BAL1UqWppcSgPAdfimcgwSZtp5TQAmeChpEwqE7virszEImjVf3+eaAJHb82q4aZu
	 xPnOgU/Kc2jz/4PAHJk1xW00xAHe6N03twa6YyvqYa4ssu2h0c37PzgmrIPLQ6n4hG
	 AGSLRa8uBFWxMJ4D5SK8CdMz9K2fv6P1mvYUn0pfh8w0OJ1lgJq7RmVDqB9b0ZUVWG
	 SI2yQGg529UMho2hsuhi0bTYUOp6UE7Bkkn/QpIV82QtpFdO5sJiteVAwgQedKR05s
	 EbGGNnbOh/ttIf20CXV4BVoWHooMZw9NAsEGYzt1tOPz3BuETjqI4cFM3jTIYoqltG
	 wXfVJT9gi+khQ==
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:11:e976::7a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A97DB17E0E57;
	Fri, 24 Jan 2025 15:26:34 +0100 (CET)
Message-ID: <b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, Jarkko Sakkinen	
 <jarkko@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Leonardo =?ISO-8859-1?Q?Br=E1s?=	 <leobras.c@gmail.com>
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
 denys.f@collabora.com, 	louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
 melissa.srw@gmail.com, 	simona@ffwll.ch, airlied@gmail.com,
 Tim.Bird@sony.com, broonie@kernel.org, 	groeck@google.com,
 rdunlap@infradead.org, geert@linux-m68k.org, 	michel.daenzer@mailbox.org,
 sakari.ailus@iki.fi
Date: Fri, 24 Jan 2025 09:26:33 -0500
In-Reply-To: <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	 <20250124081250.GA24731@pendragon.ideasonboard.com>
	 <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	 <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2250
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/b3af62d3565d2d60218520d2ebace6f1a0368c17.camel%40collabora.com>

Hi,

Le vendredi 24 janvier 2025 à 15:00 +0200, Nikolai Kondrashov a écrit :
> On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:
> > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
> > > Gitlab as an open-source software project (the community edition) is one
> > > thing, but can we please avoid advertising specific proprietary services
> > > in the kernel documentation ?
> > 
> > I don't think we should have any of this in the mainline kernel.
> > 
> > One angle is that "no regressions rule" applies also to the shenanigans.
> > 
> > Do we really spend energy on this proprietary crap to the eternity?
> 
> This is not getting included into the kernel itself, the contributed code is,
> of course, open-source. And yes it would execute just fine on the fully
> open-source community-edition GitLab. I don't think "no regressions rule"
> should apply here. This is for developers only, and is a template for making
> your own pipeline mostly, with pieces which can be reused.

Perhpas worth clarifying that Media and DRM subsystem have opted for the
Freedesktop instance. This instance is running the Open Source version of
Gitlab, with hundreds of CI runners contributed and shared among many projects
(which includes Mesa, GStreamer, Wayland, Pipewire, libcamera, just to name
few).

Nicolas
