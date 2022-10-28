Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC85DECAAA1
	for <cocci@archiver.kernel.org>; Fri, 28 Oct 2022 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=b1QGVQLtbUy2JrwXSqk8ndEk+5t8cSllp9NABLtDxko=;
  b=TIOoZVe3Xi1jg5VXK2ZC3ILAL6PD3eHYIDTeviWe8aN5eEq0uaXERuzc
   gIL0izkn0UdyZEAo3R1xeBd41H6iWus3AR55eqsus2Ocsblm2CPsPMkCr
   5ezXosVBFXTx4JWlUx5VxMyVnrT1z/hcT6m1utQBTI94Q/p1sp0A7vK/F
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,221,1661810400"; 
   d="scan'208";a="72093575"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Oct 2022 20:12:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78CEAE01BE; Fri, 28 Oct 2022 20:12:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 43804E010F
	for <cocci@sympa.inria.fr>; Fri, 28 Oct 2022 20:12:26 +0200 (CEST)
IronPort-SDR: 635c1b89_PjZdS5IWKhDmWKylgzuTj9Qx0tHneA7CQVsWEqLhf5oDGac
 MvZaB3zNsVMfL8ZV6d+FiKNqG83KAL0SfqTK0qQ==
X-IPAS-Result: =?us-ascii?q?A0BMAADdGlxjhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYIsgQEDUy4EC0WETo51gXcxhCiORIo0gX0PAQMBDTsGAQIEAQGEf?=
 =?us-ascii?q?AkChHkCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBA?=
 =?us-ascii?q?QEZCRcHDhAFIoVoDYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBg?=
 =?us-ascii?q?nkBgmwBAw0jBwytOYEygQGCCAEBBoFAAYMNHywiU4FdAwaBESwBjDqELycQg?=
 =?us-ascii?q?VVEgTyCUzA+iBuCZo8LgxOEEyYEDgMZKx1AAgELOzIDClEbMScOCR8cCgQXD?=
 =?us-ascii?q?QUGEgMgbgUKNw8oL2crHBsHgQwqKBUDBAQDAgYTAyICDSkxFAQpEw0rByNxC?=
 =?us-ascii?q?QIDIWUFAwMEKCwDCSEfBxYRJDwHWDoBBAMCECI8BgMJAwIiWHQCLxEVBQMNF?=
 =?us-ascii?q?yUIBU4ECDoCBQZSEgIKEQMSDwYmRw5KPjkWBidEATQPDhYDYpk3g1KYNIxnn?=
 =?us-ascii?q?0I0B4IdgUuBTAyJcZRuBhMug2UBkwYOBpITlycgjSKVFYUegWQCNoFbMxokg?=
 =?us-ascii?q?zZPAxkPjiAMDQmEA4ELiSI/NAswAgcLAQEDCYVHAQGEdQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:6PfbPKtf1011KOOKdCCg5JIzVOfnVHBaMUV32f8akzHdYApBsoF/q
 tZmKWqPa6uJZDH3KN1yOdvn9kpUu5+Bz99qHlc/qHo3RSIWgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbyRFtspvlDs15K6o4WtC7gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYrLFDn2fF/wXEqfFPH+9NtDV5uOrEG0ctXP30f+
 rsxBXMkO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4QwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKGAI9gjK/fFfD27751J68LTLAJnsQNmaGOpKkECn9
 mj58DGsav0dHIXClWTcqyzEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPXOnpPCjlk+4VvpNK
 kke4CNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9kbKyy2hIGsFUWZGVMINme8IWW0lk
 Xak3Pq8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4oe0tvIGLTGYb0UunczpzLEKmpoGtRmqtk
 lhmuAB72O5C3JZXv0mu1Q2f21qRSo71ohnZD+k9dkSo8UtIY5SmD2BDwQGDta4bRGp1Zn+Mo
 zA1nNKdhN3i4LmIkzGRBvoAFvel6p5p0QEwY3Y/T/HNFBz0qhZPmLy8BhkgfC+F1e5aIVfUj
 Lf741852XOqFCLCgVVLS4ywEd826qPrCM7oUPvZBvIXPMYvJF7aoHozPR7Kt4wIrKTKuf5uU
 Xt8WZn8ZUv29Yw8nVJaus9Aje51nXlWKZ37HMGgn0rPPUWiiI69EOpZbgLXMIjVHYvd7lyd8
 tBDOtGMxgkXWeKWX8Uk2d57ELz+FlBiXcqeg5UPKIare1M6cEl8VaO56e5/KuRNwf4J/s+Wp
 SvVchEDlzLCaYjvcljihoZLM++0Av6SbBsTYUQRALpf8yNzMNf2s/5AL8ZfkHtO3LUL8MOYh
 sItI62oasmjgByek9jERcmi9N5RZ16wiBiQPiGoRjE6ctQyD0bK49LoNE+nviUHEiP954N0r
 qyCxzHrZ8MJZz1jK8LKN9Op7Ve65kYGlMxIAkDnH9h0eWfXyrZMFRDftPENHpwzGU3x/QfCj
 weyKjUElNbJuL4woYXoh7jbjoKHENleP0t9HkuA34mXKBv1w2uH6q1DWdauYjryej7V+qKjR
 OMN1ND6EqQNs2hrurpGMYRA7PwB9f7wgYRF3yJYHHnvRHa6OINKe3Wp85FGifxQ++V/pwCzZ
 HOqxvBbHre4YOXeD18bIVseXNSpjP07tGHb0qUoHR/c+iRywbugVHdSNTmqjAh2DuN8EKEh8
 NcblP8m0S6NoTt0DY/elQFRzXqGEVIYWaZ+tp06Pp7iujB29n58O67jGg3Ey7DRTeUUKUQ7A
 C6mtIybjZRm+0fyWX4SF3/M4OljuaozqC16lF8vGlDYtefG19kW3QJQ+wsZVg567AtK+MMtN
 3lJN39aH7Sv/TBpiJJ9XkSpIQVgBQKYyGP12VAmhG3UdGj2d23vfUkWG/eBw1AdyE1YJgNkx
 bC/zH33dBrXZ+Tz43cCYlFkoPndUtBBzA3Ot8S5FcCjHZNhQz7aroKxRGgP8T3LPNgQgRDZm
 OxU4+pAU633GioOqakdCYPB97AxSgiBFVNSU8Na46IFMmHNSg6cgQHUBRiKRfpMAPjW/WuTK
 c9kfJtPXivj8he+lGkQAKpULoJkmPIs2sE5RYrqAmw44p+/tTtitazC+hfu3FELR8pcqudjC
 4fzWQ/bLEmuqyp1oVLdlOhFJWuyXvccbiLewu2e0bsEBrADgs5WYGAw1bq+gCTMPCA6pCCrn
 R7xSJLX68dAyo1cuZTmPYseJgezKPL1DP+p9iLquftwTNr/C+X8nCJLlUvCICJXIqk0d+lss
 Law7O7Mw0LOuYgpX1Djm5WuE7dD4eOwVrF1Nv3bAWZ7nyzYfuPR+DoGpn6FLKJWnONn5sWIQ
 xWybO2yf4U3X/Zf3HhkVDhMIS0CCqjYbrbSmg3llq6iUiMi6A3gKM+r0VTLbmsBLy8BBMDYO
 z/O4v2r4ohVkZRICBo6HMpZOp5fImGyaZt+Ipe1/XOdA3Kzi1yPhqr6mFByoXvXA32DC4Dh7
 YiDWhH6cw+otbrVyM1C9bZ/pQATEG03lNxYkpjxIDKqo2vS4K86weUh3VEuD5ZJjmrt2Zu+a
 DylgK7Oz8nidWwsTPk+yI2LssSj6igmJdrzYDAkl69RQznjH5uOWdON6Q85i0qbuVLfICWPN
 twUvHH9VvR0LleFWs5LjsGGbSxbKj82C57GFY0RUyA/PvrGPYg36Q==
