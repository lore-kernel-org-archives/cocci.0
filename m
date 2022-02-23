Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30621C433EF
	for <cocci@archiver.kernel.org>; Wed, 23 Feb 2022 08:13:51 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,390,1635199200"; 
   d="scan'208";a="22777063"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2022 09:13:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0726EE0356; Wed, 23 Feb 2022 09:13:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C08A8E00A8
	for <cocci@sympa.inria.fr>; Wed, 23 Feb 2022 03:19:34 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=morgangreen@hotmail.com; spf=Pass smtp.mailfrom=morgangreen@hotmail.com; spf=Pass smtp.helo=postmaster@NAM11-BN8-obe.outbound.protection.outlook.com
IronPort-SDR: 0gURVCmbbHAjtuZaF8Dhgs3bOcF5RKXHtHBEwTSe8/Zr5+E0lFQqYQ0qvKT7eoCgLPI9jy84DA
 RA7ccfD3ZRWhx5J9k0MUvJxP2zfZi+XE5h1h83r86pjBfETaDkgBkMZKwST7hcvcUzny8+9qlH
 ugLB7NAiEuIW8n0WA2ZdhGltoFvb2rWDZVn5I4X3/mFw4d+n07/8SR7MqRdAJ9theySXW9Kohq
 vjM1s7aqtePxAfuvINT+7hdUsL07JIxxrHVuDCJTQescPeai2q/At2ImkhAysqkrPrZIBfE2hC
 ueC+lZe8SFF5xtgX5D1tXt5Q
X-IPAS-Result: =?us-ascii?q?A0DtAgCFmBVihw0UXChagQmCDYEfKC6BVicDBwhCiB4Dh?=
 =?us-ascii?q?TmIEYMEiCKBBJIvCwEDAQwBQQQBAYUHAoQKHwYBBEcBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIDBAETAQEBDA0JBQgKBw4QBWZlXQGBTgGBMCgGAzEBD?=
 =?us-ascii?q?II1IoQELgEBOBEBPUMnBBsagmKCZQEDLwKgHgGBOgICixWBFwUBFoEBgggBA?=
 =?us-ascii?q?QaERwEjKANxgVsJi2yEVoFJRIFYgWaGBoNNgi6UNRkIgQ1MgQB/HqFbnmpeg?=
 =?us-ascii?q?nMPAYEvC543FZlYjj2WTiCmKgIEAgQFAg4BAQY1gUSBfTMaI4M5TgECAQEBD?=
 =?us-ascii?q?QECAQEDAQIBAQEJAQEBAY4pDQmDUIpeQjM4AgYLAQEDCZNMAQE?=
