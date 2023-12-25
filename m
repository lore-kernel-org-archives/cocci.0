Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2919EC3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eJzgxGEUok1ldx0JR0QKMd4IctC4HOcqlicPsn0u19w=;
  b=bh9BRjfH2g0t5ohtHEZcd66DSNRveWKIvwL2n8CljBJ1bvdACtj+1/eo
   So0P3TU/nuXXiEBwaUsi9JAlJt02dj0cb31f9pMkXpyuOl03XHSYxMSfL
   HaMR2LjKVA3aKPOkFVOTMIS5tNLu3DDom8FsSlX7DK+lamWjwK450avU1
   U=;
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
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143990318"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:47:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8E976E0CCE; Mon, 25 Dec 2023 18:47:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 19785E0AF1
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:46:59 +0100 (CET)
IronPort-SDR: 6589c013_DDia3hb17wMX1xjecjoXcsq4K8eqx7zQaNGSx1Ds7tjEeNC
 mpWjj61j5REoyqE7GUc1jGBJwFbGnJP9+PJadFw==
X-IPAS-Result: =?us-ascii?q?A0EdCQB1v4ll/wwR49RaHgEBCxIMQINgKAeBSzIEC0iEU?=
 =?us-ascii?q?49BgXUwhDuHNYdMhGuEBIMWPg8BAwENQQECBAEBAwQ4hEcChzYCHgcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcARCBDIEeA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwJHQgYjBBkBAREmAQ8fAQUCJgICSwsGARICA?=
 =?us-ascii?q?QGCfIIrAQMxB68nfzOBAYIKAQEGr1gfLCJWgWAJgRouiBsBhSVCg0F6Jw+BV?=
 =?us-ascii?q?USBFScLgkdvhAqEFIJoiRwHMoIcg0+EXox7fQVBcBsDBwN/DysHBDAiBgkUL?=
 =?us-ascii?q?SMGUAQoIQkTEkCBXoFSCn4/Dw4Rgj4iAj02GUiCWxUMNARGdRAqBBQXgQ5uG?=
 =?us-ascii?q?xIeNxEQFw0DCHQdAhEjPAMFAwQzCh0LIQVWA0IGSQsDAhoFAwMEgTAFDRoCE?=
 =?us-ascii?q?CwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2wfMgk8CwQMGgIbHg0nIwIsQgMJC?=
 =?us-ascii?q?gUQAhYDJBYENhEJCygDLAY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDF?=
 =?us-ascii?q?AcLB1IDGSsdQAIBC209NQYDCxsGPgKmS4EOgnbFATQHgjSBYIFhDJ8rBhMvl?=
 =?us-ascii?q?yYOBpJULoVlgWuQTyCoRjWBRSaBWTMaJIM2TwMZD44gDBYWdAECgnyPCQE9Q?=
 =?us-ascii?q?DU7AgcBCgEBAwkBgVWDcAEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23:1MIPjRyh4YOeok3XCzLyw1BlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hyZv682xwaRB83y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNYAhEniSxba18I
 Rm5sAndqtcaipZ+J6gszRfEvnRHd+NKyG1yIl6dgwjy7dqq8p559CRQtfMh98peXqj/Yq81U
 79WAik4Pm4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WSm+7
 6puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQXNNUttNWyBdB4+xa
 ZYEAegcMuZCt4TzpFUAohSwCgexBO3h1CFFhnH00qIm3OosCh3G3BU6Et4SrHjYstf4OaEPW
 u611qnIyjDDYutR1zjn8ojIcQ0hoeqRVrx/dcrRx1MvFwLDjlWftIfoODSb2f4Xs2iY8upgT
 vijhWEjqwF/uDivx8EsiobSi4Mb1F/L7j91z5srKtChTkNwfNGrHodKuS6AK4t2Xt0tQ3tuu
 CsixLALupq2cTQOxZopxxDSb/6KfoqU7xzsSeucIit0inx7db++iRi/81atx+PyW8Wp1FtEo
 CRIn9jSu30OyRHe9M6KQeZ+8Ee5wTuDyR3f5v9eLUwqi6bWKYQtzqMym5YJrEjPADf6lUH5g
 aOMeEgo5/Kk5ufnb7n8opKRN4l5gRzgP6Qqh8y/Gvg4PRYUX2aG+OS91aPs8FXlTLhMk/Y4i
 LPWsIrAKsQevqO5AxFa0oIk6xunCjem18kYnWUdIFNLZh2IlJLlNEzQL/zgDPe/hUqjkCtzy
 vzYI7HtHI/BImbdnLrjZ7px9kxRxBAuwdxB/55UD6sOIPP3Wk//rtzYCRo5PhSzzen9EtV91
 Z4eWXmVDqGWNKPSv0WI5uMpI+mDf4IUtijyJOM/6/Hzk3A1gVkdcrKx0psNdH+4BuhmI1meY
 Xf0n9sNCX0KsRYmTOz2lF2CViZeaGq1X60g+j47CZmrDZzDR4ComLyOxj23HpxQZmBcC1CDC
 23kd4ueW6REVCXHJs5njyxBWLSoQKc/2hy08gz30bxqKqzT4CJc/ZHuzt5446jRnBcz6TtuF
 OyD3GyXCWJ5hGUFQ3kxxq876WZ60FaY1aFmy8RVCd9U+bsdWB8SPJrdwuoqTdz/DEaJXN6MR
 U3uZ9K8Gjx5GtA4xtIVJUN6Ac6vphnZ2myhBLpD0/SuDYEu9er31mLvLsJ9zD7t1KQhhlNuF
 s5ENWCmj6RX9AXJAYPN1UKDmPDuPZ4b1iPX6C+5zGGOoExCGFpqS6TOdXMSfE3bqZL+/EyUC
 /eSDrI2ei9cws3KfrdNbMyviUhNR9/iPsjTZyS6nGLmQV65z6GBasLFe2wb2izYQBwVmhIe+
 zCJNQE4AC6ki2vbAHplEle5MG329uwrjXqhTVIvhyyOYVdg0bX9rjscn/+BULU+2rweuSEug
 yp5FhCx0oSFWJK7uwN9cfAEMpsG61Bd2Dec7lQlVnTBB6Vrh1pENh9yo1urzRJ8TINJjcktq
 nouigt0M6ORll1bJHuDxZ6lHLrRJyHp+Qy3LbbM0wT72cyV57xJxfA2sVTlsym2G0Bk/3g0m
 8JN3S6k747RRBEXTYq3V0828xZgoLSPRyAn5J7Pk1BoP7O1tDDqxN8jQucomV67Z9kKFqSCG
 UfpFtECQcijLOt/g1+ychcNJ/xf7oYxON66MeSL0uinMY6MhRqAimJKqMB420OIrW9nT/LQm
 owCyLee1xeGUDH1iBGgtNr2kMZKf2NaGG330iXiCINLA886NY8WFWejJdG2zdRiltbsXXBf7
 luqG1IB3oegZxOTa1X32QAY214QpDSrni6xzjo8lD9MzOLX+SXUwPn5MjcDNHRKQmZKklrmZ
 4S5zpgbUEWucwk1hU69/0+pj6Nfpal5MyzSWRISJnKwdTs9FPLv8OPYMKstoNsyvC5aUfqxe
 wWfQ7/5+V4B1j/7WnFZz3Y9fi2rvZPwm1p7jnicJTB9tim8G4k4yBHB6djbXfMU0CABQXwyr
 DDNBUWnefSt88+VkZjrre20EW6sHM42E2Gj3cabuS236Hc/Szi2hfOugZvKFQYg0Cn0/8ZnX
 2PEoVyvB+ujn7T/OuVhcE5yAVb64McvAYBynLw7g5QI0GQbjJGYlZYeuV/6Ks4Tmaf3bX5XA
 CUO38aQ+g/unktqMnOOwYv9EHSb2MpoIdegMCsa3Sc07sYCD6nxjvQMuCJvoUej6y/Vb+J8m
 Dg11vYkrnIXy+0EowsiyCyBD6taRxACe3a2yFLRsJbn9u1efy63fKK11VZikNzEbvnKuQxaV
 HvjO98jESJ28sRjIQfJ2Xz35JvjfYqYZtYSuxuI1hbY2rIMctRrzKVM3HUhYDiu2B9tg/Q2h
 hFvw5yg6Y2OKmE3ubm8HgYdLDr+IcUa5jDqi69a2MeQxYGmWJt7SVBpFNPlS+ylFDUKuLHpL
 QGLRXcZo22YBKGZMAuR8kZgoFrQHprtO3zddxx7hZ1yAQKQIkBSmlVeeTwgnYMiUC2uytbgd
 khR+T0boFL14EgpqKogJ1z0VWHRox2tYzE/Rc2ELRZY2QpF4l/cLc2U6u8gVzEd5JCqqxaBb
 3CKfwkdR39cQVSKXhqwW9vmrcmF6eWTAfCyaufDcanb4/ILTO+GnNquytc0pW/WcJ/VYT87V
 aN9gxATGiokfqaR0zQXF35NzniLNZTE4k7hvHUw9J338ey3Cli2v83VUeQUaIopo1fs3u+CL
 7LC3n8mb2kCkMpdnzmSlOhYhg936WkmdiHxQ+Ra83eTEeSJx/4RV1lBNWtyLJcatftjmFYXf
 5SD1ZWtkeQnxv8tVwUfDAOnxZvvPJ1QZT/hcwmZYSTDfLWeeW+bmYeuP/76E+cByrwP71Wxo
 WrJQxWlZ2re0WOyD1b1a6lahSWfdnSyoambdRBgQSjmRdPiMFigNcNvyCcxyvsyj2/LMmgVN
 X59dVlMp/ue93EQhPI3AGFH4nd/SIvM0y+E8+nVLIoXuvp3E2x1kexd+nEz17pS6mlNWvV0n
 CLYqtMmrUuhl6GDzT9uURwGrTgu5srDpUJ5JaDQ7YVNQ17B+w8Rq3qdAVIGqpotC9HivbxR1
 smalK/3L2QnkZqc9s8dCs7IbcOfZSB4a1yzQmGSVVRDFGT4UAOXz1ZQm/yT6HCP+50zq5y23
 YELVqceTls+UPUTFkViGtUGZpZxRDIt17CB36tqrTKzqgfcQMJCs9XJTPWXVL/KISyakKICS
 h8G27L+IqwMO4e910EoOTwY1MzaXlHdW9xAuHgrdggvvEBE62RzVEU23F/5LByg6jkfGLTn+
 3x+whs7auMr+jD25l4xLVefvyo8nn46ntD9iCyQejr8RE9RdYRRFjayqEU7dJ/2EV4dheiag
 kFucjvJFeo5Z1RIam1hzgPR68InJA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uFdFo6j1tyqbg/3byN2dTM/P9XBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:cFJ7cW6P6z9K4q3M5tsszUsUA+FmbX/myWraB377AGh7a7qNRgrF