IronPort-HdrOrdr: A9a23:7WgNya+Ye8t0nKV7kQVuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,221,1661810400"; 
   d="scan'208";a="35862703"
X-MGA-submission: =?us-ascii?q?MDFx7lCQhELDJ9unpabcq5FA6y3HAs17bZs/HG?=
 =?us-ascii?q?nHZQyScsFEHw11+lQAdRvxfC/L4MzbgAJErchPTmHRnhu2uwzrDPsuSq?=
 =?us-ascii?q?7Vf3/iXd5Hokqcd+SUukgTFJGi9rXxdPqKTHqz7xc5PRGyLDfpcbkRAv?=
 =?us-ascii?q?7+qcDiCcs/xvboxB8JjhlBrg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 20:12:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666980744; bh=b1QGVQLtbUy2JrwXSqk8ndEk+5t8cSllp9NABLtDxko=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=KzBDrK/SDnlmKNeAuGakTd7Xc9HjJY5sViLsxinox9RMkocdiNyYLnb1AbimPuoPx
	 vh5yxL/+2SGSXXpB5eAleDw2ubmsVDxmcWQM5Sq32SHOaHsV0wDP2/DXU3Ncyk7gXR
	 rejxU+PtoKxrxNVviZ6Hhf/+CxcFGRkJatEJvLvqLpDj4yDzEtRXOG5d/4fvCsql3e
	 plxRsJylbPX7acg7RDjrY0sO2S4pgTBpGpL2GP8gojDwwvc/AMwKQ5m3OhES0HgLGp
	 xGiZqaoisk9Fa6Xz9gxMAZOBnyjrSLb91iaRLgQ4Ee02p1BFf+kPeOYvByIDsGbVHi
	 IewChrfp1DYtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Epo-1pAhbM0nTc-014FTI; Fri, 28
 Oct 2022 20:12:24 +0200
