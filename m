Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC846C3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ySWAI4kP7vmZs3Y+VlnIHKgTIesun+Yl241EM1zS2CU=;
  b=D/6X8lxChhCE1QYkHR9STNWmBRIiL38O40kxTQIik9hnPgU0BfYqbihX
   Sw79QtXTyEAVn1HuXR0uI3DhZfozDk1xN/JzrIfxVp8Ny9O5l6zDpbmW+
   Hn/Qw8Dh+ISjSncDnkj8s+XWHWi8pQ54JaJUeT4rxKKOCa3hdcwISpj6P
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="143972891"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 11:18:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9305E0AF1; Mon, 25 Dec 2023 11:18:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CA5AE004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 11:18:33 +0100 (CET)
IronPort-SDR: 658956f8_Y6Wd0koC1PZ+1uawr/Tft4mphsv+tuh8t7w00v3k5o9tacn
 PkCU7sKWt7LXRt5N3RNkP3BmvZdkg12rVuTrkZA==
X-IPAS-Result: =?us-ascii?q?A0FWAABbVYllewQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4gVIyBAtIhFOIHYckgXUwhDuHNYdMhGuEBIFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiERwKHNgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABASQYBg4FCyeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IDA?=
 =?us-ascii?q?yMEGQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQevFH8zgQGCCgEBBq9YH?=
 =?us-ascii?q?ywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgRUng0GIHoJoiRwHMoIcg0+RXH0FQ?=
 =?us-ascii?q?XAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV6BUgp+Pw8OEYI+IgIHNjYZS?=
 =?us-ascii?q?IJbFQw0BEZ1ECoEFBeBDm4bEh43ERAFEg0DCHQdAhEjPAMFAwQzCh0LIQVWA?=
 =?us-ascii?q?0UGSQsDAhoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2wfM?=
 =?us-ascii?q?gk8DwwaAhseDScjAixCAwkKBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPC?=
 =?us-ascii?q?QQlAwgEAyspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+AqZQgQ5yg?=
 =?us-ascii?q?gSScpMdnnI0B4I0gWCBYQyfKwYTL5cmDgaSVC6HUJBPIKhGgWM6gVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIDiDc49HQDU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23:wNZ3GRALosu0I7NAkXkMUyQUiUkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua89ygWTBs6CsrptsKn/jePJYS863d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhzexe61+I
 Au4oAneq8UanJZpJ7osxBfOvnZHdONayH9yK16Ugxjy+Nq78oR58yRXtfIh9spAXrv/cq8lU
 7FWDykoPn4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Ximi7
 7tuRRT1hioLKyI1/WfKgcFrkqlVvAyuqAB+w47MYYGaKvx+fr/GfdgHQWZNR9tdWzBdDo+5a
 YYEEugPMvtCr4TlpFUAoxSxCgexCu3v1DFFmHH20q8m3OouCgzGwBUgEsgSvHjIstn4NqEfW
 v21wqnSyjXDautb1zDn54jScRAhvOqMVq9/f8rVx0kvDQLFjlOfqYf4OD6b0f4Cs3KY7+p9T
 uKjkWEpqwV/oji1x8csjIbJi5kby1/a7ip12ps6KsOhRUN9fNWrH4deuTuAOItqXsMtXXtou
 CAix7AIupO2eDQHxZApyRDfb/GKcYqF7w7sWuuMIjp0mHxrday+ihi880Wt1OPxW8ep3FtOo
 CRInNjBu24O2hHN9MWKTOZ28ES52TuXyQzf9/9ILVoqmabFKZMt2KM8m5oJvUnMBiP7nEr7g
 LWYe0k54OSl6OTqbq/iq5KcMYJ/lx/zMqAzmsykHeQ3LBIOUXWa+eW9yrLu5VH1TbNXhfMsi
 KbZqorVJcEDq665HQBV1oEj5g66DzehzdQYgWMLLVxbdx2clYTmJk/BLOj5Dfe5nVusjC9my
 +7bMrH/GJnBMGbPnbX7cbpg60NQ0gU+wcha551OC7EBJPzzWlX2tNzdFhI3NBa7w/zkCNVgz
 YMSQ22BAquXMKPIsF+I4O0vLvKCZYALoznxMeUq6OD2gX8/glASZbOp0ocPaHCkAvRmJF2Ub
 Wf0jtcbDWgKphY+TPDtiFCaTTFTYGq9UL495jwgE4KnDYLDRpi3j7Cb3Se7GIdWZmFcBVyWH
 3fobdbMZ/BZZCebL8lukzoJfaauRpVn1hy0sgL+jb19Ia6c+SACs5/nkdp84ezPkgsp3SJ7A
 t7b0GyXSWxw2GQSSHt+4qF5pkA16VCe1eAsnf9fCNh75P5TVAo+c5nGwLopJcr1X1fkd82KV
 U3ub9GoGzA3QZpl5tYUYFtmXfimgArC2SWCHLIf0bCGUs9nupnA1mT8cp4ug03N07Ms2hx/G
 pMn3QyOg6d+81OWHIvViwCCkL7sc60A3SnL/WPFzGyUvUgeXhQjGb7dUyU5YU3b5c/8+luEV
 6WnXJEuKAhc0oivLqVQa9vmpUpLTrHvNYeWeHq/zl+5Hg3A3baQdMzvcmQZ0j/aDR0hmhoQ4
 G3AGAwwHCanrErBATYoGV+8K1j0/7xYr3W2BlQx0xnMb0Bl0O+t/QUJgPWHV/4J9rcDpTtnt
 Dh+Wlqwtz7PI/yHoQcpPKBVYNdmpUxCyXqcrAtleJqpM6FlgFcaNQVxpULnkRttWM1GloAxo
 XUmwRAXS+rQ2U5ddz6ewZH7O6HGYmj08he1bqfK21bYmN+I86YL4f48ph3tpgasXkYl9nxm1
 ZFS3R7+rt3vBRARTIm3f0I57Rl8qJnFbyN7646VnXxgPK+osyPTjsozDbhtwRKhctFDdaKcQ
 VWrSYtAXZfocbFsxwvMDFpMJu1Z+a8qMtnzcvKH3PXuJ+N8hHe9inwB5olh00WK/i46S+jS3
 p9DzevLu2nPHzr6klqltdj63I5eYjRHVE+20yv5H8h8YqNofIAEIXijKYu7y58t4vylE24d7
 1OlC14cjYWMcACRcke78Alez0URrlS4lCH+wzE+wFRL5uKPmSfJxerlbh8OPGVGEXJjgVnbK
 o+xl9kGXUKsYmDFjTOd7F3hj+heraV7dCzIRFtQOjPxNydkW7exsbyLZ4hO7okpuGNZSrb0b
 VefQ7/76xwUtkGrV05X3jMmbHeHvpvjnhp1oH2QJjB/oTLVdNpxyhHW+NHHDaQIhHxcHnY+0
 GSRWhC1JJGx8M+Rlovfv+zbNSrpTZBVfSTxjMuBuCa9+Wx2EEi6lvG3lMfgFFty2iv62t92E
 CTQ+UylOM+xjfv8aL8hIhoNZhe08cdxF4Bgn5FlgZgR3SNfnZCJ5T8cln+1N9xH2KX4ZX5LR
 DgRwteT7hK2vS8rZn+P2Y/9UW2Qh8V7YNzvKEYfwCEg9IZnDKmO7bpLtTR4qBy0oEiCBJo11
 idY0vYo5HMA1qsssRAu0z7bL7QcB0heMgTzmh7O4930/8A1LC6/NLO30kR5h9WoCrqP9xpdV
 HjOcZAnBSZs7897PQGEwDjp54rjYtWVccMLu0jejULbl+YMYsFU9LJClW99NGn6p3Fg1+Mrk
 Ukkw8ShpIbeY2R1oPDjW0QebGeqIZpJpHe01/YZxJvzvcjnH409SG9SBt2yF63uSW9U7bO9a
 k6PCGFu8C7BX+CFQknGtwE+6CiQW5GzayPNfSZfko8kHUjHYhYD0EdODVBY1tY4Dlz4lJanK
 RkkoGlMtxig7UESguNwa0ulCziZ+13uMG9rDsDYdkUe7xketR2MborBtKQqTnseoMHm9lLoS
 CTTZhwUXzFTHBXaWha5ZOjovIKYu+mAWrjudb2XP+jI87cGEa3SjYSm1o8sl9qVHuOIOHQqT
 /gy204YGGt8B9ycgDIXDSoeiyPKacef4ha64Cx+6M6lorztX0r06I2DBqE3U50n8g2qgaqFK
 ++bhTpoYTde2JQWwHbUyb8ZlFcMgiBqfjOpHPwOrynIBK7Xn6ZWCVYcZUYRfINQ6Lkg2wBWJ
 cPBotbyy6I+kfM/TVtIFBTglsyvec0WMjS9OVfAVyPpfPyNITzGxd2yYLvpE+QKyr8O6Fvp5
 HDHQCqBdnyZmjLkVg6iK7RJhSCfZ1lFvZ2lNw1qES7lRc7nbRuyNJl2iyc3yPs6nCCvVyZUP
 D5ifkdKtrDV4zlfh6A1PmVb7Wd+a8SAlTyY6ebwNZsc9/dmSHcR9aoS8DEhxr1Z4TsRDuRyg
 zfXp8VyrkuOl+6S1nx4XRAIpjsB1+fp9Q1yfK7e8JdHQ3PN+hkAuH6RBxo9rNxgEtTzuqpUx
 7Ane4rsJT0E/9+GpKP05uDRL9+bdmUsO1zlFWyMZOPgZSGmPyfTih4F+Mw=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RlU6PaNvzkq7/MBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:JvgXXW/rBbcXdeT0BdaVvxEvGsIvdFff93fdDhG/FGtvFpK0cUDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A7Hb5mwylpf8fTm9Pgqe29QKMJd6aqPS+BWMoia5?=
 =?us-ascii?q?Fgc+VJCpeCxqmgjWzW6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="75314934"
