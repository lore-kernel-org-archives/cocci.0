Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F47BCCA468
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X1gPDL7CSLnNAYvUobR3JSGrIqM7fsJWSB+SVv0kmOY=;
  b=dnW8CuHMoqxNQ1b/yH8t4NCBeKzUxq3EHJa89MW+40o9lixKiHT2+UGO
   3JuIlt7dHRzut1pZnNseEqH8CMQQ3zI6h+iWjEQFMsYqwZ0hO7UVDRtp5
   BwNlymgKQZsMO0mKgi7IJempxTg/F3bWpOPRD/iYcmQhukB5fg8e21tE/
   I=;
X-CSE-ConnectionGUID: 9gh5zRktRs6oiu6uBSDt4w==
X-CSE-MsgGUID: pmFb5IK0Qeet1QE8BUJnfw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@Nvidia.com
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241375768"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 15:36:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 88CC8E0171; Sun, 28 Sep 2025 15:36:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 381BFE0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 15:18:08 +0200 (CEST)
X-CSE-ConnectionGUID: xMbrh0CGTrmBsOVHIB0+7Q==
X-CSE-MsgGUID: RMCSNywERMOcuJCUf+xNVw==
IronPort-SDR: 68d9358f_CfLDhtCp3V7AO6EfUevDlIn7EakYumg/TMdoknxsrQWAgBC
 IiK92JJ+pCOwBEIlmtanykDS92VzvZrk/spDbUg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAAAdNNlojzHRayhaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYFtUkABgRwyBFSEVYNNAQGETV+IeYQ7mV+BQD8PAQMBCwJRBAEBA?=
 =?us-ascii?q?wSFAAKMRx8HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAQEBATkFDjuGFQY0DYJiAYEkXkgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQERAg1eAQEdAQEBAQIBEhEECwENAQE3AQ8LGAICJgICMSUGFQEBHoJgg?=
 =?us-ascii?q?iUEJCYEAqd1AYFAAooren8zgQGCDAEBBgQE3B2BZAkJAYERLgGFa4JkAYVsh?=
 =?us-ascii?q?HdCgg2BPIMDPogegmmCJkRSgVWCOYIohD+FPIQwigNSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDA4EPI0sFLR2BJ3eEFINZRStPghxygXRXQYNTEQ0Gaw8GgRUZSQICAgUCQ?=
 =?us-ascii?q?z6BawYcBh8SAgMBAgI6Vw2BeAICBIIvgRKCGkACAQttPTcJCxsGPZgzgzaBF?=
 =?us-ascii?q?QGCPgwvlkABjwuLfZUXhCaBZJ94Bg8EL6prLphYo3CFJgIEAgQFAhABAQaBa?=
 =?us-ascii?q?DqBXE0jFTuCZ08DGQ+MMYFwDA0JHINCyCBBNDwCBwEKAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23:QhmS/xRZmusWrI8WWWP1TkV/cNpsopSXAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBsODt7kb1rCP++C4ACpcus3H6CtDOLV3FDY7yuwu1zQ6B8CEDUCpZNXLVAcdW
 OlkahpO0kr/D3JoHt3jbUbZuHy44G1aMBz+MQ1oOra9QdaK3Iy42O+o5pLcfRhDiiajbrNuN
 hW2qhjautULjYd4Jas8xBXErmFUd+lZym9lJ1Kekwjh6syt+JJv7zlct+gu+sNOX6j2Zbg0Q
 LJdAD87L207+crnuAXMQgeI+nYSSHgdnABSAwjC4hH6X5PxvTX/u+FgxiSUPtD4QK4tVzi64
 KllUBDnhD4ZOjA27W/bksN/gr5VrxKnvBx/3pXbYJqJO/pkf6PSZs0VSGxcVctMTSNBA4e8b
 4wSD+odOOtTsofwq0cSoRa4GAKhH/3kxCNWiXDq3K06y+UhHh/A3Aw8BNIFrXDYoMzoOKsOT
 ey5ya/FxijBYfxLwzfw8IvGfB4vrv+RQ7x9b8TRx0ktGAzZgVufppfoPy+W2+kXr2SX8/RsW
 OCphmU6qw9xuD+vxsI0h4fInI0Vzk3P+z9jwIkrPt24U0t7bsSiEJBNsCyaOJF5Qsc5TmFup
 iY6y6AJuZ+hcyQQ1JsnwBvfZuWBfoOV7R3tSPyfLi1khHJ5Zr2/nRCy/FC8x+DgS8S5zlVHo
 CRGn9TQtH0AygHf58aHRPZg/UqsxyiD2Q/T5OxFP005larWJ4MvzLIumZQev0TOEjHylUv4i
 qKda0Yq+vCw5unofrnqvIKQO5N2hw3kLKgihsiyDf43PwUKR2SX5+Wx2KHt8ED8XblGkuY5n
 6jcvZ3bOMgXuqu0DxJa34sg7huyCiqq3dYekHIaNlxKYgiHgJLsO1zWIPD3E/O/g1O0nTlxx
 f7LPafvDInRInXCjrruc6px51JBxAYpytBf+o5UBaoGIPLuXE/+qcbUDgcjMwyz3+boFsly1
 p8fWWKIBK+VKqTSsUKU5uIrJOmMY4wVtCzhJPgi4v7ilX45mVkDcqm1xZYaZ2y0Eu57L0mFY
 3fgmMkNHXsOswYkQ+HnjEWOUTtJaHazW6I86Cs7CIWjDYrbSYCimriB0Ty9Hp1IZ2BJF1GMH
 m3ye4qYXPcMbTqeItV9nTwcSbihV4gh2AmqtADgxbtoNO7U+ikDuJPi1dh14vbclQso+jBuD
 sSd1XuNT2BukW8SST82xrhzoVZhxVebzah4n/tYGMRP6PNOTgg1KZ/cwvdhC9HyXwLBZs2GR
 EynQtWgGzExT8g+z8UAY0ZnA9miiAvM0DKwA7AJj7yLGIA08qXE0nTvP8p9xGjJ1K4igVc8W
 sZAO3CoirZl9wfNGY7HkF+Xmr6vdasG3S7N8H6PzGSQs0FDTA5wTL7FUH4FaUrXqtT54F7OQ
 6KyBbg6LAdN1cGPJ69QZt3ukFVGWOzsONPDY2K3hmi8Hw6IxqmLbIr2ZWoSwDndCEkDkwAV5
 3qGMhU+Bjulo2LZCzxuFkjjbF/r8el7sH+0U0w0zwCPb0B5z7S79RAai+KARf4P2LwIoDouq
 zBuE1anw93bE8KOqRN5cqtTed89+09H1WzBugJnIpGuMr1sikYFcwRvsUPhzxV3BZtEkcgtt
 H4k1BN8J7qX3gAJSzTN/430O7SfDmDt9RSrI/rUx1Xf2ZCS87gG7PAQqlP5vQjvGFB0oFt91
 NwA/HKYrq3QAREJVJv3GhI4/hxSoa/bbig0oYjT0Cs/YuGPrjbe1odxV6MewRG6coIaafvcf
 OeTO8gTBsz0bfcvh0DsdBUPeuZb6K8zOcqiMfqAwq+ieuh6z3q9lWoSxod73wqX8jZkDPbS1
 sMKyvWw2BWGWzb1ylymt5O/gphKMAkbBXH30i34HMhUb6x2c5wMDDKhKsmfwMt/i5/kHXVf8
 Q3rHEsIjemufxfadFnhxUtQ2EAQ9GSggje9xidonisBlorP5BaWnc/fLEJefGlWWGNlkFHgZ
 5CuiMwXV1SpaA5vkwa54UH9xO5Qo6EXw3D7Z0BOcmC2KmhjVvH1rb+ee4tV75hutyxLUeO6a
 FTcS7jnohJc3TmxV21ZjCs2cT2noPCb11RzlX6dIXBvrXHYZdA4xBHR48bZTOJQ2TxOTTdxi
 D3eDFyxd9ez+tDcm5DGu+G4H2WvM/8bOSbiyauGqiq35GQsChq63riyltDhDQkmwHrjzdA5H
 S7MrRv6fszqz/HmaaQ+JhYuXgetrZYrSeQc2sMqiZod2GYXnMCQ9HsDyyLoNMlDnLj5ZzwLT
 CIKxNjc5E7k3ldiJzSH3dGcND3Vz81/at29em5T1Dg66pUAB66QxLpanCd0qxyzqgebMrBt2
 ywQz/cj8itQjOgNkAwzzymcC/YZGkwSbkmO31yYqtu5qqtQfmOmd7O9gVF/kd6WB7aHughAW
 Xz9d//OBAdI595keBLJ2Xz3sMT/fcXIKMgUvVuSmgvBiO5cLNQwkOALjGxpIzC1sXogwu89x
 RtguPPy9IeOL01r4qO1AxcePTrwL88e4TDii69Ck93eg9jpR80+XG9TDd20HLqhC3oKuO7iN
 hqSHTF0sXqdFbfFXGr9oA9no3/JD5G3JiSSLXgdw89lQUrVL0hejQYIGTQiy8JhUFnym4q7K
 BY/umFCgzyw4gFBwe9pKRTlB2LWpQPyLywxVIDaNh1dqAdL+0bSN8WaqON1BSBRuJO7/2nvY
 iSWYRpFCWYRVwmKHVfma/Oh7N3o9faZCuu3afDJZP/d4fwbTPqOyZ+1h8Fp9jKkMNuOMnhrS
 fY83wAQOBIxU9SckDIJRSsNkivLZMPOvxaw9Bp8qcWn+ejqUgbitsOfTqFfOtJ191WqkL+OY
 qSO0T1hJ28ShfZujTfYjaIS11kIh2RyeimxRP4e4DXVQvuYm7cLXUJDLXIpcpMOt+Vlg0FMI
 ZKJ1ouzj+YnyKZzUxAcCzmD0omofZBYfjv7bQufQh7NbPPfeHXK252lPPn6EOUKyr0S71rp5
 36aCxOxY27FzmGyEUjpaaYV00T5dFRfoN3vK04xTzS8CoqgMlrib5d2lWNkm7Rs3yGTbDdOP
 2QkKxEf6eHAiEEQyvRnRT4b5yI8f7DdwnSXs7GDeMRR7aojAzwqxbhTuC1okuIMvi8YHKcny
 HOK9ow85Az/94vHgjt/DkgUo24S1tvS5BdsZf2CpJIYAS6WrlVQtC2RE0pY/dI9U4+24vkCx
 ISXz/D9cG8aoYCToJFUQsHQLIjv3GMJFx3vFXaUCQIESWTuLmTDnwlHl/rU8HSJr588o5yqm
 ZwUS7YdWkZnXvUdQl9oGtAPOvIVFnstjKKbgcgU5HG/sAiZRcNUuYrCX+6TBvOnISiQjL1Nb
 R8Fib3iKoFbOor+0k1kIl50+eaCU1LXRsxIqzZ9YxUcmGUdyEImEEYOgxq8LASw/HUUCPi42
 AYsjRdzavgs8zGq5EorIl3Np207l0xw/LetyTGdfTjtLbuhCIFbDy2n/0M1M579X0N0dVjux
 Qo9bGiCHeoAyecxJgUJwEfGtJBCGOBRV/hBaR4Un7SMYukwlE5boWOhzFNG4u3MDd1jkhEre
 NiitSEluUorYdgrKKjXPKcMwEJXg/fEsSas/uYvwQMfLgAG92bYK0tq8AQYc6IrISal5Lkm8
 QuZhz5KY3QBTdISgqJSzBtjENnYl3um1KNfIEesMeDZN7mep2XLic+PRBU3y18MkE5Gu7Nx1
 I1wFijcH1Bqx7yXGRMTMMPEIgwAdMte+k/YeiOWuPnMy5Z4V21YPub2TOOPveAfhUf2RG7B/
 qw0zpQ5JMHy+3yAdZ6hK6MZwxIw4gitPE+CEPlCZBOMlnEAvt27y5h0m4JaI2NFaY2SGSOp5
 7rWr0khh//RBb8L
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NfDlgai7OoRhfq+b0B45z8ILxXBQXzZ13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I+eruBEBPewK6yXcH2/hoAV7EZniahILIFvAZ0WKG+VHd8kLFh41gPM
 tbAtFD4ZjLfCNHZKXBkXeF+rQboOVvmZrA7Ym+854ud3ANV0gJ1XYHNu/xKDwSeOApP+tcKH
 PR3Lskm9L2Ek5nEvhTS0N1KdTrlpnurtbLcBQGDxko5E2nii6p0qfzF1y90g0FWz1C7L8++S
 yd+jaJrpmLgrWe8FvxxmXT55NZlJ/IzcZCPtWFjowwJi/3ggilSYx9U/mpvSwzosuo9FE2+e
 O86isIDoBW0Tf8b2u1qRzi103J1ysv0WbrzRuijX7qsaXCNUcHIvsEobgcXgrS6kImst05+r
 lMxXilu51eCg6FtDjh5vDTPisa2nackD4Hq6o+nnZfWYwRZPt6tooE5n5YF58GAWbT9J0nKu
 9zF8vRjcwmPG9yV0qp8FWH/ebcH0jaRny9Mwg/U42uonJrdUlCvgQlLJd1pAZCyHo/I6M0ld
 gsfJ4Y1o2mdfVmHp6VNN1xMPdfNVa9MS4kEFjiVWgPR5t3TE4l7aSHq4kI2A==