Message-ID: <e3eaafe7-eb32-e6cb-8be2-869d0fb46db9@web.de>
Date: Fri, 28 Oct 2022 20:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
 <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr>
 <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
 <ow4zgdj3t7l.fsf@inria.fr>
Content-Language: en-GB
Cc: Jan Tojnar <jtojnar@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ow4zgdj3t7l.fsf@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6t5PGAUChCbqFLT0eTCMGN0WWTjUfmXGncdgKtbeMTGqngJYzNl
 wXQIEGJoZC58lFRrvZAxmOPjzfckUl5yGMEk3g2OUfJCF3SLAHvyvw2Zfgk2TdNW5KK7JIE
 oQbHy/3jmPMMI7HvL9fUHlbCKyweZcskURrvEAh1glRBCdXZgIIfGvNOHjeHwI5S/4Izq5Y
 zxaPzWhMku/rhqvOsiB1A==
UI-OutboundReport: notjunk:1;M01:P0:sZmkooKa5J4=;4dksX0FF8BsT63mmN8wxJPb/NK/
 2vjvHffeKdO92khL02OVZ9kHgJTB9T/1U34ovbKai4uJ8S7TW2NPSDBbkAL2XXKLsj+GYcmfN
 MM1h7Mel8hvMIP6n+uhdhLRAM/+IToE/29+r+ITthC+zyeC9vZaK+pcawUxby2qXYj+L6/hjE
 Q/gnC/Q1o2QnZS81XoEo3eDakPW1S37/IuEa0WxFzAQgYEj4LXEcwn1yYWRoAyUoOBJlBTDU4
 ZjIoNOhtyJd7BkMXqYyz78C5ziTsbkDiHMhYQObhQwb5+1R7GlhsZpAlILaoOhEtVjTl7WZA+
 V4WolO5DJo+RtqLmn8VjvKeWQFhgWqPH2i0Oou874nhw96iebl+cwbwUUNme1Kri20WmXHYEX
 EKMBV6nYiUOHJTmyCahiokc6YaqPK3dsabAcyHWgvZGyZiqvvzxv3u0dolCRuszTX/kXVSi1v
 rfQZCuf0dDGAMycbg2nbUbolqEDOkj62K03ccd2vYUp6EADUJufv0nKPkuDWuk4hEUcq1/EJg
 UAehl+9Nxe7cjyIy5DjG4qEmeY/YINNHlGUDasBUh/TQR7C5iq71VAuPSMQP4Qu1ReWafAgEy
 6+q1kZfB3bg9I/ko43KAU8Fy20IL4frrLl5KdgJ6FarxCQvm4CtdFfnmFVOF+cWrToo0JIKUn
 ws5qzhEBdeQg84PfHi2mmhQNyv4GifJQDsm/nR7CxNUandeQ2wvIfV6jQjy6aHytx6eK44qe/
 qL/t5oS/4aUK0ZQ+fLFp6u1Rbb3sUCqIiO0mqqgA83zBlwPp1HlIfJUG5k00GfRJd39CKHUN/
 n1dfOSwDZs2G7y24+plRYjtGVw22mhsl5UkdJvlBrVDZXk+FMzfWEumBkkfD7UL1S/L9nS0qS
 x6U3/U/PUKnvvv/uLUPrf9aEe9d0F2Uo25uNDP8NrqmD4vK5uPvHe2STMGLGUBFxwl2qj0aCM
 N5N2156+OGZ49/+Jh9sU7NxYnNU=
Subject: Re: [cocci] No longer possible to build with system dependencies?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 693
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/e3eaafe7-eb32-e6cb-8be2-869d0fb46db9%40web.de>

> It will be fixed by the following merge request:
> https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/231


Why did you not add attribution to Jan Tojnar (as the bug reporter) to the description
of a commit (from 2022-10-26)?
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/0f96f7b8ac3f6a31f571eb845e6c253a34f935b6

Regards,
Markus

