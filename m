Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBB2CCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wKRq6Ju1skhSe8iFmdeF8ZRGsydXVNDSbV0PmfELvbQ=;
  b=ffR7UzodYosPXh0iZQkCDKcFCrbxtxM3uZ4EkGKv2Z5dVRN6az124yle
   BDQMTp6pw+kgGt7lMpIj/2ZYXdQJ9FKekxfc5kfyZ6gnISnP/xCoyW7a9
   EE5K50SOhsFltBtUTb6WRboAL6Lw+doK/BNL9B6cVOUIl0ow9S3j4/SG1
   E=;
X-CSE-ConnectionGUID: 2FvWLiTJR9eoCaxhvq+dZg==
X-CSE-MsgGUID: UqHzZ2aVQYynIfjEnpXafg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246850832"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 13:26:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6B455E0BE9; Thu, 30 Oct 2025 13:26:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 59AC9E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 13:26:27 +0100 (CET)
X-CSE-ConnectionGUID: DvpcjNQCT2WIegko9BRgQg==
X-CSE-MsgGUID: FV0MoXHfTN6M8XfhAmoQYg==
IronPort-SDR: 69035972_Zlqf8K6gzOyZal8x3iuYBZAG4nNsuBXqyDv8qucEaWbnfl1
 i65GlKLOQuIemrrm1I/htLuIXKuWLk7m2ABYviA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GCAACtWANpgwsR49RaHQEBAQEJARIBBQUBQIE+BgELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRVj1KCJIQ7hzyQToFVgX0CDwEDAQ1OAQIEAQEDBDiBVIJ0A?=
 =?us-ascii?q?oxTAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAToHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB7B0gTKBAYIMAQEG2l8fLCJZg?=
 =?us-ascii?q?WQJgRwuAYVsgmQBhieDQ3onD4FVRIE8gksHMT6EQ4NbgmmCJoEOhimSPVJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIEMDKjQtIw88BS0dgSQiHxgRYD0XQINJGwZoDwaBEhlJA?=
 =?us-ascii?q?gICBQJAOoFoBhwGHxICAwECAjpXDYF3AgIEght+gg8PiRACAQttPTcJCxsGP?=
 =?us-ascii?q?ZQzg1SBBG+BNwKTB4M9r2w0B4I4gWeBZAyfbAYTL5dSDgaTBZkGIqkfgW8CM?=
 =?us-ascii?q?YFcMxokgzZPAxkPjiEMDQkcg3XLHEI1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 0xv4jY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BxJS264vckjkvx9yogPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:Lr1772NMTb+k5u5DdDd//0wyI+sZKEL8wXjTJB6SM2lQR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AteAQYQ/uPR36t8StSSTNhGuQf+lWu4GpOGADrbN?=
 =?us-ascii?q?Ynpm0OyxZPjCkvTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129495610"
X-MGA-submission: =?us-ascii?q?MDFds/QmWvTDADOIFHThFMKq1ppawlcpBgpVPE?=
 =?us-ascii?q?coiFbhKzflptfW67O5MxKr+CKcVwnwP0a2Ni5Ox5by9k1bxgTM9RlMk5?=
 =?us-ascii?q?9uSmRFtZkBMRz2Zm0kaIwo81e4EuN1IGO8d0499FC/z98E9crskcDAKg?=
 =?us-ascii?q?o1DdZWq9+6Ma6f2PivMte+Gw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:26:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761827180; x=1762431980; i=markus.elfring@web.de;
	bh=wKRq6Ju1skhSe8iFmdeF8ZRGsydXVNDSbV0PmfELvbQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QmLj2K1rc02+Van8hHM7jt2OsJzq+A+mom/MwJ8gPxVJ/mLeGVZO92P6p/4XULuL
	 OEz4HrdBmX6Jb/vurG0UQgRz8FuiqFjjn5uyl9XjklW1Y6SZKffqLZUQYt8hmRCHE
	 wEQBfuuBPBU7DlrXM+7IaCzD6+lDSrSXBsq0xxWrpRR8Th85VO3hUf/JWEHXmfS3P
	 D1lxXPeOPl03zK8ku/FKTic5Z+k+wBaAICSNRkCLmfmYUAyrRODAdkphQujmSscPS
	 138VQVBc9Mygc93Y++4UJBxJ0yHAPUAM62kbIIUbKk0RWVYiTxDL44Nrcmyq4AX34
	 olFkdR0LvyIiRTn2FQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j1c-1vKTLN3TiM-00HCVZ; Thu, 30
 Oct 2025 13:26:19 +0100
Message-ID: <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
Date: Thu, 30 Oct 2025 13:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bz1ahwt8PKujpvFw+axgHQjxI/y34qeztIKDsshP/5jj4yqxJIN
 MrV/2Q+fofAth6RwA2yPXkCAAKu7e10pQfbTAbdiwWVguUJclSdgMrD9QKw3uwHr6tbNfW0
 bGwIeMDqDgzcfgKQME2/Nt1fuebSzMi4o1WSQXpfGoAKO0T8tPYpfF29RJvhRX2u5ZkmeZa
 qRIclI5LOttQuQD4z1s1g==
UI-OutboundReport: notjunk:1;M01:P0:Yuy3p+mWVqs=;uJZegLi1wAsQ8tyOHJ/w7UXw37I
 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
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3119
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/60f881dc-979d-486b-95be-6b31e85d4041%40web.de>

> If you have a concern, you have to say what it is.  It doesn't seem it i=
s
> about the running time, so why do you include that information?

How will remaining open issues be resolved?


> I should not have to repeat your experiment

It would be nice if further software users would occasionally reproduce
presented data processing possibilities.


>                                             to figure out what you are
> asking about.

I =E2=80=9Caccidentally=E2=80=9D tried also the following SmPL script vari=
ants out.

A)
@replacement3@
expression object, size, source, target;
@@
 target =3D
-object; memcpy(target, source, size)
+object; memcpy(object, source, size)
 ;

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
=E2=80=A6
@@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
                        goto out_err;
                }
=20
-               page_addr =3D page_address(page);
-               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_p=
ercpu_size());
+               page_addr =3Dmemcpy(page_address(page), CHOOSE_NVHE_SYM(__=
per_cpu_start),
+                                 nvhe_percpu_size());page_address(page);
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,578s
user    0m0,524s
sys     0m0,047s



B)
@replacement4@
expression object, size, source, target;
@@
-target =3D object; memcpy(target, source, size)
+target =3D object; memcpy(object, source, size)
 ;

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
=E2=80=A6
@@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
                        goto out_err;
                }
=20
+               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start=
), nvhe_percpu_size());
                page_addr =3D page_address(page);
-               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_p=
ercpu_size());
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,565s
user    0m0,533s
sys     0m0,032s



Would you like to reconsider implementation details accordingly?

Regards,
Markus