IronPort-PHdr: A9a23:TPHpUBNouocaWI6ydxol6nbxBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv68r3A6CAd6TwskHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yf6+94fQbghMizawbr1/J
 wiqoAvMscUbnZFsIbsrxBvTpXtIdeVWxWd2Kl+Wgh3x+MS+8oN9/ipJo/4u+NJOXqv8f6QjU
 LxXFy8mPHwv5M3qrhbMUw2C7WYBX2oMkxpIBw/F7AzmXpr0ryD3uPZx1DWcMMbrS70/RDas4
 LpxSBLwiCkJKSM38H3ZhMJzkK1Vrx2uqgdjw47NfI2ZKOZycr/Acd4cWGFPXtxRVytEAo6ka
 IUPCPABPelCoIn7ulAArAG+CheyC+Pp1zRFgXr23aog0+QuCw7G2gMgH8gQv3vKqtX4L6cSU
 eepzKnN1zrDbvdW1S3h54jPdxAsuPeBVq9/fsTN00cgDR/FjkmOpoz/OTOYzusDvWiU4edvS
 O6ij3IqpgNsrzWxxMoglofHipwLx13A+yt03ps5KMC4RkN5b9OqHpReuS+VOYZoQ84uX2Jlt
 Dg8x7YbupC7ZDAHxZs7yxLFb/GLbZKE7gz/WOqLPDt1imppdKy+ihqu/0Wtz/DwWtWv31tLq
 ydIkdzBu3IO2hHW78WLV/lw80G80jiVzQ/T8PtLIUUsmKrbNZEhxrkwm4ILv0nfGSH6hVj6g
 LaLe0s8+eWk8uPnba74qZOGMI90lx3+Pb8pmsyiB+Q3LxICX3CB+eS7yL3s41H2QKlLjv0xl
 KnVqpfaJdkHpq69BA9V1YUj5wyjADeh1dQUhXgHLFRbdxKbl4XkNE3CLOr8APuhmVigjitny
 +rbMrDvGpnNK2LMkLblfbZz8U5czw8zwMha55JTELEBL+j8Wkn+tNzCEBA2LQq0zv3nCNV6y
 oMeXHiAAq6dMK/IrVCI4ecvL/GKZIAOoDn9MeQq5+byjX8lnl8QZbSl0YMNaH+kBvRmP1mZY
 X30j9gdFmcFohYxTO3xhV2ZUT9TYm6yULgm6jE6DoKmF4bDSZq3jLyPxifoVqFRMypNDVuHE
 F/pcZ+FUrECcmjadsRmmTcFfbmnUY4okx+04lzU0b1ie8/T4CIRs9rMztV44aWHkBYo+jVyA
 N6Q3melT2Zom2oJQ3k926Up8h818UuKzaUt268QLtdU/f4cCm/SVLbZxu1+UJXpXx7ZO8yOU
 BCgS8mnBjc4SpQwxcUPagBzAYbqlQjNigytBbJdjLmXHNos6KuJ2n/rKM97xGzL2a8Jj146R
 8JOMSutgassvxPLCdvxml6C372vabxa2SfM8GmZym/buUZCXwd2Xr/IUHY3ZkzKqN344gXJS
 Lr9Qa8/PF55wNWZYrBPdsWvjVhCQ6L7P8/CZmuqh2qqLTCh4+rVKaDMKyAa1iibD1UYmQcO+
 3rALRI5Giqqv2PZCnppCE7rZETvt+J5rRtXV2cSyAeHJw1k3ruxoVsOgOCEDugUxvQCsTsgr
 DN9GBC82cjXApyOvVgpeqIUet477FpdsACR/wVgIpytKbxjjV8CYkx2uU3pzRB+FoRHl4Ajs
 noryAN4La/Q3klGcnuU2pX5O7ufLWeXnljnbqnM1VjY38yb96En6PMkrlziuEeiEU9ju3Rr3
 t9J0meNs43QBVlaWpbwX0Arshli8u2CJHhnodmMkyQ3YszW+nfY1tkkBfUo0EOldtZba+afE
 RPqVtYdH46oIfArnF6galQFOvpT/eg6JZDDFbPO1ai1MeJnhD/jg35A5dU310WW+CN6RfTF0
 pAtw/aE2wKGU3H3i1Lr4aWV0chUICofGGay032uAYlLaaR0cpwGBGGGI8qrw9x/g9jmXHsSp
 zvBTxsWncSufxSVdVn02wZdgF8WrXKQkiy91zVokjsto8JzxQT2yv/5PFoCM29PHyx5iEv0Z
 JOzl5YcVVSpaA4gkF2k41z7zu5VvvY3I27WSEZONy/4SgMqGq63rLWLZcFV5Z4umSVQTOG1Y
 FTcQbn46xcXyCLsGWJCyStzK2ns68+/xUQ80TnVJW07tHfDfMBs2RrTgb6UDeVc2DYLXmgwi
 DXaAES9I8j8+NyVk5nZteXtH2mlV5BVbWzq1dbc7G3qvyswWVvmxKPW+JWvCwUx3C7l2sM/U
 CzJqE25eYz3z+GhNvoheEB0BVj64s48G4dkk4J2iotDvBpSzpiT43cDln/+dNtB3qerJn8KX
 zECxdHP7QXj8E1kMneAxoa/XXKYiJgEBZHyciYN1yQx4tofQqKT9rNNmyRvr1e+hQLWff10n
 zNbwvwroi1/4alBqE8mySOTBaoXFE9TMHn3lhiG2Nu5qb1eeGeldbXjnFo7h92qC6uO5x1NQ
 HusMIl3Bjd+t48sVTCEmG228Izvf8PcKM4epgHB2QmVlPBbcdowjqZY2XIhaDi75Tt9jLdmx
 R12gcPm5M7eczorpOThRUcGU1+9L8ILpmOw1+AHxp7Qh8b3Wcw9UjQTAMmxFa7uTG1U7bK/c
 F/RWDwk9CXBEOKGT1bGsRVo8yqXQcLsayHyRjFRzM08FkOUfBUN2VlNDjtmxsVrREf2lITgd
 kx9+zwctEXgpBcK0vhvKxT0TmbYokGvdyswT5+cahFR62Qgrw+QOMiapIqfBglg94a65EyII
 22fPEFTCH0RH1eDHxblN6Wv4t/J966ZAPC/Jr3Ae+fGpetbXvaOjZWht+kuty6LLdmKN2J+A
 ucT/GNmBCk8MeKJ3jIFRmoQij7HaNOdqFGk4Cpro8uj8fPtHgXy+Y+IDLgUOtJqnnL+yauOL
 O+fgi9lJC0QistKlCWOkuBZhQVagjombzS3FLUcqSPBBLndnKNaFV9Tai9+MtdJ87Np3gRJP
 p2+6Ju93bp5g/gpTlZdAAC53JDzI5ZSZTjmZzalTA6ROb+LJCPG2ZTyaKK4EvhLiflM8ga3o
 XCdGlPiOTKKk3/oUQquOKdClnL+XlQWtYejfxJqEWWmQsjhb0jxNdhtgjQwzqc5i3XiNWkAN
 DF9dwVGqbjavkY6yr1vXndM6HZoN7zOgyGC8+zRMYobq9NNKwEtzqdwxiR/zLFYqiZZWPZyh
 S3e6MZ0pE2rmfWOzTwhVwdSrjFMh8SAukAoasC7vtFQHH3D+hwK92CZDR8H8sBkBtPYsKdV0
 tHTlaj3JWQK45fO8MAbHcSRNNOfPS9rL0/yADCNRlhgL3bjJSTFikdaiv3X6nCFss1wtM33g
 JRXAr5DCA5pTrVLUAI9WoRFeco/Xyt4w+LDypdQujzm6kGWHZs/3NiPV+rOU6i1bm/B1f8cI
 UNPmO+wLJxPZNSjhwo+NR8i2tyNQhWYXMgT8HdoNlZm+RwUonYiFjVhiQW5OmbPqDcSDaDmx
 Bdu01knOL1/+mu0uAVlYQaa7Co2m00sldi3miiffHjpNqCsUIpKCi3y8U8sLpf8RAUzZgq3+
 C4sfHLNQ7Yb51OFXWBslArVuJ8JEvlZH/UsiPA4xfaLYvwp1RJXrSD1nCevBMPjIL47zU4AV
 87pqHhNnQV+cNQyOKrcYrJTyURdjb6PuSnu0f0txAgZJAAG92bAIUY1
