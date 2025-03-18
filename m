Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFA2C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=igHgIpWdpOaaZK/xQBdCQjQDuc+k8+pye6Nh+J3Bo9I=;
  b=NxtjE0h1Zh7tV1Zg8cUFStMNt0iZ8WMokb4+VdACMBvuhFXmk9G0VMOL
   ebeXSPfWU5/NyO2VZVyFbZgD8JKj+hko9aVQ2y8gmThyuYcXgHx1rKcb6
   EPBlzA5tk6e2tN6rU+JhC576OXiuzvjMIFxiWzsL+z7aZ8IPxQ9XRntgU
   w=;
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
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213525783"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 16:18:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF347E0264; Tue, 18 Mar 2025 16:18:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E741E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 16:18:05 +0100 (CET)
IronPort-SDR: 67d98eae_4He+GVGb+cp0jETYSbvBUeANg2qf9/anWA2QYzuWMfrHKyL
 VoLzLrbKaN+SG7Y9PE7VhcCPctS2rTUwTAQBtaA==
X-IPAS-Result: =?us-ascii?q?A0GPDQBXjdlngAMP49RagQmBU4JEYhtaMwQLSIRWg0+MA?=
 =?us-ascii?q?YF0MIQ7jw6IdYFqgSwWKA8BAwENOQgBAgQBAQMBA4IMgnQCix8CHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiA?=
 =?us-ascii?q?TNxZQk3AQEBAQEBAQEBAQEBAQEBAQEBAQEWAj0HA0QBAQECASMdAQERJwQLC?=
 =?us-ascii?q?xoCERUCAlYGARQBAYJ+AYIvAQMOIwcNrXiBMoEBggwBAQaBCNlUHywiV4FlC?=
 =?us-ascii?q?YEaLoVtgmMBhieEPCcPgVVEgTyDAz6CYQICAYEWgQaDHIJpgjOBCIIOgS1nh?=
 =?us-ascii?q?xqFYIIVH3iFNAQRVmyCSpAcUnscA1ksAVUTFwsHBYEpQwMqNDEjgSIFNDQOO?=
 =?us-ascii?q?CmBY2lJOgINAjWCGyRYgihqBAWBJII3hD6EQYVQghGBXQMDIgGDH3Ucg0h2P?=
 =?us-ascii?q?oRkLVCBTR1AAgELbT03CQsbBj2jDjuEPYFBgX0HZKQ6oT00B4I4gWaBYwyKK?=
 =?us-ascii?q?ZU1BhMvhVqRbA4Gkn2IKZBVIo1jmy6BfSSBXDMaJIM2CUYDGQ+QDIJChGCwc?=
 =?us-ascii?q?EI1PAIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 CaA9raGRnm5n+PJxjc1CHJz
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:qnUcP6h3EjJUjnfEEDTBqWermnBQXskji2hC6mlwRA09TyX+ra
 2TdZUguSMc5wxxZJhNo6HkBEDiexzhHOBOgbX5VI3KNGKNhILPFvAH0WKI+UyDJ8SRzJ8/6U
 4ZScZDNOE=
X-Talos-CUID: =?us-ascii?q?9a23=3AXNXssGjtWRQFOIlJHqWC7NxdnTJua1P+41ToeE2?=
 =?us-ascii?q?DUkUyWqatdEXJ451onJ87?=
X-Talos-MUID: 9a23:0qrsHgb6mMHXhuBTsCTjnzdZCoRU3p+HJwMjnK48ive5HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213525772"
X-MGA-submission: =?us-ascii?q?MDF3RNOKdyCnRyyTDnlkbyNInF5n1DLL05Osgu?=
 =?us-ascii?q?Udk8Z4yJvWSb5TuxozWYCz9iifKC9zSF2W1dFUtpU5Dafo6LyEicQaK8?=
 =?us-ascii?q?ekyYYE9WJLbAgs9ca/jjFIQyNuI2E4xz5fEOUsUm0NQ3pfiU8iuedI1H?=
 =?us-ascii?q?Go68NgUf7EtUuFfpsk/fv6eg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 16:18:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742311084; x=1742915884; i=markus.elfring@web.de;
	bh=igHgIpWdpOaaZK/xQBdCQjQDuc+k8+pye6Nh+J3Bo9I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZYwS0VMbJjPEux7Fxxa8cuypzr9kzWN3Ks5Rits8gH/XMO+ecmcUMkaJeSoeU2Rr
	 aME9lnUvmmDsybMenEwjGYi0pzUv54Rwpxd0cvtwftapfF7Yo2Etj5WCs3X80G6eQ
	 oYlJw72Y/FP8GhrKjlLO75VxUKs4COcP1SkmgDCyYKUR37F4WzKPsWr15Ws3pnk2n
	 4o4KVRa5Hh8Pq5CZjUC84P63fY4Vxzd3EtZ5DYHmR9Kh3LNZeNzw7qBziU81H9YOo
	 Fj3YM9rJ8aGCuoPjmECo01MPx4VQ3HS5rdocX25eOfm3x2YXvSH3+CCphwNu4R2NA
	 U8Md1ON7AtCpJvrdvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Voj-1t7s1l1Aif-017C8L; Tue, 18
 Mar 2025 16:18:04 +0100
