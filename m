Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7C2C76195
	for <cocci@archiver.kernel.org>; Mon, 27 Mar 2023 05:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NbwAOPMrDQxUEIt6QthT83wL1c/Cwpr53Iu46jtcHVo=;
  b=oUak/DxcVSCHF/kTRKzOWBR9Xw3JAaVEcKQOlWX64/MdaPv3CmmUAh2i
   XlDKca/gROF6VfPVafGkb8+9SVXnm2w5LdMYfCEDFA57vaun2Fwolf66I
   3B8RXFs5Why2wQkxAgAPbeL8ztvuwIxjHWhcTtd6IFldU842AzIMeW3M7
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.98,293,1673910000"; 
   d="scan'208";a="99183829"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2023 07:56:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98E09E0D42; Mon, 27 Mar 2023 07:56:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E40FBE0D40
	for <cocci@sympa.inria.fr>; Mon, 27 Mar 2023 07:56:40 +0200 (CEST)
IronPort-SDR: 64213017_IXo2B6fAzLnqbDtN/jAQbXsADQwf/QgxU/bfxa4fkiZwDEl
 KVLriZoB9kYi5cPsds8Im0fLumOPp+tFUVV34Vw==
X-IPAS-Result: =?us-ascii?q?A0GXBAA6LyFkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLnVWLwQLRggihCmRATGEL45mhGeEAoMWPg8BAwENOwYBAgQBAQMBA4FJg?=
 =?us-ascii?q?iJORQJrhE8CHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEVYOgQYCAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAg06GDs9AQICASMdAQERJgEPCw4MAiYCAlcGAQwIAQGCegGCJwEDD?=
 =?us-ascii?q?iMHDAatRYEygQGCCAEBBpwKHywiU4FeAwaBFC2NBYM2eicPgVVEgTwMgnc+g?=
 =?us-ascii?q?mIEgV6DWIJngiqHWIQZiyMKgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOb?=
 =?us-ascii?q?4FKAmRMgRclBA4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGH?=
 =?us-ascii?q?DQRAggPEg8GJkQOQjc0EwZcASkLDhEDUIFGBC9egQEGASYknUSBQYFegRmSK?=
 =?us-ascii?q?wiSOJ4ONAeCKIFVgVkMigyVAAYTLpcIDgaSIy6HLZAPII0ymkiBeiOBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44gGR6DOzOPCQE+PzQCATgCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 2zjxtsMFN+g3ROBRfo=
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:1DFF0a5MD9DiXHxB9QPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,293,1673910000"; 
   d="scan'208";a="51315115"
X-MGA-submission: =?us-ascii?q?MDH2OvaLLQJCJ2vr4f+PyddGqPR0clUy4Rj9dW?=
 =?us-ascii?q?VSsK4RgWdp8ifF/b9pYfaa8q8Lvhm1Cr9/6o0/y50plvTOi3/pXLfz9H?=
 =?us-ascii?q?NaWjenyBg+8iEUi7oO5RmjPiuMRwEgaUUTQ26E6E9TiS9QaMB4jzZiat?=
 =?us-ascii?q?U7G7WSAPqB8+N7OY8kFX+D7g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:56:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679896565; i=markus.elfring@web.de;
	bh=pz/J0Hn4+9u+G26gPwGVXPtbTt3MxR2I7unMqST3Igg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=wVADs5LHX7spvpSubZ+v4nPIXGVfrzNkf8ibwxU2UHb06xMXH+EE/6JbxjYPzYIdY
	 znDbAvGe2zq0IWPd0BS72QMrKxIQdRsmnSwDz7SpjZ8uj7cqJsYRq9+uuGOB/w0y26
	 l9k6N7EYK6P9WDMLkHscHsra2HpIKCTXfwuHauD/CcQ2Tibk1ewrj6ZLSJ/ubpwPTt
	 zUK09KQc3VPIjHSjsqYhZ1nuMoi7YTWddo3HT57bBgKzFyrfJwbjS1nmFE3D/XJwI6
	 ptoVTvMAzAFyhi3E4I7ReXeuwL6NXj8r5F5/Ekc1VOODRMTuZGYaRIEmZqyxHq7OqA
	 JOKqtpnoKJ4Xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk0k-1psFKh1zhK-00TI8R; Mon, 27
 Mar 2023 07:56:05 +0200
