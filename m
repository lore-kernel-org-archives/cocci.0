Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586E0C3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IRa323tvRQStlWRyBE3ldqhrtQrliFg6xCR/Bq1UuBc=;
  b=ozvO4wZzSq1b8G19ByjVOpwkbZCofgXfA/nE0ugGYBdLrtkVc3dvrMbd
   za9gw0Flwrxeen7WVbce74fidfvJ3Sxa2mG1a1gZ46XlKemE5opP/qaQ6
   XvgWWDb/ByCiku/XOkZNyjQlcOke7REkRh+a+p7AmLV5L/Y9isiSUUXBE
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178141465"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 14:14:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B84EFE0141; Mon,  5 Aug 2024 14:14:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 78831E0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 14:14:45 +0200 (CEST)
IronPort-SDR: 66b0c235_BmGnmdYCoBxpsTiXD3YOOBnI0rdTvruDPzoSkSht4+dPXIA
 rCA2CA1hngRP2opwPjIwmexZoNofxmopi4kdVpA==
X-IPAS-Result: =?us-ascii?q?A0HBAgDSwLBmh07ASNlaHgEBCxIMQIFEC4JEYhsGVDMEC?=
 =?us-ascii?q?0iEVo9MgiWEO48LikuBQD4PAQMBDT0EAQIEAQEDBIILgnQCiUoCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V1DYJnA?=
 =?us-ascii?q?RCBEoEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMdAQERJgEPCxoCJ?=
 =?us-ascii?q?gICVgYVAQGCfAGCLwEDDiMHDa1fgTKBAYIMAQEG2lkfLCJXgWMDBoEaLohKA?=
 =?us-ascii?q?YlfeicPgVVEgRUngwM+gkoXBBiBRoNbgmmOToNYh3mEAiaBJIczh2RSexwDW?=
 =?us-ascii?q?SETAVUTFwsJBYlLCoMjKYFLJoQYCIEtFYNlDYFeDGGIVIEOgT44gScBg0BKg?=
 =?us-ascii?q?2ccgWOBA4JjVx1AAgELbT01CQsbBj2kSIVCCbNClFg0B4I2gWKBYwyKJZUqB?=
 =?us-ascii?q?hMvlzwOBpJuLJhEjXubG4FnOoFcMxokgzZPAxkPjiEZhBSEYcJaQTUCAQE3A?=
 =?us-ascii?q?gcLAQEDCYVGAQGGXIFLAQE?=
IronPort-PHdr: A9a23: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
 jfni6/5bjtPoYu8wA==
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:itWmsKzpP0ky2NAElArhKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:NwSI8mDwdIWpupj6E3I/0nI/RMMaSSfMllPAPF/hAEVKdbLAHA==
X-Talos-MUID: 9a23:lMjLoAa7sfpqWeBTkDHrmCxgF+hSw4OuI30v1sld4JW0Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178141449"
X-MGA-submission: =?us-ascii?q?MDH38G/CrVlPXbV4onrjkGrqyprO4CBfVxTGNI?=
 =?us-ascii?q?D06jV08kECTS4MqMvDBtk5KZnVEH0slcsUc1g9A99s0G/6Y3XvHm3VJy?=
 =?us-ascii?q?84lgosiWtKC5UesLdD+J5syBFvILYpmvZSynL81cqwxYT+67Irx0GOVY?=
 =?us-ascii?q?rg952O6X415RrbQUPBA5Wrrg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 14:14:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722860083; x=1723464883; i=markus.elfring@web.de;
	bh=IRa323tvRQStlWRyBE3ldqhrtQrliFg6xCR/Bq1UuBc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oSN5IQyrZN0bvPypmXSNkwM/3S4sUHjQAxaV7estE1s9+3yRa5TSwqGeM9kLC3Pp
	 LywbmUtrxFbkxo3fu1Nvgo1css5vLLAYQVcwxGnGSUUiTh/ZBy52LwkIpRcC3K7ud
	 ebm9GS+YBbHBXAXdt7ARjSUFKFpXF5fYnvWu9vW65A2xyYqltNu8rWeaUHc+81RPO
	 KpHKoGUzJTHXRpSFAqt2LZx+kPeAEZMFCv9rkuqBnwS9VFKpJIVAYjezPPJoR83SJ
	 fgLBaITnr2uP4bQOjQhmES7hxMHUtm3HN3AsaSqfSORv72hlHXRtMK6UEoncgmkDJ
	 HML5FmzoCHETC0ELqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOV6-1sqqfB2yIU-00NA1I; Mon, 05
 Aug 2024 14:14:43 +0200