X-Talos-MUID: 9a23:RIedkAu+cpxq9IHHv82nqhFBCcY2xKqUS3sGoMsfv9WCagB0AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143990313"
X-MGA-submission: =?us-ascii?q?MDHwW/dBdpKL7P3aEuuI3UpTmGUnC5eWayi7Sg?=
 =?us-ascii?q?xl5GcSWRe+BnEEBOGx64OYMNzlhWiRnZeZ78pBN9+4VKEJnb1ccUezrZ?=
 =?us-ascii?q?JD5ngppT232qZ+TcZwm0pbWsMgt3/siAWIWY09Nx8i+wNy+yzi6eYgRp?=
 =?us-ascii?q?QfhbwaLQRPqz4gNAswin2q1Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:46:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526384; x=1704131184; i=markus.elfring@web.de;
	bh=yZfNVyN4f4vfAqTUZd3nhSOWUqIAg4Bk9xRcEkmGZ5M=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=GiO7qeHCXutEbfDxFIdz4So3jEDLAuTIEVpxo6C6Hd7t9H3wD2azDaACSutB62aQ
	 YwqXdfHwqdzHRLMyn0Z2L1I+524QFb6MXZCjg7gR+CrtHia7VmbV6QlGEIxmjPM1w
	 3JJAj9p+eRGZ/kCBzT/Ma9GcDjJqa2X9FDKu/VdvBRaqolrAh32WOTUNASbU+mnLn
	 4L6GnoftHVl4140LMk7mGlMRx5csm6qinrSpYKkEEkoXZKr2ewbbu5yqZZqtqWYHl
	 GLBShQsPoandcv0O205o3ggQYErKlhypAoOb/Fl8vumw0Ra5luK1E4floSkx+i/B9
	 98H/MVwTv4CnuD3jyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1rgJlD0Q8J-00TZ2O; Mon, 25
 Dec 2023 18:46:24 +0100