Message-ID: <c46dbb48-259b-1de9-2364-9bfaf1061944@web.de>
Date: Mon, 27 Mar 2023 07:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: David Vernet <void@manifault.com>, kernel-janitors@vger.kernel.org,
 linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Jay Kamat <jgkamat@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <c383bdca-6f0d-4a75-e788-e1920faa0a62@web.de>
 <fffcd98a-bb73-41cd-8545-0f2c55dd38f9@lucifer.local>
 <5b7921c9-ee5d-c372-b19b-2701bcf33148@web.de>
 <20230326213900.GJ363182@maniforge>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230326213900.GJ363182@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1gwnZkH0S7NOslRRW02w5YeQ2GC+UHGP08MEPPAyTvxz2nKDWMC
 HJFhFZ9TyIlWXP9d3nb1XbmaYsbPRASZsmUfWzWarfWlnIgolNeKexeBYmRCI1WHybLcw1K
 teafLPSrb0FP+fXa/4ZQjfeE3QEtOiQmoFhjTgH4xxYTul0SH7X/CqfVCQmNEhpa+e6qqHL
 tSkaSSyK7nE7iTodcf/4A==
UI-OutboundReport: notjunk:1;M01:P0:Htzphb0YYVI=;6y+XyO+AN5hu4AW+bfxbV3QzUDG
 9bcm+ocGOjQrpbGJI99ku1L3oJsNv9nnXcxI+su8i/Ahr7TSHkrbh1bL3jEsMly/+2jCdHk7s
 MMyhwqofXY9WeEG5KW7/pVWjqCwXc4LTxiCls35O1G20/gThnLvs7nNTJ2B3sMhiMu1jQruU8
 28rnxOqka+u+teftx94THlhfTHwe6H5ekQ25VomXdxEhfeTynQuOA3DzfRamnGNONM33+WNZu
 nIlw4q5Xeqa/OD4jDLnZ9OCskK7tCFuAc8LpCjwvYDmNWgNkh1iZWQQD4q4a/+jP/bz+qkKR4
 jWAgdkWRusUJBnfOTuJQ+02cFXNzeYv+lzjpMuo08JJeprv1jBIzCYt2l96PI2UI43NnlmAMJ
 fLnXQ9QGx3nc0Z2XGOjqLtNbr0UvFS+OtcN2GnQdVEaD/I1mymFh4KClTbndB4Yu6cWQLGLz+
 UV/MULYvvyg5bo8W1kEoJAngo1h1UNYY3ZdMbROGpu6FTGYiZmr4CBNDFeIsuiTdjAf8DcrKF
 IyZKE7jb96H1N98WCE/LkMBJYnYt708PskGu2iAnttpasZgyCIgfPPhGlh295P7ELxPLZqc89
 FHa8MnIsvaTbPVQ/Ns0GbVRrFBcLYERrlN7frycaR/8tQn5Zmm29WB7Q2mdQ8miTJ0cyopO9T
 ua+CmxAOq0Al5I+B3qzqGoIC/67OOF/Y3ZBM5FWDiS++w0FqYX7CL0SQyVpSGP9BGw7Di64dl
 Smy+MOGgpxnWmrvkwt3DUqTnXiTzlzmbvRU3SAUAzs6li++DH9x1qjpbqiLPBWVgql9D5I1rr
 nC9nQFppBcrRPdxS/2ZcSAeOnHefnbETgOISLTYp+o1YQM9bzPOiHCMjvp68JUz89gxKqFwx1
 rzWptgXaDBrz60cSF4cm9KzYKWJDRYG3eEtHOmcPjHpefVme2svuKTXao
Subject: Re: [cocci] [PATCH] selftests: cgroup: Fix exception handling in
 test_memcg_oom_group_score_events()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 962
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/c46dbb48-259b-1de9-2364-9bfaf1061944%40web.de>

>> 2. Can a cg_destroy() call ever work as expected if a cg_create() call =
failed?
>
> Perhaps next time you can answer your own question by spending 30
> seconds actually reading the code you're "fixing":
>
> int cg_destroy(const char *cgroup)
> {
=E2=80=A6
>         ret =3D rmdir(cgroup);
=E2=80=A6
>         if (ret && errno =3D=3D ENOENT) <<< that case is explicitly hand=
led here
>                 ret =3D 0;
>
>         return ret;
> }

Is it interesting somehow that a non-existing directory (which would occas=
ionally
not be found) is tolerated so far?
https://elixir.bootlin.com/linux/v6.3-rc3/source/tools/testing/selftests/c=
group/cgroup_util.c#L285

Should such a function call be avoided because of a failed cg_create() cal=
l?

Regards,
Markus