X-Talos-CUID: 9a23:lcr8qm2yUBLxoKRsZmJU8LxfCuUvaH2F51jsOUqSEkFXaJy/ERzPwfYx
X-Talos-MUID: 9a23:/YraigRAjUDqkWDDRXTWoRpZEtZ3zp6LL0sQs747tYqUExJvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241374997"
X-MGA-submission: =?us-ascii?q?MDF+SF6CjldX8hlFCytqor68VRgB2tld7/8rHJ?=
 =?us-ascii?q?8n699uddkz+ayYteTmjOlKyMOWcjKpOUVvS0bKDxnmNiyPDIXDYf9ydc?=
 =?us-ascii?q?HlML+YZsSQUnScctZW9EzTJDqLURxfRXkXwGWqcKsz0kLYd0qJrDL9ih?=
 =?us-ascii?q?R/5KD7Yo49Mgvl4SsgO2giiA=3D=3D?=
Received: from mail-westus3azon11012049.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 15:18:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arebLGmtJ0A7FWat7Y65t9AmnyUN5X/eU+/maEfIIAuMfcts6+8JGkgl86IfIIITpI1mcrH0K0t7xGRx/YcZG+ynQLGyQr4Xb5hrI9+897fVMqmhgmAvs0unnMshS1NoWYQ3c6ifqLvG+OY9WqYBdJRp3Nek3N+kP/vSWa0eaL1w+JFuvIvyLHd+iGIP7ZP79pXWPY/mfxcxudgF0Y3ez4GdE3dPowZKv+mBcUD23jU4xzOGE31l+FNwyCajK9SVqq0f1lvYCftUUozCRwM+TYbWQ2gKrOIEI0OYpsQVsKoW+/h/gaGWbn0j3JHWORA4mkWVxt43foyOxMw/3LxpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1gPDL7CSLnNAYvUobR3JSGrIqM7fsJWSB+SVv0kmOY=;
 b=KzOik+l5es2Iu1czgf6887yCfnERLcn4oFw8/rjObrjP/wMxGpLIxnDXs6xQjukNanMacl8QzlAZrY16B5krt7fE9d4epwmjY+PEENZOlPGm3Zu1aEGH8zEW0JSisI5+5JGkoGOvtH2mr3bgDbDagzZmQ411YJAjKcrhPZH3gyVQHEDm5UEY79bzNZ+fMvjZUqewVJ7Tcyqhbbos3rcE3hhUXRWXD1QJ91mGGpMf2y2/5pIoMOvFxDZCcSog8CcS+W3uOwtvk165QZuFG8bzjbA/Aizd01QTJDzdXZQld5jvjWUOjgayb2zhUwZJXtvCRb5QZ2GiN7CE3bExdAM3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1gPDL7CSLnNAYvUobR3JSGrIqM7fsJWSB+SVv0kmOY=;
 b=VMNwt8S63M2ucybqUIupEJ8sAPQinHlogGF3+QVcN1jfQ29h398tIZz+DjRxpCVG9nStCniFsuZMU6bTfuiwBk3dOovAqdIbJ93ZkMcDxE9FLVLF3qBdvGRxzDYGRDMqwiC3gq1abGYei/unBAePlZOpNopni4Q8ybZE+0W4oejX1F11Bcfl9pgdLdphR5utX3hwwXOJ7OBzF+0yBFOFmeWIRrx7LVMC/xKhvpZxUsT5jypHdutDNpLDLg1v3mUfiRwk/cHqSJhFUleJCWxlan5gkKz97cQlJ1ZIfk3vRqRqn+DODT83l2fIzihC6Rr+kLTz8E4ztWFo8a/xfdg/yA==
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 13:18:00 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 13:18:00 +0000
Message-ID: <6b2eb2c2-15e7-49b4-aaca-6fd58af9ec6c@nvidia.com>
Date: Sun, 28 Sep 2025 16:17:53 +0300
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <7522bdc8-1379-d516-d1fd-f7835453f23@inria.fr>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <7522bdc8-1379-d516-d1fd-f7835453f23@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: a00536ac-428e-4a65-1163-08ddfe91723c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW84WFBpKyt1KytCd2U0VDBKRHhVUXR3RUp3TmU0ZDI1OU42QTBRWUdHdVVB?=
 =?utf-8?B?UTJQM2ZDK3FaQVNIbTJCbWJIY3JTV1dxa2ZjR2JDR2VvOVlxcnBLMS9YZy9j?=
 =?utf-8?B?Sm1yQ3ZtOXFlU08yMWZDNTlMaTBqYzR0NGN1cDErWVBHMmtIWHkxeEo5NFJS?=
 =?utf-8?B?L3Y4ZDROdmRFblNoSzdzWm1Dc1VBTGNMdWZ0aklGSm5ValpzQ09Lc29LRXdC?=
 =?utf-8?B?MGN1OFpSM3R4bWFQK0NNYjVUcVdSdEcyRnlnV0ZWNDYxVkdXL2R4OFBPb2dn?=
 =?utf-8?B?dXFtTG55Y25sTC84eEk3NGdhR29tREova3dKRzNsNzlRYUxUa0FEL2Z6ZjQv?=
 =?utf-8?B?Q2F2Q0RZMlFQNjlKdC9QTnVXckNOQXYyRTJZZmc3Y0c3K0dlVHRtaXdRY1lZ?=
 =?utf-8?B?dURoZnZhT2FCY1A2dVpxZmxobkZ6anQ2dlFiczEzZWtrNTliUVNia1M2ZzJY?=
 =?utf-8?B?ekg4cHRudURudkRMRHJNM3EvUUtwU09BZ3hQWXIvVVJGSjI4am1QT1JIampD?=
 =?utf-8?B?WS9ObURQOVIxSHRuL3gzSUhKR3hhakRaNS85eGdSTG54blJnNnZvb2NJNnBy?=
 =?utf-8?B?bXIrUUZuREFMcTI5TVpleXdGMXdFYnp4S3drMGE5bjJuRHFNNzFkRFNLL1o4?=
 =?utf-8?B?L29oRkhCeUQ5ZjRYVkduNzFnRjRkL3VCaThZVUlmS00ra2pDaU5DVTdXTzFW?=
 =?utf-8?B?aUpsRTVpOVBoUjljcnVKZXl6a3R2UlZYSHBwQ3dJckJOdmtLa3BpVUcvV21V?=
 =?utf-8?B?Qm5pcjhFU05IMXBtRVlOSVVwWXUwaTVlek5vNHlaMEUrMVcweStkOEF0T2hs?=
 =?utf-8?B?d1VIM2RqbDY5YjVjMmczeGNXUGFQZWNwWjVvOTYvZit1TTlveU5aVUZSYnZW?=
 =?utf-8?B?S2J6Vm5YU1JzeWxadHR3Tkw4ak5qd3ZUM3o1RGVCYTB2bWRNRlVPL05rN2Ns?=
 =?utf-8?B?MEtETnpxVDVhcVZRUnBhZUtSNnU4NlZlR1RUZENGTUpGc3BHVTMrWlpZMmhG?=
 =?utf-8?B?OTVEcGJHcGM3QlU4UFZ5RGU2Y0FpL3Y0RDRsSjIwSlpjMjRvbG80dlpHQzVB?=
 =?utf-8?B?R1VMdXF5S3NGTE1tejVCclpsQlpNeU1rWTJOcGZYSWNHczlWUytCbzhnR29M?=
 =?utf-8?B?MDNHclhqMEZBWXdEaFBxQnN6dWUxOE5FQlM3Z3A2NG03aktvb3VTOEtjS1lX?=
 =?utf-8?B?RVMyR1g5b3N0L2UxWnB6RXhyTFdNRGZkWWZkVmNDcXNTdGM4NWVYVFhaMjMy?=
 =?utf-8?B?WThqbkgvMWt2allrS1Z6UlpLcG5LSXp0eWhIbkZvbVlUNUc5WG5zSE4ybFZ6?=
 =?utf-8?B?RnZ2MmJTdEwwVHhjR2VEUnNXaExaRE5BeXJMOFBrVWd2b1AzeEJGdURwNHMx?=
 =?utf-8?B?WU13aitzUEJqRUtmbmVmSzR2cjlFbnY4c3l4MFRQYlpwR3JYVzFCeTh5VVBG?=
 =?utf-8?B?OTRMd1ZQaHhUNTlUWUxXM1d2V2dreTdkMHdmdGljN2E5RUpoZzBoMUdXL0JX?=
 =?utf-8?B?UUN5V1Rib0VuN08yNHV3WFlNWWZQOFBuQVUwYkNPTFdjYzloZmRCcERGZ05m?=
 =?utf-8?B?d2VXZ2tyVCt6M01sTnE3blBFNGhySDR6WDNlclRRbFYyeXpyS0c5RzVsOFlE?=
 =?utf-8?B?YjJIN0d5TCtKZk9QVVZ2ZWl2U0N0QzlHSjJaekZURmNBaUlGYU4vR2dXbmZI?=
 =?utf-8?B?RWx4VmFoRGNiWEhqNCtnVXlMaGlCY2RxaE5tVEJXNTYrTFV5R3pDOWcxWWIv?=
 =?utf-8?B?bkNjUDBiRXhTRzdXN1hLRXk4S1ZFY00yT1NqMGRPL2t1OFhjQ2tRNk9lR0li?=
 =?utf-8?B?ajUxTlA3WUx1WmgxMDZDekhITkRtcVd2NFE2eDI4akVSZ245d2NKc0VDaEFM?=
 =?utf-8?B?QUhtWTRWU2NiWG0zUmluVmJ1YzdENTBuUlRXTmJGM0tHbjVUN0NoVjNkU3hI?=
 =?utf-8?Q?3DTpwAjjprO/w858eaxxMoC0jjL8Eev0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkYwZ1VhRGxOTk9HL2E5WWZtaWx5Lyt3V0NjRk9uUlFvdWkvQ2lqM252SG5q?=
 =?utf-8?B?bCtMYUxVVEZ4aXZQeDRzY1pTRkFHaFl1RVFkOGJZZUIzWk1oNnAyQ05ZSFhz?=
 =?utf-8?B?TjJwMzF6QU1RcVM5OWtnZ25UNXJqUjE3M0xwWXFod3U0eUNyLzlINlRXYXBX?=
 =?utf-8?B?a21udTlrUjBhZjB3cnk2bkkxdC8reDJCMmlLbEQrYkdoblV0M2FmVmdlY3Er?=
 =?utf-8?B?S2tOUXZCdFJHbjBOYWNLbnE4VFlTVWVZeVRJY3VnY1BtSmtleS9tZUdsK0NB?=
 =?utf-8?B?aC91Y2ZkeDlVMnZ0eWpQMDN5VTdsZ2RCdHlFcE9pT3MxME05ZzN2eGV5MXhM?=
 =?utf-8?B?K21OdXMrd1VvNFdSbSs1WmMzaGdWT1ZoK0VJWk1kK3lBWk1uWUR3bVJvUjd2?=
 =?utf-8?B?azArMDBaSnVmS0FTcTZQR3ZmTW84aWVGTVZ2QWlDRk1oMHBmbXdzRWhLU0hL?=
 =?utf-8?B?LzhXWVBFSGx6UGZLK2NFYjR4T0Q3UVdwcnp1QzBMaC9QaUdERGFkbWh2Qmlz?=
 =?utf-8?B?K2U2bTRkN0RZMitMcjhQdWYxR2ViY1kveGI4RncvV2xUWm9sYldUV1FESnlM?=
 =?utf-8?B?bGZqdkxMUVI3ZStrZTZWdms0NkRyRE9UcDhZNEN3Rzc0NnVjSkFUTW5IZitK?=
 =?utf-8?B?NExDUURDK2VCeng1enR6WnIzN3pBRVplVmEyUkw0b1l2TGdFTWlqQzIvMlp6?=
 =?utf-8?B?dkFIQ3dzc1JzWm9QbnBIS3FLK205aEJucFhpNkRRZGNUazhtcUN0elRkSjd6?=
 =?utf-8?B?RVZYTVRFcFRxQk1PbkYzRXJQSENhc1lpayt4aGNHM0tlT1NTMHJpcEdSQm04?=
 =?utf-8?B?cm9zVUFsZ0tsUFBhRHlMR2V1akZNLzVGZGFSOC9HY202S3BYWHg0S296UUJO?=
 =?utf-8?B?ZllsSjh6RmN1aXVBNnphaldZdUJtZjdGZUsvd1F1cjRtdE1CR0tleWgrUk9F?=
 =?utf-8?B?MDNhSkFRZzdYSFRHY0dJdnBlenplM01pSDF2ZnpXMTRtdC9FakxnQUJMLzJW?=
 =?utf-8?B?VCtnc1dVeXZNOEp4UWtnc1EvakhSUE1xVU9VTEdDRmU2aXVzRlp2bnB4c2VF?=
 =?utf-8?B?SUtNMFh4cTgxaUEyRzhPMHlnWmtoYzZWWkd2Z3IrVy9wSVMxaHlUK2xUdmQv?=
 =?utf-8?B?WndvdHdTQ0Q2V3BqOEd2S1dybGFsNDZpaEorWGhLdk1iakVsK21sL0xrdVRz?=
 =?utf-8?B?RWtpcUNySlhoSmd3ODVDemZUaGx6Z3pLampXQWdtdXNmbmlXZ1ltTjl0YUl6?=
 =?utf-8?B?cVRsVGZ6eTJyTWlhN1ZBaGxSMHpsR3VsWFU2a01zWDA5UlBqcWtVdU1XY08y?=
 =?utf-8?B?WS84akl4cCtkYzgvVXFCKzdIS2xRTFNGaGJQRlBvTGdWaFVGVEl4SjNYYmJB?=
 =?utf-8?B?NU1QQ0ZzSk00cWEzVVVKNmk3dkZmS0o1U2YyVWFZOENRWit4QlNDZTN6NlUr?=
 =?utf-8?B?cGJydkJaT2FZU1Bja0pYZitIK0wvenJuYmM5d1ljTHFKM2RUMjk3RjFuMXl4?=
 =?utf-8?B?TzJwQnZXd2VQQ2tTUE9BaWpjRTQ3WG02L2F5dHZrYXVVVk1LZDRrVE12Tm93?=
 =?utf-8?B?Qk9ZaGducTRuajNKNThlOXVMVkZPdXFSellKekhGbFV3MHcvNTVHOGdRQXJk?=
 =?utf-8?B?cmhrVm1XK1VsTDJKQ1dPRGFRR0hkd0Jxckpsc0J1U2tUalpyRFpxdHlrU0xj?=
 =?utf-8?B?RXU2YkJDMnphazhzaS9jcTJ5VHhsc1ViT01PV3VBR0ZWeU1rOTlOSTBqSVJC?=
 =?utf-8?B?UWIvaFNnQ3lTYXcrcksyMGxUR3JXaFdyZ0Fxemt5eTRQOHVXb2tibEF1L1BF?=
 =?utf-8?B?aUlLNG9jS29tYXJYaTZSd0VSNUhGUEU4amlscWkrdWV2dzBWQkdIRTZCd1o2?=
 =?utf-8?B?a2tRUGNLT0Fqd2hCSEcxT3R3UlIrbHdBbXVVVUc3N09PaFVIcUN3Y043Q1FL?=
 =?utf-8?B?cDVQYlZVWDRLb0lROVhjUlpMVUpPQVpOZFM3VFlXNlZ5Mm50MXBVWEhtL1pa?=
 =?utf-8?B?OGJjU2E2d1EyZUlTSkcxYmlwemZMSVhjSTA4RnBQeFdvSnUrT3JveG10UGtq?=
 =?utf-8?B?QlNZVFRlNXd1Q3Q5bkYrRThSQzdsQzQydlVrWGtjczJPMFJwVkxMYk9hbmRJ?=
 =?utf-8?Q?iSGlQyeTGEFaTV01CzFmH8mP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00536ac-428e-4a65-1163-08ddfe91723c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 13:17:59.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5u8B7G/nJc7u9NGISNp2I/1ybAct3YcCZ60Ue+SRNEBR5bjWzN+yA1nQ7tp3XndT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Gal Pressman <gal@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3049
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/6b2eb2c2-15e7-49b4-aaca-6fd58af9ec6c%40nvidia.com>