X-MGA-submission: =?us-ascii?q?MDH0ZUmjbko2ClgKUrblYuyxYWZrNlhGCVgIjC?=
 =?us-ascii?q?NlqRnoC99eiAC3svK3//Q2AghD2gCDTLyZ6GELSYc/kHK09gxDbbV4B0?=
 =?us-ascii?q?xSvTnZKSqmE+2T0WFcpkRh1E+ramMtFOEb83s7NxxIWwIGTBgFi1wq2M?=
 =?us-ascii?q?6Wb9K3zZ7inRWzBIsUMM5v+w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 11:18:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499511; x=1704104311; i=markus.elfring@web.de;
	bh=HUXBB4x97jqAAp/XJdLxZnTbCwGahqmDUfoq0o7TY0Y=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=AqR1cWYtd7+eKcVdEjj1jDRU90bU3sIoJYTdsYIuRUHa05DCoczn9hKRkw35Sd9n
	 aV8azjz4esk7zxbfKkfzLsweIPy6Qph8ZtGvVNZhTjtB1r15Dczg9C60qNG1V+51Y
	 POG+U6YcjzhEOVyzx3BebImbfBjg6JfGuBOvdWmZ8j6sfbyEZz477gA1v1DB8dMLe
	 7r5cfIdT4rGRWcrbW2vwYkTeeAUoZaQx79m80HJXbeIkVuNmazK8UakCL0xuyZSb7
	 XOIpdxXRmdBYAQU4VRnVWl+vtbKytqFtpvpDYaAF31y5C0OorWpuZzDgOhRzSHcvg
	 wWuzCg6+vbxJVBSnEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2ggd-1rGt5s2LFf-0040rC; Mon, 25
 Dec 2023 11:18:31 +0100