Message-ID: <c05b066f-af9b-49c1-9bdb-9167d24e3d3b@web.de>
Date: Mon, 5 Aug 2024 14:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3dt/C+2IptyuMDtrl4Op+fNvYtQgULi/qdoBcQMXuhFiK28Yp4k
 8FSfIA9d6i2Rsws7lQVnI8f2nFqZ/vFsocSDlSPMCNxcq8zpE9DuNtOFPrBUuObMTSc1lLb
 ZrLhzd2MCuRgVAIQofrUGnoh6EdHGYtOxuYhQjJo6ApRydkFPeooHLoI+COoFQf9/2TQ4+w
 rKLGg4Zrea815KL/SNClA==
UI-OutboundReport: notjunk:1;M01:P0:iuZPEsL4EM4=;NkVrWqtQi7KKE36knxdRZwkNRg3
 NLOiLuVaheMVjiqYOQCBOflgFbMA49NeXI0FPENbssJnO/EA6WKVbxe7kBMEp3HZL6ERjbVBe
 7VLJtclpOnBPq7deH8kIo45aF8UvsNwoeojAo3HR4EDqZI5zruc65uV/Hen4K+jhOPqxeyZ8H
 Xb0aOC9A3PkqHVhC9VVXqPUljUT50qz6EtWiqfCVRoMf/Bq9uK21/uN47CDvE9puSuVEgYs+t
 P9NACZ6W7Bzj2JJ68kj1Yj25N5m22mFh6m9nNtq7xKt6ote3yaapUXcfDNHJzr6ed5SJKDzUv
 98e5Ug8ngKIberJ9mG4pKjXQFVdeZLv2Kc9LhkGwz34McanyUWYZgn5NB7k7yZorL7+PFFsHT
 ALOzpwoHl/FsL2Kaod9dfND1aBaO7DvchC9UlScsb1ibz1E2fIF08yk2KEOEI9e2ur3MGOLl7
 2+g8Xik7qzOWn4DasDGSHGPTMb7Os5hAj3K5uxu8W+QwhxrLdqkLO5ud5clZ6Hy8+fKNged07
 BGFnUnsLiAwOHQfrlZm6VqL9UMle6qjGuNx01te5vYk8fE0ycTiUnMiCakvZQF60fQF1UxFbh
 IRU0cakxt1CGOeCm/FHikeIcIxO960z4BH7QUWqk5cAeegcxqlcZ76z/xwTXD10FFyvlxhmhS
 T+8qIlni1t7xWvi28vP4Ura+cpvGS3RT3UkgQf6aG0fwrfev1hI9nqBTA6VP9i2g/FdNvAq1L
 IZmSbq4+1u/mcvcFYr+7b8qRgk2rEMh2PcS+ChoiXOSD8AF34F4L+Rxn//OXAfhWJWpimlm/i
 NCQLd9og1FYEY0F69jjNLn1w==
Subject: Re: [cocci] Questionable run time characteristics for SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1838
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/c05b066f-af9b-49c1-9bdb-9167d24e3d3b%40web.de>

>> Are there any possibilities to increase the measurement granularity for
>> affected SmPL scripts?
>> Would you like to compare software run time characteristics in more det=
ail
>> (in parallel) also according to each SmPL script?
>
> Let me know if this is enough:
>  time make coccicheck M=3Ddrivers/media/ MODE=3Dreport V=3D1 | ts -i > 1=
.2.ts.txt

Unlikely.


There are more system configuration possibilities to consider.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.11-rc2#n203

I am unsure how far you would be willing to increase corresponding measure=
ment efforts.

Regards,
Markus
