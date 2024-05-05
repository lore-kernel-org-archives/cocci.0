Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CB0C4345F
	for <cocci@archiver.kernel.org>; Sun,  5 May 2024 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Cx3BHwF6eQJQgdqCLwi9/GtDrMK8F4Ntxy/3itFmL+k=;
  b=iI/47JI4iTS8GKycaX+dKr1trwcbak8EZSmoxrdL1q+QdSRqAn/uwQsB
   0XLlbDrF+0EpRsDOXVc86ByQFuC5Q4TKFYHKwwy93d2v01079Qh/23oFh
   OLBP7oXyI4LxTW7aBySYqEAxdZmk3eZno2d+nQKfknzQjITrPKM3f657F
   4=;
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
X-IronPort-AV: E=Sophos;i="6.07,255,1708383600"; 
   d="scan'208";a="164528429"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 May 2024 07:26:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ACDD7E0133; Sun,  5 May 2024 07:26:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A1AABE0035
	for <cocci@sympa.inria.fr>; Sun,  5 May 2024 07:26:05 +0200 (CEST)
IronPort-SDR: 6637186d_VBtRV/ogLgvbvtxmmaneJDPgCxI98FUH9UvdlSzAb+2jxbs
 Q9RdLE0qzFhJtZYr99P5NcMWX0x++fRdKosm33w==
X-IPAS-Result: =?us-ascii?q?A0HTBADbFzdmhwQP49RaHgEBCxIMQIFEC4JEfANUMwQLS?=
 =?us-ascii?q?IRWkTstA4Q7jwiIcYMWPg8BAwENOQgBAgQBAQMEgguCdAKILgIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZ?=
 =?us-ascii?q?wEQgQ5jCDsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEwINOiIBHwEBAQIBIx0BA?=
 =?us-ascii?q?REnBAsJAhoCJgICVgYBFAEBgnwBgi8BAw4jBw0GlRecNIEygQGCDAEBBtpZH?=
 =?us-ascii?q?ywiV4FiAwaBGi6ILgGFfIRAJw+BVUSBPIMDPoJKFwMBgV6DW4JphRKKN4ZmR?=
 =?us-ascii?q?4EAgjOCK4pmVH0cA1kyAVUTFws+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZI?=
 =?us-ascii?q?BYJBCMDCAQDRAMgbxEDBBoECwd1gXyBNQQTRAOBOIl9DIMxgXUphCIIQ2wVg?=
 =?us-ascii?q?3WBeA5ig1yDHR1AAgELbT01CQsbBiIBHaEXgzaBAhQpAoFRbMVANAeCNoFgg?=
 =?us-ascii?q?WEMiiGVIwYTL5c4DgaSaJhiII1UlUqFSYF7JIFcMxokgzZPAxkPjiAZhBSEY?=
 =?us-ascii?q?ZkBQTUCOQIHAQoBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CF++66tPUUgwQD/hSmbFgmS+7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:jmXrWWOqiyRtfu5DYQ97/WxIQ5seUT7kkU/JB02qIkVgR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3APKYQsQxeANWAfK6aihluij8DZ46aqI2gDntXoLg?=
 =?us-ascii?q?2gtHeMghwKWyas2uxTYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,255,1708383600"; 
   d="scan'208";a="164528428"
X-MGA-submission: =?us-ascii?q?MDGYXbi4vvp+tJk82ZPaJ78okeF3v1NfXp5BoZ?=
 =?us-ascii?q?mnUMkHURjRXuSycvP0/UvC+ZmV7xEtQdnkLYL8Y12TTRSWtKaJHam9mR?=
 =?us-ascii?q?ysXEs+xUZPDqoMKf2+0QUa8/ZYr+j59aQb/oQR3t/7GZgtjT6G2WI1AR?=
 =?us-ascii?q?w/6VGcn6u4UmEPILmqt1okZg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 07:26:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714886761; x=1715491561; i=markus.elfring@web.de;
	bh=Cx3BHwF6eQJQgdqCLwi9/GtDrMK8F4Ntxy/3itFmL+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K7MoRdgKDVm2v0O94072ezMvaZSeYWxzQ4OBGxstKgwikFO59vJViH4M3X0u//DR
	 61BdXtXn+8Op9XJHJl2cIspxrGKEVSX+TiYB7Qf4kH/6kEKoSgG4qIlhCYPKhx8uL
	 16WjnQjJpldD1rzEqearxCZmGgt62/SR2PVnb3o86qR0h44/VCldig3rexCQjwMCv
	 XtGiToxSKcN1T+rR5y52Z+3+wpJ9pNbhoHYChv7eKV2dvO4kYO/y1kI9IUrsIVaPX
	 a5kBsNAr8EU19VkKQTbuDNd3/wlpAOIBV/jazUVXIqeV41Dtnrc8Wvmxou2e2I8fX
	 3GHu6YK/gLuW03fLnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1sKbnP2wpG-00IN60; Sun, 05
 May 2024 07:26:01 +0200