IronPort-Data: A9a23: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
 YiwjeM=
IronPort-HdrOrdr: A9a23:DEJAfKtD1IUvgJL4PaX2fNGE7skCUYMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6HnBEDyewKkyXcT2/hlAV7CZniVhILMFu1fBOTZslnd8kHFl9K1tp
 0QB5SWaueAamSS5PySiGbXLz9K+qjlzEncv5a6854bd3AJV0gP1WdEIzfeNnczaBhNBJI/Gp
 bZzNFAvSCcdXMeadn+LmUZXsDYzue74q7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFqQrk/a+u2svLgyM0llWjpKi/1bPau5N+7f63+4UowwbX+0qVjbFaKve/VGhcmpDh1L9lqq
 iDn/5qBbUK15qYRBDPnfKq4XiW7N8C0Q6d9bajuwqTneXpADYhT8ZRj4NQdRXUr0ImodFnya
 pOm2aUrYBeAx/MlDn0o4GgbWAYqmOk5X451eIDhX1WVoUTLLdXsIwE5UtQVJMNBjjz5owrGP
 RnSMvc+PFVe1WHaG2xhBge/DWBZAVOIv7deDl+hiW86UkooJhYp3FovvAiog==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,389,1635199200"; 
   d="scan'208";a="6705234"
X-MGA-submission: =?us-ascii?q?MDElP2v7MRUrX3ysR0RxxOC544VoBjGswkwHot?=
 =?us-ascii?q?KZF9+Nrid+jVnSyFRg70pUAAqAxXKCy1D8VxycBd+UjQzwA5wYMJjBVx?=
 =?us-ascii?q?8Id89LyzZgjQlLJCLOo7Yx3pAjn7g6+cLh0SNm4Y1tTgl3266x7MfxHJ?=
 =?us-ascii?q?rRxOpwK2880Fpf8/fpiks6Eg=3D=3D?=
