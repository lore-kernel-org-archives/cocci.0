Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DD9C4345F
	for <cocci@archiver.kernel.org>; Mon, 15 Apr 2024 07:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ehw3JP9/jH11oJR68DQOEghJBea6xoCh7eHWITgqHRM=;
  b=XHgnaKNLvKWMkCfoHrTtqQp8oTtloRktHzsohwxyAKkoLGcv34QjoCle
   HVCrbUnF7IxVzRVmItzy3fztOLOIOmTjgteeajD8wZ2faaKfOaZ3R1CmG
   S3cIu/xtb3J8lcuB+lphJgEfWVHzv7xueXv40mEg1bE7ggpSXccZWFHdf
   c=;
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
X-IronPort-AV: E=Sophos;i="6.07,202,1708383600"; 
   d="scan'208";a="161583090"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Apr 2024 09:43:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2CED2E0CCE; Mon, 15 Apr 2024 09:43:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1935BE004E
	for <cocci@sympa.inria.fr>; Mon, 15 Apr 2024 09:43:21 +0200 (CEST)
IronPort-SDR: 661cda98_STqo/HGs2s1z7iULXrSqgnDKVf9jge45l/7V7TdC4kujUwq
 4327MvG7eaRx3GSHue55UnRyY0mY1Iy0aOvtrtA==
X-IPAS-Result: =?us-ascii?q?A0EdAAA72RxmhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDfANTMgQLSIRWiB2HKYIiA4Q7jwaIcYFWFIEsPg8BAwENOwYBA?=
 =?us-ascii?q?gQBAQMEhH8CiBgCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBIxcHDhAnhW0NgmcBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?g06QgEBAQIBIx0BAREmAQQLCxoCERUCAlYGARICAQGCfAGCKgEDDiMHDbM4g?=
 =?us-ascii?q?TKBAYIKAQEGgmfXch8sIleBYQMGgRouAYgtAYV8hEAnD4FVRIE8gwM+g3xHP?=
 =?us-ascii?q?4McgmiHIohtW4IBg0+FQIV3VH0cA1kyAVUTIgsEDBoCGxQNJCMCKT4DCQoQA?=
 =?us-ascii?q?hYDHRQELhEJCyYDKgY5AhIMBgYGWyAWCQQjAwgEA1ADIHARAwQaBAsHdYF8g?=
 =?us-ascii?q?T0EE0QDEIEyBooMDIF9gTQpgU4pgSmDCQhDcRWBCQKCe4E5A0QdQAIBC209N?=
 =?us-ascii?q?QYDCxsGIx2dbAGDAHsTLIFlgRCSUEKScZ8FNAeCNoFggWEMiiGVJAYTL4QFk?=
 =?us-ascii?q?zMOBpJomGIggjSJKYF3mxGBZDqBXDMaJIMCAQEyTwMZD44gGYQUhGGKKAGFX?=
 =?us-ascii?q?EE1AjkCBwsBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
 vbXog55fPhr6zrmpVs6dAKimQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:AJpcf6Mjmwt07cBcTtCjsMiBIKoaSvp037Dk7TETdfUnSK2lfq
 GV9sjzuiWZtN98YgBDpTniAsa9qBHnmKKdiLN5VdyftWLdyQ6Vxe9ZjbcKjwePJxHD
X-Talos-CUID: 9a23:GVE+x25mCCeyZtGV+tsst0IpAO4hLCXnzVT6GmDpFiFUYZ/JcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AbxB6uQ40+zWnq3ByIfAo1Yo7xoxru4KxCXFct68?=
 =?us-ascii?q?CmOyAEyV6ZTq3kG6OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,202,1708383600"; 
   d="scan'208";a="84809980"
