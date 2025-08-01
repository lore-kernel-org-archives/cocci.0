Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDA7C87FD2
	for <cocci@archiver.kernel.org>; Fri,  1 Aug 2025 07:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8DneUI0EdnoS0X1xyo4luOmDCcKGnTruaw7i+wIw/4w=;
  b=W+qFTKp+HkzJZ1+wJ8mp/J098dbw8ZxL2MvbWuqM1Cbv1YZ0FTBwljn4
   FsI21rbKtHgISIPSqYpuMUEC82Xf6N7ZBt3b95QGsfoakwbSXHpMqljEg
   ++uL29SKQ7ArH5I+X6NMwb76oMXfsLBWsGPa9mRhV6mHv5r94HjOzJO4/
   o=;
X-CSE-ConnectionGUID: 7YqehP9uTL6gGvFFygisnw==
X-CSE-MsgGUID: BvTQWBpfR/alGGeJhuYc9w==
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
X-IronPort-AV: E=Sophos;i="6.17,255,1747692000"; 
   d="scan'208";a="233834881"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2025 09:33:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1600EE0C55; Fri,  1 Aug 2025 09:33:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 139B4E0171
	for <cocci@sympa.inria.fr>; Fri,  1 Aug 2025 09:33:39 +0200 (CEST)
X-CSE-ConnectionGUID: Tu1agrKnSTy4dYEh008vUA==
X-CSE-MsgGUID: BYSmF804RYWnqZClR4qQ9A==
IronPort-SDR: 688c6dd2_LxoXal17T+ZTolrhzkXW4qMUl1Tz+2i1HOAHuX95Y9S0qdk
 7/cl5YUH3F9EQUyzDFLo9PzegRkoRwgvffSPuag==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HdAQB0bIxogAMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBU4JEgQZUMwQLSYRVj1CCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IUAAowbAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?SYBBAsLGgImAgJWBgEUAQGCfoIiAQYQAQMOJAewcIEygQGCDAEBBoJp13UfL?=
 =?us-ascii?q?CJZgWQJgRsuhW2CZAGGJ4Q8Jw+BVUSBPIMDPogegmmCJoEWg2ONBYhuUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EKCtPgiJ1gXlBGT+DUx4Gb?=
 =?us-ascii?q?Q8GgRUaHi0CAgIFAkNFgWAWBwYYQAIBC209NwkLGwY9k1KCNZs7jiegO4EKN?=
 =?us-ascii?q?AeCOIFngWQMn2wGEy+DcZNhDgaTBZkGIqkfgX8jgVwzGiSDNk8DGQ+OIYQzv?=
 =?us-ascii?q?jpBNTwCBwsBAQMJhUYBAYwDgUsBAQ?=
IronPort-PHdr: A9a23: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
 UJgKVbQMokZcIH2iRQKVw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+pZm6Kq6ss6IeIPfMmMmJNwaV5r/eYIsimQD101hICG9vPbo8v
 xG785rsiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWrbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AckIxDGgAMV9zAkpQIrIvjh0flDJuTmCExXjKAEm?=
 =?us-ascii?q?DNXc1RIy4SQfIqL1Zup87?=
X-Talos-MUID: 9a23:ofLvPAmyM4f75niZAnOUdnpIBfxtzfT2VHo8rpMfieKAD3BpAma02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,255,1747692000"; 
   d="scan'208";a="233834868"
X-MGA-submission: =?us-ascii?q?MDFRy2LNEPGbU3AnY/5uC/0xCSDql1rnj2ycOt?=
 =?us-ascii?q?87SNoM08akLYiAMemInChSL4T91qO4Nrvd79dk95A6pzi+2r/gT33YuP?=
 =?us-ascii?q?i0ph2wTFlu3/YPZ+UYjUNhB0SN2GPKFnh2FcJyKFnyZ6TxzBtPyAYz0h?=
 =?us-ascii?q?9OXuWH+AimzFf9Fm8U1AoleQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 09:33:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754033618; x=1754638418; i=markus.elfring@web.de;
	bh=8DneUI0EdnoS0X1xyo4luOmDCcKGnTruaw7i+wIw/4w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uRB8FDSzc5lyYnjFgKuiCq9mPCsRgBPtvXtkP4fkvxm2AvIG9LTlxZOLUMllnvf8
	 eEWiKOKY2Jl7SxMGOZtSIxhE0fDJRZ2Vi4TOrfnZ6MGCjjWbuYSeK2MrQ3j7FbSay
	 tQn7L+mhCsUkPKelplqGuiMlg/5EQTLpT+K6e9PB8JVrFozakxRwZFxbKT5dN7BCD
	 kMlicfimmvOPFEAR91W5vLVfEmjwEwXnZSPxv1Ip0l0DJF+Acey01g0R2j9hgn0Dx
	 Z2CBmF8uFx+kaJ2a2wdKoe5YNMbI+bu+1Bp4M7YGBGTlJhGIB6KsA8nHNiaCqueJK
	 4o90nV7t43IW1S/Y+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1u8PFm3JUF-00neNa; Fri, 01
 Aug 2025 09:33:37 +0200