Received: from mail-bn8nam11olkn2013.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.92.20.13])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:19:33 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gleihMhkSGCxLcAk16s0316UcGsLOPBf3UNkkkrtOlCATD96Pm+ZnB18yJbh+dlGj1FajpMpZugYOTvV+OX7ITFsta9nvi2N9tdldYO0gf15mWn4ZWckxp1PARce/AmUMOElZAt4JNkNlaKZUGSucET4icmioyg18ILqCZacpRSqy2JzH/349AXWT3Tv4tquGxb2+PVP/+ysk/AOsaa/wovPnsFzeHxBzS2H0bHRLH29zJ4pYs/vbDfMheVi8NVnIpgYh2V/bbWEEgwu/O0VPRdOwrhy7738ILa79FbDXDzQvNM5xzDdCAtrk0tY/+96Zl1gznM8c7nl1k3wnWIwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mE24WbRjcqzQ04Eex8sy8vUxVho/LPl2wnTdJsW6fy4=;
 b=eAZIdza1PbWuXJJvMZ0g9UV6OnVs4t89eY2MdXEMyFPKm9Lw6wAD0N2uexp52oEPpZjQeHFKZNLyJMkhnA/wjLmK3SAlU91BugZydnFSdDri4ZJqsiqXMJaXAhohPVOfdxUsvEyagJSXDfbpEJfzjKNnQypbkedsCXUYvQxhfQ2DRgVAL//8SVere9VsC1wJxpFz8QmZ8r39kNu/s0D5XYAOjfiYMe81f3ufQ60Pu8N7nLoaPjYchTn5kNZt7LIOl2S05wbvOkXvt/DEd/n/UqLoldHnCeIS65sUlo6ppU8pQYgDfMDRjy1I4JYIyhFqZBGJv4YtbxkLd1kfrC50SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE24WbRjcqzQ04Eex8sy8vUxVho/LPl2wnTdJsW6fy4=;
 b=aiN+K40+5nI57X0+ac514nrSu2v9zXMpZ5IKtoYY0iYvutS+95D38GsFICRL1blt8F5yT7kPgBRApzvpj1vbDqrZQugXzRBug8W+L9ziyfKrY6+/JXyjBes6CKYv3vmFzmPiza4Orwu1K96YNMPXSQT/1DD+8o43tmhoD8Ktz/vh2Txqo5gqk3EGVT4dxynxtY4s3/A3EN8Vedg8Gl899dfOlw4Nv7OoFsk3mJaRziOAf66rHweoSJQOQIYpPqxOWETkGwCN0P/EnScmINPELxBo95eBmUyZaA1EUp0wm1n8qdVNoLzPEeSvpuTR1cV822phpkyZaBkuaud5Y4OHJg==
Received: from DS7PR19MB5853.namprd19.prod.outlook.com (2603:10b6:8:78::17) by
 DM6PR19MB2842.namprd19.prod.outlook.com (2603:10b6:5:13e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 23 Feb 2022 02:19:30 +0000
Received: from DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54]) by DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:19:30 +0000
From: Morgan Green <morgangreen@hotmail.com>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: C++ support
Thread-Index: AQHYKFYOveewPXZwTU2EZGh8A4keNw==
Date: Wed, 23 Feb 2022 02:19:30 +0000
Message-ID:
 <DS7PR19MB5853948767791AEA2E6E290FAC3C9@DS7PR19MB5853.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [vFCXHGDLbU+IbG6Z5TwWVOWXnK3Nnh3g]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d66c54d-5f66-4672-7e86-08d9f672ecc2