Message-ID: <777e1507-b0a9-4c08-bf68-3ef1fe67061d@web.de>
Date: Sun, 5 May 2024 07:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
 <20240503121530.GV7636@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240503121530.GV7636@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6a3YRUSQCv01tEFH0FEFkEsDtAn/ELOGjNThmpXdnQNhVWqizt
 6ieSy1y1HGa/HohU+NKcXxi7BgOKKkYOJZr7E+PhmdLTUfV1SUOgczLHG3dwVMiCyXwBM22
 zCbfOJyK8iyp6Zwm5AmB5SJv1jlE+Pf5/BX1t9W2IV+iy3WP/jwsQIncRwwUyHyGHBM/Mvl
 EQ1T17A4nlVSwevleipTg==
UI-OutboundReport: notjunk:1;M01:P0:6qDp8g8lH7g=;zelfhDrrEl6K6uMyV0ww6U00+KI
 bl4tO0dSLr1+YH+t3SNk9Pv8qWg39AJ/uMyUaSqMO0d+RrasdvqIywwS6sRCRc0H8RHeDEu9o
 xoy4lx50Fj7jr33spQDv39ydYGmpFX2MihKX0V30TYAsXDFbMEGsTcwKx2A8n6KJVC/OuHnzd
 /88wuDl9Trnp0EyUWtQAMdL+p63OtNfwbBAbfsbelHORy1YuEK4vQYrTXXKWP97XLtRTVkaHe
 orp+UODRf+il849VOHFPRxNuoYQL5oOt5Qa5c9Sxqv+YdLOkF0SdS/f+0mEDUpeEOnDBlNSXa
 MI/nfKkqlvOGGFNWy4MNS9Zm/5Q8y0amxhYThIclkl6LK1Pi56C0RmBg2j3kFkbMbhe9coHzM
 /REDKOZiVA3wZh6k2kaJcxa/IHba9DC9NyEPCN9v9aAeeS+ZeuO5TrwxwZVPDVzqkzDu2bbCV
 J+RV3hQYOv4WrJtCl1N/7kG488A0mjAZazu8fxvebj4e+rukoN6e1tLx6Pl/4BmbqmiEe6jEf
 J4ONokaygys2q0mebdS7TWQSMBtjIyumCyOMJT7xF6SS3tN4bwvkYP+6tOI6zlUD5QF42OOa9
 NGx0jaitnJAKmtC7ymjTuNa1VPYX9UveADm4s2z1QAQ8MaVgJh5/uEIHswObRF/i+TrXUCqW1
 2AOivqjytkvt9JE+ucq62eN9x/h57TsuKondPkCWIJxTfZCnW57N3cYCbH82Cf1Y/8vRK4Y61
 d7kSsnZEszu/PJupvrr9hgqvexyrG4AofMrsnjmsSeLwNQDQOzrTQNQGyf5zYS26mnuXFI1zZ
 hEV/NueKHS91Z6UmkzLtlA8YYT+1NFgZZqMxeQm43cAl3/ymJv2G/O2m7cv+zac0jj
Subject: Re: [cocci] Using OCaml compiler variants?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1700
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/777e1507-b0a9-4c08-bf68-3ef1fe67061d%40web.de>

> It turns out this happens because Fedora enables "flambda" in the
> OCaml compiler (ie. ./configure --enable-flambda).

I find related information interesting for further clarifications.
https://src.fedoraproject.org/rpms/ocaml/blob/f40/f/ocaml.spec#_253


> More here:
> https://ocaml.org/manual/5.1/flambda.html

A desire was indicated to benefit from compilation optimisations also
for source files of the programming language =E2=80=9COCaml=E2=80=9D.
Such optimisations mean extra data processing efforts.


> I will discuss with Fedora if we want to keep this option enabled or
> drop it. =E2=80=A6

I hope that development interests will grow for corresponding case distinc=
tions.

The following information is also provided by the referenced software docu=
mentation:
=E2=80=9C=E2=80=A6
(There is no support for a single compiler that can operate in both Flambd=
a and non-Flambda modes.)
Code compiled with Flambda cannot be linked into the same program as code =
compiled without Flambda.
Attempting to do this will result in a compiler error.
=E2=80=A6=E2=80=9D

Software builders would occasionally like to choose between standard and o=
ptimised
system configurations.
I got the impression here that only optimised builds would be directly sup=
ported
for affected OCaml software packages (in Fedora) so far.
How much were compilation durations checked during the years?

Are you looking for possibilities according to better support for other
software build variants?

Regards,
Markus