Message-ID: <4b7b5eed-d00e-43ea-afb6-1f563fb2577c@web.de>
Date: Mon, 25 Dec 2023 11:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
In-Reply-To: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kzWqifzdC9upknspVDEsGqa/iK/LiQ+tcH1RpaEvLdJZMpNhh8m
 Ys3H+MVK7Ztd9cpyz3ZRXbetOfAcRVo9gGT610atXbS+5HOqpzQGP5DnFvMwwD5u6hGRd43
 cJWIpvazYhfCVaSo0wYwQVMyf6y5Vj7iFNG1UxATRmzUMKUKQBIRgr+/uUh3IyJEk54a6fr
 UouIH+E8jv+jvI/c31o3w==
UI-OutboundReport: notjunk:1;M01:P0:5WXMyCpU9ac=;VbG3CJm/62DrSyXNdzthHO8TcpT
 1/uF+efGVkVTZz2xgTh5sY0R6uotfXQmiFkdOgVyajsiF+N+eIpvGq+NM0Oblg5N42D3JPXJw
 G8qveNjhgONtQUfwxRGkj3FoxPFP0IcY/9DKhwTZnVZm6TF5RS6K/rzKLdhJE8gjq2zPiYnUV
 Hsp/D31XyTekbDwyLI2/PpiIfadDn8h78MJeM/6H8fhF0l1ZPEuJjgZ37J9nDPOlIWnIFKOXV
 1jz2dbJgkHOKlpIYC0Yclg5rBAMb2RF+td8Q55B32MP6vaVdmsciELyDPmOPapizkp6My3xeS
 MhaRjvCPIx8UJV6iX1wx7V3VQ6CbSNKHo5HL4WaIUAlMprgkMwKBSsV6QIiW75gqEggWma/xE
 HuSewG2EsF5XXtL4hgefQUp0VZTAlYjZ2SjGKlYfnBMapMVeMXd28mktGq84vXoeXTXTE1hmk
 6zNVaEQFiRjBNP+0/ROnI0RZcukdBO7MGDFNaUXuWFwHFXGcUv2crddDd0XHifljTLhp8mA9p
 vu2pp7tcSHbX11EpkQ9ELuQ26wiApMbj3uwJyWd6vpyjqakbgjnrCM6zS1Umw+6Q0NIVRne9y
 gDJGsC/javSUel4AmlNnnuV+Kdhd25qiluARVGS+zw46nLWEyfrxsFFwalmR/SIayFLv1l5Bi
 bYy02+KYi6oQOCaWLcsbPJpUusCn7jMyvBaxA65kvsqLqxb1wYcMeT/xstXng3HbW36iYWotn
 kkIa8miKrk0X4LfSPnYnTeqqfOQFyHZwlNLj2ba1vyYhju5BpBtrjfeZ4u7C7dcvhJlvJMAJR
 sTdY6TNNnxbMl7gbYnNZnzfH4OC8f14PLMpY7WtkEIUkMqTQOtnlZnn67bjwD1357BNZw0CrN
 71IWRzpxX1Y/jm7kBI9vwbSwH8sFKO6ehNJr2kSvnsILHmFsKAD0z4ODF6SRyaKZp06UA4wo/
 vAVJ9Q==
Subject: [cocci] [PATCH 1/3] dmaengine: timb_dma: Return directly after a
 failed kzalloc() in td_alloc_init_desc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1381
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/4b7b5eed-d00e-43ea-afb6-1f563fb2577c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 10:40:12 +0100

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning.

2. Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with th=
is refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/timb_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 7410025605e0..abcab0b1ad3b 100644
=2D-- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -327,7 +327,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)

 	td_desc =3D kzalloc(sizeof(struct timb_dma_desc), GFP_KERNEL);
 	if (!td_desc)
-		goto out;
+		return NULL;

 	td_desc->desc_list_len =3D td_chan->desc_elems * TIMB_DMA_DESC_SIZE;

@@ -352,7 +352,6 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)
 err:
 	kfree(td_desc->desc_list);
 	kfree(td_desc);
-out:
 	return NULL;

 }
=2D-
2.43.0