x-ms-traffictypediagnostic: DM6PR19MB2842:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MTzGN7oUz2FkfcqBwIMb+eXcktks1Vc15oR8LXtV47A1Lsuo5OrnoGhlE5tkoMPetZNaQU02fwp1nrVWUtwPNVTdQI6Tji4dsyDgo6RUb/IZU2ofMYMEjL2kti3OEqNSRHFCQhJWaSH2+0spJXbJfavWWshiROn+g9OOySxOz8a+8f1SPp0ipAS2SpzcQQ6S0rfm5sa/5jl+ytX7klRPQsrpzzISvhJxHdVrzViJa/ijsYv1G2ccqTGyPV978FLE2WNl9oLCEepEp456HgrMKwchSO1gVOIebnkWI3W9g62qr96sdizAl0GqUHiCx/nOm6uFAjAqhIteeHOfORJFZTEGt6TrRYaHdFLEQX89p6Th9PFqgK/ktX1dSOjI975V/C3fYzXcGAwt0FbSxhDK11CcH9HDGvTvUehMPPwGqhgA5YjHi5rUDcqa2Xn3cZmxw2O0K8/rjhFaxmbPhJiKOouYIh02+FcdOBY4O9f1iyEHZs/NxooRA3n2RdZus7jNooLJ6QPfLXySfIKyPkwWt0Rt6+Mafv7r5zEIx9GP64T4pPCGTDulIhTg0FyVrh6mReN97j76vtikMDvavLrsyA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 ZY3WH6Nq1YrQf24ztq+0XOhvgxgLfGfyMaE6tl0zROjLbIUY+oSnOiFiKJW+czYS7u6c0pAjNdiCmyi7vTPxl3hQkZ8r7ozWk7LLz0SKzarluz/Z+Nsaz8ut42eo2V3JhKKZ+m0S9V5rxi2NaGw4HXrRfA2e7mXPCellp3yiQPgLNpWkhaOYUxugfTNEkYo36EHvgVfrbv0ElfHBQwLG1Xd74xA5x/ua1IWmSeBzy9K/eaNs/qEz1AaoqXd9SrFua8tdiYE92N1ZGNUWYOuJvkBDsIPosxtVv+YVo++t5mvblNv21TUj7+PLih/EK5XpGKTmSW+UZW1/sVfZr8FFu1/iVACsap5knzAKPODFZ+rNWpx2WMcwm1uh4ZFlNJkdEfBEMwwW6V4yAGrtzjFNthnOF3bYEp/pw5n8mJFrEgNkq2g5Ab4o4fIVt8iyT9WalgNMpr7e/F5qDsNN5StMKMzt43cVUSpr+B2vqMpVlsvK+RByJPuiQLyE25MhaHqkwcGYj33rbL8UHQ5OIUriVCfk0F9EQUn2te//pGYrzn0Kp12tf+9nY1otKX34UwkSo7n11Mj/ckAFqoz3bJQXSzQA/ViA9sjP+kiGH0lLNXMLdAka5Wsq8voFWsYmtPJV1I7B3M1QyluTxxauVFWA6ay/pLW3dy/vrjQ0iqKNPNwIlh9lgODVwlW9vRfRxfOpkfHLHeeh9LRU605KEiANpuQJ9w+/JhfX2/uoDtRLOKKcRERnktsR7szyjH2t92RHBjqffyghqKkvV6u1LGty20Z0lpRsvWig3XjSk+zVNINDita+NbPshX7ASnAYGR4amJgBx6IqCfNX94CYowNDJHLd02dR1hjXTmeqtMEw4WU8REWR25udEkWjo+na1AP2EcR5GFUH3z7W/g50JFboM1mhGE9flWcvHD+XB/Mb4lyHDTy9aplwIKN5iHIxfuub
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5853.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d66c54d-5f66-4672-7e86-08d9f672ecc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:19:30.7729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2842
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] C++ support
Reply-To: Morgan Green <morgangreen@hotmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 145
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/DS7PR19MB5853948767791AEA2E6E290FAC3C9%40DS7PR19MB5853.namprd19.prod.outlook.com>

Thank you=A0for the incredible tool!=0A=
=0A=
I'm attempting to use it to clean up a large C++ code base. I'm aware that =
Coccinelle has minimal C++ support, but decided to try it anyway. The code =
I'm working with sticks to the basic C++ features so I thought it might be =
sufficient. It mostly works when I pass --c++ to spatch, but there are a fe=
w basic C++ things that cause parse errors:=0A=
=0A=
1) constructor definitions with initializer lists=0A=
2) class definitions=0A=
=0A=
Class definitions failing to parse prevents functions that are defined insi=
de a class definition from being parsed and it also prevents functions that=
 contain an embedded class definition from being parsed.=0A=
=0A=
Here is a minimal C++ source file that demonstrates all the problematic cas=
es:=0A=
=0A=
----=0A=
class foo {=0A=
    foo(int val);=0A=
    void do_nothing() {}=0A=
    int val;=0A=
};=0A=
=0A=
foo::foo(int val) : val(val) {}=0A=
=0A=
void bar() {=0A=
    class bar_internal_class {=0A=
    } local;=0A=
}=0A=
----=0A=
=0A=
Is there any chance support for that C++ syntax could be added? In my case =
support for parsing constructors with initializer lists would be a big impr=
ovement. I don't actually need to be able to do any transformations on init=
ializer lists, but it would be great if my rules could be applied to the bo=
dies of constructors with initializer lists.=0A=
=0A=
I'm also hitting an unrelated issue where spatch appears to be getting stuc=
k in an infinite loop. I've let it run for an hour so far. That seems to be=
 triggered by the following rule:=0A=
=0A=
----=0A=
@@ @@=0A=
{=0A=
...=0A=
- if(1) {=0A=
+ {=0A=
...=0A=
return ...;=0A=
}=0A=
- ...=0A=
}=0A=
----=0A=
=0A=
Unfortunately I have not been able to reproduce that with a stripped down t=
est case. So far I've only seen it happen when running spatch (version 1.1.=
1) on one specific ~3000 line source file. With a stripped down test case t=
hat rule successfully removes the if(1) check and everything after the body=
 of the if in the containing block. Am I doing something wrong or hitting a=
 bug?=0A=
=0A=
Thanks,=0A=
Morgan=