X-MGA-submission: =?us-ascii?q?MDEaW6e+aq7+QpBs0YB0/37mAWWB3T8ETg4hEC?=
 =?us-ascii?q?2N+UOeLZeLK+fTEO0Mxi7+TbND3uk5io3f/CRRYaHhPunft2z0gHph3x?=
 =?us-ascii?q?P0VKve3BJ1pxyF/gaqGg0dIYNybLUGUPi97w+0XnfzHEmOsuUMAbLShm?=
 =?us-ascii?q?o0MRHRRijW6y+0rhkZxP7mCg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 09:43:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713166994; x=1713771794; i=markus.elfring@web.de;
	bh=Ehw3JP9/jH11oJR68DQOEghJBea6xoCh7eHWITgqHRM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eryD4r6kmxWCnkLLaPtDkiFoBn4OIfitiMN4abV05fl8tNgD2k9xI8qIF6wmU2fM
	 5Qk+Kwvs29iv33OOKUKVBnc1q96JO1eK+ybtB/FQCkrbw8r/7gKSrCPHQfHOVjBHj
	 dwfO2VrUin92HOM2N4uDB0EuWZY5GrnZoV6tt77/WwvizHP6+OaU3/kMwQ16YIEyi
	 cTGkwk2sxBaP0juO3kLKcPM6l8UwXLjsqxD36BwrBLwR2LVMPuc2VAG2ojIYF1+3C
	 gasuNuKMVhOVmjaN1VDgJmf036H8mBNDPZHV+K3g9chcH51Id+xw7RnWmMw4vkCxG
	 t0UXS7ElfAHoUM8Wuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1sE4zj2557-00Hz6h; Mon, 15
 Apr 2024 09:43:14 +0200
Message-ID: <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de>
Date: Mon, 15 Apr 2024 09:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Language: en-GB
In-Reply-To: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:clWA/QkEMk1zwMQrfsyv96T78gaWC3LvgzWJUo1bf0wfhW8Ib83
 dTf4utj1Tw3KMQwJMwkvi+LGtQt2GBBMU6UbPuBwVyePLDUe3W71tPDnKSa9VsvT3sqgU2D
 caERPxmHaL4CoVKIpUQiXoj+F2s2abtVqYEeEsw4j8HcEgYEFMKkhherMm4g5b+S9nrXboa
 OH2uBab55WhqqaOsclLAA==
UI-OutboundReport: notjunk:1;M01:P0:QIo4Ksqsr9g=;4Gg95QXmFO+zKJrVU0tNrlb2pZ5
 pO2yecCe36GJ78zuRFCpoCTROCAj9WCi7BuNDbDJ8y3kj82gVfEVqGPTCAS9GhAIR73fpgduD
 4/mrWvqX9oWV5fXBI5/7mtZPuCuFJNcQgvX05PjCnK5Ti7OVvamI/rnfoLPUtd5rcl86mrXPZ
 jCHidQabVd49+ww84TFn+RgP3m8gp+FtgtkXjAi7WKLpBhwNrqa83EBoMxIlpmCeqToWEKJvp
 cxxY+u1c5Pw+C3/WDfXEhLb7BqufYxSpeAxhjnro2kKQmuHqkMVxyR7Hvyahbflt0A4phQDzI
 Gju1dKIO9H2W3Jr13NHRhzlwBg+0kPGUwtpgbxMQIamMXl35j3ubfoJHMGNkjVuis695Eju8M
 zv/DqNwtjWDYq1D9bTY5wITMIBNRTQ3a0BeAvpbjjiTq6rkKpz+4p9aKxOWE9t2EJEH3yyDkI
 OcD5mbSvFK08kIYHkFglwGAUwBP6I060u9mzW6dRtvEzqYCN7mOxEplcB1PMJMLVelyOdraK+
 Q5DnPfai0rumhfVNlngBon1Xp1APjwQwjdey8Q7s8Atb+UD/xTVcTps4BPT62puVFic8rRwml
 myVjvlVIsxz0IZ/GsfkfgLLILxTxeqRFYtYMVKchA4CwgUFF+QpiMhxyXLru/wjsbWc06mm1w
 DVk+a+F+hJ2dujOr+bsfc3sU958bOK+zpA/o8ZUIk51OmpVDqz8Kk4l5j+lbKu+PCOpcbuaCb
 ZAnA8S0crAjSHJ4c923RO7mEJUjzCyXPOkUK9E+5PbOqY4bp6KsKr+Y4j0QQjHOeSscgHgoyp
 xpECGR9p6xaDhBT7yMYifcVH2JwfnoPiZs7tpLrvq0e6A=
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1652
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/ee6022b8-3aeb-4e6e-99f5-2668dd344e0a%40web.de>

> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):

I would appreciate a bit more information about the reasons
why this patch series was rejected.


>   One function call less in vas_window_alloc() after error detection

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1f1c21cf-c34c-418c=
-b00c-8e6474f12612@web.de/


>   Return directly after a failed kasprintf() in map_paste_region()

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/f46f04bc-613c-4e98=
-b602-4c5120556b09@web.de/


>  arch/powerpc/platforms/powernv/vas-window.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)


Regards,
Markus