Message-ID: <d508db9c-fa5a-4aac-b4ee-d67573d5aaa5@web.de>
Date: Tue, 18 Mar 2025 16:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250318111305.281abcca.olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250318111305.281abcca.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HYOayB9bwqAZ91O5HjdvcM7lAz5D2dPo+1OvOiK024pT/o2/N+q
 nNypvhwXr14yJvFtxz9psdWK0We5GhVub3Vhp6OOUbkyK8ML7E++dBIHdlMpmQVbDdWkyzo
 DcJmnm4y4Euv95OeoJgiyqWoGnJTETxlaNRgCPBfSERuSUGwUORGiyhhzj/sCMhhBhhzikq
 /G3/yuzogHDpDdPbdR76Q==
UI-OutboundReport: notjunk:1;M01:P0:Lt10MJ76W4w=;XbosyYoQ9m8cNIuncyrtZk+avj3
 ZiiMahsL9hew7d5UjEdUKBdZ3RDe6XPaLHn8ovAC1q10tiNv4uzSpKqTIPsaCUe0QDxSpmoGj
 iSjzZDDU9az8dH5mlyHbg+koPsQ9iieFcW2v3gHq1b/wZMVcofH3Jeh6XdyIAlyse2MauurQr
 3PKKoQi4dMDgkfW/hXPhtf49874niwI2IdiiuPgk5snMIc7z+pq22yk9yc7U0dFnEl119RybH
 rZURDtiPlizmWS2GVt5WXr5AGHKyFPxzZFk2sxF0IsJE+PU3E8RmjaOMXR1Rcf2vUth2hr0NH
 bC9HTLVP1ECJAdYQ2krXpY3gRVS/lp3ZMG6QQjVm6qx8m1EY1Nt9CiNk7bkl5I9NLZZmH2RpX
 3uR3QViTNfJo+J0ey9E0ViED5RvfRlXImZa0olQI4GxnM605spHWrnOTb3oeBn/2tYMjBIIA2
 S2kC8ljnGgsdohm6vcauEM6lHQYY/dqnS2V1XsF4uPWlgVsCJcxN1WxEhXm9tz+r2pcEVAwB8
 XDGxEQ2iYZdxQypJgtO6CAsuXbQhEbWKVOpl0gVFcCg2PlCLbs+x/AdRMjEyHYZTaDsmh931u
 Nrm9JtFbQgR7w7JOZAf4R0RShCDQoEcC4boyYkxYCJaBPjgTz5hEjEH4ZvcWio7mrSLgBCsBK
 EXl/f8NlJQIhXk1xBcuyOz5/q1+okAAVvQ9U6evV9NOv3+VjW1ho0hU4Mra4HQPiNcvVnfJdO
 j+KXzSxet1CZHGiY6f/hU+3fMtxM+LH3wEA8ZeMaR8cO2O4d3BkXdR8dS8Dhy2VEUrOfjQ8ms
 /Bv2GRjI+SofTnL4Gxs8c565Osj9SVStTFLWF3UHCfJAkJvEv/+CbeV6SHY1DxspfB6c/bs7/
 u5MDi9zH23ItBIuCT73fBoOkHwqheZw0wpb8JylFMa8eT8TMWpNZR67xgImkKzDlcxy4QeCxz
 ALKP9Cwsm7ovRx+MBBPZebmD8khcCWDWPW0YpiZ1wUOW0wzgagsYnASovDmY28lajN8V6xcAj
 TTWYJdjxxuO30OKHmI0NE6SDTOJOu7GQXtTRIiAa+OWbh3BVSUE4eGOk/87WT+4+3RsvnOLtC
 dSHaumJ022mplD1WSK5W3VVFoRiWrfItzq3g/lmg3NdjvIdnloNtfoxJH/f6405AJD6Mt33vj
 RE08xhEuWhUBXck3vASWns+Jq/OTgkdFoEEN26LYbAMVDhedOFAJXfDig6i2h64XjXF2SfQXb
 Pz8nYtGwsrgyKegfVl2pnGyBeRjRjrLijMrkQ8qo+wASyETNy9BhTNOo84bSgnxRhvGlCfSrt
 D1E3IkO4jq4EK+uLC3PQkXqfxuK49eYWxUNZMZ3rOaCg4c8RQrDiLZ6Ckf6hVzJPUwC4ONQ8B
 J2eT8qcAPkdLQmHRWByDHU6sXH4SsiOOEiOlwZE2H/IgCovJbxgKskdyS9Q/W17/P1fa0kHwA
 3XxSth++Q0+rNBOqKNTER0N3z2yEbdk9Lk1oZlRlqbsGP727+
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2624
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/d508db9c-fa5a-4aac-b4ee-d67573d5aaa5%40web.de>

> While looking for the proper way to import pcre2, I realized that the
> way configure.ac looks for required OCaml libraries is ... weird.

I find such a view interesting somehow.


> There is no way to force the usage of the variants in bundles/,
> the version provided by ocamlfind is always preferred.

There are remaining system configuration challenges to consider.
https://en.wikipedia.org/wiki/Product_bundling#Software


> I think since a while the required build environment is easy to create
> with either 'opam install $ALL_BUNDLES', or 'zypper install $packages'.

Corresponding software dependencies might trigger further concerns.


> Hence I suggest to remove bundles/ and all code referring to it.
I propose to take further case distinctions better into account
so that the involved software build system can become safer and more convenient.

Regards,
Markus