Message-ID: <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
Date: Fri, 1 Aug 2025 09:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PzCZi1hHYC7iz9q6LY8HXuz2hBA2AqnaVB7AeLQdjWMBD9a+x6o
 BRd+dAD9tEZKX8UBGvlNBKUyTWbbb7mI1yXvG/PmfPeGfma2NuYwB4yQfMK/4j5/pokUZW8
 wv2FN3/PDF1oCmB3Ft1RowULnzPnUsq0W9tAscE6d50AWdKQJ4I39MlzBAXLQDH2uZq0Mai
 sx2HjUcukzozt0MT0ggZw==
UI-OutboundReport: notjunk:1;M01:P0:vqbEq/Exm1I=;x0hdwDPwOIhrXayoZHKVT9BvrCz
 mL7icHaprvwHnhqpk2Fo6puXGXG6WyX5Po7zTmwF8lyXSj3IePOb6aH9oAgzG/DUUeBqqhnSS
 uOuMiXeg00pycm4Uh32DvlH6JZoiOtwXdy9JhGgQ6uIj8pQ9i9ot17UcgljHU/GVkNRa85vbX
 ho3TQvLQ+5GNYpEmjCF+DW6QeeZ3RUmAEyIzOB1zMQxEjvSNTuq+Vie1nwOp8dLGpgIu5mcrP
 1YusyyTYCHQLvykR0jCgYP3tB45nXYl2qZDj0wLQKPeJmnMFeg3Grv0Lef5/pDB53RMk4ptFc
 ZooBUPBIA+1SK+hTN9SypBcKqs3hsQqfka/K3879D37x/sDAdtv8Ky8sjLYDFVap1pqhc4STC
 74Q0dNoTSi93SxDt1G1RH8aCQD/bTGp2cVloD/va7JrIppk5n7B0djsEzhsP1wE4nl37u1GMA
 tcv0qyC/794M+0MszZ7NarE0lZpw0kpGB1E2EIc+1qf1J84eeOJ1NN6HTKJdKS/7c4NQVGfOS
 tYRJvJoEm0fNH/dq6wd3MW3fAKc0j/fYEOWktc4t5h1JseKBqJl29tbsG8P2wx6pHEb3DoDiw
 bZjdLoPxD6xOmugFMP6mFCN9KAeLXn1UP6yjag7Xi5KW7E5mg4dvReLShJ5UV0LlKl9olFN0z
 fj3PlZVMwGPKlcktCHAkdLZYWY01IHe9Z+A+GI+pmAXeWcYvnGk0C8t2y5qWr4Ehbz2q4PNP3
 2uEye34UM+9nts5frIGLVDtjM4rq5LmGFMmLQTxmUzNWKjsbYGxOjIcmjz5KupbJaQrKVUJFb
 y0woSt6Ff9JmU1eVYWuuvD7Gd4j2cL2VtZKjVnTdVlrYOD12+2wSqsWSSprvmx+dFSDVnnmd6
 KqEX46Wv4q5kh+22VCxcZ1tqh4M4624se9I55sSEVc387XWxWvUaY7FfHu91fxYpZQbZIR+qK
 QQFCkGCwlzEJaSv6VMCi5l08XWbmqOZfLM32Zl0qzZ7BLYsNtgv7EFbajne2EVJMw6c5m/NRk
 UUaetACI1RzSY9R6mC6Q+kZvQlC+VR2tSh79YAlUBX8WoQbhDEQE1iCbcLrQcnINEPcr8c64Z
 3P2Q+XfC4M82QdjtH/L6BgDpz5/xBitN5CgpLRbmPxULHqxib3KImtXu9gURW35zzAqc+hYZ7
 ogC60bx9DhsrP3IBtgRN8G7K3Z1WA84Ppw6F3n630r9v4C0UEW3srddlJbTybcVbcZ+ulqp4k
 xvDufgHBbYcGSDTphADyi7GLQkQIuF6pLqPvRAh7aOvV0l6W+WJnXC80Dkl9JiLw086Y0gqN4
 bbMHHqf45MnGaQeQU1WC6a2gIfPZuNkSFzTf+j5qEQj0PCycnmHgmX8nKfcZGxMEzQ/wE+6GU
 AjH9RywtaNlkh5QODwyoGR68zQYOG8+OPIf+nxBj7VXhsr4dCit1SO6qexNmIKfntQktgGky5
 6pYgkGTcmjlX22L+RqUq7AZZprf8NRGxAf2Vdkp2d01yuLkETT0aUiXRITHcBTgnTtBOJWdRf
 l8COBQ+nBI02bZQjkO/zGun/5UepfLgR46izlPegwCguaf1cJh/A3gI9FQUhmcyX+D30cXp7k
 RVRpd+v/jbrG1QZ0jqd0sbVxZ8/MSRG1uPhIfVMRLPJZoQTxIEg/moz9UfftEL9h/RPaCBI26
 vc2ZfLQ7cIY1cRmt/w20sj7dqnfeh7pdls3brldsI0TkAdDE9aPENcR7ZXlwcr+YiS1M98lE0
 S51Q3wi0f5VN/iYAvBqDszu7RuZKqpi+iz5FIuVwnzQtl5X3MbDX8ztHbF3D3aGpWxjffFFBy
 XZI7vNeLl0tixS9wA3yWQqulTm7uiTeOSs9UZo1CA5i299kqad5FJt37KZPu2iQufYSyHpBVr
 sYtYy1zWjK81qId2spZqp3K3ZTC2yqEQG7M/GXQaiKZIVi8Jy00641hZJKEfZDFiQ+xcZzQhJ
 2Afbdwr/L155ZVKfTqGO/ihdJT5i2lOT8oU9tGq6tA2MkeUO2apnimNOxbRy777HWS8eswS6K
 jv0POIyZBjxCIdxxPuQ33jXw4OmSZFqQC9QR6IpmaVe0oJaZNagZelpckvlVVoOA5BcJpPqm7
 aTPtKlAtwtgYAxR8TU7RANNqcZ2kx05IGqo2M4lcL9ccvcOHFway+71g1eNcE918kDL2t4bf7
 K5WoxSrQxQwtdKmNSANUu9j/pARcWXQLr4/ex6lWrEvEjpsjfwbxDif4aX+83KZGDsX6UT2ja
 d1qtstaA40cap+5lLmV55GhKMw7JuydHQRFfyohHD+Anq83wyDgRKJ6buBPCbEJrsflILK7ZI
 6tP5exXJpYM9zQPBrsMALo/62tFVguQX5Bd7sJ/Amyx7cnXhi8/qw1xEILXSyvd0of5ApMCwQ
 Gbb3kh2mmtJSuy6GcCZXX9vMoQJk88ZlWhQraBcsKZtydpsMouJRq7r5JWUFOLIK33YTeO0/L
 ScG5flndVDh4B3Ve8PMrL1Hqd5CLsgwowMbiGeVfYqjVMl5PwQ+1YacRM+CcI5DLTHFjjmz95
 +9SJCzx/xoSAF68AT6abrMYQRT5wzeajTBhYAkkcju5VQYwoc2PWvq65+ZskIiLqHtwirw/87
 oENJgewr8JNUw2lIwXTcmPW4FSNaybZxq4dSHcgyovBp7C9mgab+ON/IgCu2bf3+DS6ajZYdO
 PASOVIDAXG0KG7n9C/YZJZqaSBoSHI8j1DDE+KOWBBEKRB4X92TA5wjLpBqu9DTqTCKQ8GLMA
 GQOKiVrt8OcSkniYFm77d2m4BNi73Qj4PDTq5qad9aMDNgWQoU6NLkiPgKnsPvBSWGGNGScg9
 MH6i43sEfDbns2b95zUeWX/FdqPMM++apnteGDh28L+QOmCle6h45s+yXllLSQ5WZ/hjlzk7y
 7/SXOQ/HM8u1cpU2e8KGFbYyslRJOAlvIW2VL2SjnKQeeBpwSBidcYSkBx/TAzUIZBnZ7JdRA
 HMJN9pRCu8PTGbtOUWoma3MyXxee431hVlYjgnkWb22vCd6KNAtFoHQAhbJMA3ZXz98KZGqeB
 fjIpObVQf5DldiA53LoLg5Hhahp2ZERCdUFhzcCzbadtUEHdP2C8zEiqwWpYNNZ29MV9bPDet
 WumpP+jz7CF/rVBZJdxHkPiF8CLLI3jZLmqpCYvyLgMhhOnTDbxWOq5WRX7MyeqyxFqKt6tNm
 FPUDBif/pCVq8iBW+9i49B/F1STX4zGVBmCwh4glsAvYgH84HDRjCman8/oqYesFX9GTSGKZk
 hOivFcY5T4kmhX/NDaJJmVruJKABIVNbAHUt26O+HlKud1UMVVABuGQqI2N5HJXW4b1xoTwLn
 AQJpzxVzoUdrnTJ26Yk0AvtZQHyNebvg1TgCOJhEptC4DRpecSnY1gF3YH+Paxcz22euUtiN1
 GyK0Qg1Mt+9TXlSOd79X92+ElO/+iKMe+C3rSRxb7K2+w9baszOLc7R8Ir4tN96diISfnO+/A
 doF/nGSWUPG4Zck5lYH1b0JNRSBCOfC6N753k+/m8ckUjn2I3k2VoAVPFRpfjvPDOD8GpsRZW
 twTVSN3uahatIer6osLb0As=
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2922
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/3cdb1e5b-72bf-475a-a83b-c469e0225c84%40web.de>

> Would you like to add any insights why an additional qualification
> would become relevant for the first SmPL ellipsis in the discussed
> source code search pattern?

Would you get further development ideas if the source code search approach
(like the following for example) would be more general?


@display@
expression allocate, release, x, y;
@@
*allocate(x);
 ... when forall
*allocate(y);
 <+...
*release(x);
 ...
*release(y);
 ...+>


How do you think about to refine the selection of relevant
macro/function calls here?

Will any constraints become more interesting for usable call pairs?

Regards,
Markus
