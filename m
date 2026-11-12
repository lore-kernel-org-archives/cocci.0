Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FD606A31C
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=V73IWPSC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:reply-to:message-id:
   content-transfer-encoding:subject:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=mu4ZBNrGf7WRRqTY132ZGFvNbeezqfeIyO4YhMn0sLQ=;
  b=V73IWPSCG7LyFZxzhGdsvxfeBro/1P5BZ2hVDSHc4ZusgF+DnMhK604M
   Odrd/WHytjY6otLNObIiSkWjuIigdGCB72rJ1RRxYXlSE8ItW7njH7yd1
   E2IDpE1ca6brq06jsn/kWigbdYQLbhlZjgAeL65TZsXB99Dbc/N/Egcd9
   U=;
X-CSE-ConnectionGUID: 9pozkWcWR42FSV/JXv0emQ==
X-CSE-MsgGUID: nZnPj771T2mflmDkcHEhTA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305052903"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 11:34:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DD3BD81AEB; Thu, 12 Nov 2026 11:34:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 29D3081996
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 11:34:21 +0100 (CET)
X-CSE-ConnectionGUID: lLAO8UGPTCyYWZSFo73Wbw==
X-CSE-MsgGUID: b/m3YCs1SMygVAfYfD4wEQ==
IronPort-SDR: 6af5962c_BlgUTME8ONx9m53ZrO7DsLkywoJv98YNCYalXnWQlFUqIb5
 MGfD7J/Ed2hq7K8P04g1UhUAeRKaXKw1AsYgOxw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H6AwCnlPVqgQQqG9RaglmBblOBBVQUMgcIjhubFowJg?=
 =?us-ascii?q?X4PAQMBDU8CBAEBAZMlAh8HBAUtBw4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEA?=
 =?us-ascii?q?QEBAgEBAgQDAQEBAQIQAQE7Bw47hlyME4RGAlMQC11MhW8EAwGzAYdTgTSBA?=
 =?us-ascii?q?YRmGNlLgR9VgU2FdIJSHAGLHQ4NgUhFgRWCe4V/hXkEgiKBDIFaAZYLBwceQ?=
 =?us-ascii?q?1scA1ksAQ8RNRMXCwcFYIEIA4EGbjIdN2w+Fy9YGwYFgRyBHoESgQVdgSsoX?=
 =?us-ascii?q?gEgfQuBdQKCUYIAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxnC?=
 =?us-ascii?q?AMaBUACHwgCDQx0ORAwHiQvBRomPhsKfgdmPTcJDBkEAgFCQh0SAph9lR+QU?=
 =?us-ascii?q?aFAPIQqBYFvghCTcolwEhwXhASUGpJUmQipRYFvBi2BXH0IghSBD08DGQ/gX?=
 =?us-ascii?q?kRxAgcCBw4DC4VGjFaBTAEB?=
IronPort-PHdr: A9a23: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
 wKYyWIrRQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:P2attq+uyhm1Qb4kSjNuk+DtI+orL9Y04lQ7vn2ZLiYlCPBw9v
 re58jzuiWVtN98YgBCpTniAsi9qa+wz+8T3WByB8bFYOA3ghrREGgK1+KLqFePJ8SZzJ846U
 4KSdkaNDSfNykZsS6riDPIaurI2OPrzEmzv4vjJmlWIj1XVw==
X-Talos-CUID: 9a23:zj6exGO0jkT0fu5DXA1O0x4pNfgZWWzs80XrDUjnUlljV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A45M8Fw4CpMn3sIitfEjoO4hJxoxipKH1OWsWyK4?=
 =?us-ascii?q?jqsa6HCJBNRvBkxmOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305052857"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFIjU4yQDbeG0ij68kBQnDMJkRP/Sho26/qoH?=
 =?us-ascii?q?c38dAdRA04YBv88fQpPv9qIse34V47kWBelddIWwtouSqLzhjBrfI0if?=
 =?us-ascii?q?ray6SQLNURJIHcfBrDyqgG7skypkiNjkHdwMsYc9pLsjtZUN2cOL8S/u?=
 =?us-ascii?q?HcjGzUvbaZnrfdkBtE8bBQiw=3D=3D?=
Received: from smtp4-g21.free.fr ([212.27.42.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 11:34:20 +0100
Received: from lettres.chocolatnoir.net (unknown [83.159.1.88])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id 6CC6319F574
	for <cocci@inria.fr>; Thu, 12 Nov 2026 11:34:20 +0100 (CET)
Received: by lettres.chocolatnoir.net (Postfix, from userid 126)
	id 15382CE8E20; Thu, 12 Nov 2026 11:34:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
Received: from lettres.chocolatnoir.net (localhost [IPv6:::1])
	by lettres.chocolatnoir.net (Postfix) with ESMTPA id 53CCFCE8E1D
	for <cocci@inria.fr>; Thu, 12 Nov 2026 11:34:19 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 11:34:19 +0100
From: picca <picca@debian.org>
To: cocci@inria.fr
Reply-To: picca@debian.org
Mail-Reply-To: picca@debian.org
Message-ID: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
X-Sender: picca@debian.org
Organization: Miaouh
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Bug dans la parseur de coccinelle ?
X-Loop: cocci@inria.fr
X-Sequence: 3790
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/HTZHSTjptsj9WO2Jm-kEqw>
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=no autolearn_force=no version=4.0.1

Bonjour,

J'ai un fichiers qui ne parse pas,  je fini avec cette erreur

bad: 	sprintf(datetime,"Date: %.2s-%.2s-%.2s time: %.2s:%.2s:%.2s",
bad: 		&INLINE[25],&INLINE[23],&INLINE[21],&INLINE[35],&INLINE[37],
bad: 		&INLINE[39]);
bad: 	if (NULL != fgets(INLINE,INLLEN,infile)) {;}
bad: 	if (NULL != fgets(INLINE,INLLEN,infile)) {;}
bad: 	sscanf(INLINE,"%8s%f %f %f 
%f",dummy_name,&HMIL,&KMIL,&LMIL,&BETAIN);
bad: 	/*
bad: 	 * First two characters must be spaces and beta shouldn't be zero 
for
bad: 	 * for correct beta read from header
bad: 	 */
BAD:!!!!! 	if((strstr(INLINE, "  ") != INLINE+9) || (BETAIN == 0.))
bad: 	{
bad: 		BETAIN = 0.;
bad: 		has_read_beta = false;
bad: 	}
bad: 	else
bad: 	{
bad: 		has_read_beta = true;
bad: 	}
bad:
bad: 	sprintf(DATATITLE,"%.40s",&INLINE[9]);


INLINE et une variable global de type

char INLINE[fix size] defini dans "ana.h".

J'aimerais savoir comment regler ce probleme de parsing ?

Merci

Frederic.