Message-ID: <15936ac5-5380-42fa-b13a-e6b2ccf92490@web.de>
Date: Mon, 25 Dec 2023 18:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:66u+l/NmUncqbzV4DyhYiHKTFwdL8r80fp0lKBBqJ4Se1lKH36E
 GRmsALRYZzIW/mZQat/0+0+7qD1JqwkFqKB1IjRWouz9CCsUT3Q1Xn7MOSCIkdWAg0LlRPY
 fsTP51u3VQUz6c4p72SnFchlNUCxKVUE8v9BRvw3ZqJem/eJCNJIHoqdnUGko/13jb6Fh+Z
 mZXcmp6jjjDEZmDhtHGSA==
UI-OutboundReport: notjunk:1;M01:P0:vZ18hv2qYMk=;dqmj3WTTTp6yGfjGEUHWNrWEOJU
 yt2QYNCgE0N5ixA/hQm26un+3Uzx029yhuNPS8eyYQw44Mb9/856Jvi328c4KjUHx5dyB31jR
 bmQ2FLL2iH/meS+Rh/adpIgGW/wu6NKPnCL1n9eLMFoMKLUiXz99Puwjz+1dL1O+HhzLz09RI
 A1KVzV80mW2YKtageXbFY1VuXlFlRTwBFlMVv9mfCYleqvgeZtSeicfXqAjxLWBC52umcmN6A
 VbfKqgIdcyB0RvK3WcxnhKqiSppA9Rj9NQHlNLOWFEfhgv7BYXr+yJsb33sEskYCjVOBQS3D8
 qOhCwOPRytdLEhbUcUKuE8lcCyrxrZh2Sd4onQBKsy14OIm5VEOqrmTDaGtuGL0v88whKKnZd
 cG5JQ+K1EVxYAxb/veAHWtOso9f8rcFMKdy7KVMcdI52hawN77L/rsBzhPcm2fkhnUl3WOadn
 oyEbKEYKCi0pKtThDZgALTSqvpXYbW5YlpPsr8xG8pIJUmW6hvVnjhDU10WW6kOfRg/BsLvcq
 9E/Mx9nbddgtpIySrnAlnZRBqJwx3Ifb9mNWZh3k74FGuyijm1pN44+kUspkS4aXRNfOZOVoL
 VdhYNpARcU7Bjwa8UuvZ8T2eG+rGoHQ4a/tr0JOLGYuFWqgD6/8PUXT0ZphRPRxu3oznk93/4
 dU89SApnK96KCVuqQyZxNc72NhFenzVvgyuHzktkaSUWEJoQuv1ianExWedXUF6deXzfPOBc8
 N/e7UX5+zQPnQ3lSs8t69XhGz7JuWprKS7yKoI6D4JI3NceCYFiQPmSuPfLVbNn1gmxnmODz8
 9/cHwOAKOz4buRNFxA7tQDa6NeDtKW+PuZHDGW5oHAPrn+ED9yrxpP+j/qe0UVwXjRGaCclnj
 j9s0TbFd4HatEHu3M2S5HVO+aJ3f4aVFFuaXI7lGhF7GL7TnHuUqnlMudtL//4VMqTBzw4xhY
 J/d6AQ==
Subject: [cocci] [PATCH 7/7] EDAC/amd64: Move an assignment for the variable
 =?UTF-8?Q?=E2=80=9CF3=E2=80=9D?= in probe_one_instance()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1391
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/15936ac5-5380-42fa-b13a-e6b2ccf92490%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:54:33 +0100

Move one assignment for a local variable so that its setting will only
be performed immediately before this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 698cde573847..91e0abdf762f 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4263,7 +4263,7 @@ static bool instance_has_memory(struct amd64_pvt *pv=
t)

 static int probe_one_instance(unsigned int nid)
 {
-	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
+	struct pci_dev *F3;
 	struct amd64_pvt *pvt;
 	struct ecc_settings *s;
 	int ret;
@@ -4281,6 +4281,7 @@ static int probe_one_instance(unsigned int nid)
 	}

 	pvt->mc_node_id	=3D nid;
+	F3 =3D node_to_amd_nb(nid)->misc;
 	pvt->F3 =3D F3;

 	ret =3D per_family_init(pvt);
=2D-
2.43.0