Thanks for the review Julia!

On 28/09/2025 15:23, Julia Lawall wrote:
>>>> +@r@
>>>> +expression ptr;
>>>> +constant fmt;
>>>> +position p;
>>>> +identifier print_func;
>>>> +@@
>>>> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
>>>
>>> How do you think about to use the metavariable type “format list”?
>>
>> I did find "format list" in the documentation, but spatch fails when I
>> try to use it.
> 
> I would suggest constant char[] fmt.

That works, thanks!

> 
> format is for the case where you want to specify something about the %d
> %s, etc in the string.
> 
>>> Would it matter to restrict expressions to pointer expressions?
>>
>> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
>> didn't find anything. Am I doing it wrong?
> 
> expression *ptr should be a valid metavariable declaration.  But
> Coccinelle needs to have enough information to know that something is a
> pointer.  If you have code like a->b and you don't have the definition of
> the structure type of a, then it won't know the type of a->b.  More
> information about types is available if you use options like
> --recursive-includes, but then treatment of every C file will entail
> parsing lots of header files, which could make things very slow.  So you
> have to consider whether the information that the thing is a pointer is
> really necessary to what you are trying to do.

Makes sense, indeed the pointer is embedded in another struct.

I'll keep it as is, if the code calls PTR_ERR() on something that is not
a pointer it has bigger problems than using %pe.

> 
>>>> +@script:python depends on r && org@
>>>
>>> I guess that such an SmPL dependency specification can be simplified a bit.
>>
>> You mean drop the depends on r?
>>
>>>
>>>
>>>> +p << r.p;
> 
> Since you have r.p, the rule will only be applied if r has succeeded and
> furthermore if p has a value.  So depends on r is not necessary.

Got it.
